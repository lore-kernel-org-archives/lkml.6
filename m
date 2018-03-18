Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754646AbeCRUP0 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 16:15:26 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:52724 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754316AbeCRUPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 16:15:18 -0400
From: Stefan Agner <stefan@agner.ch>
To: shawnguo@kernel.org, kernel@pengutronix.de
Cc: fabio.estevam@nxp.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 2/3] ARM: imx_v6_v7_defconfig: add mwifiex driver
Date: Sun, 18 Mar 2018 21:15:09 +0100
Message-Id: <20180318201510.13086-2-stefan@agner.ch>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180318201510.13086-1-stefan@agner.ch>
References: <20180318201510.13086-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Marvell mwifiex driver which is required to drive the
Wi2Wi WM828CC6 wireless module found on Colibri iMX6ULL.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/configs/imx_v6_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 8947769cd449..67db78f8c9df 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -153,6 +153,9 @@ CONFIG_USB_RTL8152=m
 CONFIG_USB_USBNET=y
 CONFIG_USB_NET_CDC_EEM=m
 CONFIG_BRCMFMAC=m
+CONFIG_MWIFIEX=m
+CONFIG_MWIFIEX_SDIO=m
+CONFIG_MWIFIEX_PCIE=m
 CONFIG_WL12XX=m
 CONFIG_WL18XX=m
 CONFIG_WLCORE_SDIO=m
-- 
2.16.2
