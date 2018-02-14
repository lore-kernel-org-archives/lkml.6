Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967835AbeBNMbE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 07:31:04 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44311 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967738AbeBNM30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 07:29:26 -0500
X-Google-Smtp-Source: AH8x2265fSWHzVKyKtWtk8gJ8N03Bhb6mWd9jtgBlwDWcTkXq4IG9WWeP0RbAV+pmjuiuQaL9sRYzQ==
From: Corentin Labbe <clabbe@baylibre.com>
To: David1.Zhou@amd.com, airlied@linux.ie, alexander.deucher@amd.com,
        christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 09/13] drm/amd/include: remove unused asic_reg/vce headers
Date: Wed, 14 Feb 2018 12:28:47 +0000
Message-Id: <1518611331-13144-10-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518611331-13144-1-git-send-email-clabbe@baylibre.com>
References: <1518611331-13144-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All thoses headers are not used by any source files.
Lets just remove them.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../gpu/drm/amd/include/asic_reg/vce/vce_1_0_d.h   | 64 --------------
 .../drm/amd/include/asic_reg/vce/vce_1_0_sh_mask.h | 99 ----------------------
 2 files changed, 163 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_d.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_sh_mask.h

diff --git a/drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_d.h b/drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_d.h
deleted file mode 100644
index 2176548e9203..000000000000
--- a/drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_d.h
+++ /dev/null
@@ -1,64 +0,0 @@
-/*
- *
- * Copyright (C) 2016 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included
- * in all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
- * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
- * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
- */
-
-#ifndef VCE_1_0_D_H
-#define VCE_1_0_D_H
-
-#define mmVCE_CLOCK_GATING_A 0x80BE
-#define mmVCE_CLOCK_GATING_B 0x80BF
-#define mmVCE_LMI_CACHE_CTRL 0x83BD
-#define mmVCE_LMI_CTRL 0x83A6
-#define mmVCE_LMI_CTRL2 0x839D
-#define mmVCE_LMI_MISC_CTRL 0x83B5
-#define mmVCE_LMI_STATUS 0x83A7
-#define mmVCE_LMI_SWAP_CNTL 0x83AD
-#define mmVCE_LMI_SWAP_CNTL1 0x83AE
-#define mmVCE_LMI_VCPU_CACHE_40BIT_BAR 0x8397
-#define mmVCE_LMI_VM_CTRL 0x83A8
-#define mmVCE_RB_ARB_CTRL 0x809F
-#define mmVCE_RB_BASE_HI 0x8061
-#define mmVCE_RB_BASE_HI2 0x805C
-#define mmVCE_RB_BASE_LO 0x8060
-#define mmVCE_RB_BASE_LO2 0x805B
-#define mmVCE_RB_RPTR 0x8063
-#define mmVCE_RB_RPTR2 0x805E
-#define mmVCE_RB_SIZE 0x8062
-#define mmVCE_RB_SIZE2 0x805D
-#define mmVCE_RB_WPTR 0x8064
-#define mmVCE_RB_WPTR2 0x805F
-#define mmVCE_SOFT_RESET 0x8048
-#define mmVCE_STATUS 0x8001
-#define mmVCE_SYS_INT_ACK 0x8341
-#define mmVCE_SYS_INT_EN 0x8340
-#define mmVCE_SYS_INT_STATUS 0x8341
-#define mmVCE_UENC_CLOCK_GATING 0x816F
-#define mmVCE_UENC_DMA_DCLK_CTRL 0x8250
-#define mmVCE_UENC_REG_CLOCK_GATING 0x8170
-#define mmVCE_VCPU_CACHE_OFFSET0 0x8009
-#define mmVCE_VCPU_CACHE_OFFSET1 0x800B
-#define mmVCE_VCPU_CACHE_OFFSET2 0x800D
-#define mmVCE_VCPU_CACHE_SIZE0 0x800A
-#define mmVCE_VCPU_CACHE_SIZE1 0x800C
-#define mmVCE_VCPU_CACHE_SIZE2 0x800E
-#define mmVCE_VCPU_CNTL 0x8005
-
-#endif
diff --git a/drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_sh_mask.h
deleted file mode 100644
index ea5b26b11cb1..000000000000
--- a/drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_sh_mask.h
+++ /dev/null
@@ -1,99 +0,0 @@
-/*
- *
- * Copyright (C) 2016 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included
- * in all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
- * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
- * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
- */
-
-#ifndef VCE_1_0_SH_MASK_H
-#define VCE_1_0_SH_MASK_H
-
-#define VCE_LMI_CACHE_CTRL__VCPU_EN_MASK 0x00000001L
-#define VCE_LMI_CACHE_CTRL__VCPU_EN__SHIFT 0x00000000
-#define VCE_LMI_CTRL2__STALL_ARB_UMC_MASK 0x00000100L
-#define VCE_LMI_CTRL2__STALL_ARB_UMC__SHIFT 0x00000008
-#define VCE_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK 0x00200000L
-#define VCE_LMI_CTRL__VCPU_DATA_COHERENCY_EN__SHIFT 0x00000015
-#define VCE_LMI_SWAP_CNTL1__RD_MC_CID_SWAP_MASK 0x00003ffcL
-#define VCE_LMI_SWAP_CNTL1__RD_MC_CID_SWAP__SHIFT 0x00000002
-#define VCE_LMI_SWAP_CNTL1__VCPU_R_MC_SWAP_MASK 0x00000003L
-#define VCE_LMI_SWAP_CNTL1__VCPU_R_MC_SWAP__SHIFT 0x00000000
-#define VCE_LMI_SWAP_CNTL__VCPU_W_MC_SWAP_MASK 0x00000003L
-#define VCE_LMI_SWAP_CNTL__VCPU_W_MC_SWAP__SHIFT 0x00000000
-#define VCE_LMI_SWAP_CNTL__WR_MC_CID_SWAP_MASK 0x00003ffcL
-#define VCE_LMI_SWAP_CNTL__WR_MC_CID_SWAP__SHIFT 0x00000002
-#define VCE_LMI_VCPU_CACHE_40BIT_BAR__BAR_MASK 0xffffffffL
-#define VCE_LMI_VCPU_CACHE_40BIT_BAR__BAR__SHIFT 0x00000000
-#define VCE_RB_BASE_HI2__RB_BASE_HI_MASK 0xffffffffL
-#define VCE_RB_BASE_HI2__RB_BASE_HI__SHIFT 0x00000000
-#define VCE_RB_BASE_HI__RB_BASE_HI_MASK 0xffffffffL
-#define VCE_RB_BASE_HI__RB_BASE_HI__SHIFT 0x00000000
-#define VCE_RB_BASE_LO2__RB_BASE_LO_MASK 0xffffffc0L
-#define VCE_RB_BASE_LO2__RB_BASE_LO__SHIFT 0x00000006
-#define VCE_RB_BASE_LO__RB_BASE_LO_MASK 0xffffffc0L
-#define VCE_RB_BASE_LO__RB_BASE_LO__SHIFT 0x00000006
-#define VCE_RB_RPTR2__RB_RPTR_MASK 0x007ffff0L
-#define VCE_RB_RPTR2__RB_RPTR__SHIFT 0x00000004
-#define VCE_RB_RPTR__RB_RPTR_MASK 0x007ffff0L
-#define VCE_RB_RPTR__RB_RPTR__SHIFT 0x00000004
-#define VCE_RB_SIZE2__RB_SIZE_MASK 0x007ffff0L
-#define VCE_RB_SIZE2__RB_SIZE__SHIFT 0x00000004
-#define VCE_RB_SIZE__RB_SIZE_MASK 0x007ffff0L
-#define VCE_RB_SIZE__RB_SIZE__SHIFT 0x00000004
-#define VCE_RB_WPTR2__RB_WPTR_MASK 0x007ffff0L
-#define VCE_RB_WPTR2__RB_WPTR__SHIFT 0x00000004
-#define VCE_RB_WPTR__RB_WPTR_MASK 0x007ffff0L
-#define VCE_RB_WPTR__RB_WPTR__SHIFT 0x00000004
-#define VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK 0x00000001L
-#define VCE_SOFT_RESET__ECPU_SOFT_RESET__SHIFT 0x00000000
-#define VCE_STATUS__JOB_BUSY_MASK 0x00000001L
-#define VCE_STATUS__JOB_BUSY__SHIFT 0x00000000
-#define VCE_STATUS__UENC_BUSY_MASK 0x00000100L
-#define VCE_STATUS__UENC_BUSY__SHIFT 0x00000008
-#define VCE_STATUS__VCPU_REPORT_MASK 0x000000feL
-#define VCE_STATUS__VCPU_REPORT__SHIFT 0x00000001
-#define VCE_SYS_INT_ACK__VCE_SYS_INT_TRAP_INTERRUPT_ACK_MASK 0x00000008L
-#define VCE_SYS_INT_ACK__VCE_SYS_INT_TRAP_INTERRUPT_ACK__SHIFT 0x00000003
-#define VCE_SYS_INT_EN__VCE_SYS_INT_TRAP_INTERRUPT_EN_MASK 0x00000008L
-#define VCE_SYS_INT_EN__VCE_SYS_INT_TRAP_INTERRUPT_EN__SHIFT 0x00000003
-#define VCE_SYS_INT_STATUS__VCE_SYS_INT_TRAP_INTERRUPT_INT_MASK 0x00000008L
-#define VCE_SYS_INT_STATUS__VCE_SYS_INT_TRAP_INTERRUPT_INT__SHIFT 0x00000003
-#define VCE_UENC_DMA_DCLK_CTRL__RDDMCLK_FORCEON_MASK 0x00000002L
-#define VCE_UENC_DMA_DCLK_CTRL__RDDMCLK_FORCEON__SHIFT 0x00000001
-#define VCE_UENC_DMA_DCLK_CTRL__REGCLK_FORCEON_MASK 0x00000004L
-#define VCE_UENC_DMA_DCLK_CTRL__REGCLK_FORCEON__SHIFT 0x00000002
-#define VCE_UENC_DMA_DCLK_CTRL__WRDMCLK_FORCEON_MASK 0x00000001L
-#define VCE_UENC_DMA_DCLK_CTRL__WRDMCLK_FORCEON__SHIFT 0x00000000
-#define VCE_VCPU_CACHE_OFFSET0__OFFSET_MASK 0x0fffffffL
-#define VCE_VCPU_CACHE_OFFSET0__OFFSET__SHIFT 0x00000000
-#define VCE_VCPU_CACHE_OFFSET1__OFFSET_MASK 0x0fffffffL
-#define VCE_VCPU_CACHE_OFFSET1__OFFSET__SHIFT 0x00000000
-#define VCE_VCPU_CACHE_OFFSET2__OFFSET_MASK 0x0fffffffL
-#define VCE_VCPU_CACHE_OFFSET2__OFFSET__SHIFT 0x00000000
-#define VCE_VCPU_CACHE_SIZE0__SIZE_MASK 0x00ffffffL
-#define VCE_VCPU_CACHE_SIZE0__SIZE__SHIFT 0x00000000
-#define VCE_VCPU_CACHE_SIZE1__SIZE_MASK 0x00ffffffL
-#define VCE_VCPU_CACHE_SIZE1__SIZE__SHIFT 0x00000000
-#define VCE_VCPU_CACHE_SIZE2__SIZE_MASK 0x00ffffffL
-#define VCE_VCPU_CACHE_SIZE2__SIZE__SHIFT 0x00000000
-#define VCE_VCPU_CNTL__CLK_EN_MASK 0x00000001L
-#define VCE_VCPU_CNTL__CLK_EN__SHIFT 0x00000000
-#define VCE_VCPU_CNTL__RBBM_SOFT_RESET_MASK 0x00040000L
-#define VCE_VCPU_CNTL__RBBM_SOFT_RESET__SHIFT 0x00000012
-
-#endif
-- 
2.13.6
