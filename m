Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA4CC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30F6120897
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30F6120897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbeH2MK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:10:29 -0400
Received: from mout.perfora.net ([74.208.4.196]:55443 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728289AbeH2MK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:10:28 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M6DOO-1fjRNk2dcQ-00yBbQ; Wed, 29 Aug 2018 10:14:39 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 12/31] ARM: tegra: colibri_t20: indentation/line-feed/white-space clean-up
Date:   Wed, 29 Aug 2018 10:13:48 +0200
Message-Id: <20180829081407.11304-13-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180829081407.11304-1-marcel@ziswiler.com>
References: <20180829081407.11304-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:K9GHaMQXdU7bPSVyF3LWWbH/UgsHDZMjH2LQRJwbw6bx8CDW4Rz
 jOJ4rfH7K6wxlb3PMQ6b7SamKnVVLtQI+nRNkk6miWNmRjbXQBI87K8h8NPlPHC/Vna8Mja
 VV1h7I5yFmq3HoCdiO4gFXAvAv3Hr7LVxmU5pP5SdAK78NyWiJxLKInMxR7EgnJEVTreUgk
 ewjZvfh7z11l4aqR6/4eA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZH7MKC3nRVk=:eBIiusYvPPTZyQjzpr+1pY
 Nm7dtluVzX5VdhhyCEIGNXaeqTuvEW5gN7re4wG6bA/DnFbHw/sp4zxQLtzR31I4BZFMuC/k3
 JdmM8gqGyBDcNIue8GvRN1z45m3f1cHw0iSeBkIJERtml9rNkpctaWpBuE9rXpuljf9N3klAX
 bDaYNyGp3tLD94EzB3rfKe7a4FeSeLmult4vWZBPApVs+RLe0f+JUPlsq2cP6RNzwKIiuAIS4
 JF2V1q5pnUAR52chzpEXN6IBuD0ARvl4uQePQXrKVHirOHwwnn6coUsjNAwtogg5LBoGnwGS3
 OHc4nVeP/wqYXPdZGSGN3C1H86Jb5zMbBliiH6Gd3lpqzusXUFDrhXxZbgefeHGevrpnXOvmF
 ubx6snfLM/AtNirNVHZYFLiWgSyb3rGWKefMA7B4FHiQLFBSpDrgG51PitmX+StWuSp3eSp2D
 xnucTnLUeMC8SH4auxXnyaJedMAuV0FvLjDemaTzuf8qVAFLrzy2QDIgtDaJH6B8Z9/VqZeEG
 HOT35YJeduapZw9DrIqCq3O+MR2DzkBnsEO6JeVCHUTdOiO3py3MbpbO1gL4AyFzDTO497dXY
 HWvlzfYWIEqVzfnsD4rPa0skl5akApJVJYR0sI3Jvk8g+uSc5e93bhDY19i7Pg/hOc7jEpTDF
 NPr0ZSabDFfHvBsnyD3lrlzh1APY0b/WhjQxgkrY1WqxI984mJ80LK4NWQIykwsy1LcY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Cleaning up indentation, line-feed and white-space.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra20-colibri.dtsi | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-colibri.dtsi b/arch/arm/boot/dts/tegra20-colibri.dtsi
index 06d0be29c0b4..5559008efc5f 100644
--- a/arch/arm/boot/dts/tegra20-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
@@ -206,10 +206,10 @@
 
 	ac97: ac97@70002000 {
 		status = "okay";
-		nvidia,codec-reset-gpio = <&gpio TEGRA_GPIO(V, 0)
-			GPIO_ACTIVE_HIGH>;
-		nvidia,codec-sync-gpio = <&gpio TEGRA_GPIO(P, 0)
-			GPIO_ACTIVE_HIGH>;
+		nvidia,codec-reset-gpio =
+			<&gpio TEGRA_GPIO(V, 0) GPIO_ACTIVE_HIGH>;
+		nvidia,codec-sync-gpio =
+			<&gpio TEGRA_GPIO(P, 0) GPIO_ACTIVE_HIGH>;
 	};
 
 	nand-controller@70008000 {
@@ -254,12 +254,9 @@
 			compatible = "ti,tps6586x";
 			reg = <0x34>;
 			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
-
 			ti,system-power-controller;
-
 			#gpio-cells = <2>;
 			gpio-controller;
-
 			sys-supply = <&reg_module_3v3>;
 			vin-sm0-supply = <&reg_3v3_vsys>;
 			vin-sm1-supply = <&reg_3v3_vsys>;
@@ -468,8 +465,8 @@
 
 	usb-phy@c5004000 {
 		status = "okay";
-		nvidia,phy-reset-gpio = <&gpio TEGRA_GPIO(V, 1)
-			GPIO_ACTIVE_LOW>;
+		nvidia,phy-reset-gpio =
+			<&gpio TEGRA_GPIO(V, 1) GPIO_ACTIVE_LOW>;
 		vbus-supply = <&reg_lan_v_bus>;
 	};
 
@@ -511,16 +508,13 @@
 		compatible = "nvidia,tegra-audio-wm9712-colibri_t20",
 			     "nvidia,tegra-audio-wm9712";
 		nvidia,model = "Colibri T20 AC97 Audio";
-
 		nvidia,audio-routing =
 			"Headphone", "HPOUTL",
 			"Headphone", "HPOUTR",
 			"LineIn", "LINEINL",
 			"LineIn", "LINEINR",
 			"Mic", "MIC1";
-
 		nvidia,ac97-controller = <&ac97>;
-
 		clocks = <&tegra_car TEGRA20_CLK_PLL_A>,
 			 <&tegra_car TEGRA20_CLK_PLL_A_OUT0>,
 			 <&tegra_car TEGRA20_CLK_CDEV1>;
-- 
2.14.4

