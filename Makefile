all: tinymembench

ifdef WINDIR
	CC = gcc
endif

tinymembench: main.c util.o util.h asm-opt.h version.h asm-opt.o x86-sse2.o arm-neon.o mips-32.o aarch64-asm.o aarch64-neon.o
	${CC} -O2 ${CFLAGS} -o tinymembench main.c util.o asm-opt.o x86-sse2.o arm-neon.o mips-32.o aarch64-asm.o aarch64-neon.o -lm

util.o: util.c util.h aarch64-neon.h
	${CC} -O2 ${CFLAGS} -c util.c

asm-opt.o: asm-opt.c asm-opt.h x86-sse2.h arm-neon.h mips-32.h
	${CC} -O2 ${CFLAGS} -c asm-opt.c

x86-sse2.o: x86-sse2.S
	${CC} -O2 ${CFLAGS} -c x86-sse2.S

arm-neon.o: arm-neon.S
	${CC} -O2 ${CFLAGS} -c arm-neon.S

aarch64-asm.o: aarch64-asm.S
	${CC} -O2 ${CFLAGS} -c aarch64-asm.S

aarch64-neon.o: aarch64-neon.c aarch64-neon.h
	${CC} -O2 ${CFLAGS} -w -c aarch64-neon.c

mips-32.o: mips-32.S
	${CC} -O2 ${CFLAGS} -c mips-32.S

clean:
	-rm -f tinymembench
	-rm -f tinymembench.exe
	-rm -f *.o
