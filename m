Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754525AbeDYN2O (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 09:28:14 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:63145 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753615AbeDYN2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 09:28:09 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Santosh Shilimkar <ssantosh@kernel.org>
CC: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        <kishon@ti.com>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/3] ARM: configs: keystone: Enable CONFIG_MMC_SDHCI_OMAP
Date: Wed, 25 Apr 2018 18:57:46 +0530
Message-ID: <20180425132746.13911-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425132746.13911-1-kishon@ti.com>
References: <20180425132746.13911-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CONFIG_MMC_SDHCI_OMAP so that TI's K2G SoC
can use sdhci-omap driver for MMC/SD controller.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/configs/keystone_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index 2536c231eea1..21a6ce4ef9bc 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -170,7 +170,10 @@ CONFIG_USB_DWC3=y
 CONFIG_NOP_USB_XCEIV=y
 CONFIG_KEYSTONE_USB_PHY=y
 CONFIG_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_OMAP_HS=y
+CONFIG_MMC_SDHCI_OMAP=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
-- 
2.17.0
