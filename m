Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966264AbeBUQKd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 11:10:33 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:47047 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938555AbeBUQKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 11:10:30 -0500
X-Google-Smtp-Source: AH8x227TsxCNUITrX65qRBQZbV+IMIuLF0FVbzoy/wgkmOr9gpl4yV6vPUe3fYN8L2Q+WWR1OsSqlg==
Date: Wed, 21 Feb 2018 17:10:25 +0100
From: Guillaume =?utf-8?Q?Dou=C3=A9zan-Grard?= <gdouezangrard@gmail.com>
To: Andy Shevchenko <andy@infradead.org>
Cc: Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/7] platform/x86: topstar-laptop: update copyright and
 fix some comments
Message-ID: <00f229d21923bec24c4318482491247c7f1c3255.1519228823.git.gdouezangrard@gmail.com>
References: <cover.1519228823.git.gdouezangrard@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1519228823.git.gdouezangrard@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as an author of the driver.

Signed-off-by: Guillaume Douézan-Grard <gdouezangrard@gmail.com>
---
 drivers/platform/x86/topstar-laptop.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/topstar-laptop.c b/drivers/platform/x86/topstar-laptop.c
index 30a6c5cbc58f..294729c98267 100644
--- a/drivers/platform/x86/topstar-laptop.c
+++ b/drivers/platform/x86/topstar-laptop.c
@@ -2,9 +2,10 @@
  * Topstar Laptop ACPI Extras driver
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
