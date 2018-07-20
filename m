Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13381ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6EAB204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6EAB204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732315AbeGTPTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 11:19:51 -0400
Received: from mout.perfora.net ([74.208.4.196]:45295 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731817AbeGTPTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 11:19:50 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MatW0-1fRbwA19g2-00KRlq; Fri, 20 Jul 2018 16:30:32 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Eric Anholt <eric@anholt.net>,
        Russell King <linux@armlinux.org.uk>,
        Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH 2/6] ARM: multi_v7_defconfig: update order
Date:   Fri, 20 Jul 2018 16:30:08 +0200
Message-Id: <20180720143012.7740-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180720143012.7740-1-marcel@ziswiler.com>
References: <20180720143012.7740-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:zgT0xYQTUKgnjdiMp98V3Yv47P69BsdKGHyy15mLafEoHsIOhEM
 MvKELrhTCnWwCIVAZFPS3Ds/X6JcBJjNWesv/r6i5G7wIsfu3uXVO35IQl1ai5lVvpv9Eif
 UAW1fdNIG6+e2LCcdyKGL4wo333mGPkUoJ3joLM8TLhnwHZjePdCwz1mHApSdzC9AOFkgW2
 QIk8g3+En6kUkNl9KNnqQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Bsc1YRpIeGI=:zSW8dBoflPLGItKn+oXgox
 YTOI5Ftnf2XZ3SE0u/lpNPXGBnvelhfO+qez2z3usZj4ivrNX66daNC8yt2eqeBnWwu76t2Lm
 ScZfPDm6eQpAZfKGYbWaNXMf1NguKNhQShkYGW8GuIjy/4zAJiuDni2qtxx1+h9JLzZxlSVg0
 MOBN4wjsW8gcyv2CiLcLWlMDjoPQAVLYiGukaT02pLEJ3XlFnHPtt3HJvGR6A57KOSrmtwJok
 Jmo3/TL2BDHSF+ae+et810VJIoRt3MqbCthjDGhxdB2UuR8Iql17Mvh1XxDulPnmHwVXn4aYO
 Uvy6A/cm1rjwT+XljiAuRtozAfbrtI7I4DEpMhnk+63t9MRX/uO7+sYMW++QhfkpiLrF1iFj4
 vVkh3bGXVNQaEg/zT0gKVgfjbK+V0VTNGJsIpNgqQg3j3fN2oHhnTrD2k3zY62ZEqmQFN4qi9
 Js9DqxEf83RTlgX8noG6MyFlj/zQResdaicHuJe52GxVjyJzY+25+Usk/EwTKVyIC2DVyh35e
 uEWKec0nxP5L/R8H5Jx+HX7J2JmN0acuXozsC3ahQfoqwVvYlUbA52ahN+MzJLVUSYY/e5Ahv
 pm2D8l9YcV9o1GO06UAQPlTRXV2X/dYLut85zHrWqXK3V5zBx1699zmvk/wHu6yqTLtHnLzP8
 CZBdHDaqv45UfgCBQBKFgxuskIrv6q9VRwyYpsEaBheOxm98bYywnrg2mwHWXMEgIoMM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

The order of some kernel configurations changed.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/configs/multi_v7_defconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index c9dcb85cb1dd..4a47a9de6a5e 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -48,8 +48,8 @@ CONFIG_SOC_IMX6Q=y
 CONFIG_SOC_IMX6SL=y
 CONFIG_SOC_IMX6SX=y
 CONFIG_SOC_IMX6UL=y
-CONFIG_SOC_IMX7D=y
 CONFIG_SOC_LS1021A=y
+CONFIG_SOC_IMX7D=y
 CONFIG_SOC_VF610=y
 CONFIG_ARCH_KEYSTONE=y
 CONFIG_ARCH_MEDIATEK=y
@@ -493,8 +493,6 @@ CONFIG_MFD_AC100=y
 CONFIG_MFD_AXP20X_I2C=y
 CONFIG_MFD_AXP20X_RSB=y
 CONFIG_MFD_CROS_EC=m
-CONFIG_CROS_EC_I2C=m
-CONFIG_CROS_EC_SPI=m
 CONFIG_MFD_DA9063=m
 CONFIG_MFD_MAX14577=y
 CONFIG_MFD_MAX77686=y
@@ -864,6 +862,8 @@ CONFIG_SERIO_NVEC_PS2=y
 CONFIG_NVEC_POWER=y
 CONFIG_NVEC_PAZ00=y
 CONFIG_STAGING_BOARD=y
+CONFIG_CROS_EC_I2C=m
+CONFIG_CROS_EC_SPI=m
 CONFIG_COMMON_CLK_MAX77686=y
 CONFIG_COMMON_CLK_RK808=m
 CONFIG_COMMON_CLK_S2MPS11=m
-- 
2.14.4

