Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BEAC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF9420841
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:14:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF9420841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbeIAMZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 08:25:24 -0400
Received: from mout.perfora.net ([74.208.4.194]:33285 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbeIAMZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 08:25:24 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MEDMs-1g73fq2Mzg-00FOwq; Sat, 01 Sep 2018 10:14:07 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 34/34] ARM: tegra: colibri_t30: annotate power I2C being on-module
Date:   Sat,  1 Sep 2018 10:12:48 +0200
Message-Id: <20180901081248.22639-35-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901081248.22639-1-marcel@ziswiler.com>
References: <20180901081248.22639-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:CH+nXAAWLnuw8EMLjq/IDgLlzISUj0ALeyE/KNotwlqKodq/uNM
 OHtz2+HSnL7Yv66tIDGjVp7VKo6xhn7QGcH6MtVrjyHsgz4KapJ97yfKsaiFQuCBdNWrY+g
 cB2v8c0pIh7qSn14U0iMhCINtpfiSeFPQ1ol5pWTtYgH8pcsE9XnhIHhKjHFgrrnVkxHoWN
 RPHLx187VksopQdu9FIbw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:B5K0Waq3sDc=:g9HIl3XDI1nDdjLq+9r88g
 y/sAIv6oJv7TPYBQB/gd/PyLRkahnKfejfZavjjeMXlZpn+4TrwC2NZfjAkNx9bwH8ASzpc3F
 RaFl1M0/Eks3UP4uDkmR6psKJX2AT1/SgRJOb5cYABohyL5azwuQIfYpVBfsdvQniE+ydZDvB
 9Gn/hR4Rxvc7uzdZi8EKRZK/YUCD0ZuObay6pai18r++dMhsfD/zYCu4vcE/wYF7ZtKlt3UlJ
 WvyQHwXrmvevaT/8GmOIa69r14mUlA3yI6Tn3rMhI7cN+cZSTEPZWK5ddESYUnqD7xz4f8kk1
 9uGCUaHBWY1aJ88B9cCs5bu2EEn6I7A2kWog2tAzUg+F0ary1E3IiuH+Yu1PDlQFKOXDmLF/l
 ulzgASwGFOH/OH20tmwFbp8oPhCZF3GeydGx5Uxd7zdESXILzYfRDnfQ6xEp8IKvYHX6HYdeP
 366Hrpjx2IkIb8jgz0LfrZacBUlk2w5Dz08cs7oCWrev1TcxCUGBJBc0njbFpmXTas/9CNomw
 suKoJEz/T9fnJOysx/BHUGalz8MynN1XI/wvC6xXlXpbBPgexLhvEs/vjIrVgDARQhoVW3DXU
 FBxrspxoNBibVX+zJIr4o7uL0ofVQpU61ytjNHpbCYDNvFSPdxhRkx6Yo0no6mQTXisYi8/H7
 R2wUHxxpB3mieeJAF8wXqmBIhfAUjNp8XGjFIE8FL2TfIIPRdHz3G6+HPufExb2kLx4CdSHXR
 /qnUctCUtAkve5KgUo7QQvtW3b8J0BXcEdeN3Wwt/bKO75HCgPlFRjkgDbZ5hsGraNFmorG6N
 OwrB3gQxxP5NPSKmEWsXMRS2bVbNQXREGH/k3nna8az8oTItHtaig41lrdURmjH1Yw49QNYic
 L8p90xKtFHGMeDZPm48A==
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

 arch/arm/boot/dts/tegra30-colibri.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index e32702a4ab10..35af03ca9e90 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -713,7 +713,7 @@
 
 	/*
 	 * PWR_I2C: power I2C to audio codec, PMIC, temperature sensor and
-	 * touch screen controller
+	 * touch screen controller (On-module)
 	 */
 	i2c@7000d000 {
 		status = "okay";
-- 
2.14.4

