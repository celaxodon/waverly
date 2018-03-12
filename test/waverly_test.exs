defmodule WaverlyTest do
  use ExUnit.Case
  doctest Waverly

  test "error messages on missing files or non WAV files" do
    assert {:error, "test/fake_data.wav does not exist"} == Waverly.read("test/fake_data.wav")
    assert {:error, "This library only accepts WAV files"} == Waverly.read("README.md")
  end

  test "we can read data from a WAV file" do
    result = Waverly.read("WAV_samples/PCM-16kHz/ex2-16kHz.wav")
    assert elem(result, 0) == :ok
    assert is_bitstring(elem(result, 1))
  end

  test "we can parse the header data from a sample 16-bit WAV file" do
    {:ok, data} = Waverly.read("WAV_samples/PCM-16kHz/ex2-16kHz.wav")
    assert data != :nil
    wave = Waverly.parser(data)
    # "RIFF" == 0x52, 0x49, 0x46, 0x46 or <<82, 73, 70, 70>>
    assert Map.get(wave, :chunk_id) == 0x52494646
    # "WAVE" == 0x57 0x41 0x56 0x45 == 57415645
    assert Map.get(wave, :format) == 0x57415645
    # "DATA" == 0x44 0x41 0x54 0x41 == 44415441
    assert Map.get(wave, :subchunk2_id) == 0x64617461
  end
end
