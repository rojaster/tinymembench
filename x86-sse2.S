/*
 * Copyright © 2011 Siarhei Siamashka <siarhei.siamashka@gmail.com>
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice (including the next
 * paragraph) shall be included in all copies or substantial portions of the
 * Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

#if defined(__i386__) || defined(__amd64__)

.intel_syntax noprefix
.text

#define PREFETCH_DISTANCE 256

#define MACRO(MACRO_NAME, PARAMETERS...) .macro MACRO_NAME PARAMETERS

#ifdef __clang__
#define FUNC
#define ENDFUNC
#define ENDMACRO .endm
#define DST rdi
#define SRC rsi
#define SIZE rdx
#else
#define FUNC .func \function_name
#define ENDFUNC .endfunc
#define ENDMACRO .endm
#endif // __clang__

#if __APPLE__ && __clang__

MACRO(push3)
    push $0
    push $1
    push $2
ENDMACRO

MACRO(pop3)
    pop $2
    pop $1
    pop $0
ENDMACRO

MACRO(asm_function_helper)
.globl _$0
_$0:

#else

MACRO(push3, a,b,c)
    push \a
    push \b
    push \c
ENDMACRO


MACRO(pop3, a,b,c)
    pop \c
    pop \b
    pop \a
ENDMACRO


MACRO(asm_function_helper,function_name)
.global \function_name
FUNC
\function_name:

#ifdef __amd64__
  #ifdef _WIN64
    .set DST,  rcx
    .set SRC,  rdx
    .set SIZE, r8
  #else
    .set DST,rdi
    .set SRC,rsi
    .set SIZE,rdx
  #endif
#else
    mov  eax,  [esp + 4]
    mov  ecx,  [esp + 8]
    mov  edx,  [esp + 12]
    .set DST,  eax
    .set SRC,  ecx
    .set SIZE, edx
#endif // __amd64__

#endif // __APPLE__
ENDMACRO


#if defined(__APPLE__)
MACRO(asm_function)
    asm_function_helper $0
#else
MACRO(asm_function,function_name)
#if defined(_WIN32) && !defined(_WIN64)
    asm_function_helper _\function_name
#else
    asm_function_helper \function_name
#endif // _WIN*
#endif // __APPLE__
ENDMACRO


/*****************************************************************************/
asm_function aligned_block_copy_movsb
0:
#ifdef __amd64__
#ifdef __clang__
    push3       rdi,rsi,rcx
    push3       DST,SRC,SIZE
    pop3        rdi,rsi,rcx
    rep movsb
    pop3        rdi,rsi,rcx
#else
    push3       rdi rsi rcx
    push3       DST SRC SIZE
    pop3        rdi rsi rcx
    rep movsb
    pop3        rdi rsi rcx
#endif
#else
#ifdef __clang__
    push3       edi,esi,ecx
    push3       DST,SRC,SIZE
    pop3        edi,esi,ecx
    rep movsb
    pop3        edi,esi,ecx
#else
    push3       edi esi ecx
    push3       DST SRC SIZE
    pop3        edi esi ecx
    rep movsb
    pop3        edi esi ecx
#endif
#endif
    ret
ENDFUNC

asm_function aligned_block_copy_movsd
0:
#ifdef __amd64__
#ifdef __clang__
    push3       rdi,rsi,rcx
    push3       DST,SRC,SIZE
    pop3        rdi,rsi,rcx
    sar         rcx, 2
    rep movsd
    pop3        rdi,rsi,rcx
#else
    push3       rdi rsi rcx
    push3       DST SRC SIZE
    pop3        rdi rsi rcx
    sar         rcx, 2
    rep movsd
    pop3        rdi rsi rcx
#endif
#else
#ifdef __clang__
    push3       edi,esi,ecx
    push3       DST,SRC,SIZE
    pop3        edi,esi,ecx
    sar         ecx, 2
    rep movsd
    pop3        edi,esi,ecx
#else
    push3       edi esi ecx
    push3       DST SRC SIZE
    pop3        edi esi ecx
    sar         ecx, 2
    rep movsd
    pop3        edi esi ecx
#endif
#endif
    ret
ENDFUNC

asm_function aligned_block_copy_sse2
0:
    movdqa      xmm0,       [SRC + 0]
    movdqa      xmm1,       [SRC + 16]
    movdqa      xmm2,       [SRC + 32]
    movdqa      xmm3,       [SRC + 48]
    movdqa      [DST + 0],  xmm0
    movdqa      [DST + 16], xmm1
    movdqa      [DST + 32], xmm2
    movdqa      [DST + 48], xmm3
    add         SRC,        64
    add         DST,        64
    sub         SIZE,       64
    jg          0b
    ret
