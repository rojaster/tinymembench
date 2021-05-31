This is a simple memory benchmark program, which tries to measure the peak bandwidth of sequential memory accesses and the latency of random memory accesses. Bandwidth is measured by running different assembly code for the aligned memory blocks and attempting different prefetch strategies.

### Test results comparison

> Check log files to get whole output.
>> Find even more data in the [wiki](https://github.com/ssvb/tinymembench/wiki).

* [Apple M1 - Macbook Air](m1.apple.log)

```bash
....
 ---
 standard memcpy                                      :  30251.8 MB/s (22.9%)
 standard memset                                      :  42933.1 MB/s (8.2%)
 ---
 ....
```

* [Apple i7 - Macbook Pro]()

```bash

```

* [Apple i9 - Macbook Pro](i9.apple.log)

```bash
....
 ---
 standard memcpy                                      :   8036.5 MB/s (1.0%)
 standard memset                                      :  33126.4 MB/s (7.6%)
 ---
 ....
```

* [Linux i7- Desktop](i7.linux.log)

```bash
 ---
 standard memcpy                                      :  15452.2 MB/s (0.2%)
 standard memset                                      :  32821.6 MB/s (0.4%)
 ---
```

> The experiments aim to represent memory accesses speed.

## Supported Archs
- [X] macOS: x86, M1
- [X] Linux x86
- [X] Android AArch64
- [X] Windows x86

> Personally tested on Apple's M1 air , i9 pro macbooks; Android Aarch64 mobile phone and tablet with cortex-a76, cortex-a55 cores,
> and Linux x86 i7 desktop machine. 

### Support or Contact
Alekum(Rojaster)

#### Personal contribution
- [X] aarch64 NEON support
- [X] clang's integrated assembler fixes for aarch64, arm, x86 on linux and mac

#### Ongoing plans
- [ ] x86 SSE4
- [ ] x86 AVX
- [ ] AArch64 SVE
