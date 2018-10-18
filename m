Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116D1ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A852087A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:14:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4A852087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbeJRTPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 15:15:25 -0400
Received: from mout.perfora.net ([74.208.4.196]:43505 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728172AbeJRTPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 15:15:15 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LfhYy-1fpYsw3EZW-00pPIK; Thu, 18 Oct 2018 13:14:29 +0200
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LfhYy-1fpYsw3EZW-00pPIK; Thu, 18 Oct 2018 13:14:29 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v3 5/7] ARM: tegra: apalis_t30/tk1: annotate power I2C being on-module
Date:   Thu, 18 Oct 2018 13:14:09 +0200
Message-Id: <20181018111411.26623-6-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181018111411.26623-1-marcel@ziswiler.com>
References: <20181018111411.26623-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:6ytx73dKNmKS4wTx5/ab2c+OWSE8abSKVDkRutB3nqgKttHMjut
 J27WQ93Q8ZwQyw4/vZnjEeVCFXgKgA9UeAgKCwektj4de8WPtgDd9uE1f3j3V21bF15Sppo
 NR5lf4IiyY/ILz0KXNHE1t0jBycru/ZcVxL0TLCHmct2YiQc6wmNb2l+lZ223K8SqiYlCju
 SmitiD17R0IOVS6Bd9fvg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2FouDlTDRI0=:uX8ODmuzU7Wev47uEHHzi+
 3zKZkVuGk1VVVZmKXRXhdW2PFxPUa0X2Eh6s3NHCDrmq6K68TOBslZ8opX9Kw1eol9zEev6j1
 p+/EQ05a/RLCDWfHjrPf0Q4eah2Y86hQVyMav6j8L9zFZDPh8htoIwBXzDwTng3vTJjSQOzh8
 TsZzou/UKebK/mCSSa5fjHFxNfFCbTKVvNf0mjAQSotssdwGuGFbudRWuxF4xHMbU4szDVdJx
 BOb2+msLWGlx/+w76TgO2eeLZA7S7N6zWBpai4AvK1LFj1EMtI++k3BI/DbSOBjlnER4Nl+jB
 fGnbZJLMy4sbUYd4AJuIP9Vt//mnk7nBpj0JLRalrMEhfPgrpQHV+OAAFrNNOhT1w3Tin9yXA
 mxLvvbjXv1+XMv/3A4muej/ZPJLWMsKqr/IFKzpyEzXOwO9cmUqf7/VdENdIdPQDwNMrQUTSe
 LMvAdYWV5rk67b5JBuKnPchm03aMkAFdw3LZjA0Qw/d2ECqRz2e7lIFQcQxP+8/8xyFjynkvX
 WrnSaQRHbTDuHLGx7cLN01UXtyEepO8c4+1va5rASisKkwj40En7SKoVf1sOz9fwLDggiUy6V
 qEwnqCHkUM7vYCBspgAQKLOgali/ie27YbtQuNCUKcGSCQKZS7h3wNk5/Iwy9Eh5Nfw29ddHX
 ng81tnSQnRNn8cdyNQxq5dcS7SlQ8Ie2K38tSHryvV3I998lY0gAsUX0b1AY5S3p0rFg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

The power I2C bus aka PWR_I2C which connects to the audio codec, PMIC,
temperature sensor and touch screen controller is really on-module only.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v3: None
Changes in v2: None
Changes in v1: None

 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi | 5 ++++-
 arch/arm/boot/dts/tegra124-apalis.dtsi      | 5 ++++-
 arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi  | 2 +-
 arch/arm/boot/dts/tegra30-apalis.dtsi       | 2 +-
 4 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
index e532b564e4c9..0d095729b46b 100644
--- a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
@@ -1552,7 +1552,10 @@
 		clock-frequency = <10000>;
 	};
 
-	/* PWR_I2C: power I2C to audio codec, PMIC and temperature sensor */
+	/*
+	 * PWR_I2C: power I2C to audio codec, PMIC and temperature sensor
+	 * (On-module)
+	 */
 	i2c@7000d000 {
 		status = "okay";
 		clock-frequency = <400000>;
diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi b/arch/arm/boot/dts/tegra124-apalis.dtsi
index 3cab9bda918f..13127415d86b 100644
--- a/arch/arm/boot/dts/tegra124-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis.dtsi
@@ -1582,7 +1582,10 @@
 		clock-frequency = <10000>;
 	};
 
-	/* PWR_I2C: power I2C to audio codec, PMIC and temperature sensor */
+	/*
+	 * PWR_I2C: power I2C to audio codec, PMIC and temperature sensor
+	 * (On-module)
+	 */
 	i2c@7000d000 {
 		status = "okay";
 		clock-frequency = <400000>;
diff --git a/arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi b/arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi
index 02f8126481a2..bc714032d771 100644
--- a/arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi
@@ -845,7 +845,7 @@
 
 	/*
 	 * PWR_I2C: power I2C to audio codec, PMIC, temperature sensor and
-	 * touch screen controller
+	 * touch screen controller (On-module)
 	 */
 	i2c@7000d000 {
 		status = "okay";
diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index 7f112f192fe9..4b6a8ecaac76 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -836,7 +836,7 @@
 
 	/*
 	 * PWR_I2C: power I2C to audio codec, PMIC, temperature sensor and
-	 * touch screen controller
+	 * touch screen controller (On-module)
 	 */
 	i2c@7000d000 {
 		status = "okay";
-- 
2.14.4

