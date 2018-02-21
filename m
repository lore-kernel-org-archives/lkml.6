Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966079AbeBUPNy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 10:13:54 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40091 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934979AbeBUPNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 10:13:51 -0500
X-Google-Smtp-Source: AH8x226OGnMETzpfn4uGSp/bNen8o6zkItMxyBbBTy88z8bV61JdvRT2xnZs3jEEHlAQO2r3u7+PtA==
Date: Wed, 21 Feb 2018 16:13:48 +0100
From: Guillaume =?utf-8?Q?Dou=C3=A9zan-Grard?= <gdouezangrard@gmail.com>
To: Andy Shevchenko <andy@infradead.org>
Cc: Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/6] platform/x86: topstar-laptop: update copyright and
 fix some comments
Message-ID: <f5dd2db62302ce21ed3234125924dfd81e123749.1519225570.git.gdouezangrard@gmail.com>
References: <cover.1519225570.git.gdouezangrard@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1519225570.git.gdouezangrard@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Guillaume Douézan-Grard <gdouezangrard@gmail.com>
---
 drivers/platform/x86/topstar-laptop.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/topstar-laptop.c b/drivers/platform/x86/topstar-laptop.c
index bf9761092c7e..294729c98267 100644
--- a/drivers/platform/x86/topstar-laptop.c
+++ b/drivers/platform/x86/topstar-laptop.c
@@ -1,10 +1,11 @@
 /*
- * ACPI driver for Topstar notebooks (hotkeys support only)
+ * Topstar Laptop ACPI Extras driver
  *
  * Copyright (c) 2009 Herton Ronaldo Krzesinski <herton@mandriva.com.br>
+ * Copyright (c) 2018 Guillaume Douézan-Grard
  *
  * Implementation inspired by existing x86 platform drivers, in special
- * asus/eepc/fujitsu-laptop, thanks to their authors
+ * asus/eepc/fujitsu-laptop, thanks to their authors.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -397,5 +398,6 @@ module_init(topstar_laptop_init);
 module_exit(topstar_laptop_exit);
 
 MODULE_AUTHOR("Herton Ronaldo Krzesinski");
+MODULE_AUTHOR("Guillaume Douézan-Grard");
 MODULE_DESCRIPTION("Topstar Laptop ACPI Extras driver");
 MODULE_LICENSE("GPL");
-- 
2.16.1
