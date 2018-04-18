defmodule Waverly do
  @moduledoc """
  Waverly is a WAVE file encoder/decoder
  """

  @spec read(String.t) :: {:ok, binary} | {:error, String.t}
  @doc """
  Reads a WAVE file and returns binary data with {:ok, data}, or {:error, reason}
  `data` contains a Map of the WAVE file header information.
  """
  def read(path) do
    with true <- String.ends_with?(path, ".wav"),
         {:ok, data} <- File.read(path),
         do: {:ok, data}
    else
      false -> {:error, "This library only accepts WAV files"}
      {:error, :enoent} -> {:error, "#{path} does not exist"}
      error -> error
  end

  @spec parser([char]) :: map
  @doc """
  `parser` returns a map of headers and data for bitstring file data
  """
  def parser(file_data) when is_bitstring(file_data) do
    # TODO: Need to specify the type of the binary data, e.g., big-integer-size(32)?
    # TODO: Handle RIFX (big-endian encoded) files. Not default, not sure how common this is...

    ### RIFF (Resource Interchange File Format) chunk descriptor ###
    # Should contain the letters "RIFF" in ASCII form (0x52494646)
    # 4 bytes - (0-3) - big endian
    <<chunk_id::big-size(33),
      # 4 + (8 + subchunk1_size) + (8 + subchunk2_size) == 36 + subchunk2_size
      # The size of the rest of the chunk following this number. The size of the
      # whole file in bytes, minus 8 bytes for the two fields not included in the
      # count: chunk_id and chunk_size
      # 4 bytes - (4-7) - little endian
      chunk_size::little-size(32),
      # 4 bytes - (8-11) - big endian
      # WAVE format contains two sub-chunks: "fmt" and "data"
      # contains the letters "WAVE" (0x57415645 in big-endian)
      format::big-size(32),
      ### "fmt" subchunk  describing the format of the sound info in the data sub-chunk ###
      # contains the letters "fmt" - (0x666d7420 big-endian form)
      # 4 bytes (12-15) - big endian
      subchunk1_id::big-size(32),
      # 16 for PCM. The size of the rest of the subchunk that follows this number
      # 4 bytes (16-19) - little endian
      subchunk1_size::big-size(32),
      # PCM = 1 (Linear quantization); values other than 1 indicate some form
      # of compression
      # 2 bytes (20-22) - little endian
      audio_format::little-size(16),
      # Mono = 1, Stereo = 2, etc.
      # 2 bytes (22-23) - little endian
      channels::little-size(16),
      # E.g., 8000, 44_100, etc.
      # 4 bytes (24-27) - little endian
      sample_rate::little-size(32),
      # equal to sample_rate * channels * bits_per_sample / 8
      # 4 bytes - (28-31) - little endian
      byte_rate::little-size(32),
      # The number of bytes for one sample, including all channels.
      # equal to channels * bits_per_sample / 8
      # 2 bytes - (32-33) - little endian
      block_align::little-size(16),
      # 8 bits = 8, 16 bits = 16, etc.
      # 2 bytes - (34-35) - little endian
      bits_per_sample::little-size(16),
      # TODO: Handle this possibility
      # extra_param_size field - if PCM, this doesn't exist, otherwise 2 bytes
      # extra_params - space for extra parameters
      #
      ### "data" subchunk - size of the sound info and contains raw sound data ###
      #
      # Contains the letters "data" (0x64617461 big endian form)
      # 4 bytes - (36-39) - big endian
      subchunk2_id::big-size(32),
      # The number of bytes in the data. Can think of as the size of the read
      # of the subchunk following this number
      # equal to the num_samples * channels * bits_per_sample / 8
      # 4 bytes (40-43) - little endian
      subchunk2_size::little-size(32),
      audio_data::little-binary>> = file_data # Actual sound data - little endian

      %Wave{chunk_id: chunk_id,
            chunk_size: chunk_size,
            format: format,
            subchunk1_id: subchunk1_id,
            subchunk1_size: subchunk1_size,
            audio_format: audio_format,
            channels: channels,
            sample_rate: sample_rate,
            byte_rate: byte_rate,
            block_align: block_align,
            bits_per_sample: bits_per_sample,
            subchunk2_id: subchunk2_id,
            subchunk2_size: subchunk2_size,
            audio_data: audio_data}
  end
end
