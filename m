Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932930AbeDXLsZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 07:48:25 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46502 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932908AbeDXLsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 07:48:20 -0400
X-Google-Smtp-Source: AIpwx48jayhs8oAolKK3b8++2US9rlwCmYYY09Pjof6k/kzF3D0JdvzTvcON5fgP/WbAbf/seHs67g==
From: Masanari Iida <standby24x7@gmail.com>
To: mchehab@kernel.org, trivial@kernel.org, linux-kernel@vger.kernel.org,
        ramesh.shanmugasundaram@bp.renesas.com
Cc: Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] [trivial] media:platform: Fix a typo in Kconfig
Date: Tue, 24 Apr 2018 20:48:13 +0900
Message-Id: <20180424114813.19015-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.17.0.140.g0b0cc9f86731
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix a spelling typo found in media/platform/Kconfig

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 drivers/media/platform/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index c7a1cf8a1b01..0a031bbb0f31 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -624,7 +624,7 @@ menuconfig SDR_PLATFORM_DRIVERS
 if SDR_PLATFORM_DRIVERS
 
 config VIDEO_RCAR_DRIF
-	tristate "Renesas Digitial Radio Interface (DRIF)"
+	tristate "Renesas Digital Radio Interface (DRIF)"
 	depends on VIDEO_V4L2 && HAS_DMA
 	depends on ARCH_RENESAS || COMPILE_TEST
 	select VIDEOBUF2_VMALLOC
-- 
2.17.0.140.g0b0cc9f86731
