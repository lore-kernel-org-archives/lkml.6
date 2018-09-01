Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4ADC433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C22CB20843
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C22CB20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbeIAMZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 08:25:05 -0400
Received: from mout.perfora.net ([74.208.4.194]:60039 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727251AbeIAMZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 08:25:04 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M4pkR-1fi4iS213l-00z1B7; Sat, 01 Sep 2018 10:13:46 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 23/34] ARM: tegra: colibri_t30: annotate sd card detect
Date:   Sat,  1 Sep 2018 10:12:37 +0200
Message-Id: <20180901081248.22639-24-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901081248.22639-1-marcel@ziswiler.com>
References: <20180901081248.22639-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:+Z7lNHMDsLSSn7Utup26zdhhXZLHHio5F+EqJsThoobe3H1rSKS
 eaDQN1CuG7LxERR5Ddq+yrFpTMXMoa1Zt9JMnXyGApGWXpQ0/lstmhxMPXIi6yK2uXYyVp2
 QF9Cil0vzCkwRYx+UGB17Dju5wzZnSkKFI+dKrfEy4RQ0f8upu9fwAMXkiz2LIu75d8InCo
 1QksocLBrRNK7lnTOjbsA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/rV6Ef6d8uY=:AUwLkDt0yd4H8HDI8XPew3
 0DS7hfY9K1iprWwxcWZ9YpEHV1icgb0Aer+kUcBBqivq4SUueOgQHDaqOUovvuN+7AkJ9/T/I
 sqQSplkzSHvISEfMVlNik0jxuZREvjr8w/ztay7FLS3qEGR5Pibdk26wsyt/KT2B4JSyk1ZvT
 HZZgzY6BREL0trYBBkKtSEhlb+XvSWGnsfIRUXXdPQ2GYAPNaMh7LyHvmquGobHtOwmrWxRte
 dJ2XaMm3kNM8OmfvxGZUhqUGg8xy6RL+WWVXjdHEd1e0pftJxot0FY1cEn/v/+Nhzm1hSeUje
 hTojhvd3351/zXyUvQMLHNSi169FauhM6PX4i67mG60mYzCn41TG/gpKM4Ed85bk2bWZ6TEO+
 c+PWsmm5PlgjTqJL8GDefQgrc1eoM/FDu+xZjMFpJc6tyuj2+PZHTQD8TwNgyZXLAAQnFwLzb
 SNR6qZ05z+h89Zg+j8ubUlfQ1dY01EiUvaCKruUkZ/z5lhiZGkd6UmIN1cAwtP7x6INcaoMJm
 iiveOuSpDa9ppUVdCZYeCTFj1MCO5pU08Il9sbniOOPrKhQQTeA5AMGupnG9jxl2+h59B3H6M
 ij7vhbRvCwZeog3Z3BGs8kW8o6uKU8ou5gwSYK+Px46Vz7XqYU3y4oJwStSK1xg3Pr6AzD17m
 +VtBX0yRRDD1fKx+nlk8aLYBv5BfE5DcQV1x3p7ypxkaY3sOYQoPE+3Q2xJTYlrVUu+A=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Annotate SD card detect.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
index 16f5e6af68b9..aca4cd786442 100644
--- a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
@@ -100,7 +100,7 @@
 	sdhci@78000200 {
 		status = "okay";
 		bus-width = <4>;
-		cd-gpios = <&gpio TEGRA_GPIO(C, 7) GPIO_ACTIVE_LOW>;
+		cd-gpios = <&gpio TEGRA_GPIO(C, 7) GPIO_ACTIVE_LOW>; /* MMCD */
 		no-1-8-v;
 	};
 
-- 
2.14.4

