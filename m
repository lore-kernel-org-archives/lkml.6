Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AF1C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E29520841
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:13:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E29520841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbeIAMYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 08:24:53 -0400
Received: from mout.perfora.net ([74.208.4.194]:39829 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbeIAMYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 08:24:53 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MLhDB-1fvjv23rPv-000ssd; Sat, 01 Sep 2018 10:13:36 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 18/34] ARM: tegra: colibri_t30: line break long compatible property line
Date:   Sat,  1 Sep 2018 10:12:32 +0200
Message-Id: <20180901081248.22639-19-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901081248.22639-1-marcel@ziswiler.com>
References: <20180901081248.22639-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:1L2zZ9JytNuUm+37AfJhGr8p6diB9v7jVT/Dk28tknwrF3f9JY7
 deXz5a/Dp7btRpNcebXxmBXtoewnpet8Y6phm3Ge7yi6jnl3sNsMkZUDCd9xxOmhwe5kL3H
 2TgiphO2wER/Wwxt/JdXIZivz2HpdsIMmanHQ1PY/vCZd/n3cbHr7pn0pONvdJDKkWDUdRb
 tPNo536nbo/Z2cVLQFawQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GEx/9x5ns2c=:4F7EF0U7BgPUWSG0Bg9NeN
 JzQCKRK1QaJDy/Kt8IR3yn21E8pIa82v44q6+24RA5LnDhaS3VsMVukRC/7U830vqt0JDdKyw
 BpsdaHc91z8mXltSom24neIzkJ/G7nNYYz6IsYUb1enzwHiUeMZtiLlKyucAb78hLQLDIbAYc
 AzVtwatzXTlfNsvK62zxhx/0Q6gjc0oPfCkJTn2KWuezBHyI+Qh0Cv/KJMEdzR4vk+PHr4He1
 poRi4dMVlMBzR52llxLRD7ZG45gCGsnYdzDa7R5XatnApFobNVPil5lqdL4lnfVXx1gvRgace
 EvY2W4JramMTwPjEATur3HBoQau/PeHedumPJO0bvpa0rVKsABXXR1pky0RoPGJCpV2xALcHt
 984EkA027BL1BfX3ByoPHZB6rkmau+cthYuHbF3U9h7aYTU8cD/N07uTA8Fhj2fbJytO+CdYo
 fkmLHGuWYPRx/lXbUWpwnSKsupC51jLXbja9vsKHLKQUlsTt161NEppdLnyOy+dtf5qHf5Kxz
 9xlt8qiQP5DdjIK3zCf13btiHi4KTFTMLGgoR5oHPLmDyXEDAz+ruARjarkhHlKTz2ijp/0O+
 3zxlj9igj9UNL190FBh5ZNHww9LtxbfpU5KXddLlJ6ZDCKnYzSd2uQKaqZ/ewfcwq7KnXC3fi
 G/gJBKNUzq2JR6E602n+8uZ81eOa32iupks2N+dXeTFwi50FcSe7KoYikAHg7FA8+Sww=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Line break long compatible property line.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
index bcdaeedcbea2..d8ee7edb24cf 100644
--- a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
@@ -5,7 +5,8 @@
 
 / {
 	model = "Toradex Colibri T30 on Colibri Evaluation Board";
-	compatible = "toradex,colibri_t30-eval-v3", "toradex,colibri_t30", "nvidia,tegra30";
+	compatible = "toradex,colibri_t30-eval-v3", "toradex,colibri_t30",
+		     "nvidia,tegra30";
 
 	aliases {
 		rtc0 = "/i2c@7000c000/rtc@68";
-- 
2.14.4

