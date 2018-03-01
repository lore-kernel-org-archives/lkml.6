Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161668AbeCAUfQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 15:35:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:41768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161653AbeCAUfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 15:35:13 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC98B21771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: exynos: Remove unused bypass-smu property from Xyref5260
Date: Thu,  1 Mar 2018 21:34:59 +0100
Message-Id: <1519936499-23230-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bypass-smu property is neither used nor documented in bindings.
Remove it from Xyref5260 board DTS.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5260-xyref5260.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5260-xyref5260.dts b/arch/arm/boot/dts/exynos5260-xyref5260.dts
index 442eb0353f29..fa19c59b2fb6 100644
--- a/arch/arm/boot/dts/exynos5260-xyref5260.dts
+++ b/arch/arm/boot/dts/exynos5260-xyref5260.dts
@@ -65,7 +65,6 @@
 &mmc_0 {
 	status = "okay";
 	broken-cd;
-	bypass-smu;
 	cap-mmc-highspeed;
 	supports-hs200-mode; /* 200 MHz */
 	card-detect-delay = <200>;
-- 
2.7.4
