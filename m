Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753338AbeB0Nhw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 08:37:52 -0500
Received: from mail.bootlin.com ([62.4.15.54]:54778 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752107AbeB0Nhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 08:37:50 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Arnd Bergmann <arnd@arndb.de>, arm@kernel.org
Cc: Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] ARM: reorder mach-*/Kconfig inclusions
Date: Tue, 27 Feb 2018 14:37:47 +0100
Message-Id: <20180227133747.23517-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorder the mach-* inclusions so the comment about them being ordered
alphabetically ends up being true.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm/Kconfig | 52 ++++++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7e3d53575486..d868983faf20 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -709,8 +709,6 @@ config ARCH_VIRT
 # Kconfigs may be included either alphabetically (according to the
 # plat- suffix) or along side the corresponding mach-* source.
 #
-source "arch/arm/mach-mvebu/Kconfig"
-
 source "arch/arm/mach-actions/Kconfig"
 
 source "arch/arm/mach-alpine/Kconfig"
@@ -719,6 +717,8 @@ source "arch/arm/mach-artpec/Kconfig"
 
 source "arch/arm/mach-asm9260/Kconfig"
 
+source "arch/arm/mach-aspeed/Kconfig"
+
 source "arch/arm/mach-at91/Kconfig"
 
 source "arch/arm/mach-axxia/Kconfig"
@@ -739,6 +739,9 @@ source "arch/arm/mach-dove/Kconfig"
 
 source "arch/arm/mach-ep93xx/Kconfig"
 
+source "arch/arm/mach-exynos/Kconfig"
+source "arch/arm/plat-samsung/Kconfig"
+
 source "arch/arm/mach-footbridge/Kconfig"
 
 source "arch/arm/mach-gemini/Kconfig"
@@ -747,31 +750,33 @@ source "arch/arm/mach-highbank/Kconfig"
 
 source "arch/arm/mach-hisi/Kconfig"
 
+source "arch/arm/mach-imx/Kconfig"
+
 source "arch/arm/mach-integrator/Kconfig"
 
+source "arch/arm/mach-iop13xx/Kconfig"
+
 source "arch/arm/mach-iop32x/Kconfig"
 
 source "arch/arm/mach-iop33x/Kconfig"
 
-source "arch/arm/mach-iop13xx/Kconfig"
-
 source "arch/arm/mach-ixp4xx/Kconfig"
 
 source "arch/arm/mach-keystone/Kconfig"
 
 source "arch/arm/mach-ks8695/Kconfig"
 
+source "arch/arm/mach-mediatek/Kconfig"
+
 source "arch/arm/mach-meson/Kconfig"
 
-source "arch/arm/mach-moxart/Kconfig"
+source "arch/arm/mach-mmp/Kconfig"
 
-source "arch/arm/mach-aspeed/Kconfig"
+source "arch/arm/mach-moxart/Kconfig"
 
 source "arch/arm/mach-mv78xx0/Kconfig"
 
-source "arch/arm/mach-imx/Kconfig"
-
-source "arch/arm/mach-mediatek/Kconfig"
+source "arch/arm/mach-mvebu/Kconfig"
 
 source "arch/arm/mach-mxs/Kconfig"
 
@@ -789,23 +794,31 @@ source "arch/arm/mach-omap2/Kconfig"
 
 source "arch/arm/mach-orion5x/Kconfig"
 
+source "arch/arm/mach-oxnas/Kconfig"
+
 source "arch/arm/mach-picoxcell/Kconfig"
 
+source "arch/arm/mach-prima2/Kconfig"
+
 source "arch/arm/mach-pxa/Kconfig"
 source "arch/arm/plat-pxa/Kconfig"
 
-source "arch/arm/mach-mmp/Kconfig"
-
-source "arch/arm/mach-oxnas/Kconfig"
-
 source "arch/arm/mach-qcom/Kconfig"
 
 source "arch/arm/mach-realview/Kconfig"
 
 source "arch/arm/mach-rockchip/Kconfig"
 
+source "arch/arm/mach-s3c24xx/Kconfig"
+
+source "arch/arm/mach-s3c64xx/Kconfig"
+
+source "arch/arm/mach-s5pv210/Kconfig"
+
 source "arch/arm/mach-sa1100/Kconfig"
 
+source "arch/arm/mach-shmobile/Kconfig"
+
 source "arch/arm/mach-socfpga/Kconfig"
 
 source "arch/arm/mach-spear/Kconfig"
@@ -814,21 +827,8 @@ source "arch/arm/mach-sti/Kconfig"
 
 source "arch/arm/mach-stm32/Kconfig"
 
-source "arch/arm/mach-s3c24xx/Kconfig"
-
-source "arch/arm/mach-s3c64xx/Kconfig"
-
-source "arch/arm/mach-s5pv210/Kconfig"
-
-source "arch/arm/mach-exynos/Kconfig"
-source "arch/arm/plat-samsung/Kconfig"
-
-source "arch/arm/mach-shmobile/Kconfig"
-
 source "arch/arm/mach-sunxi/Kconfig"
 
-source "arch/arm/mach-prima2/Kconfig"
-
 source "arch/arm/mach-tango/Kconfig"
 
 source "arch/arm/mach-tegra/Kconfig"
-- 
2.16.2
