Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A00C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79DB92083C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:14:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79DB92083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbeIAMZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 08:25:48 -0400
Received: from mout.perfora.net ([74.208.4.197]:39967 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728031AbeIAMZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 08:25:14 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MeiSs-1gFkp244Ua-00OIum; Sat, 01 Sep 2018 10:13:57 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 29/34] ARM: tegra: colibri_t30: rename tps65911@2d, stmpe811@41 and tps62362@60
Date:   Sat,  1 Sep 2018 10:12:43 +0200
Message-Id: <20180901081248.22639-30-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901081248.22639-1-marcel@ziswiler.com>
References: <20180901081248.22639-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:4+Ayz0Bpav3UvNG8kx2vUIp+rB0x9T8ftyGFnYE2b3oKmHF/z/x
 isbrs8m3oPA737FGSZR75gLaZfUg69mV0BaKOD/hD+dIDviFYCzOFSEGlCIfGD543Ez1egA
 qr/xEbCwkC2S0KeGPS37DjKnPyb4SO3DoiPFA3MN1tsdzMIKZftIB373bTpP4LJ6db4M60y
 TV6TOIuZC0gMW+44QOhnQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:19zSf4trqCc=:ecVRwJYYUefQ9x1tReoc3g
 MLXyFE0o7/PTsDAq5UXND3sB4QbhawAYEKplNY25qY4mbv/8/TM8xw7yEEBQo3lIW5Y5c8k04
 2Ll63rl3CKmdHJS1EHwPu/xP9zRcmoa1H371Da2P6aiX8Gd/0Q4bBmIhaeKMezniLDk0suDRL
 3Pe+ci5aDq0zY7R/SAAg5ammzvfPXhRCJfBeDAB3pQEmwKWa7EZtUJ0Pj5KbEK+vLl/A+2ERl
 siATc45LVOrK3OdgfdsGXi1EURzIK1fT0Vxv6K0mS62qTfbfpjDQ2RDY/kmQO7gkKgqRK86hm
 jyMzfeaCos2xsmfT4hnHh0Ww7URRjQ7l76xn6f59IfQ4jiCG1Ih161p/WEL/olgI4SyOkwO0F
 I4LA2UMQm7DbhEDg2T5oI1qtI1whUYUNOPvxL0lEap51C8zHaTUSWhM44rv0FuCYDhzwWe4k/
 2lXzbV5snbeG6/GOsLaacKZOzU5S8D6AsI+DcQzcHP1i//5maNCpLp17Pm+4kYuLT0+fcTR09
 atHA/eQs46fLOJHPfvCYCbR+4VfY7t+7HWmpOOB+8dIbpq+Myco306KlzOPhnb8UJdIcjXf1N
 GpyHYZ++OW7nGp2VFB3PMqBwYbXQ9QO/KwcAntGum8CPX7sdOUfGB1J7duJ8PODunvkYIMLX6
 h0KQ34ZoJBTx2/WNDcgtKtXLofNyJkLg1MUyRB7m88CAUv5raN+fayjTrY4G9uIyM3LE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Rename a few nodes using more common names:
- rename tps65911@2d to pmic@2d
- rename stmpe811@41 to touchscreen@41
- rename tps62362@60 to regulator@60

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- New patch as suggested by Rob.

 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts | 2 +-
 arch/arm/boot/dts/tegra30-colibri.dtsi        | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
index 49771ea379ed..c63ef3aedb7a 100644
--- a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
@@ -11,7 +11,7 @@
 
 	aliases {
 		rtc0 = "/i2c@7000c000/rtc@68";
-		rtc1 = "/i2c@7000d000/tps65911@2d";
+		rtc1 = "/i2c@7000d000/pmic@2d";
 		rtc2 = "/rtc@7000e000";
 		serial0 = &uarta;
 		serial1 = &uartb;
diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index 03047d2bba9d..e32702a4ab10 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -729,7 +729,7 @@
 			clocks = <&tegra_car TEGRA30_CLK_EXTERN1>;
 		};
 
-		pmic: tps65911@2d {
+		pmic: pmic@2d {
 			compatible = "ti,tps65911";
 			reg = <0x2d>;
 
@@ -837,7 +837,7 @@
 		};
 
 		/* STMPE811 touch screen controller */
-		stmpe811@41 {
+		touchscreen@41 {
 			compatible = "st,stmpe811";
 			reg = <0x41>;
 			irq-gpio = <&gpio TEGRA_GPIO(V, 0) IRQ_TYPE_LEVEL_LOW>;
@@ -882,7 +882,7 @@
 		};
 
 		/* SW: +V1.2_VDD_CORE */
-		tps62362@60 {
+		regulator@60 {
 			compatible = "ti,tps62362";
 			reg = <0x60>;
 
-- 
2.14.4

