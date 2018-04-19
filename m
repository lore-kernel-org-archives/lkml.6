Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753642AbeDSUBD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 16:01:03 -0400
Received: from sauhun.de ([88.99.104.3]:48082 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753568AbeDSUA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 16:00:58 -0400
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] i2c: i2c-pca-platform: move header to platform_data
Date: Thu, 19 Apr 2018 22:00:11 +0200
Message-Id: <20180419200015.15095-6-wsa@the-dreams.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180419200015.15095-1-wsa@the-dreams.de>
References: <20180419200015.15095-1-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This header only contains platform_data. Move it to the proper directory.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 arch/sh/boards/board-sh7785lcr.c                     | 2 +-
 drivers/i2c/busses/i2c-pca-platform.c                | 2 +-
 include/linux/{ => platform_data}/i2c-pca-platform.h | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename include/linux/{ => platform_data}/i2c-pca-platform.h (100%)

diff --git a/arch/sh/boards/board-sh7785lcr.c b/arch/sh/boards/board-sh7785lcr.c
index d7d232dea33e..3cba60ff7aab 100644
--- a/arch/sh/boards/board-sh7785lcr.c
+++ b/arch/sh/boards/board-sh7785lcr.c
@@ -17,7 +17,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
-#include <linux/i2c-pca-platform.h>
+#include <linux/platform_data/i2c-pca-platform.h>
 #include <linux/i2c-algo-pca.h>
 #include <linux/usb/r8a66597.h>
 #include <linux/sh_intc.h>
diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/i2c-pca-platform.c
index bc2707ffd409..de3fe6e828cb 100644
--- a/drivers/i2c/busses/i2c-pca-platform.c
+++ b/drivers/i2c/busses/i2c-pca-platform.c
@@ -20,7 +20,7 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/i2c-algo-pca.h>
-#include <linux/i2c-pca-platform.h>
+#include <linux/platform_data/i2c-pca-platform.h>
 #include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/io.h>
diff --git a/include/linux/i2c-pca-platform.h b/include/linux/platform_data/i2c-pca-platform.h
similarity index 100%
rename from include/linux/i2c-pca-platform.h
rename to include/linux/platform_data/i2c-pca-platform.h
-- 
2.11.0
