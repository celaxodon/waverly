# Waverly

[![Build Status](https://travis-ci.org/celaxodon/waverly.svg?branch=master)](https://travis-ci.org/celaxodon/waverly)

Waverly is a WAVE file encoder/decoder. It parses WAVE files, extracting headers and audio data
and can also encode audio data in WAVE file formats for storage or to pass onto other applications

## Usage

```elixir
# Encode data
iex> audio_data = Waverly.write(audio_data)
# Decode data
iex> raw data = Waverly.reader(path/to/file.wav)
iex> wave_data = Waverly.parser(raw_data)
iex> Map.get(wave_data, :chunk_id) == 0x52494646
true
```

## License

[MIT][]


[MIT]: https://opensource.org/licenses/MIT "MIT License"
