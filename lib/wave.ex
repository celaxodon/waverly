defmodule Waverly.Wave do
  @moduledoc """
  This module contains the Wave struct, which defines fields for the WAVE file 
  audio format.
  """
  defstruct [:chunk_id, :chunk_size, :format, :subchunk1_id, :subchunk1_size,
             :audio_format, :num_channels, :sample_rate, :byte_rate, :block_align,
             :bits_per_sample, :subchunk2_id, :subchunk2_size, :audio_data]

end