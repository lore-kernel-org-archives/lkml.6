Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754769AbeCRUez (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 16:34:55 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:54050 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754626AbeCRUes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 16:34:48 -0400
From: Stefan Agner <stefan@agner.ch>
To: shawnguo@kernel.org, kernel@pengutronix.de, arnd@arndb.de
Cc: fabio.estevam@nxp.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 7/7] ARM: multi_v7_defconfig: add NXP graphics drivers
Date: Sun, 18 Mar 2018 21:34:42 +0100
Message-Id: <20180318203442.19759-7-stefan@agner.ch>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180318203442.19759-1-stefan@agner.ch>
References: <20180318203442.19759-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable drivers to support NXP graphics IPs such as:
- Etnaviv (e.g. i.MX6)
- DCU (e.g. Vybrid LS1021A)
- mxsfb (e.g. i.MX6UL/ULL/7)

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/configs/multi_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 61968bd6cccc..403d0e7156aa 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -623,6 +623,7 @@ CONFIG_DRM_ATMEL_HLCDC=m
 CONFIG_DRM_RCAR_DU=m
 CONFIG_DRM_RCAR_LVDS=y
 CONFIG_DRM_SUN4I=m
+CONFIG_DRM_FSL_DCU=m
 CONFIG_DRM_TEGRA=y
 CONFIG_DRM_PANEL_SAMSUNG_LD9040=m
 CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=m
@@ -630,6 +631,8 @@ CONFIG_DRM_PANEL_SIMPLE=y
 CONFIG_DRM_SII9234=m
 CONFIG_DRM_STI=m
 CONFIG_DRM_VC4=y
+CONFIG_DRM_ETNAVIV=m
+CONFIG_DRM_MXSFB=m
 CONFIG_FB_ARMCLCD=y
 CONFIG_FB_EFI=y
 CONFIG_FB_WM8505=y
-- 
2.16.2
