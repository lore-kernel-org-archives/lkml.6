Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6ADC433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 13:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973C420843
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 13:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 973C420843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbeIARRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 13:17:30 -0400
Received: from mout.perfora.net ([74.208.4.194]:44751 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727159AbeIARR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 13:17:27 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M8jj0-1g3oIN2Jau-00C7Eo; Sat, 01 Sep 2018 15:05:20 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 02/19] ARM: tegra: apalis-tk1: reorder host1x/hdmi properties
Date:   Sat,  1 Sep 2018 15:04:47 +0200
Message-Id: <20180901130504.14318-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901130504.14318-1-marcel@ziswiler.com>
References: <20180901130504.14318-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:LlRmvptvAvvwz3TW0MoIkGufGMLwcvy3wlhezebcsLOsu/XYoyk
 1yiIJKvaJgIF6c/dkYMikpwRkrcFgCtUfoczcIq+WxbYD3mUOhFj4HOYc9xoC41hCHprT8S
 dS32qaSjoxZTdKiFtERAQL6N7YMIeuEyZH0Pxf4Fk/LcrNZYdOXlmwQq3lhW+MW6U3smRFP
 XiOrF4kQds903kE+/B+xA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OwGeXWW/8oM=:Kc8kN4bzTbZFLycHaZf7Qi
 ue0ABXaoghOCua01dSBUPq0qV9H4ybjROwpiHKs/CyWMe+mg2igBxc9a9YZEV1SOIA4FWDhMv
 e3V2fNU6n+6CgzkaXdPlTrY0DWUlcJyoBMwSB6x3Z8ygSune4Bn6GW+066/SeroZCdzSP1IND
 decMA795CLFaewvfPnvxWhmvhEvBGzfD0pdjBsu4hiTnza81qDOiMQGIgVOoRXvl6niC2J990
 YNUGjsL7srJS+ADNGiVwUdyj2LGbYcoZeMzdHUsinBNJRkxILdUmQQ8K0Ja8iMe9XrgIvpPpi
 IuDPGc3NhsdIRt4Ak0obh+Eo3LOSXvOk39CBraEZvIsUPNrUJneImvC+xQzB3+QrrXTrbR4On
 D1/5UTx9Z8Xe3ohMmjqKSg1WRUZJeQsB+TqougckTkvEmujW5iPIytXWit14/Ky1vSoxXVCFU
 J3cDD0hep+MhmrN8oxeyZeTcJuoWitvSdwIH9MT2b2YYU/FTbgAOB5/ISgUWpAgt3ypZRwtxi
 lhWm/VRZq5yZzd7AUP6Mscr1O3OanCJFix7uCUPd8Gh/Wp9eFaK8hwmuAGwmpPDL2NUoGjGuZ
 WDNk2ls12sCkMJm8TFTyAUt6AB32CcDn/fxH6Pj8Od/LWpRILQw+XkBHfGKLWa0M4IiSuBaS+
 xxIncAMg54R8P6Eui7I2+cY3/8XnByOHXl/hygGC5JTwDRbZuKPgrLmesZMgK8iPU74Y=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Reorder Host1x/HDMI properties.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi | 4 ++--
 arch/arm/boot/dts/tegra124-apalis.dtsi      | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
index 09e3641258ae..86768ba28d67 100644
--- a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
@@ -52,11 +52,11 @@
 
 	host1x@50000000 {
 		hdmi@54280000 {
-			pll-supply = <&reg_1v05_avdd_hdmi_pll>;
-			vdd-supply = <&reg_3v3_avdd_hdmi>;
 			nvidia,ddc-i2c-bus = <&hdmi_ddc>;
 			nvidia,hpd-gpio =
 				<&gpio TEGRA_GPIO(N, 7) GPIO_ACTIVE_HIGH>;
+			pll-supply = <&reg_1v05_avdd_hdmi_pll>;
+			vdd-supply = <&reg_3v3_avdd_hdmi>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi b/arch/arm/boot/dts/tegra124-apalis.dtsi
index 5e7ae5e92fb8..2c291d210677 100644
--- a/arch/arm/boot/dts/tegra124-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis.dtsi
@@ -87,11 +87,11 @@
 
 	host1x@50000000 {
 		hdmi@54280000 {
-			pll-supply = <&reg_1v05_avdd_hdmi_pll>;
-			vdd-supply = <&reg_3v3_avdd_hdmi>;
 			nvidia,ddc-i2c-bus = <&hdmi_ddc>;
 			nvidia,hpd-gpio =
 				<&gpio TEGRA_GPIO(N, 7) GPIO_ACTIVE_HIGH>;
+			pll-supply = <&reg_1v05_avdd_hdmi_pll>;
+			vdd-supply = <&reg_3v3_avdd_hdmi>;
 		};
 	};
 
-- 
2.14.4

