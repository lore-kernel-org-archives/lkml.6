Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753556AbeAaJcD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 04:32:03 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:41693 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752494AbeAaJcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 04:32:01 -0500
X-Google-Smtp-Source: AH8x226m6VwouQmo/lgGBYpgd0vHZnqlAfKT7nFY/xGM/cJwvvkDX26D9W63D8dojY6csxuxG7xNVA==
From: Shannon Booth <shannon.ml.booth@gmail.com>
To: paul.burton@mips.com
Cc: linux-kernel@vger.kernel.org,
        Shannon Booth <shannon.ml.booth@gmail.com>
Subject: [PATCH] staging: auxdisplay: add missing MODULE_LICENSE()
Date: Wed, 31 Jan 2018 22:31:11 +1300
Message-Id: <1517391071-29042-1-git-send-email-shannon.ml.booth@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the compilation warning:

WARNING: modpost: missing MODULE_LICENSE() in drivers/auxdisplay/img-ascii-lcd.o

Signed-off-by: Shannon Booth <shannon.ml.booth@gmail.com>
---
 drivers/auxdisplay/img-ascii-lcd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/auxdisplay/img-ascii-lcd.c b/drivers/auxdisplay/img-ascii-lcd.c
index db040b3..9222c88 100644
--- a/drivers/auxdisplay/img-ascii-lcd.c
+++ b/drivers/auxdisplay/img-ascii-lcd.c
@@ -441,3 +441,5 @@ static struct platform_driver img_ascii_lcd_driver = {
 	.remove	= img_ascii_lcd_remove,
 };
 module_platform_driver(img_ascii_lcd_driver);
+
+MODULE_LICENSE("GPL v2");
-- 
2.7.4
