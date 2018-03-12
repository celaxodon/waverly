defmodule Waverly.Writer do
  @moduledoc """
  A WAVE file writer
  """
  @spec writer(binary) :: {:ok, binary} | {:err, String.t}
  @doc """
  Generates a WAVE file audio object with little-endian encoded format (RIFF)
  """
  def writer(_wav_struct) do
    :not_implemented
  end

  @spec writer(binary, String.t) :: :ok | {:err, String.t}
  @doc """
  Writes a WAVE file to disk
  """
  def writer(_wav_struct, _path) do
    :not_implemented
  end
end
