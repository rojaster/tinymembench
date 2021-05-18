all: tinymembench

ifdef WINDIR
	CC = gcc
endif

objects = util.o
util.o: util.c util.h
	${CC} -O2 ${CFLAGS} -c util.c

objects += asm-opt.o
asm-opt.o: asm-opt.c asm-opt.h
	${CC} -O2 ${CFLAGS} -c asm-opt.c

objects += x86-sse2.o
x86-sse2.o: x86-sse2.S x86-sse2.h
	${CC} -O2 ${CFLAGS} -c x86-sse2.S

objects += arm-neon.o
arm-neon.o: arm-neon.S arm-neon.h
	${CC} -O2 ${CFLAGS} -c arm-neon.S

objects += mips-32.o
mips-32.o: mips-32.S mips-32.h
	${CC} -O2 ${CFLAGS} -c mips-32.S


objects += aarch64-asm.o
aarch64-asm.o: aarch64-asm.S aarch64-asm.h
	${CC} -O2 ${CFLAGS} -c aarch64-asm.S

objects += aarch64-neon.o
aarch64-neon.o: aarch64-neon.c aarch64-neon.h
	$(CC) -O2 ${CFLAGS} -c aarch64-neon.c

tinymembench: $(objects)
	$(CC) -O2 ${CFLAGS} main.c $(objects) -lm -o tinymembench

clean:
	-rm -f tinymembench
	-rm -f tinymembench.exe
	-rm -f *.o
