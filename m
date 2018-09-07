Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B260EC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60AC020844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:41:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60AC020844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbeIGRTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:19:31 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45713 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729212AbeIGRTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:19:31 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fyG27-0007bm-79; Fri, 07 Sep 2018 14:38:43 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <sha@pengutronix.de>)
        id 1fyG26-00061e-AJ; Fri, 07 Sep 2018 14:38:42 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-mtd@lists.infradead.org
Cc:     David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 01/25] ARM: imx_v6_v7_defconfig: update
Date:   Fri,  7 Sep 2018 14:36:22 +0200
Message-Id: <20180907123646.12688-2-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907123646.12688-1-s.hauer@pengutronix.de>
References: <20180907123646.12688-1-s.hauer@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/configs/imx_v6_v7_defconfig | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 7eca43ff69bb..2ce9626e213b 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -4,7 +4,7 @@ CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
-CONFIG_LOG_BUF_SHIFT=18
+CONFIG_LOG_BUF_SHIFT=24
 CONFIG_CGROUPS=y
 CONFIG_RELAY=y
 CONFIG_BLK_DEV_INITRD=y
@@ -214,14 +214,13 @@ CONFIG_POWER_SUPPLY=y
 CONFIG_SENSORS_GPIO_FAN=y
 CONFIG_SENSORS_IIO_HWMON=y
 CONFIG_THERMAL_WRITABLE_TRIPS=y
-CONFIG_CPU_THERMAL=y
-CONFIG_IMX_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_DA9062_WATCHDOG=y
 CONFIG_RN5T618_WATCHDOG=y
 CONFIG_IMX2_WDT=y
 CONFIG_MFD_DA9052_I2C=y
 CONFIG_MFD_DA9062=y
+CONFIG_MFD_DA9063=y
 CONFIG_MFD_MC13XXX_SPI=y
 CONFIG_MFD_MC13XXX_I2C=y
 CONFIG_MFD_RN5T618=y
@@ -231,6 +230,7 @@ CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_ANATOP=y
 CONFIG_REGULATOR_DA9052=y
 CONFIG_REGULATOR_DA9062=y
+CONFIG_REGULATOR_DA9063=y
 CONFIG_REGULATOR_GPIO=y
 CONFIG_REGULATOR_MC13783=y
 CONFIG_REGULATOR_MC13892=y
@@ -299,10 +299,6 @@ CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_MXC=y
 CONFIG_USB_STORAGE=y
-CONFIG_USB_CHIPIDEA=y
-CONFIG_USB_CHIPIDEA_UDC=y
-CONFIG_USB_CHIPIDEA_HOST=y
-CONFIG_USB_CHIPIDEA_ULPI=y
 CONFIG_USB_SERIAL=m
 CONFIG_USB_SERIAL_GENERIC=y
 CONFIG_USB_SERIAL_FTDI_SIO=m
@@ -411,9 +407,14 @@ CONFIG_MSDOS_FS=m
 CONFIG_VFAT_FS=y
 CONFIG_JFFS2_FS=y
 CONFIG_UBIFS_FS=y
+CONFIG_UBIFS_FS_ENCRYPTION=y
+CONFIG_UBIFS_FS_AUTHENTICATION=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_NFS_V4=y
+CONFIG_NFS_V4_1=y
+CONFIG_NFS_V4_2=y
+CONFIG_NFS_V4_1_MIGRATION=y
 CONFIG_ROOT_NFS=y
 CONFIG_NLS_DEFAULT="cp437"
 CONFIG_NLS_CODEPAGE_437=y
-- 
2.18.0

