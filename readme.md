# Tinymembench - simple memory benchmark 

> Disclaimer:
>
>I merely completed aarch64 NEON instructions support, fixed assembler files for x86 and aarch64 to be ok with clang integrated assembler(you don't
> have to pass `-fno-integrated-as` on Linux or Mac, to be more precise, it is actually marked as deprecated on macOS.). My plans are to add AVX, SSE instructions support as well. Currently, it is only with SSE2 instructions support.

This is a simple memory benchmark program, which tries to measure the peak
bandwidth of sequential memory accesses and the latency of random memory
accesses. Bandwidth is measured by running different assembly code for
the aligned memory blocks and attempting different prefetch strategies.

> [Project github page](https://rojaster.github.io/tinymembench)


## Build 
This program can be compiled in either linux or windows (via mingw32 and msys)
by simply running make:
    $ make

Adding extra optimization options is possible (in linux):
```bash
    $ CFLAGS="-O2 -march=atom -mtune=atom" make
```

Example of crosscompiling for **ARM** (also in linux):
```bash
    $ CC=arm-linux-gnueabihf-gcc CFLAGS="-O2 -mcpu=cortex-a9" make
```

Example of crosscompiling and running the benchmark on **Android** device(tested on cortex-a76, cortex-a55 as well):
```bash
    $ CC=arm-linux-gnueabihf-gcc CFLAGS="-O2 -mcpu=cortex-a8 -static" make
    $ adb push tinymembench /data/local/tmp/tinymembench
    $ adb shell /data/local/tmp/tinymembench
```
----
### Results
* The benchmark results for some hardware can be found in the [original wiki page](https://github.com/ssvb/tinymembench/wiki)


### Remarks:
- [X] it works perfectly well with Clang's integrated assembler
- [X] compiled on Apple, Linux x86 and tested with/without -fno-integrated-as flag
  - [X] no issues on Linux
  - [X] Apple deprecated non-integrated as in favor of integrated one as part of their 
- [X] compiled on Apple M1
  - [X] compiled with integrated as of clang