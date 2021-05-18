all: tinymembench

ifdef WINDIR
	CC = gcc
endif

libs = -lm
objects = main.c util.o util.h asm-opt.h asm-opt.o

util.o: util.c util.h
	${CC} -O2 ${CFLAGS} -c util.c

arch_headers = asm-opt.h

arch_headers += x86-sse2.h
objects += x86-sse2.o
x86-sse2.o: x86-sse2.S
	${CC} -O2 ${CFLAGS} -c x86-sse2.S

arch_headers += arm-neon.h
objects += arm-neon.o
arm-neon.o: arm-neon.S
	${CC} -O2 ${CFLAGS} -c arm-neon.S

arch_headers += mips-32.h
objects += mips-32.o
mips-32.o: mips-32.S
	${CC} -O2 ${CFLAGS} -c mips-32.S

arch_headers += aarch64-asm.h
objects += aarch64-asm.o
aarch64-asm.o: aarch64-asm.S
	${CC} -O2 ${CFLAGS} -c aarch64-asm.S

objects += aarch64-neon.o
aarch64-neon.o: aarch64-neon.c
	$(CC) -O2 ${CFLAGS} -c aarch64-neon.c

asm-opt.o: asm-opt.c $(arch_headers)
	${CC} -O2 ${CFLAGS} -c asm-opt.c


tinymembench: $(objects)
	$(CC) -O2 ${CFLAGS} -o tinymembench $(objects) $(libs)

clean:
	-rm -f tinymembench
	-rm -f tinymembench.exe
	-rm -f *.o
