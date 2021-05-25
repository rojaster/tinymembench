This is a simple memory benchmark program, which tries to measure the peak bandwidth of sequential memory accesses and the latency of random memory accesses. Bandwidth is measured by running different assembly code for the aligned memory blocks and attempting different prefetch strategies.

## Personal contribution
- [X] aarch64 NEON support
- [X] clang's integrated assembler fixes for aarch64, arm, x86

### Test results comparison
* Apple M1

```bash

```

* Apple i7 <full_spec>

```bash

```

* Apple Intel(R) Core(TM) i9-9980HK CPU @ 2.40GHz

```bash

```

* Linux i7

```bash

```



## Supported Archs
- [X] macOS: x86, M1
- [X] Linux
- [X] Android
- [X] Windows

> Personally tested on Apple's M1 air , i9 pro macbooks; Android ARM64 mobile phone and tablet with cortex-a76, cortex-a55 cores,
> and Linux x86 i7 desktop machine. 
### Support or Contact

Alekum <=> Rojaster