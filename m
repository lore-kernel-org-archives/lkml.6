Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967755AbeBNM3c (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 07:29:32 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51567 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967394AbeBNM3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 07:29:24 -0500
X-Google-Smtp-Source: AH8x226c0DzcxJ2EVJRut1PKpmbb4XQbDn6LXkht4LFIcmPRP3fJUN7SYdKQt7Eh6DZNrkoJjYjfPg==
From: Corentin Labbe <clabbe@baylibre.com>
To: David1.Zhou@amd.com, airlied@linux.ie, alexander.deucher@amd.com,
        christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 07/13] drm/amd/include: remove unused asic_reg/umc headers
Date: Wed, 14 Feb 2018 12:28:45 +0000
Message-Id: <1518611331-13144-8-git-send-email-clabbe@baylibre.com>
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
 .../drm/amd/include/asic_reg/umc/umc_6_0_default.h | 31 -------------
 .../drm/amd/include/asic_reg/umc/umc_6_0_offset.h  | 52 ----------------------
 2 files changed, 83 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_0_default.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_0_offset.h

diff --git a/drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_0_default.h b/drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_0_default.h
deleted file mode 100644
index 128a18f1e362..000000000000
--- a/drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_0_default.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/*
- * Copyright (C) 2017  Advanced Micro Devices, Inc.
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
-#ifndef _umc_6_0_DEFAULT_HEADER
-#define _umc_6_0_DEFAULT_HEADER
-
-#define mmUMCCH0_0_EccCtrl_DEFAULT				0x00000000
-
-#define mmUMCCH0_0_UMC_CONFIG_DEFAULT				0x00000203
-
-#define mmUMCCH0_0_UmcLocalCap_DEFAULT				0x00000000
-
-#endif
diff --git a/drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_0_offset.h
deleted file mode 100644
index 6985dbba39f5..000000000000
--- a/drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_0_offset.h
+++ /dev/null
@@ -1,52 +0,0 @@
-/*
- * Copyright (C) 2017  Advanced Micro Devices, Inc.
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
-#ifndef _umc_6_0_OFFSET_H_
-#define _umc_6_0_OFFSET_H_
-
-#define mmUMCCH0_0_EccCtrl				0x0053
-#define mmUMCCH0_0_EccCtrl_BASE_IDX			0
-#define mmUMCCH1_0_EccCtrl				0x0853
-#define mmUMCCH1_0_EccCtrl_BASE_IDX			0
-#define mmUMCCH2_0_EccCtrl				0x1053
-#define mmUMCCH2_0_EccCtrl_BASE_IDX			0
-#define mmUMCCH3_0_EccCtrl				0x1853
-#define mmUMCCH3_0_EccCtrl_BASE_IDX			0
-
-#define mmUMCCH0_0_UMC_CONFIG				0x0040
-#define mmUMCCH0_0_UMC_CONFIG_BASE_IDX			0
-#define mmUMCCH1_0_UMC_CONFIG				0x0840
-#define mmUMCCH1_0_UMC_CONFIG_BASE_IDX			0
-#define mmUMCCH2_0_UMC_CONFIG				0x1040
-#define mmUMCCH2_0_UMC_CONFIG_BASE_IDX			0
-#define mmUMCCH3_0_UMC_CONFIG				0x1840
-#define mmUMCCH3_0_UMC_CONFIG_BASE_IDX			0
-
-#define mmUMCCH0_0_UmcLocalCap				0x0306
-#define mmUMCCH0_0_UmcLocalCap_BASE_IDX			0
-#define mmUMCCH1_0_UmcLocalCap				0x0b06
-#define mmUMCCH1_0_UmcLocalCap_BASE_IDX			0
-#define mmUMCCH2_0_UmcLocalCap				0x1306
-#define mmUMCCH2_0_UmcLocalCap_BASE_IDX			0
-#define mmUMCCH3_0_UmcLocalCap				0x1b06
-#define mmUMCCH3_0_UmcLocalCap_BASE_IDX			0
-
-#endif
-- 
2.13.6
