all: tinymembench

ifdef WINDIR
	CC = gcc
endif

# @TODO(alekum) Refine Makefile to pick only necessary object files to be built with
# 1. find architecture via uname -m
# 2. conditionally form the list of the object files, could I set conditinal for the whole rule rather than recipe lines?
# 3. compile final exec

util.o: util.c util.h
	${CC} -O2 ${CFLAGS} -c util.c

asm-opt.o: asm-opt.c asm-opt.h x86-sse2.h arm-neon.h mips-32.h aarch64-asm.h
	${CC} -O2 ${CFLAGS} -c asm-opt.c

# iif x86 or x86_64
x86-sse2.o: x86-sse2.S
	${CC} -O2 ${CFLAGS} -c x86-sse2.S

# iif __arm__
arm-neon.o: arm-neon.S
	${CC} -O2 ${CFLAGS} -c arm-neon.S

# iif __arm__ and __aarch64__
aarch64-asm.o: aarch64-asm.S
	${CC} -O2 ${CFLAGS} -c aarch64-asm.S

aarch64-neon.o: aarch64-neon.c
	$(CC) -O2 ${CFLAGS} -c aarch64-neon.c

# iif __mips__
mips-32.o: mips-32.S
	${CC} -O2 ${CFLAGS} -c mips-32.S

tinymembench: main.c util.o util.h asm-opt.h version.h asm-opt.o x86-sse2.o arm-neon.o mips-32.o aarch64-asm.o aarch64-neon.o
	${CC} -O2 ${CFLAGS} -o tinymembench main.c util.o asm-opt.o x86-sse2.o arm-neon.o mips-32.o aarch64-asm.o aarch64-neon.o -lm

clean:
	-rm -f tinymembench
	-rm -f tinymembench.exe
	-rm -f *.o
