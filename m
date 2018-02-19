Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932249AbeBSW6L (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 17:58:11 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:50302 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932195AbeBSW6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 17:58:09 -0500
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: linux-kernel@vger.kernel.org
Cc: Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH] MAINTAINERS: Update email address for Miquel Raynal
Date: Mon, 19 Feb 2018 23:57:59 +0100
Message-Id: <20180219225759.3427-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Free Electrons is now Bootlin.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index e18cab73e209..6cc2d5a94cc2 100644
--- a/.mailmap
+++ b/.mailmap
@@ -126,6 +126,7 @@ Mayuresh Janorkar <mayur@ti.com>
 Michael Buesch <m@bues.ch>
 Michel Dänzer <michel@tungstengraphics.com>
 Miodrag Dinic <miodrag.dinic@mips.com> <miodrag.dinic@imgtec.com>
+Miquel Raynal <miquel.raynal@bootlin.com> <miquel.raynal@free-electrons.com>
 Mitesh shah <mshah@teja.com>
 Mohit Kumar <mohit.kumar@st.com> <mohit.kumar.dhaka@gmail.com>
 Morten Welinder <terra@gnome.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index 1efb94e6a8b3..1b0972015358 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8471,7 +8471,7 @@ S:	Odd Fixes
 F:	drivers/net/wireless/marvell/mwl8k.c
 
 MARVELL NAND CONTROLLER DRIVER
-M:	Miquel Raynal <miquel.raynal@free-electrons.com>
+M:	Miquel Raynal <miquel.raynal@bootlin.com>
 L:	linux-mtd@lists.infradead.org
 S:	Maintained
 F:	drivers/mtd/nand/raw/marvell_nand.c
-- 
2.14.1
