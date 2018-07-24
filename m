Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB3FECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8023A20875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:43:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8023A20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388786AbeGXLtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 07:49:43 -0400
Received: from mout.perfora.net ([74.208.4.196]:38385 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388296AbeGXLtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 07:49:41 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M1Gz0-1g1vaL2OYy-00tGEA; Tue, 24 Jul 2018 12:43:46 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 15/15] ARM: tegra: apalis-tk1: reorder SD card properties
Date:   Tue, 24 Jul 2018 12:43:09 +0200
Message-Id: <20180724104309.21741-16-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180724104309.21741-1-marcel@ziswiler.com>
References: <20180724104309.21741-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:+f7EPuiXSInyAPaIiqmk+h0qzTMqq3LJJc4rxRoNigWWdq2ltlm
 kr2sAEbWYJEcmY6/ULYllIWbIGR/HYCht/90O5u+5RDt0O2NDjIVGZrXMvVwQm17G5b3SZV
 bLl4ka7TchzVauTwm+Gl0KkZmDzxZurDJKGmtCcaYzz3COTgzy9+aUaBlwOkqASkqaLQoOI
 OJ/Wmdqm9zArfnNzn0ItQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:R7UhaTH3eG8=:wpxPcfYiEtZf31Vr/FN8fZ
 Rirxi0AcGmTm9ZsDKCedtYo09JDPXsBWDqj6U4qASjT5kf2azcf8Ytk0LOG6fA0QoX2BiSq1p
 DgoogTg+dIyzXBiEK+UizNhE5a+qB8F5tBqbqk01SV2o2N4IwMOssInoggkmMeubaqmukHi0p
 j8ee/hjDWmj/ZLHnZymIWkmcCw3gf0KBrDFt1EMmBqlZiTX9H0Pic8u7+g/XsefreOpziEMgA
 P+ER0CSfWzyQr9ui5CnZr+CMIJwJhfMjcd+/c+Kvwxbri+8/aN08I/5qj8i3GBJPjsBUh7pM9
 eRoGTNr5nEIQT+PAqdiHnkXuB99v+X+k8jPVKCJm5fwtCdGAHXgCH93Zqm52VjCe32S6CWBlY
 shrnr0oYAvs9dxgcwm71tFQS/boaNrqacR/7KukNaMWMKxUFWr0DokxIZXojCiNWj/pmOmYwF
 j3Ii6iWtz/RfsCy9P/EwSji0EknNSP0oHfuBkFU0G9EktrRIYauxYt4Hi4QpmEsxOU/DWCBRU
 DL14m+HGa8UQ9n2Umk/4Jyc/4oAf4IYVp2EQNeKDKn/PscFgenr9X8pW81OHdFzIFxmTftJLt
 8ZAwmR5iQvQQxMAZt1itixSOdCfec4/Ov5g9HSuDelgbWWSmXK/itsG/EIZsXka1WFUqHDlLr
 rlkdmo5bGRqaG3iYAb2tOHuqmbfQFZnKzAR3V5z4KSf4gD99XD974EiCOTM6KIDagCkk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Reorder SD card properties.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra124-apalis-eval.dts      | 4 ++--
 arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-apalis-eval.dts b/arch/arm/boot/dts/tegra124-apalis-eval.dts
index 84ab7dc9febb..7d32e402a0f1 100644
--- a/arch/arm/boot/dts/tegra124-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra124-apalis-eval.dts
@@ -180,18 +180,18 @@
 	/* Apalis MMC1 */
 	sdhci@700b0000 {
 		status = "okay";
+		bus-width = <4>;
 		/* MMC1_CD# */
 		cd-gpios = <&gpio TEGRA_GPIO(V, 3) GPIO_ACTIVE_LOW>;
-		bus-width = <4>;
 		vqmmc-supply = <&vddio_sdmmc1>;
 	};
 
 	/* Apalis SD1 */
 	sdhci@700b0400 {
 		status = "okay";
+		bus-width = <4>;
 		/* SD1_CD# */
 		cd-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_LOW>;
-		bus-width = <4>;
 		vqmmc-supply = <&vddio_sdmmc3>;
 	};
 
diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts b/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
index 5319f88d3cab..91d54d14f527 100644
--- a/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
+++ b/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
@@ -146,18 +146,18 @@
 	/* Apalis MMC1 */
 	sdhci@700b0000 {
 		status = "okay";
+		bus-width = <4>;
 		/* MMC1_CD# */
 		cd-gpios = <&gpio TEGRA_GPIO(V, 3) GPIO_ACTIVE_LOW>;
-		bus-width = <4>;
 		vqmmc-supply = <&vddio_sdmmc1>;
 	};
 
 	/* Apalis SD1 */
 	sdhci@700b0400 {
 		status = "okay";
+		bus-width = <4>;
 		/* SD1_CD# */
 		cd-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_LOW>;
-		bus-width = <4>;
 		vqmmc-supply = <&vddio_sdmmc3>;
 	};
 
-- 
2.14.4

