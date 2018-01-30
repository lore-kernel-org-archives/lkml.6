Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753062AbeA3THJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 14:07:09 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36616 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752996AbeA3THF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 14:07:05 -0500
X-Google-Smtp-Source: AH8x2273rnnRedJmQhWtZxT6HrjEnDhWJFoQFx9paOrha4iH6z7VXUT6TVbWhKbQCYVSlS6W20wVyA==
From: Ulf Magnusson <ulfalizer@gmail.com>
To: linux-kbuild@vger.kernel.org
Cc: yamada.masahiro@socionext.com, mcgrof@kernel.org,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Hans de Goede <j.w.r.degoede@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Michal Simek <michal.simek@xilinx.com>, Arnd Bergmann <arnd@arndb.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] video: fbdev: kconfig: Remove empty help text
Date: Tue, 30 Jan 2018 20:05:24 +0100
Message-Id: <20180130190555.6577-3-ulfalizer@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180130190555.6577-1-ulfalizer@gmail.com>
References: <20180130190555.6577-1-ulfalizer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding a warning ("kconfig: Warn if help text is
blank"): https://lkml.org/lkml/2018/1/30/516

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
---
 drivers/video/fbdev/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 6962b4583fd7..11e699f1062b 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1156,7 +1156,6 @@ config FB_I810_I2C
 	bool "Enable DDC Support"
 	depends on FB_I810 && FB_I810_GTF
 	select FB_DDC
-	help
 
 config FB_LE80578
 	tristate "Intel LE80578 (Vermilion) support"
-- 
2.14.1
