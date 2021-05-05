#include <string.h>
#include <stdint.h>
#include <stdlib.h>
#include <sys/time.h>
#include "aarch64-neon.h"

#define PREFETCH_DISTANCE 320

void aligned_block_neon_copy_64x2_aarch64(int64_t *__restrict dst_,
                                          int64_t *__restrict src,
                                          int                 size)
{
    volatile int64_t *dst = dst_;
    int64x2_t v64x2_1, v64x2_2;
    while((size-=64)>=0)
    {
        v64x2_1 = vld1q_s64(src);
        v64x2_2 = vld1q_s64(src+=2);
        vst1q_s64(dst, v64x2_1);
        vst1q_s64(dst+=2, v64x2_2);
        v64x2_1 = vld1q_s64(src+=2);
        v64x2_2 = vld1q_s64(src+=2);
        vst1q_s64(dst+=2, v64x2_1);
        vst1q_s64(dst+=2, v64x2_2);
        dst+=2; 
        src+=2;
    }
}

void aligned_block_neon_copy_64x2_aarch64_pf2(int64_t *__restrict dst_,
                                               int64_t *__restrict src,
                                               int                 size)
{
    volatile int64_t *dst = dst_;
    int64x2_t v64x2_1, v64x2_2;
    while((size-=64)>=0)
    {
        __builtin_prefetch(src + PREFETCH_DISTANCE, 0, 0);
        v64x2_1 = vld1q_s64(src);
        v64x2_2 = vld1q_s64(src+=2);
        vst1q_s64(dst, v64x2_1);
        vst1q_s64(dst+=2, v64x2_2);
        __builtin_prefetch(src + PREFETCH_DISTANCE, 0, 0);
        v64x2_1 = vld1q_s64(src+=2);
        v64x2_2 = vld1q_s64(src+=2);
        vst1q_s64(dst+=2, v64x2_1);
        vst1q_s64(dst+=2, v64x2_2);
        dst+=2; 
        src+=2;
    }
}


void aligned_block_neon_copy_64x2_aarch64_pf1(int64_t *__restrict dst_,
                                               int64_t *__restrict src,
                                               int                 size)
{
    volatile int64_t *dst = dst_;
    int64x2_t v64x2_1, v64x2_2;
    while((size-=64)>=0)
    {
        __builtin_prefetch(src + PREFETCH_DISTANCE, 0, 0);
        v64x2_1 = vld1q_s64(src);
        v64x2_2 = vld1q_s64(src+=2);
        vst1q_s64(dst, v64x2_1);
        vst1q_s64(dst+=2, v64x2_2);
        v64x2_1 = vld1q_s64(src+=2);
        v64x2_2 = vld1q_s64(src+=2);
        vst1q_s64(dst+=2, v64x2_1);
        vst1q_s64(dst+=2, v64x2_2);
        dst+=2; 
        src+=2;
    }
}


void aligned_block_neon_copy_64x2x4_aarch64(int64_t *__restrict dst_,
                                            int64_t *__restrict src,
                                            int                 size)
{
    volatile int64_t *dst = dst_;
    int64x2x4_t v64x2x4;
    while((size -= 64) >= 0)
    {
        v64x2x4 = vld1q_s64_x4(src);
        vst1q_s64_x4(dst, v64x2x4);
        dst+=8;
        src+=8;
    }
}

void aligned_block_neon_copy_64x2x4_aarch64_pf1(int64_t *__restrict dst_,
                                                 int64_t *__restrict src,
                                                 int                 size)
{
    volatile int64_t *dst = dst_;
    int64x2x4_t v64x2x4;
    while((size -= 64) >= 0)
    {
        __builtin_prefetch(src + PREFETCH_DISTANCE, 0, 0);
        v64x2x4 = vld1q_s64_x4(src);
        vst1q_s64_x4(dst, v64x2x4);
        dst+=8;
        src+=8;
    }
}

void aligned_block_neon_copy_64x1x4_x2_aarch64(int64_t *__restrict dst_,
                                               int64_t *__restrict src,
                                               int                 size)
{
    volatile int64_t *dst = dst_;
    int64x1x4_t v64x1x4_1, v64x1x4_2;
    while((size -=64) > 0)
    {
        v64x1x4_1 = vld1_s64_x4(src);
        v64x1x4_2 = vld1_s64_x4(src+4);
        src+=8;
        vst1_s64_x4(dst, v64x1x4_1);
        vst1_s64_x4(dst+4,v64x1x4_2);
        dst+=8;
    }
}

void aligned_block_neon_copy_64x1x4_x2_aarch64_pf1(int64_t *__restrict dst_,
                                                   int64_t *__restrict src,
                                                   int                 size)
{
    volatile int64_t *dst = dst_;
    int64x1x4_t v64x1x4_1, v64x1x4_2;
    while((size -=64) > 0)
    {
        __builtin_prefetch(src + PREFETCH_DISTANCE, 0, 0);
        v64x1x4_1 = vld1_s64_x4(src);
        v64x1x4_2 = vld1_s64_x4(src+4);
        src+=8;
        vst1_s64_x4(dst, v64x1x4_1);
        vst1_s64_x4(dst+4,v64x1x4_2);
        dst+=8;
    }
}

