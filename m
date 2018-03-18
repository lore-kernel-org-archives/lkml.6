Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754689AbeCRUev (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 16:34:51 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:53946 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754606AbeCRUes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 16:34:48 -0400
From: Stefan Agner <stefan@agner.ch>
To: shawnguo@kernel.org, kernel@pengutronix.de, arnd@arndb.de
Cc: fabio.estevam@nxp.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 5/7] ARM: multi_v7_defconfig: add GPMI NAND controller support
Date: Sun, 18 Mar 2018 21:34:40 +0100
Message-Id: <20180318203442.19759-5-stefan@agner.ch>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180318203442.19759-1-stefan@agner.ch>
References: <20180318203442.19759-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add GPMI NAND controller support as required by some NXP i.MX6/7
based boards.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 66c32741a130..984e509d41bf 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -208,6 +208,7 @@ CONFIG_MTD_NAND_DENALI_DT=y
 CONFIG_MTD_NAND_OMAP2=y
 CONFIG_MTD_NAND_OMAP_BCH=y
 CONFIG_MTD_NAND_ATMEL=y
+CONFIG_MTD_NAND_GPMI_NAND=y
 CONFIG_MTD_NAND_BRCMNAND=y
 CONFIG_MTD_NAND_VF610_NFC=y
 CONFIG_MTD_NAND_DAVINCI=y
-- 
2.16.2
