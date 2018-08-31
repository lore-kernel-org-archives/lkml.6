Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3863BC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0FEA20658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:41:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0FEA20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbeHaUrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:47:14 -0400
Received: from mout.perfora.net ([74.208.4.196]:33381 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728463AbeHaUrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:47:13 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MSK0j-1gK8h80J4d-00TW2g; Fri, 31 Aug 2018 18:38:49 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 12/34] ARM: tegra: apalis_t30: drop unused mmc1/sd1 labels
Date:   Fri, 31 Aug 2018 18:37:54 +0200
Message-Id: <20180831163817.23970-13-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180831163817.23970-1-marcel@ziswiler.com>
References: <20180831163817.23970-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:3EpVTgNl6vs0UgMj8X7e9aXfrTOv1RxMg49Whl6Ds9P/EFFM1YG
 NAdrk1ytkD1XdB8OrUx8qw/nIRXMXXuRgbRgBj6QtxLdbqlMH4dgNY3YjL7vnPzgdGaRj3s
 WngJnaF5uIJ/yAGbrzXDvE/EW4ZykL+P5wBhE8E6JH8z8JuiDIvkEHgLtu+iyko4/00+PCN
 pw2SZ+iTKNnTmi+9kxtRA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Vdf33C6pmqQ=:cLIjLe9lfLIUKzW5qCC2zm
 c7y7xAhPbv5aHFfBuJJiUP8mR85JFhIgkPFNQENyTC4I04e8Ib8WHXP0VAD0wvY/2hXpA8i7/
 NB+G0OQEtd0ujdvsm/5DWdsuBXAclzQCNjIkgL9adIyFqIwRgDJ15jKVAxKJOsOK/q300t4OZ
 /XOb9JqxUHg9M3auI5jLw7y9BEo4bm7N+2Vy2jaqH3ZH0spUZPWK/v/FitfqEzyK6l7EWw90W
 Iwx4mcEKsAkTxhawOFm5f92oHcvlmSkdsi4nLv76ZD7JvHhoJn3ewtC5zONnZLTVhcTIly9+U
 VCSG00bzheG7K5bEJ7TeIpIxaLKM/pkArzjyLa4FhNLjAmjDBtEC5wb/zOCoT6Kb2jaT+EeFN
 BnGbuqFmvS9ki+wYbkHUThY3zDcFQkdooGY2zYLMVYKqNvYF8itx9AyY7wtqHMhHBvU1Qp1tj
 24jTAw2R5FNIqXWwksCH7xrU8VuDr3WEotvC3Mcqrg/aZoY0PQM6dxFRc/8ROOqrBQI0ronib
 BAauphAuTTiq0GPu/uqPg71swM2t51+16KAKxGWl4F3vJN32FjP9qVPynKeexqlakNMVDHCIA
 tO6CnKMtJmq4dqdfqEPkaWCNW6K794KhnBSXmhxEWcLT8Y9dyS71gwkwOdgWfY4PiulL8jTaS
 h12YxhFvDjuHxZTjK16a1pMhPPPFXaYOOwxLYmDH+2/HBSOiImU49u/HDlam31/Co3UI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Drop unused mmc1/sd1 labels.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra30-apalis-eval.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis-eval.dts b/arch/arm/boot/dts/tegra30-apalis-eval.dts
index 0a8900be0008..3f25bb307397 100644
--- a/arch/arm/boot/dts/tegra30-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra30-apalis-eval.dts
@@ -134,7 +134,7 @@
 		status = "okay";
 	};
 
-	sd1: sdhci@78000000 {
+	sdhci@78000000 {
 		status = "okay";
 		bus-width = <4>;
 		/* SD1_CD# */
@@ -142,7 +142,7 @@
 		no-1-8-v;
 	};
 
-	mmc1: sdhci@78000400 {
+	sdhci@78000400 {
 		status = "okay";
 		bus-width = <8>;
 		/* MMC1_CD# */
-- 
2.14.4

