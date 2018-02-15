Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755065AbeBOIXY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 03:23:24 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:32921 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754950AbeBOIXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 03:23:22 -0500
X-Google-Smtp-Source: AH8x2240v5xsYHS5jCTQee5inETqtFFYBTH2Cr08VE/NxxxJ1TjvKxPUHBMlNePyzngRr49bQIbjsg==
From: Corentin Labbe <clabbe@baylibre.com>
To: airlied@linux.ie, inki.dae@samsung.com, jy0922.shim@samsung.com,
        kgene@kernel.org, krzk@kernel.org, kyungmin.park@samsung.com,
        sw0312.kim@samsung.com, chulspro.kim@samsung.com, yj44.cho@samsung.com
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] drm/exynos: remove exynos_drm_rotator.h
Date: Thu, 15 Feb 2018 08:23:15 +0000
Message-Id: <1518682995-10319-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since its inclusion in 2012 via commit bea8a429d91a ("drm/exynos: add rotator ipp driver")
this header is not used by any source files and is empty.
Lets just remove it.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/gpu/drm/exynos/exynos_drm_rotator.h | 19 -------------------
 1 file changed, 19 deletions(-)
 delete mode 100644 drivers/gpu/drm/exynos/exynos_drm_rotator.h

diff --git a/drivers/gpu/drm/exynos/exynos_drm_rotator.h b/drivers/gpu/drm/exynos/exynos_drm_rotator.h
deleted file mode 100644
index 71a0b4c0c1e8..000000000000
--- a/drivers/gpu/drm/exynos/exynos_drm_rotator.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * Copyright (c) 2012 Samsung Electronics Co., Ltd.
- *
- * Authors:
- *	YoungJun Cho <yj44.cho@samsung.com>
- *	Eunchul Kim <chulspro.kim@samsung.com>
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#ifndef	_EXYNOS_DRM_ROTATOR_H_
-#define	_EXYNOS_DRM_ROTATOR_H_
-
-/* TODO */
-
-#endif
-- 
2.13.6
