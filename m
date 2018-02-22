Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752813AbeBVIWJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 03:22:09 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33755 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752553AbeBVIWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 03:22:07 -0500
X-Google-Smtp-Source: AH8x224MmM8holItQWbkgcPPeSyqg4824jOMb6pZw9ML92EFoqRX1Ahk0g69gFeQizradvLLPmZ7Eg==
From: Corentin Labbe <clabbe@baylibre.com>
To: David1.Zhou@amd.com, airlied@linux.ie, alexander.deucher@amd.com,
        christian.koenig@amd.com, david1.zhou@amd.com, Dieter@nuetzel-hh.de,
        l.stach@pengutronix.de
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 1/2] drm/amd: remove inclusion of non-existing scheduler directory
Date: Thu, 22 Feb 2018 08:21:48 +0000
Message-Id: <1519287709-28638-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The scheduler directory was removed via commit 1b1f42d8fde4 ("drm: move amd_gpu_scheduler into common location")
Remove it from include path.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index d6e5b7273853..8408aeeaf6c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -30,7 +30,6 @@ FULL_AMD_DISPLAY_PATH = $(FULL_AMD_PATH)/$(DISPLAY_FOLDER_NAME)
 ccflags-y := -I$(FULL_AMD_PATH)/include/asic_reg \
 	-I$(FULL_AMD_PATH)/include \
 	-I$(FULL_AMD_PATH)/amdgpu \
-	-I$(FULL_AMD_PATH)/scheduler \
 	-I$(FULL_AMD_PATH)/powerplay/inc \
 	-I$(FULL_AMD_PATH)/acp/include \
 	-I$(FULL_AMD_DISPLAY_PATH) \
-- 
2.16.1
