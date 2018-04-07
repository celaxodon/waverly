# TODO

* Reader
* writer to files
* License - MIT? Apache 2.0?
* Contributing doc
* changelog.md - badge?
* Usage examples in module documentation
* check out the RFC for [WAVE and AVI codec Registries][1]
* generate sound
  - channels
  - sample rate
  - bits per sample
  - sample format
* To look at: [hound][2]
  - creates a WavSpec struct that just includes channels, sample_rate, bits_per_sample and sample_format.
    Then, it creates a writer instance passing the file name and spec
* lib/waverly.ex:

## Notes

* TODO: Sample data must end on an even byte boundary
* TODO: 8-bit samples are stored as unsigned bytes, from 0-255. 16-bit samples are
  stored as 2's complement signed integers, ranging from –32768 to 32767
* There may be additional subchunks in a WAVE data stream; if so, each has
  a char[4] subchunkID, unsigned long subchunk size and subchunk size amount of
  data

    

[1]: https://tools.ietf.org/html/rfc2361
[2]: https://github.com/ruuda/hound
