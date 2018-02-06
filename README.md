# Waverly

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

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `waverly` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:waverly, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/waverly](https://hexdocs.pm/waverly).
