Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754813AbeCRUfv (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 16:35:51 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:53683 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754383AbeCRUer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 16:34:47 -0400
From: Stefan Agner <stefan@agner.ch>
To: shawnguo@kernel.org, kernel@pengutronix.de, arnd@arndb.de
Cc: fabio.estevam@nxp.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 3/7] ARM: multi_v7_defconfig: configure I2C driver built-in
Date: Sun, 18 Mar 2018 21:34:38 +0100
Message-Id: <20180318203442.19759-3-stefan@agner.ch>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180318203442.19759-1-stefan@agner.ch>
References: <20180318203442.19759-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PMIC often require the I2C bus, and the PMIC regulators might be
necessary to power on eMMC/SD-card or other supplies required
for successful boot. Make sure I2C driver for i.MX devices is
built-in.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/configs/multi_v7_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 608bc85856a1..fc142dc75092 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -368,7 +368,7 @@ CONFIG_I2C_DIGICOLOR=m
 CONFIG_I2C_EMEV2=m
 CONFIG_I2C_GPIO=m
 CONFIG_I2C_EXYNOS5=y
-CONFIG_I2C_IMX=m
+CONFIG_I2C_IMX=y
 CONFIG_I2C_MV64XXX=y
 CONFIG_I2C_RIIC=y
 CONFIG_I2C_RK3X=y
-- 
2.16.2
