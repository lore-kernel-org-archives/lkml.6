Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965480AbeBURBL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 12:01:11 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38795 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965338AbeBURBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 12:01:07 -0500
X-Google-Smtp-Source: AH8x225toG7UOMalBy8ky2oAl7yv1W6XoCFfAmrbt1nuZxvQqrCbaA1RKfCLNKTD1YOJbIK09afgVg==
Date: Wed, 21 Feb 2018 18:01:04 +0100
From: Guillaume =?utf-8?Q?Dou=C3=A9zan-Grard?= <gdouezangrard@gmail.com>
To: Andy Shevchenko <andy@infradead.org>
Cc: Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 7/7] platform/x86: topstar-laptop: replace licence text
 with SPDX tag
Message-ID: <fd9f323f79cebb1b368d82ecafce77f7ca1dba15.1519231939.git.gdouezangrard@gmail.com>
References: <cover.1519231939.git.gdouezangrard@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1519231939.git.gdouezangrard@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace verbatim GPLv2 license copy with SPDX identifier.

Signed-off-by: Guillaume Douézan-Grard <gdouezangrard@gmail.com>
---
 drivers/platform/x86/topstar-laptop.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/platform/x86/topstar-laptop.c b/drivers/platform/x86/topstar-laptop.c
index 294729c98267..f7761d98c0fd 100644
--- a/drivers/platform/x86/topstar-laptop.c
+++ b/drivers/platform/x86/topstar-laptop.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Topstar Laptop ACPI Extras driver
  *
@@ -6,10 +7,6 @@
  *
  * Implementation inspired by existing x86 platform drivers, in special
  * asus/eepc/fujitsu-laptop, thanks to their authors.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-- 
2.16.1
