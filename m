Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752658AbeDSMDV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 08:03:21 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33079 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751170AbeDSMDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 08:03:19 -0400
X-Google-Smtp-Source: AIpwx4+ia01jmDmgMTQiWP0vyvfDI4v/ht43/x63jEArQZ33f+BHybZvCO59o6UIkPhunzCSVcc0XQ==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, David Lechner <david@lechnology.com>,
        Suman Anna <s-anna@ti.com>, Aparna Balasubramanian <aparnab@ti.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Adam Ford <aford173@gmail.com>, Russell King <linux@armlinux.org.uk>,
        Kevin Hilman <khilman@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] davinci_all_defconfig: enable support for remoteproc drivers
Date: Thu, 19 Apr 2018 14:03:13 +0200
Message-Id: <20180419120313.31359-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Enable the remoteproc framework and the da8xx remoteproc driver by
default in the davinci defconfig.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/configs/davinci_all_defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index c302a04e8cbc..21b2d7791df4 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -56,7 +56,7 @@ CONFIG_IP_PNP_DHCP=y
 CONFIG_NETFILTER=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
-# CONFIG_FW_LOADER is not set
+CONFIG_FW_LOADER=m
 CONFIG_DMA_CMA=y
 CONFIG_DA8XX_MSTPRI=y
 CONFIG_MTD=m
@@ -212,6 +212,8 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_OMAP=m
 CONFIG_DMADEVICES=y
 CONFIG_TI_EDMA=y
+CONFIG_REMOTEPROC=m
+CONFIG_DA8XX_REMOTEPROC=m
 CONFIG_MEMORY=y
 CONFIG_TI_AEMIF=m
 CONFIG_DA8XX_DDRCTL=y
-- 
2.17.0
