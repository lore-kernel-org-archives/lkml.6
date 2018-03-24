Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751999AbeCXKSZ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 06:18:25 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35101 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751755AbeCXKSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 06:18:23 -0400
X-Google-Smtp-Source: AG47ELtcTNUOx89YMaNTSvyTwy3kq7hRhFUlAPo01Bw62sGVjzZ2D7XK+zsiGYeJBOhk+KQYg2m4Jw==
Date: Sat, 24 Mar 2018 15:47:27 +0530
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: boris.brezillon@free-electrons.com
Cc: Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: nand: do not initialise statics to 0 or NULL
Message-ID: <20180324101727.GA748@seema-Inspiron-15-3567>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl error to ams-delta.c.
ERROR: do not initialise statics to 0 or NULL

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
 drivers/mtd/nand/ams-delta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/ams-delta.c b/drivers/mtd/nand/ams-delta.c
index 6e7f6e0..8e89452 100644
--- a/drivers/mtd/nand/ams-delta.c
+++ b/drivers/mtd/nand/ams-delta.c
@@ -35,7 +35,7 @@
 /*
  * MTD structure for E3 (Delta)
  */
-static struct mtd_info *ams_delta_mtd = NULL;
+static struct mtd_info *ams_delta_mtd;
 
 /*
  * Define partitions for flash devices
-- 
2.7.4
