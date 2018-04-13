Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753878AbeDMIdX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 04:33:23 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38591 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750973AbeDMIdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 04:33:20 -0400
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] MAINTAINERS: add personal addresses for Sascha and me
Date: Fri, 13 Apr 2018 10:33:12 +0200
Message-Id: <20180413083312.11213-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.16.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The idea behind using kernel@pengutronix.de (i.e. the mail alias for the
kernel people at Pengutronix) as email address was to have a backup when
a given developer is on vacation or run over by a bus. Make this more
explicit by adding the alias as reviewer and use the personal address
for Sascha and me.

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

I'm not sure how feels responsible to apply such a patch. Maybe akpm?

Best regards
Uwe

 MAINTAINERS | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b60179d948bb..efcc1794eea7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1373,7 +1373,8 @@ F:	arch/arm/mach-ebsa110/
 F:	drivers/net/ethernet/amd/am79c961a.*
 
 ARM/ENERGY MICRO (SILICON LABS) EFM32 SUPPORT
-M:	Uwe Kleine-König <kernel@pengutronix.de>
+M:	Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
+R:	Pengutronix Kernel Team <kernel@pengutronix.de>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 N:	efm32
@@ -1401,7 +1402,8 @@ F:	arch/arm/mach-footbridge/
 
 ARM/FREESCALE IMX / MXC ARM ARCHITECTURE
 M:	Shawn Guo <shawnguo@kernel.org>
-M:	Sascha Hauer <kernel@pengutronix.de>
+M:	Sascha Hauer <s.hauer@pengutronix.de>
+R:	Pengutronix Kernel Team <kernel@pengutronix.de>
 R:	Fabio Estevam <fabio.estevam@nxp.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
@@ -1416,7 +1418,8 @@ F:	include/soc/imx/
 
 ARM/FREESCALE VYBRID ARM ARCHITECTURE
 M:	Shawn Guo <shawnguo@kernel.org>
-M:	Sascha Hauer <kernel@pengutronix.de>
+M:	Sascha Hauer <s.hauer@pengutronix.de>
+R:	Pengutronix Kernel Team <kernel@pengutronix.de>
 R:	Stefan Agner <stefan@agner.ch>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
@@ -5653,7 +5656,8 @@ F:	drivers/net/ethernet/freescale/fec.h
 F:	Documentation/devicetree/bindings/net/fsl-fec.txt
 
 FREESCALE IMX / MXC FRAMEBUFFER DRIVER
-M:	Sascha Hauer <kernel@pengutronix.de>
+M:	Sascha Hauer <s.hauer@pengutronix.de>
+R:	Pengutronix Kernel Team <kernel@pengutronix.de>
 L:	linux-fbdev@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
@@ -12790,7 +12794,8 @@ F:	include/linux/siphash.h
 
 SIOX
 M:	Gavin Schenk <g.schenk@eckelmann.de>
-M:	Uwe Kleine-König <kernel@pengutronix.de>
+M:	Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
+R:	Pengutronix Kernel Team <kernel@pengutronix.de>
 S:	Supported
 F:	drivers/siox/*
 F:	include/trace/events/siox.h
-- 
2.16.3
