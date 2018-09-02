Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56502C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B764F20855
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B764F20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbeIBOZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 10:25:02 -0400
Received: from mout.perfora.net ([74.208.4.194]:46511 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbeIBOZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 10:25:02 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0Lop6D-1fOR9r0MkV-00geSu; Sun, 02 Sep 2018 12:09:40 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 12/37] ARM: tegra: colibri_t20: indentation/line-feed/white-space clean-up
Date:   Sun,  2 Sep 2018 12:08:41 +0200
Message-Id: <20180902100906.25792-13-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180902100906.25792-1-marcel@ziswiler.com>
References: <20180902100906.25792-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:QZg6sD1H+m8MJlOwS2jTzzhDT1Tb1NFiJCnS/i4LAaFiT0aSIl7
 UM3sMqEJ2Q1zl9s7eaChGb8naA8Bqx43z536OOBIq3i9Y760CCX/ptHk8w9VYL9aXzF/3CQ
 zGwCuUm2lAOZYvK5j8tPCtkdPe0hF2GW5fc/f4C8eiYIJcQkKPIkz93tJ2IZTj/1gGAi/yP
 NRVGddmZpzEM2JwA//9Uw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NYaOf9iArAc=:Wwmf/VFOYniVFuEEnU/F5y
 WzalLqi7aXB7iwdYhWlHfrzyTrwTgx/De4/zDVspmDEoRM7QOZKmbaEdfW0ei7wVKOmTqUziF
 LzzQKLrLBtKbGrLYN9NodPIv1Hg9q9qso2Q29Wx9hBveQzM0Qkema8l6oEQBfPRupYudbmMXp
 4oiolNsOsHSQS5Z1MVinuJ6qm7YELvJqtyk8B46FnFSbw4NVqGGJtU8bNVaMSQXhiuzXi0k15
 UGXZyqHJIdfkPerfYqNigS3NpsabRnnLAKKbZRVchIT6PqEi1hrMJHIfs2OTSWGkq78f+BqNZ
 MV2hG9V2/BrkkNl7hjZy+121EsPx4lf7EbdXYPDGZj9El7/6k2MxpCxmvU+qxrvnbajC/9Itb
 31ga1LVqhQ9R8f0c0nvmkhVYZBuJfMWyUxlok2pJFrPIEXvwQoLkPzhSLaDQNF8zja+p+Bit6
 w5HKA8OOoo/OUCaXVRi5cgcEMUOcPL+BzX1C7jxHpXtwH0uujqTLyjKKSpZGqnqsBJelq1OZf
 Abeq58LuSNl3rh2mzf0D2tqbIzTJGMD8zhogwCrKlAqlSeL4sSK4ECkaMydvH8BDZJpcBwf0U
 Y37SpBa2gzvHE33pURSzZFIpAX5qVWqIMbc7t429jpk+3Qe0ABtUm+84GoIUktufrk7vR/lJc
 bmox4qw0P6pDZJRSU5Gh7XFBomH4g2DZW9e8TDey+avRvtzSCTsN3lVNCXRHDJMToB7w=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Cleaning up indentation, line-feed and white-space.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

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

