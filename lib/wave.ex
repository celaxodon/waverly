defmodule Wave do
  @moduledoc """
  This module contains the Wave struct, which defines fields for the WAVE file
  audio format.

  Similar to hound's WavSpec, which defines:
  * channels
  * sample_ate
  * bits_per_sample
  * sample_format
  """

  alias __MODULE__

  @enforce_keys [:audio_data, :format, :sample_rate, :channels]

  @type t :: %__MODULE__{
    audio_data: binary(),
    byte_rate: integer(),
  }

  defstruct [
    chunk_id: nil,
    chunk_size: nil,
    format: "WAVE", # FIXME
    subchunk1_id: nil,
    subchunk1_size: nil,
    audio_format: nil,
    channels: 1,
    sample_rate: nil,
    byte_rate: nil,
    block_align: nil,
    bits_per_sample: nil,
    subchunk2_id: nil,
    subchunk2_size: nil,
    audio_data: nil
  ]

  def new(audio_data, format, sample_rate, channels) do
    %Wave{
      chunk_id: nil,
      chunk_size: nil,
      format: nil,
      subchunk1_id: nil,
      subchunk1_size: nil,
      audio_format: format,
      channels: channels,
      sample_rate: sample_rate,
      byte_rate: nil,
      block_align: nil,
      bits_per_sample: nil,
      subchunk2_id: nil,
      subchunk2_size: nil,
      audio_data: audio_data,
    }
  end
end
