Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C070CECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED1B20875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:43:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ED1B20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388767AbeGXLtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 07:49:40 -0400
Received: from mout.perfora.net ([74.208.4.196]:57617 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388296AbeGXLtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 07:49:40 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LyTxo-1g2WTp26nG-015rOy; Tue, 24 Jul 2018 12:43:44 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 14/15] ARM: tegra: apalis-tk1: reorder cpu dfll clock properties
Date:   Tue, 24 Jul 2018 12:43:08 +0200
Message-Id: <20180724104309.21741-15-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180724104309.21741-1-marcel@ziswiler.com>
References: <20180724104309.21741-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:FWK/8a4ffohrMpgNgiz+Jq9VLstd0VjMSknLz4MWPz8sgLRl7wX
 mYUp6S4YtHE7qoacMPjvXR9plSAtyuMkzYMm8OlCW489ttjxAN28SX1bTOs9cYclMAPZijU
 3qnemsMi7ueLi8ETR5UA+Xcg9ibyHc7o97FhLn0etClsA4TqEjpn9SX+EGn9oRyws/oQUrM
 HB7xI/xffmIaqbZj9Gj8Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:85+v+8yye6s=:u1iGKF3lbzUyFK4wRRGBJx
 BCNfeYzSpQWOoZXdPQpRxDLvNuVnR0ktHwDiy0nZBB1aoMtGAHwjJ5a76DUKXI/Wwen8XjDPE
 zLSZmiB2WfF/X56Ht+HP2oJz1rKlbfmd4ajc3paJhhWhmDUnwSx6jKISKQzWaR0PghePeQuG5
 8RcsIbrfmUms/MqgF01P8hKjRoFL83tTDj9+reIWkYRpYCGV2xJuWVn1ha5qBUekTcOk8wCAa
 rRWWRPiYX2wWx0dPD/7DZWtGiOjZj4VL0CcnXcEVR1supSRchZkD6BbrKomBfIGJAvYUe0d6i
 EEFuyjyOiyUMxVj02U6WQ2f3+kCHimfITFEqhMehdHZuw4YlL/bryZJy1hMSUHdfYoCe46+iE
 x6dhwmDHSyQLPhucGulCHQW/ZPLP+xGTPHzeEJiHsKxkJNK0gReo9iX8B3u+yUQzRVdunG0Zs
 E3rHbA0GV9foLk/Eya7bdDAc4ANZ+ipz6M99ygr5B6DXVfhbg3TrA1u+jCMvW7TMycKJzB5+5
 lw8O0Ucs+L+Mb8cVRs3uJ8hccuPDd6gHoDM+9IVlE2kb0ZTqROmciFKaX0jMSwgURkVcRdEsh
 n+rFF40Iqr44qvo0LRXfcmSQTjyWy56YwIRcCYJDYlwkUf5aQmD8NK5H8FgVjs/KBfq3YnFgH
 uZxOFC0NoV8rbzObtHK7Igly8KbE8B7dC9KCeeiuTKhuO6Ol4QRHJ81obvYpOGevkaaQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Reorder CPU DFLL clock properties.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi | 2 +-
 arch/arm/boot/dts/tegra124-apalis.dtsi      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
index 13486fe407d2..0837af1bf658 100644
--- a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
@@ -1925,8 +1925,8 @@
 	/* CPU DFLL clock */
 	clock@70110000 {
 		status = "okay";
-		vdd-cpu-supply = <&reg_vdd_cpu>;
 		nvidia,i2c-fs-rate = <400000>;
+		vdd-cpu-supply = <&reg_vdd_cpu>;
 	};
 
 	ahub@70300000 {
diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi b/arch/arm/boot/dts/tegra124-apalis.dtsi
index 77ca508d755e..18e9e9e8b474 100644
--- a/arch/arm/boot/dts/tegra124-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis.dtsi
@@ -1954,8 +1954,8 @@
 	/* CPU DFLL clock */
 	clock@70110000 {
 		status = "okay";
-		vdd-cpu-supply = <&reg_vdd_cpu>;
 		nvidia,i2c-fs-rate = <400000>;
+		vdd-cpu-supply = <&reg_vdd_cpu>;
 	};
 
 	ahub@70300000 {
-- 
2.14.4

