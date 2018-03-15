Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752290AbeCOUWH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 16:22:07 -0400
Received: from 10.mo69.mail-out.ovh.net ([46.105.73.241]:58407 "EHLO
        10.mo69.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751945AbeCOUWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 16:22:06 -0400
From: Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
To: computersforpeace@gmail.com, dwmw2@infradead.org, richard@nod.at,
        boris.brezillon@free-electrons.com, marek.vasut@gmail.com,
        linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
Subject: [PATCH] MAINTAINERS: update maintainers for MTD and SPI NOR subsystems
Date: Thu, 15 Mar 2018 20:04:38 +0100
Message-Id: <20180315190438.4832-1-cyrille.pitchen@wedev4u.fr>
X-Mailer: git-send-email 2.14.1
X-Ovh-Tracer-Id: 14110340583696324574
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtgedrtdehgdduvdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecufedttdenuc
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove myself as MTD and SPI NOR maintainer.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3bdc260e36b7..7892db9a9494 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9037,7 +9037,6 @@ M:	Brian Norris <computersforpeace@gmail.com>
 M:	Boris Brezillon <boris.brezillon@free-electrons.com>
 M:	Marek Vasut <marek.vasut@gmail.com>
 M:	Richard Weinberger <richard@nod.at>
-M:	Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
 L:	linux-mtd@lists.infradead.org
 W:	http://www.linux-mtd.infradead.org/
 Q:	http://patchwork.ozlabs.org/project/linux-mtd/list/
@@ -13006,7 +13005,6 @@ F:	arch/arm/boot/dts/spear*
 F:	arch/arm/mach-spear/
 
 SPI NOR SUBSYSTEM
-M:	Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
 M:	Marek Vasut <marek.vasut@gmail.com>
 L:	linux-mtd@lists.infradead.org
 W:	http://www.linux-mtd.infradead.org/
-- 
2.14.1