ENDFUNC

asm_function aligned_block_copy_nt_sse2
0:
    movdqa      xmm0,       [SRC + 0]
    movdqa      xmm1,       [SRC + 16]
    movdqa      xmm2,       [SRC + 32]
    movdqa      xmm3,       [SRC + 48]
    movntdq     [DST + 0],  xmm0
    movntdq     [DST + 16], xmm1
    movntdq     [DST + 32], xmm2
    movntdq     [DST + 48], xmm3
    add         SRC,        64
    add         DST,        64
    sub         SIZE, 64
    jg          0b
    ret
ENDFUNC

asm_function aligned_block_copy_pf32_sse2
0:
    prefetchnta [SRC + PREFETCH_DISTANCE]
    prefetchnta [SRC + PREFETCH_DISTANCE + 32]
    movdqa      xmm0,       [SRC + 0]
    movdqa      xmm1,       [SRC + 16]
    movdqa      xmm2,       [SRC + 32]
    movdqa      xmm3,       [SRC + 48]
    movdqa      [DST + 0],  xmm0
    movdqa      [DST + 16], xmm1
    movdqa      [DST + 32], xmm2
    movdqa      [DST + 48], xmm3
    add         SRC,        64
    add         DST,        64
    sub         SIZE,       64
    jg          0b
    ret
ENDFUNC

asm_function aligned_block_copy_nt_pf32_sse2
0:
    prefetchnta [SRC + PREFETCH_DISTANCE]
    prefetchnta [SRC + PREFETCH_DISTANCE + 32]
    movdqa      xmm0,       [SRC + 0]
    movdqa      xmm1,       [SRC + 16]
    movdqa      xmm2,       [SRC + 32]
    movdqa      xmm3,       [SRC + 48]
    movntdq     [DST + 0],  xmm0
    movntdq     [DST + 16], xmm1
    movntdq     [DST + 32], xmm2
    movntdq     [DST + 48], xmm3
    add         SRC,        64
    add         DST,        64
    sub         SIZE,       64
    jg          0b
    ret
ENDFUNC

asm_function aligned_block_copy_pf64_sse2
0:
    prefetchnta [SRC + PREFETCH_DISTANCE]
    movdqa      xmm0,       [SRC + 0]
    movdqa      xmm1,       [SRC + 16]
    movdqa      xmm2,       [SRC + 32]
    movdqa      xmm3,       [SRC + 48]
    movdqa      [DST + 0],  xmm0
    movdqa      [DST + 16], xmm1
    movdqa      [DST + 32], xmm2
    movdqa      [DST + 48], xmm3
    add         SRC,        64
    add         DST,        64
    sub         SIZE,       64
    jg          0b
    ret
ENDFUNC

asm_function aligned_block_copy_nt_pf64_sse2
0:
    prefetchnta [SRC + PREFETCH_DISTANCE]
    movdqa      xmm0,       [SRC + 0]
    movdqa      xmm1,       [SRC + 16]
    movdqa      xmm2,       [SRC + 32]
    movdqa      xmm3,       [SRC + 48]
    movntdq     [DST + 0],  xmm0
    movntdq     [DST + 16], xmm1
    movntdq     [DST + 32], xmm2
    movntdq     [DST + 48], xmm3
    add         SRC,        64
    add         DST,        64
    sub         SIZE,       64
    jg          0b
    ret
ENDFUNC

asm_function aligned_block_fill_sse2
    movdqa      xmm0,       [SRC + 0]
0:
    movdqa      [DST + 0],  xmm0
    movdqa      [DST + 16], xmm0
    movdqa      [DST + 32], xmm0
    movdqa      [DST + 48], xmm0
    add         DST,        64
    sub         SIZE,       64
    jg          0b
    ret
ENDFUNC

asm_function aligned_block_fill_nt_sse2
    movdqa      xmm0,       [SRC + 0]
0:
    movntdq     [DST + 0],  xmm0
    movntdq     [DST + 16], xmm0
    movntdq     [DST + 32], xmm0
    movntdq     [DST + 48], xmm0
    add         DST,        64
    sub         SIZE,       64
    jg          0b
    ret
ENDFUNC
/*****************************************************************************/

#endif //  defined(__i386__) || defined(__amd64__)
