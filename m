Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF505C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 717CF2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:14:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 717CF2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbeH2MKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:10:16 -0400
Received: from mout.perfora.net ([74.208.4.196]:48445 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbeH2MKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:10:15 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MHZc2-1fw25H3EOS-003MDa; Wed, 29 Aug 2018 10:14:28 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 07/31] ARM: tegra: colibri_t20: iris: use no-1-8-v
Date:   Wed, 29 Aug 2018 10:13:43 +0200
Message-Id: <20180829081407.11304-8-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180829081407.11304-1-marcel@ziswiler.com>
References: <20180829081407.11304-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:RdhPPT3dvPFC9uFCvHodbhLkijsVJ3ijZDKmV75mUlncBgq0TWN
 RlmiaMwgPEsWkvCi2fp9zahxMZtUsZDSXkqGMGm0n/VWx7qL4GB90lPRYYcIDppPgzuCMIJ
 PqxcbUc6oH2AHmjYkTQIVCpnzKLZ9nV6AcBQ6BmfhXd3NMpKouQjVqW6QfKtEIOpIFq3vWR
 FRIRF1M9yT3XBoXAyO6Sw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:h6ZaEOtbzVc=:xYkTdJqdvyoy2keGsrQuUV
 RAuHEjyZ6QwZqiSvVHv+/rp3TWFmAmbZBAhbf46uffgKtcalfMjF1YeEkUtLd1W7jnjZbGcUh
 X5xOODXCLPeWeGUKxYDavc2Uj6ZGgXGj0aeYqrXYOUQkMd450LoKFooACU4kp2BjYckTbGUVH
 7cLMmkHNm7TmRIkptuvtgCVHHWpA+GekHF7+KcUxH9EP9TuvBH+OMKu2WaOqPUmkLBXKKdQuL
 UIn6jGMK2Rv6/tYUEVMpTVE0agP8g15NpCodyYqpGJ5U+6qkagC432RdLDoRE8P+8zTBT/FFl
 hL6xVrXo/QQtAYA+Irm4TIBV9loY51Bgk5rv4EsRAGbtHd3EOKB2l7lpZN1DAORoAUwmxMcga
 P94kckJ1WhUfsfQ46ObgTQsX7mHeGJXTMrBlqvPPkZ7Mi8n0EZP3j8WCI6m668Xx/d0tCUbkm
 rG6OaErw5sB/YV+VEt0DVn0cX7tCkQbIVRivtBytyCSitWjVn/a0v7y2CROdkWt+nU1k6EiUO
 zDJbbFp/owzfMCwmbKIcp669Ld13BZ0XTa6AHJ730arzfMsB2OTQRvNDEBz4f+ZN0IY32AvIV
 1fCBmp/0/voy7LVMv7N+rJtNoKNxyOI1YC9ADTNHc+QJPhMk4czU2hXLktcpKMM3Ofa+eh0wY
 5SwmM5ULQH0kvVzRuKnxY1n+JbCFH+IEXcx2K22n1ZyURX1/vhxMagBUf7YNaws5LUMk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Use no-1-8-v property rather than vmmc/vqmmc supplies and drop now
obsolete and anyway non-existent vcc_sd.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra20-colibri-iris.dts | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-colibri-iris.dts b/arch/arm/boot/dts/tegra20-colibri-iris.dts
index cc9e372a3b58..3d430fa93e8c 100644
--- a/arch/arm/boot/dts/tegra20-colibri-iris.dts
+++ b/arch/arm/boot/dts/tegra20-colibri-iris.dts
@@ -101,8 +101,7 @@
 	sdhci@c8000600 {
 		status = "okay";
 		bus-width = <4>;
-		vmmc-supply = <&vcc_sd_reg>;
-		vqmmc-supply = <&vcc_sd_reg>;
+		no-1-8-v;
 	};
 
 	regulators {
@@ -116,15 +115,5 @@
 			regulator-always-on;
 			gpio = <&gpio TEGRA_GPIO(W, 2) GPIO_ACTIVE_HIGH>;
 		};
-
-		vcc_sd_reg: regulator@1 {
-			compatible = "regulator-fixed";
-			reg = <1>;
-			regulator-name = "vcc_sd";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-boot-on;
-			regulator-always-on;
-		};
 	};
 };
-- 
2.14.4

