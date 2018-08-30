Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30750C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D548620837
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tG473dJy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D548620837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbeH3VZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 17:25:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:56198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727086AbeH3VZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 17:25:30 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D7E420661;
        Thu, 30 Aug 2018 17:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535649740;
        bh=+BdmpvZKfMFyyZ44sJbE/x5wDEV4jogU097/uL7VhN0=;
        h=From:To:Cc:Subject:Date:From;
        b=tG473dJyDytHC+74vOGcAw4jkbdr2ysFS+jd6TBeD+oPfAF1sdhJD/NNxhKG21wCd
         wttDAQzLmWfHVVU1neo2Thbn5gBlbeAQ+l7QGvhcA9wIxNrHG9JApudZc9MYogJWUC
         ypPz9f+oWCwDXIw/j+CPDD/lpNbcRClrNNQF9m0k=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2] ARM: tegra: tegra20: Fix mixed tabs-spaces indentation
Date:   Thu, 30 Aug 2018 19:21:53 +0200
Message-Id: <20180830172153.20653-1-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix indentation and alignment when spaces were used instead of tabs.
This fixes checkpatch errors like:

    ERROR: code indent should use tabs where possible
    #306: FILE: arch/arm/boot/dts/tegra20-paz00.dts:306:
    +^I^I         <&tegra_car TEGRA20_CLK_PLL_P_OUT3>;$

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes since v1:
1. Add Marcel's ack.
---
 arch/arm/boot/dts/tegra20-colibri.dtsi | 2 +-
 arch/arm/boot/dts/tegra20-paz00.dts    | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-colibri.dtsi b/arch/arm/boot/dts/tegra20-colibri.dtsi
index e7b9ab09908a..fa1af2dc276c 100644
--- a/arch/arm/boot/dts/tegra20-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
@@ -541,7 +541,7 @@
 
 	sound {
 		compatible = "nvidia,tegra-audio-wm9712-colibri_t20",
-			         "nvidia,tegra-audio-wm9712";
+			     "nvidia,tegra-audio-wm9712";
 		nvidia,model = "Colibri T20 AC97 Audio";
 
 		nvidia,audio-routing =
diff --git a/arch/arm/boot/dts/tegra20-paz00.dts b/arch/arm/boot/dts/tegra20-paz00.dts
index ef245291924f..7d8aef6ebd3a 100644
--- a/arch/arm/boot/dts/tegra20-paz00.dts
+++ b/arch/arm/boot/dts/tegra20-paz00.dts
@@ -303,7 +303,7 @@
 		request-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_HIGH>;
 		slave-addr = <138>;
 		clocks = <&tegra_car TEGRA20_CLK_I2C3>,
-		         <&tegra_car TEGRA20_CLK_PLL_P_OUT3>;
+			 <&tegra_car TEGRA20_CLK_PLL_P_OUT3>;
 		clock-names = "div-clk", "fast-clk";
 		resets = <&tegra_car 67>;
 		reset-names = "i2c";
@@ -599,8 +599,8 @@
 			GPIO_ACTIVE_HIGH>;
 
 		clocks = <&tegra_car TEGRA20_CLK_PLL_A>,
-		         <&tegra_car TEGRA20_CLK_PLL_A_OUT0>,
-		         <&tegra_car TEGRA20_CLK_CDEV1>;
+			 <&tegra_car TEGRA20_CLK_PLL_A_OUT0>,
+			 <&tegra_car TEGRA20_CLK_CDEV1>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
 };
-- 
2.14.1

