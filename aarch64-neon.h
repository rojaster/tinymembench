#ifndef __AARCH64_NEON_H__
#define __AARCH64_NEON_H__
#include <stdint.h>
#include <arm_neon.h>
#ifdef __cplusplus
extern "C" {
#endif

void aligned_block_neon_copy_64x2_aarch64(int64_t *__restrict dst_,
                                          int64_t *__restrict src,
                                          int                 size);

void aligned_block_neon_copy_64x2_aarch64_pf2(int64_t *__restrict dst_,
                                               int64_t *__restrict src,
                                               int                 size);

void aligned_block_neon_copy_64x2_aarch64_pf1(int64_t *__restrict dst_,
                                               int64_t *__restrict src,
                                               int                 size);

void aligned_block_neon_copy_64x2x4_aarch64(int64_t *__restrict dst_,
                                            int64_t *__restrict src,
                                            int                 size);

void aligned_block_neon_copy_64x2x4_aarch64_pf1(int64_t *__restrict dst_,
                                                 int64_t *__restrict src,
                                                 int                 size);

void aligned_block_neon_copy_64x1x4_x2_aarch64(int64_t *__restrict dst_,
                                               int64_t *__restrict src,
                                               int                 size);

void aligned_block_neon_copy_64x1x4_x2_aarch64_pf1(int64_t *__restrict dst_,
                                                   int64_t *__restrict src,
                                                   int                 size);
#ifdef __cplusplus
}
#endif

#endif // __AARCH64_NEON_H__

