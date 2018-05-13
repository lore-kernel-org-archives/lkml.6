Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751092AbeEMDLw (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 23:11:52 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:41446 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750844AbeEMDLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 23:11:50 -0400
X-Google-Smtp-Source: AB8JxZr3mHaYg/Qvk0wqA2rXdXvma3Xlss+Ko/bqJq+ck9d742fYll0yFTjghmguVkDBx9lBqpqlDQ==
From: Jacob Enders <jacobenders1@gmail.com>
To: geert@linux-m68k.org
Cc: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jacob <jacobenders1@gmail.com>
Subject: [PATCH] drivers: zorro: zorro.c: Added a blank line after declarations.
Date: Sat, 12 May 2018 23:11:40 -0400
Message-Id: <20180513031140.7474-1-jacobenders1@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacob <jacobenders1@gmail.com>

Fixed a coding style issue.

Signed-off-by: Jacob Enders <jacobenders1@gmail.com>
---
 drivers/zorro/zorro.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/zorro/zorro.c b/drivers/zorro/zorro.c
index 47728477297e..67fa900572a9 100644
--- a/drivers/zorro/zorro.c
+++ b/drivers/zorro/zorro.c
@@ -101,6 +101,7 @@ static void __init mark_region(unsigned long start, unsigned long end,
 	end = end > Z2RAM_END ? Z2RAM_SIZE : end-Z2RAM_START;
 	while (start < end) {
 		u32 chunk = start>>Z2RAM_CHUNKSHIFT;
+
 		if (flag)
 			set_bit(chunk, zorro_unused_z2ram);
 		else
@@ -117,6 +118,7 @@ static struct resource __init *zorro_find_parent_resource(
 
 	for (i = 0; i < bridge->num_resources; i++) {
 		struct resource *r = &bridge->resource[i];
+
 		if (zorro_resource_start(z) >= r->start &&
 		    zorro_resource_end(z) <= r->end)
 			return r;
@@ -168,6 +170,7 @@ static int __init amiga_zorro_probe(struct platform_device *pdev)
 		if (z->id == ZORRO_PROD_GVP_EPC_BASE) {
 			/* GVP quirk */
 			unsigned long magic = zi->boardaddr + 0x8000;
+
 			z->id |= *(u16 *)ZTWO_VADDR(magic) & GVP_PRODMASK;
 		}
 		z->slotaddr = zi->slotaddr;
-- 
2.11.0
