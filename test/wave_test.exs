defmodule WaveTest do
  use ExUnit.Case, async: true
  doctest Wave

  test "error messages on missing files or non WAV files" do
    assert {:error, "test/fake_data.wav does not exist"} == Wave.read("test/fake_data.wav")
    assert {:error, "This library only accepts WAV files"} == Wave.read("README.md")
  end

  test "we can read data from a WAV file" do
    result = Wave.read("WAV_samples/PCM-16kHz/ex2-16kHz.wav")
    assert elem(result, 0) == :ok
    assert is_bitstring(elem(result, 1))
  end

  test "we can parse the header data from a sample 16-bit WAV file" do
    {:ok, data} = Wave.read("WAV_samples/PCM-16kHz/ex2-16kHz.wav")
    assert data != :nil
    wave = Wave.parse(data)
    # "RIFF" == 0x52, 0x49, 0x46, 0x46
    assert Map.get(wave, :chunk_id) == 0x52494646
    {riff_hex_val, _} = Integer.parse(Base.encode16("RIFF"), 16)
    assert 0x52494646 == riff_hex_val
    # "WAVE" == 0x57 0x41 0x56 0x45 == 57415645
    assert Map.get(wave, :format) == 0x57415645
    {wave_hex_val, _} = Integer.parse(Base.encode16("WAVE"), 16)
    assert 0x57415645 == wave_hex_val
    # "DATA" == 0x44 0x41 0x54 0x41 == 44415441
    assert Map.get(wave, :subchunk2_id) == 0x64617461
  end
end
