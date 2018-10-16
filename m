Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C643CC169D4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94AB920881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94AB920881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbeJPShz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:37:55 -0400
Received: from mout.perfora.net ([74.208.4.197]:54909 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbeJPShy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 14:37:54 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LdWVQ-1fmQ0X3a0g-00imTa; Tue, 16 Oct 2018 12:47:56 +0200
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LdWVQ-1fmQ0X3a0g-00imTa; Tue, 16 Oct 2018 12:47:56 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 5/9] ARM: tegra: apalis_t30/tk1: annotate power I2C being on-module
Date:   Tue, 16 Oct 2018 12:47:26 +0200
Message-Id: <20181016104730.4598-6-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181016104730.4598-1-marcel@ziswiler.com>
References: <20181016104730.4598-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:l7GtNOgcvoa4aXzyM8tx3CX5Quhh9/oRg1UwDTbj+Wl/feUFr/o
 fsf4xBl2LcV19LD2TvTUiXDnEhJZwM0OCwBt7REh35WDHaxbLmrKm/l/aNIh9svJJ+yInaq
 VegXA/UIZZg8Qabgzbr3/Gi+CNT4hxxxjVAeyZ9/Yk95DEKMBb1OBQkNMU49i6fNVp6KZxY
 3SD0wQJNLmo1//I1mMLaQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Wvcsfaxxnds=:SdZ4MQldZdCROmbjCePgZE
 beAbC+I27ow2cxDaV5B6+fhwZprDsLFDzPKDZbbBE1F8g1KsAcv5qvRwpWj4upcE7dhcj+7wJ
 Tto1ooI8nOfGQZSI3rk+yuIn8TWir42djQlZ5k6Qmy/CaJmK9Vmk64xEn3OakJ8eUrOYTPdXV
 IAb3jqo5oj7iXZzWE3WbWFMhvhD5kNYozVBiwxiPkXONRC4a2LoxDSQ+dXtTVKQprCYI99Xqz
 WtfaNhnU+ZGNX8L87cuwo7n3wL87ETx+m/8fa//UnbWa+7C+27etiAPL1F2FO/bzT/xnTwwOm
 RLp4FRIGBZY29nZUJwwztLLGDOM7dmcZHyw57juHgV1AKmgxJcETbo7my3K2wniZHP1lqqRdM
 t3p1u+06ZY6ZAJZ1H/NTzOPJfdqr6deRWyWm1JG4DFlW/dnUO8P5Q1aYN6p3AvkAtYF6Kr21J
 hLRN9NdLDte8IFbLe14CrmvkYcpHU69MD7tPTTYkr2qDyuRhi3yZtJR5rj+NrFOHSBUkYBsxH
 kPWwp0uWqb8GqBjuG3O+sGFJmXR+m50jOqFTN7cOUpXLwVc/G4EeEUePhF4mvtFNtJ+V33+uC
 KVEdO/6ahacaufdNOExvFOEpAXt1zUg8gmclH9DCOcICLG0Vpqe6TjpIEDWgl1jxPGjRaHF9o
 XLMBOuOzO+YUm8/ROOOXU+cHNJdqvTxhXumCi80erRc/7fbAC84kTWQjnOrzN5HiwZx4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

The power I2C bus aka PWR_I2C which connects to the audio codec, PMIC,
temperature sensor and touch screen controller is really on-module only.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

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

