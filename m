Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CE8C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6643121871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="LZ5QhSJY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbeLRWlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:41:04 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16335 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbeLRWlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:41:01 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c1977720005>; Tue, 18 Dec 2018 14:40:50 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 18 Dec 2018 14:40:59 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 18 Dec 2018 14:40:59 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 18 Dec
 2018 22:40:59 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 18 Dec 2018 22:40:59 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.52]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c19777b0003>; Tue, 18 Dec 2018 14:40:59 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <mperttunen@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <ldewangan@nvidia.com>, <talho@nvidia.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-i2c@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V1 2/2] arm64: dts: tegra186: Device Tree Updates for Tegra186 I2C
Date:   Tue, 18 Dec 2018 14:40:56 -0800
Message-ID: <1545172856-19509-2-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545172856-19509-1-git-send-email-skomatineni@nvidia.com>
References: <1545172856-19509-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1545172851; bh=TjYIi0Rj1xoGKfvWe251EO/dWGZdjZo5q5Gjzf8HXUU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=LZ5QhSJY9dCTWsWz/mPxwMsRx62Ha5FDpBXnnbJYuOw5dyQKJ/s9TewVnHRlx1e69
         xEe7jaGvnofbG3+yT+bI5wsXY90XxP07yYMfUZ/M6fOqAHvPM03kY0Pc1COVeM32Ui
         w3haz5uZntr1Vn+b5bB5zNvy3M0qbSmB9sHpn9vFLiCoO02UwFowtbyOQL1nCCdBP4
         NN/2CU3AMxAykapSPW7vodmJHA5zhJy1ytrgN2CSjlXto2bBraEjAeGqhyskaNMV/k
         HURadykRtIzKZLTgzbIBgxiBTTeTJjKStBrq0WILKMFdGT43i/qg90fqZ59ZOBJzpC
         4DaM1Rd2Z5Ciw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update I2C Device node compatible string to be appropriate.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 2f3c8e29520d..31c7278f4c03 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -136,7 +136,7 @@
 	};
 
 	gen1_i2c: i2c@3160000 {
-		compatible = "nvidia,tegra186-i2c", "nvidia,tegra114-i2c";
+		compatible = "nvidia,tegra186-i2c", "nvidia,tegra210-i2c";
 		reg = <0x0 0x03160000 0x0 0x10000>;
 		interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
@@ -149,7 +149,7 @@
 	};
 
 	cam_i2c: i2c@3180000 {
-		compatible = "nvidia,tegra186-i2c", "nvidia,tegra114-i2c";
+		compatible = "nvidia,tegra186-i2c", "nvidia,tegra210-i2c";
 		reg = <0x0 0x03180000 0x0 0x10000>;
 		interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
@@ -163,7 +163,7 @@
 
 	/* shares pads with dpaux1 */
 	dp_aux_ch1_i2c: i2c@3190000 {
-		compatible = "nvidia,tegra186-i2c", "nvidia,tegra114-i2c";
+		compatible = "nvidia,tegra186-i2c", "nvidia,tegra210-i2c";
 		reg = <0x0 0x03190000 0x0 0x10000>;
 		interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
@@ -177,7 +177,7 @@
 
 	/* controlled by BPMP, should not be enabled */
 	pwr_i2c: i2c@31a0000 {
-		compatible = "nvidia,tegra186-i2c", "nvidia,tegra114-i2c";
+		compatible = "nvidia,tegra186-i2c", "nvidia,tegra210-i2c";
 		reg = <0x0 0x031a0000 0x0 0x10000>;
 		interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
@@ -191,7 +191,7 @@
 
 	/* shares pads with dpaux0 */
 	dp_aux_ch0_i2c: i2c@31b0000 {
-		compatible = "nvidia,tegra186-i2c", "nvidia,tegra114-i2c";
+		compatible = "nvidia,tegra186-i2c", "nvidia,tegra210-i2c";
 		reg = <0x0 0x031b0000 0x0 0x10000>;
 		interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
@@ -204,7 +204,7 @@
 	};
 
 	gen7_i2c: i2c@31c0000 {
-		compatible = "nvidia,tegra186-i2c", "nvidia,tegra114-i2c";
+		compatible = "nvidia,tegra186-i2c", "nvidia,tegra210-i2c";
 		reg = <0x0 0x031c0000 0x0 0x10000>;
 		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
@@ -217,7 +217,7 @@
 	};
 
 	gen9_i2c: i2c@31e0000 {
-		compatible = "nvidia,tegra186-i2c", "nvidia,tegra114-i2c";
+		compatible = "nvidia,tegra186-i2c", "nvidia,tegra210-i2c";
 		reg = <0x0 0x031e0000 0x0 0x10000>;
 		interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
@@ -346,7 +346,7 @@
 	};
 
 	gen2_i2c: i2c@c240000 {
-		compatible = "nvidia,tegra186-i2c", "nvidia,tegra114-i2c";
+		compatible = "nvidia,tegra186-i2c", "nvidia,tegra210-i2c";
 		reg = <0x0 0x0c240000 0x0 0x10000>;
 		interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
@@ -359,7 +359,7 @@
 	};
 
 	gen8_i2c: i2c@c250000 {
-		compatible = "nvidia,tegra186-i2c", "nvidia,tegra114-i2c";
+		compatible = "nvidia,tegra186-i2c", "nvidia,tegra210-i2c";
 		reg = <0x0 0x0c250000 0x0 0x10000>;
 		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
-- 
2.7.4

