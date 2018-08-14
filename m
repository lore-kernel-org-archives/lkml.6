Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F9EC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 876E32172C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 876E32172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732544AbeHNQyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 12:54:16 -0400
Received: from mout.perfora.net ([74.208.4.194]:46327 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731162AbeHNQyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 12:54:16 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LtXQA-1fzF1B3ImK-010w08; Tue, 14 Aug 2018 16:06:34 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Stefan Agner <stefan@agner.ch>,
        Tony Lindgren <tony@atomide.com>,
        Eric Anholt <eric@anholt.net>,
        Russell King <linux@armlinux.org.uk>,
        Simon Horman <horms+renesas@verge.net.au>
Subject: [RESEND PATCH 2/6] ARM: multi_v7_defconfig: update order
Date:   Tue, 14 Aug 2018 16:06:08 +0200
Message-Id: <20180814140612.12554-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180814140612.12554-1-marcel@ziswiler.com>
References: <20180814140612.12554-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:w9951iOcBaK8J3px/vlsshfa7LvLXKptpEmm7fhRQJMrPtCGmaU
 S41I6FWlaQwjLnYPP0kinN5SjAEvWJepoZLGcd8eOpWEzaDC9xBOHbHRGGNQleJe75SU2en
 oL9pQgc8t/Jdr7FGrEOeexfS4A1bfMVtYY76VdWdJ0dc65J5HTRJ3qSCdaH6tFxswkyVWiX
 VK7yN59kNiZGtgNQkFYlw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Py9ZZQDW7PQ=:+1NN2pXf9+JNfo2Vg1/X70
 5k0zl+LC3L2oT9q8avDJx9e737rTsvIJRjqqLjCjQeQA28Zj1Eu/fNRmTcdzBeSKnUlOcSOqh
 /eYIssASryKJ5F5jtbSC/ylcDDBhZQKT978Fm6BHjmaiJ4VXq2n+ftRo3cVhlSGkc8w8MxtD6
 J0I42tNqMDyY42zghQefFgUfuo5sfGibPSGTZCOxmKDFWUWpyAA9fiHTbR6dBYKKhgKGCQFcM
 nBCBZ1k7sFVexFfrVxHF+R1r7fU8+OWh+eDrb4bwk28N4B4EBBgQOZOoVL+jRiXR/iLflt+Tv
 gsZkUtvjK4WcZMFO+QE0our+hIKvT+CTax2uEdwmJUkde9eQ2slj31q4+QOnVaaVBvIvDt+uW
 4U8+BMfXjZIiaL5Fw2Lxe1WpJQ/ShHV1iaKjP7pFre+Oz/euqNj03NLcns+bOMJIffuVKL06b
 DfZNHhleyIX+gpnIZ+WFJrMt2ITwvDh4E3rTTvR1j8Y4xjxJh18BrPWoCCiR+vGdDqZVuLO/8
 zK3hA1jlg9VjNeedhNk5kjz3Fd76lSHltTBfCnk7TokYvgYVn+A5oAxosjKp95Pgd+eAwQd3F
 TSETcwYW4WHIxGiSjlt1rB4iFea+0AgwLxBL0KkXGOM6gUwkV1zgwVygaqF7KGpLTzSd5418U
 BFtz17i6b+pb9EDv3iNYVkSTHG/tQE+PHd8bQZcLjF2Io6c2Wy2CDksXcp+jkiBRPoJ0=
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
index fc33444e94f0..1299c0cf2f3a 100644
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
@@ -495,8 +495,6 @@ CONFIG_MFD_AC100=y
 CONFIG_MFD_AXP20X_I2C=y
 CONFIG_MFD_AXP20X_RSB=y
 CONFIG_MFD_CROS_EC=m
-CONFIG_CROS_EC_I2C=m
-CONFIG_CROS_EC_SPI=m
 CONFIG_MFD_DA9063=m
 CONFIG_MFD_MAX14577=y
 CONFIG_MFD_MAX77686=y
@@ -866,6 +864,8 @@ CONFIG_SERIO_NVEC_PS2=y
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

