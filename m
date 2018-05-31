Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754689AbeEaU0W (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 16:26:22 -0400
Received: from vern.gendns.com ([206.190.152.46]:41424 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754533AbeEaU0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 16:26:14 -0400
From: David Lechner <david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
Cc: David Lechner <david@lechnology.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: davinci_all_defconfig: Enable Bluetooth
Date: Thu, 31 May 2018 15:25:49 -0500
Message-Id: <20180531202549.11255-3-david@lechnology.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180531202549.11255-1-david@lechnology.com>
References: <20180531202549.11255-1-david@lechnology.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables Bluetooth modules in davinic_all_defconfig needed for LEGO
MINDSTORMS EV3.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/configs/davinci_all_defconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index a1b6e106b867..f8448c4703c1 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -54,6 +54,13 @@ CONFIG_INET=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_NETFILTER=y
+CONFIG_BT=m
+CONFIG_BT_RFCOMM=m
+CONFIG_BT_BNEP=m
+CONFIG_BT_HIDP=m
+CONFIG_BT_LEDS=y
+CONFIG_BT_HCIUART=m
+CONFIG_BT_HCIUART_LL=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_FW_LOADER=m
@@ -113,6 +120,7 @@ CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=3
 CONFIG_SERIAL_8250_RUNTIME_UARTS=3
 CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_SERIAL_DEV_BUS=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
@@ -212,6 +220,7 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_OMAP=m
 CONFIG_DMADEVICES=y
 CONFIG_TI_EDMA=y
+CONFIG_COMMON_CLK_PWM=m
 CONFIG_REMOTEPROC=m
 CONFIG_DA8XX_REMOTEPROC=m
 CONFIG_MEMORY=y
-- 
2.17.0
