Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754834AbeCRUgQ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 16:36:16 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:53641 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754375AbeCRUer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 16:34:47 -0400
From: Stefan Agner <stefan@agner.ch>
To: shawnguo@kernel.org, kernel@pengutronix.de, arnd@arndb.de
Cc: fabio.estevam@nxp.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 2/7] ARM: multi_v7_defconfig: enable thermal driver for i.MX devices
Date: Sun, 18 Mar 2018 21:34:37 +0100
Message-Id: <20180318203442.19759-2-stefan@agner.ch>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180318203442.19759-1-stefan@agner.ch>
References: <20180318203442.19759-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the i.MX thermal driver required for i.MX SoC family.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 6395425854cc..608bc85856a1 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -463,6 +463,7 @@ CONFIG_SENSORS_PWM_FAN=m
 CONFIG_SENSORS_INA2XX=m
 CONFIG_CPU_THERMAL=y
 CONFIG_BRCMSTB_THERMAL=m
+CONFIG_IMX_THERMAL=y
 CONFIG_ROCKCHIP_THERMAL=y
 CONFIG_RCAR_THERMAL=y
 CONFIG_ARMADA_THERMAL=y
-- 
2.16.2
