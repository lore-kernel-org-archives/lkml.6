Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E81EC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05ACF2070C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfAGJaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 04:30:46 -0500
Received: from andre.telenet-ops.be ([195.130.132.53]:52210 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfAGJap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 04:30:45 -0500
Received: from ramsan ([84.194.111.163])
        by andre.telenet-ops.be with bizsmtp
        id MMWe1z0093XaVaC01MWeXs; Mon, 07 Jan 2019 10:30:38 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1ggRF0-0003Kp-56; Mon, 07 Jan 2019 10:30:38 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1ggRF0-0003tu-3P; Mon, 07 Jan 2019 10:30:38 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k/defconfig: Drop NET_VENDOR_<FOO>=n
Date:   Mon,  7 Jan 2019 10:30:37 +0100
Message-Id: <20190107093037.14952-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling NET_VENDOR_* Kconfig options does not directly affect the
kernel, so there is no need to explicitly disable them.
The individual network drivers under them are still disabled.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/configs/amcore_defconfig   | 20 -----------------
 arch/m68k/configs/amiga_defconfig    | 32 ---------------------------
 arch/m68k/configs/apollo_defconfig   | 29 ------------------------
 arch/m68k/configs/atari_defconfig    | 28 -----------------------
 arch/m68k/configs/bvme6000_defconfig | 28 -----------------------
 arch/m68k/configs/hp300_defconfig    | 29 ------------------------
 arch/m68k/configs/mac_defconfig      | 29 ------------------------
 arch/m68k/configs/multi_defconfig    | 29 ------------------------
 arch/m68k/configs/mvme147_defconfig  | 29 ------------------------
 arch/m68k/configs/mvme16x_defconfig  | 28 -----------------------
 arch/m68k/configs/q40_defconfig      | 33 ----------------------------
 arch/m68k/configs/sun3_defconfig     | 28 -----------------------
 arch/m68k/configs/sun3x_defconfig    | 29 ------------------------
 13 files changed, 371 deletions(-)

diff --git a/arch/m68k/configs/amcore_defconfig b/arch/m68k/configs/amcore_defconfig
index 131b4101ae5df2e6..1ba10d57ddb14fec 100644
--- a/arch/m68k/configs/amcore_defconfig
+++ b/arch/m68k/configs/amcore_defconfig
@@ -55,27 +55,7 @@ CONFIG_MTD_UCLINUX=y
 CONFIG_MTD_PLATRAM=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_NETDEVICES=y
-# CONFIG_NET_VENDOR_AMAZON is not set
-# CONFIG_NET_VENDOR_ARC is not set
-# CONFIG_NET_CADENCE is not set
-# CONFIG_NET_VENDOR_BROADCOM is not set
 CONFIG_DM9000=y
-# CONFIG_NET_VENDOR_EZCHIP is not set
-# CONFIG_NET_VENDOR_INTEL is not set
-# CONFIG_NET_VENDOR_MARVELL is not set
-# CONFIG_NET_VENDOR_MICREL is not set
-# CONFIG_NET_VENDOR_NATSEMI is not set
-# CONFIG_NET_VENDOR_NETRONOME is not set
-# CONFIG_NET_VENDOR_QUALCOMM is not set
-# CONFIG_NET_VENDOR_RENESAS is not set
-# CONFIG_NET_VENDOR_ROCKER is not set
-# CONFIG_NET_VENDOR_SAMSUNG is not set
-# CONFIG_NET_VENDOR_SEEQ is not set
-# CONFIG_NET_VENDOR_SMSC is not set
-# CONFIG_NET_VENDOR_STMICRO is not set
-# CONFIG_NET_VENDOR_SYNOPSYS is not set
-# CONFIG_NET_VENDOR_VIA is not set
-# CONFIG_NET_VENDOR_WIZNET is not set
 # CONFIG_WLAN is not set
 # CONFIG_INPUT is not set
 # CONFIG_SERIO is not set
diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index de88ccaeb92ab5fe..525421ae277d6ebc 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -396,44 +396,12 @@ CONFIG_MACSEC=m
 CONFIG_NETCONSOLE=m
 CONFIG_NETCONSOLE_DYNAMIC=y
 CONFIG_VETH=m
-# CONFIG_NET_VENDOR_3COM is not set
-# CONFIG_NET_VENDOR_ALACRITECH is not set
-# CONFIG_NET_VENDOR_AMAZON is not set
 CONFIG_A2065=y
 CONFIG_ARIADNE=y
-# CONFIG_NET_VENDOR_AQUANTIA is not set
-# CONFIG_NET_VENDOR_ARC is not set
-# CONFIG_NET_VENDOR_AURORA is not set
-# CONFIG_NET_VENDOR_BROADCOM is not set
-# CONFIG_NET_VENDOR_CADENCE is not set
-# CONFIG_NET_VENDOR_CAVIUM is not set
-# CONFIG_NET_VENDOR_CIRRUS is not set
-# CONFIG_NET_VENDOR_CORTINA is not set
-# CONFIG_NET_VENDOR_EZCHIP is not set
-# CONFIG_NET_VENDOR_HP is not set
-# CONFIG_NET_VENDOR_HUAWEI is not set
-# CONFIG_NET_VENDOR_INTEL is not set
-# CONFIG_NET_VENDOR_MARVELL is not set
-# CONFIG_NET_VENDOR_MICREL is not set
-# CONFIG_NET_VENDOR_MICROSEMI is not set
-# CONFIG_NET_VENDOR_NETRONOME is not set
-# CONFIG_NET_VENDOR_NI is not set
 CONFIG_XSURF100=y
 CONFIG_HYDRA=y
 CONFIG_APNE=y
 CONFIG_ZORRO8390=y
-# CONFIG_NET_VENDOR_QUALCOMM is not set
-# CONFIG_NET_VENDOR_RENESAS is not set
-# CONFIG_NET_VENDOR_ROCKER is not set
-# CONFIG_NET_VENDOR_SAMSUNG is not set
-# CONFIG_NET_VENDOR_SEEQ is not set
-# CONFIG_NET_VENDOR_SOLARFLARE is not set
-# CONFIG_NET_VENDOR_SMSC is not set
-# CONFIG_NET_VENDOR_SOCIONEXT is not set
-# CONFIG_NET_VENDOR_STMICRO is not set
-# CONFIG_NET_VENDOR_SYNOPSYS is not set
-# CONFIG_NET_VENDOR_VIA is not set
-# CONFIG_NET_VENDOR_WIZNET is not set
 CONFIG_PPP=m
 CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
index 87b0f7f3973df2d9..db0e654a88d537d0 100644
--- a/arch/m68k/configs/apollo_defconfig
+++ b/arch/m68k/configs/apollo_defconfig
@@ -375,35 +375,6 @@ CONFIG_MACSEC=m
 CONFIG_NETCONSOLE=m
 CONFIG_NETCONSOLE_DYNAMIC=y
 CONFIG_VETH=m
-# CONFIG_NET_VENDOR_ALACRITECH is not set
-# CONFIG_NET_VENDOR_AMAZON is not set
-# CONFIG_NET_VENDOR_AQUANTIA is not set
-# CONFIG_NET_VENDOR_ARC is not set
-# CONFIG_NET_VENDOR_AURORA is not set
-# CONFIG_NET_VENDOR_BROADCOM is not set
-# CONFIG_NET_VENDOR_CADENCE is not set
-# CONFIG_NET_VENDOR_CAVIUM is not set
-# CONFIG_NET_VENDOR_CORTINA is not set
-# CONFIG_NET_VENDOR_EZCHIP is not set
-# CONFIG_NET_VENDOR_HUAWEI is not set
-# CONFIG_NET_VENDOR_INTEL is not set
-# CONFIG_NET_VENDOR_MARVELL is not set
-# CONFIG_NET_VENDOR_MICREL is not set
-# CONFIG_NET_VENDOR_MICROSEMI is not set
-# CONFIG_NET_VENDOR_NATSEMI is not set
-# CONFIG_NET_VENDOR_NETRONOME is not set
-# CONFIG_NET_VENDOR_NI is not set
-# CONFIG_NET_VENDOR_QUALCOMM is not set
-# CONFIG_NET_VENDOR_RENESAS is not set
-# CONFIG_NET_VENDOR_ROCKER is not set
-# CONFIG_NET_VENDOR_SAMSUNG is not set
-# CONFIG_NET_VENDOR_SEEQ is not set
-# CONFIG_NET_VENDOR_SOLARFLARE is not set
-# CONFIG_NET_VENDOR_SOCIONEXT is not set
-# CONFIG_NET_VENDOR_STMICRO is not set
-# CONFIG_NET_VENDOR_SYNOPSYS is not set
-# CONFIG_NET_VENDOR_VIA is not set
-# CONFIG_NET_VENDOR_WIZNET is not set
 CONFIG_PPP=m
 CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_defconfig
index 07c6c3febff77861..95b4a399feb75b91 100644
--- a/arch/m68k/configs/atari_defconfig
+++ b/arch/m68k/configs/atari_defconfig
@@ -391,37 +391,9 @@ CONFIG_MACSEC=m
 CONFIG_NETCONSOLE=m
 CONFIG_NETCONSOLE_DYNAMIC=y
 CONFIG_VETH=m
-# CONFIG_NET_VENDOR_ALACRITECH is not set
-# CONFIG_NET_VENDOR_AMAZON is not set
 CONFIG_ATARILANCE=y
-# CONFIG_NET_VENDOR_AQUANTIA is not set
-# CONFIG_NET_VENDOR_ARC is not set
-# CONFIG_NET_VENDOR_AURORA is not set
-# CONFIG_NET_VENDOR_BROADCOM is not set
-# CONFIG_NET_VENDOR_CADENCE is not set
-# CONFIG_NET_VENDOR_CAVIUM is not set
-# CONFIG_NET_VENDOR_CORTINA is not set
-# CONFIG_NET_VENDOR_EZCHIP is not set
-# CONFIG_NET_VENDOR_HUAWEI is not set
-# CONFIG_NET_VENDOR_INTEL is not set
-# CONFIG_NET_VENDOR_MARVELL is not set
-# CONFIG_NET_VENDOR_MICREL is not set
-# CONFIG_NET_VENDOR_MICROSEMI is not set
-# CONFIG_NET_VENDOR_NETRONOME is not set
-# CONFIG_NET_VENDOR_NI is not set
 CONFIG_NE2000=y
-# CONFIG_NET_VENDOR_QUALCOMM is not set
-# CONFIG_NET_VENDOR_RENESAS is not set
-# CONFIG_NET_VENDOR_ROCKER is not set
-# CONFIG_NET_VENDOR_SAMSUNG is not set
-# CONFIG_NET_VENDOR_SEEQ is not set
-# CONFIG_NET_VENDOR_SOLARFLARE is not set
 CONFIG_SMC91X=y
-# CONFIG_NET_VENDOR_SOCIONEXT is not set
-# CONFIG_NET_VENDOR_STMICRO is not set
-# CONFIG_NET_VENDOR_SYNOPSYS is not set
-# CONFIG_NET_VENDOR_VIA is not set
-# CONFIG_NET_VENDOR_WIZNET is not set
 CONFIG_PPP=m
 CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
diff --git a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvme6000_defconfig
index 152f621df393d3ca..b0d3609f5bb3c77f 100644
--- a/arch/m68k/configs/bvme6000_defconfig
+++ b/arch/m68k/configs/bvme6000_defconfig
@@ -373,35 +373,7 @@ CONFIG_MACSEC=m
 CONFIG_NETCONSOLE=m
 CONFIG_NETCONSOLE_DYNAMIC=y
 CONFIG_VETH=m
-# CONFIG_NET_VENDOR_ALACRITECH is not set
-# CONFIG_NET_VENDOR_AMAZON is not set
-# CONFIG_NET_VENDOR_AQUANTIA is not set
-# CONFIG_NET_VENDOR_ARC is not set
-# CONFIG_NET_VENDOR_AURORA is not set
-# CONFIG_NET_VENDOR_BROADCOM is not set
-# CONFIG_NET_VENDOR_CADENCE is not set
-# CONFIG_NET_VENDOR_CAVIUM is not set
-# CONFIG_NET_VENDOR_CORTINA is not set
-# CONFIG_NET_VENDOR_EZCHIP is not set
-# CONFIG_NET_VENDOR_HUAWEI is not set
 CONFIG_BVME6000_NET=y
-# CONFIG_NET_VENDOR_MARVELL is not set
-# CONFIG_NET_VENDOR_MICREL is not set
-# CONFIG_NET_VENDOR_MICROSEMI is not set
-# CONFIG_NET_VENDOR_NATSEMI is not set
-# CONFIG_NET_VENDOR_NETRONOME is not set
-# CONFIG_NET_VENDOR_NI is not set
-# CONFIG_NET_VENDOR_QUALCOMM is not set
-# CONFIG_NET_VENDOR_RENESAS is not set
-# CONFIG_NET_VENDOR_ROCKER is not set
-# CONFIG_NET_VENDOR_SAMSUNG is not set
-# CONFIG_NET_VENDOR_SEEQ is not set
-# CONFIG_NET_VENDOR_SOLARFLARE is not set
-# CONFIG_NET_VENDOR_SOCIONEXT is not set
-# CONFIG_NET_VENDOR_STMICRO is not set
-# CONFIG_NET_VENDOR_SYNOPSYS is not set
-# CONFIG_NET_VENDOR_VIA is not set
-# CONFIG_NET_VENDOR_WIZNET is not set
 CONFIG_PPP=m
 CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_defconfig
index b450d5bfe2a930c6..4ed7c151347cdc13 100644
--- a/arch/m68k/configs/hp300_defconfig
+++ b/arch/m68k/configs/hp300_defconfig
@@ -374,36 +374,7 @@ CONFIG_MACSEC=m
 CONFIG_NETCONSOLE=m
 CONFIG_NETCONSOLE_DYNAMIC=y
 CONFIG_VETH=m
-# CONFIG_NET_VENDOR_ALACRITECH is not set
-# CONFIG_NET_VENDOR_AMAZON is not set
 CONFIG_HPLANCE=y
-# CONFIG_NET_VENDOR_AQUANTIA is not set
-# CONFIG_NET_VENDOR_ARC is not set
-# CONFIG_NET_VENDOR_AURORA is not set
-# CONFIG_NET_VENDOR_BROADCOM is not set
-# CONFIG_NET_VENDOR_CADENCE is not set
-# CONFIG_NET_VENDOR_CAVIUM is not set
-# CONFIG_NET_VENDOR_CORTINA is not set
-# CONFIG_NET_VENDOR_EZCHIP is not set
-# CONFIG_NET_VENDOR_HUAWEI is not set
-# CONFIG_NET_VENDOR_INTEL is not set
-# CONFIG_NET_VENDOR_MARVELL is not set
-# CONFIG_NET_VENDOR_MICREL is not set
-# CONFIG_NET_VENDOR_MICROSEMI is not set
-# CONFIG_NET_VENDOR_NATSEMI is not set
-# CONFIG_NET_VENDOR_NETRONOME is not set
-# CONFIG_NET_VENDOR_NI is not set
-# CONFIG_NET_VENDOR_QUALCOMM is not set
-# CONFIG_NET_VENDOR_RENESAS is not set
-# CONFIG_NET_VENDOR_ROCKER is not set
-# CONFIG_NET_VENDOR_SAMSUNG is not set
-# CONFIG_NET_VENDOR_SEEQ is not set
-# CONFIG_NET_VENDOR_SOLARFLARE is not set
-# CONFIG_NET_VENDOR_SOCIONEXT is not set
-# CONFIG_NET_VENDOR_STMICRO is not set
-# CONFIG_NET_VENDOR_SYNOPSYS is not set
-# CONFIG_NET_VENDOR_VIA is not set
-# CONFIG_NET_VENDOR_WIZNET is not set
 CONFIG_PPP=m
 CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
index 3777ed55064cd283..0dc544e1ce1fb02a 100644
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -390,39 +390,10 @@ CONFIG_MACSEC=m
 CONFIG_NETCONSOLE=m
 CONFIG_NETCONSOLE_DYNAMIC=y
 CONFIG_VETH=m
-# CONFIG_NET_VENDOR_ALACRITECH is not set
-# CONFIG_NET_VENDOR_AMAZON is not set
 CONFIG_MACMACE=y
-# CONFIG_NET_VENDOR_AQUANTIA is not set
-# CONFIG_NET_VENDOR_ARC is not set
-# CONFIG_NET_VENDOR_AURORA is not set
-# CONFIG_NET_VENDOR_BROADCOM is not set
-# CONFIG_NET_VENDOR_CADENCE is not set
-# CONFIG_NET_VENDOR_CAVIUM is not set
 CONFIG_MAC89x0=y
-# CONFIG_NET_VENDOR_CORTINA is not set
-# CONFIG_NET_VENDOR_EZCHIP is not set
-# CONFIG_NET_VENDOR_HUAWEI is not set
-# CONFIG_NET_VENDOR_INTEL is not set
-# CONFIG_NET_VENDOR_MARVELL is not set
-# CONFIG_NET_VENDOR_MICREL is not set
-# CONFIG_NET_VENDOR_MICROSEMI is not set
 CONFIG_MACSONIC=y
-# CONFIG_NET_VENDOR_NETRONOME is not set
-# CONFIG_NET_VENDOR_NI is not set
 CONFIG_MAC8390=y
-# CONFIG_NET_VENDOR_QUALCOMM is not set
-# CONFIG_NET_VENDOR_RENESAS is not set
-# CONFIG_NET_VENDOR_ROCKER is not set
-# CONFIG_NET_VENDOR_SAMSUNG is not set
-# CONFIG_NET_VENDOR_SEEQ is not set
-# CONFIG_NET_VENDOR_SOLARFLARE is not set
-# CONFIG_NET_VENDOR_SMSC is not set
-# CONFIG_NET_VENDOR_SOCIONEXT is not set
-# CONFIG_NET_VENDOR_STMICRO is not set
-# CONFIG_NET_VENDOR_SYNOPSYS is not set
-# CONFIG_NET_VENDOR_VIA is not set
-# CONFIG_NET_VENDOR_WIZNET is not set
 CONFIG_PPP=m
 CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index 2d7e1c4330671c51..5a7b7b0d6e72e293 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -434,9 +434,6 @@ CONFIG_MACSEC=m
 CONFIG_NETCONSOLE=m
 CONFIG_NETCONSOLE_DYNAMIC=y
 CONFIG_VETH=m
-# CONFIG_NET_VENDOR_3COM is not set
-# CONFIG_NET_VENDOR_ALACRITECH is not set
-# CONFIG_NET_VENDOR_AMAZON is not set
 CONFIG_A2065=y
 CONFIG_ARIADNE=y
 CONFIG_ATARILANCE=y
@@ -444,43 +441,17 @@ CONFIG_HPLANCE=y
 CONFIG_MVME147_NET=y
 CONFIG_SUN3LANCE=y
 CONFIG_MACMACE=y
-# CONFIG_NET_VENDOR_AQUANTIA is not set
-# CONFIG_NET_VENDOR_ARC is not set
-# CONFIG_NET_VENDOR_AURORA is not set
-# CONFIG_NET_VENDOR_BROADCOM is not set
-# CONFIG_NET_VENDOR_CADENCE is not set
-# CONFIG_NET_VENDOR_CAVIUM is not set
 CONFIG_MAC89x0=y
-# CONFIG_NET_VENDOR_CORTINA is not set
-# CONFIG_NET_VENDOR_EZCHIP is not set
-# CONFIG_NET_VENDOR_HP is not set
-# CONFIG_NET_VENDOR_HUAWEI is not set
 CONFIG_BVME6000_NET=y
 CONFIG_MVME16x_NET=y
-# CONFIG_NET_VENDOR_MARVELL is not set
-# CONFIG_NET_VENDOR_MICREL is not set
-# CONFIG_NET_VENDOR_MICROSEMI is not set
 CONFIG_MACSONIC=y
-# CONFIG_NET_VENDOR_NETRONOME is not set
-# CONFIG_NET_VENDOR_NI is not set
 CONFIG_XSURF100=y
 CONFIG_HYDRA=y
 CONFIG_MAC8390=y
 CONFIG_NE2000=y
 CONFIG_APNE=y
 CONFIG_ZORRO8390=y
-# CONFIG_NET_VENDOR_QUALCOMM is not set
-# CONFIG_NET_VENDOR_RENESAS is not set
-# CONFIG_NET_VENDOR_ROCKER is not set
-# CONFIG_NET_VENDOR_SAMSUNG is not set
-# CONFIG_NET_VENDOR_SEEQ is not set
-# CONFIG_NET_VENDOR_SOLARFLARE is not set
 CONFIG_SMC91X=y
-# CONFIG_NET_VENDOR_SOCIONEXT is not set
-# CONFIG_NET_VENDOR_STMICRO is not set
-# CONFIG_NET_VENDOR_SYNOPSYS is not set
-# CONFIG_NET_VENDOR_VIA is not set
-# CONFIG_NET_VENDOR_WIZNET is not set
 CONFIG_PLIP=m
 CONFIG_PPP=m
 CONFIG_PPP_BSDCOMP=m
diff --git a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme147_defconfig
index 0be202bb4553d5ac..71eb9be1803b1006 100644
--- a/arch/m68k/configs/mvme147_defconfig
+++ b/arch/m68k/configs/mvme147_defconfig
@@ -372,36 +372,7 @@ CONFIG_MACSEC=m
 CONFIG_NETCONSOLE=m
 CONFIG_NETCONSOLE_DYNAMIC=y
 CONFIG_VETH=m
-# CONFIG_NET_VENDOR_ALACRITECH is not set
-# CONFIG_NET_VENDOR_AMAZON is not set
 CONFIG_MVME147_NET=y
-# CONFIG_NET_VENDOR_AQUANTIA is not set
-# CONFIG_NET_VENDOR_ARC is not set
-# CONFIG_NET_VENDOR_AURORA is not set
-# CONFIG_NET_VENDOR_BROADCOM is not set
-# CONFIG_NET_VENDOR_CADENCE is not set
-# CONFIG_NET_VENDOR_CAVIUM is not set
-# CONFIG_NET_VENDOR_CORTINA is not set
-# CONFIG_NET_VENDOR_EZCHIP is not set
-# CONFIG_NET_VENDOR_HUAWEI is not set
-# CONFIG_NET_VENDOR_INTEL is not set
-# CONFIG_NET_VENDOR_MARVELL is not set
-# CONFIG_NET_VENDOR_MICREL is not set
-# CONFIG_NET_VENDOR_MICROSEMI is not set
-# CONFIG_NET_VENDOR_NATSEMI is not set
-# CONFIG_NET_VENDOR_NETRONOME is not set
-# CONFIG_NET_VENDOR_NI is not set
-# CONFIG_NET_VENDOR_QUALCOMM is not set
-# CONFIG_NET_VENDOR_RENESAS is not set
-# CONFIG_NET_VENDOR_ROCKER is not set
-# CONFIG_NET_VENDOR_SAMSUNG is not set
-# CONFIG_NET_VENDOR_SEEQ is not set
-# CONFIG_NET_VENDOR_SOLARFLARE is not set
-# CONFIG_NET_VENDOR_SOCIONEXT is not set
-# CONFIG_NET_VENDOR_STMICRO is not set
-# CONFIG_NET_VENDOR_SYNOPSYS is not set
-# CONFIG_NET_VENDOR_VIA is not set
-# CONFIG_NET_VENDOR_WIZNET is not set
 CONFIG_PPP=m
 CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
diff --git a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme16x_defconfig
index c5cd30c455135193..ea2ebd4241c03992 100644
--- a/arch/m68k/configs/mvme16x_defconfig
+++ b/arch/m68k/configs/mvme16x_defconfig
@@ -373,35 +373,7 @@ CONFIG_MACSEC=m
 CONFIG_NETCONSOLE=m
 CONFIG_NETCONSOLE_DYNAMIC=y
 CONFIG_VETH=m
-# CONFIG_NET_VENDOR_ALACRITECH is not set
-# CONFIG_NET_VENDOR_AMAZON is not set
-# CONFIG_NET_VENDOR_AQUANTIA is not set
-# CONFIG_NET_VENDOR_ARC is not set
-# CONFIG_NET_VENDOR_AURORA is not set
-# CONFIG_NET_VENDOR_BROADCOM is not set
-# CONFIG_NET_VENDOR_CADENCE is not set
-# CONFIG_NET_VENDOR_CAVIUM is not set
-# CONFIG_NET_VENDOR_CORTINA is not set
-# CONFIG_NET_VENDOR_EZCHIP is not set
-# CONFIG_NET_VENDOR_HUAWEI is not set
 CONFIG_MVME16x_NET=y
-# CONFIG_NET_VENDOR_MARVELL is not set
-# CONFIG_NET_VENDOR_MICREL is not set
-# CONFIG_NET_VENDOR_MICROSEMI is not set
-# CONFIG_NET_VENDOR_NATSEMI is not set
-# CONFIG_NET_VENDOR_NETRONOME is not set
-# CONFIG_NET_VENDOR_NI is not set
-# CONFIG_NET_VENDOR_QUALCOMM is not set
-# CONFIG_NET_VENDOR_RENESAS is not set
-# CONFIG_NET_VENDOR_ROCKER is not set
-# CONFIG_NET_VENDOR_SAMSUNG is not set
-# CONFIG_NET_VENDOR_SEEQ is not set
-# CONFIG_NET_VENDOR_SOLARFLARE is not set
-# CONFIG_NET_VENDOR_SOCIONEXT is not set
-# CONFIG_NET_VENDOR_STMICRO is not set
-# CONFIG_NET_VENDOR_SYNOPSYS is not set
-# CONFIG_NET_VENDOR_VIA is not set
-# CONFIG_NET_VENDOR_WIZNET is not set
 CONFIG_PPP=m
 CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
index fbfda56bd3cb9e3b..cef6dc47c7250d32 100644
--- a/arch/m68k/configs/q40_defconfig
+++ b/arch/m68k/configs/q40_defconfig
@@ -380,40 +380,7 @@ CONFIG_MACSEC=m
 CONFIG_NETCONSOLE=m
 CONFIG_NETCONSOLE_DYNAMIC=y
 CONFIG_VETH=m
-# CONFIG_NET_VENDOR_3COM is not set
-# CONFIG_NET_VENDOR_ALACRITECH is not set
-# CONFIG_NET_VENDOR_AMAZON is not set
-# CONFIG_NET_VENDOR_AMD is not set
-# CONFIG_NET_VENDOR_AQUANTIA is not set
-# CONFIG_NET_VENDOR_ARC is not set
-# CONFIG_NET_VENDOR_AURORA is not set
-# CONFIG_NET_VENDOR_BROADCOM is not set
-# CONFIG_NET_VENDOR_CADENCE is not set
-# CONFIG_NET_VENDOR_CAVIUM is not set
-# CONFIG_NET_VENDOR_CIRRUS is not set
-# CONFIG_NET_VENDOR_CORTINA is not set
-# CONFIG_NET_VENDOR_EZCHIP is not set
-# CONFIG_NET_VENDOR_HP is not set
-# CONFIG_NET_VENDOR_HUAWEI is not set
-# CONFIG_NET_VENDOR_INTEL is not set
-# CONFIG_NET_VENDOR_MARVELL is not set
-# CONFIG_NET_VENDOR_MICREL is not set
-# CONFIG_NET_VENDOR_MICROSEMI is not set
-# CONFIG_NET_VENDOR_NETRONOME is not set
-# CONFIG_NET_VENDOR_NI is not set
 CONFIG_NE2000=y
-# CONFIG_NET_VENDOR_QUALCOMM is not set
-# CONFIG_NET_VENDOR_RENESAS is not set
-# CONFIG_NET_VENDOR_ROCKER is not set
-# CONFIG_NET_VENDOR_SAMSUNG is not set
-# CONFIG_NET_VENDOR_SEEQ is not set
-# CONFIG_NET_VENDOR_SOLARFLARE is not set
-# CONFIG_NET_VENDOR_SMSC is not set
-# CONFIG_NET_VENDOR_SOCIONEXT is not set
-# CONFIG_NET_VENDOR_STMICRO is not set
-# CONFIG_NET_VENDOR_SYNOPSYS is not set
-# CONFIG_NET_VENDOR_VIA is not set
-# CONFIG_NET_VENDOR_WIZNET is not set
 CONFIG_PLIP=m
 CONFIG_PPP=m
 CONFIG_PPP_BSDCOMP=m
diff --git a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_defconfig
index 49b3a38a08c3334b..69f2282dc4e9cafa 100644
--- a/arch/m68k/configs/sun3_defconfig
+++ b/arch/m68k/configs/sun3_defconfig
@@ -370,36 +370,8 @@ CONFIG_MACSEC=m
 CONFIG_NETCONSOLE=m
 CONFIG_NETCONSOLE_DYNAMIC=y
 CONFIG_VETH=m
-# CONFIG_NET_VENDOR_ALACRITECH is not set
-# CONFIG_NET_VENDOR_AMAZON is not set
 CONFIG_SUN3LANCE=y
-# CONFIG_NET_VENDOR_AQUANTIA is not set
-# CONFIG_NET_VENDOR_ARC is not set
-# CONFIG_NET_VENDOR_AURORA is not set
-# CONFIG_NET_VENDOR_CADENCE is not set
-# CONFIG_NET_VENDOR_CAVIUM is not set
-# CONFIG_NET_VENDOR_CORTINA is not set
-# CONFIG_NET_VENDOR_EZCHIP is not set
-# CONFIG_NET_VENDOR_HUAWEI is not set
 CONFIG_SUN3_82586=y
-# CONFIG_NET_VENDOR_MARVELL is not set
-# CONFIG_NET_VENDOR_MICREL is not set
-# CONFIG_NET_VENDOR_MICROSEMI is not set
-# CONFIG_NET_VENDOR_NATSEMI is not set
-# CONFIG_NET_VENDOR_NETRONOME is not set
-# CONFIG_NET_VENDOR_NI is not set
-# CONFIG_NET_VENDOR_QUALCOMM is not set
-# CONFIG_NET_VENDOR_RENESAS is not set
-# CONFIG_NET_VENDOR_ROCKER is not set
-# CONFIG_NET_VENDOR_SAMSUNG is not set
-# CONFIG_NET_VENDOR_SEEQ is not set
-# CONFIG_NET_VENDOR_SOLARFLARE is not set
-# CONFIG_NET_VENDOR_SOCIONEXT is not set
-# CONFIG_NET_VENDOR_STMICRO is not set
-# CONFIG_NET_VENDOR_SUN is not set
-# CONFIG_NET_VENDOR_SYNOPSYS is not set
-# CONFIG_NET_VENDOR_VIA is not set
-# CONFIG_NET_VENDOR_WIZNET is not set
 CONFIG_PPP=m
 CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_defconfig
index d8acd36e45b110dc..e91267e868b2dd37 100644
--- a/arch/m68k/configs/sun3x_defconfig
+++ b/arch/m68k/configs/sun3x_defconfig
@@ -370,36 +370,7 @@ CONFIG_MACSEC=m
 CONFIG_NETCONSOLE=m
 CONFIG_NETCONSOLE_DYNAMIC=y
 CONFIG_VETH=m
-# CONFIG_NET_VENDOR_ALACRITECH is not set
-# CONFIG_NET_VENDOR_AMAZON is not set
 CONFIG_SUN3LANCE=y
-# CONFIG_NET_VENDOR_AQUANTIA is not set
-# CONFIG_NET_VENDOR_ARC is not set
-# CONFIG_NET_VENDOR_AURORA is not set
-# CONFIG_NET_VENDOR_BROADCOM is not set
-# CONFIG_NET_VENDOR_CADENCE is not set
-# CONFIG_NET_VENDOR_CAVIUM is not set
-# CONFIG_NET_VENDOR_CORTINA is not set
-# CONFIG_NET_VENDOR_EZCHIP is not set
-# CONFIG_NET_VENDOR_HUAWEI is not set
-# CONFIG_NET_VENDOR_INTEL is not set
-# CONFIG_NET_VENDOR_MARVELL is not set
-# CONFIG_NET_VENDOR_MICREL is not set
-# CONFIG_NET_VENDOR_MICROSEMI is not set
-# CONFIG_NET_VENDOR_NATSEMI is not set
-# CONFIG_NET_VENDOR_NETRONOME is not set
-# CONFIG_NET_VENDOR_NI is not set
-# CONFIG_NET_VENDOR_QUALCOMM is not set
-# CONFIG_NET_VENDOR_RENESAS is not set
-# CONFIG_NET_VENDOR_ROCKER is not set
-# CONFIG_NET_VENDOR_SAMSUNG is not set
-# CONFIG_NET_VENDOR_SEEQ is not set
-# CONFIG_NET_VENDOR_SOLARFLARE is not set
-# CONFIG_NET_VENDOR_SOCIONEXT is not set
-# CONFIG_NET_VENDOR_STMICRO is not set
-# CONFIG_NET_VENDOR_SYNOPSYS is not set
-# CONFIG_NET_VENDOR_VIA is not set
-# CONFIG_NET_VENDOR_WIZNET is not set
 CONFIG_PPP=m
 CONFIG_PPP_BSDCOMP=m
 CONFIG_PPP_DEFLATE=m
-- 
2.17.1

