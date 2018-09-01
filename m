Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C946C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E661D20841
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:14:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E661D20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbeIAMZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 08:25:21 -0400
Received: from mout.perfora.net ([74.208.4.196]:50427 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbeIAMZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 08:25:20 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LgoYS-1fal7y2tKI-00oCKk; Sat, 01 Sep 2018 10:14:05 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 33/34] ARM: tegra: colibri_t30: annotate unused i2c busses
Date:   Sat,  1 Sep 2018 10:12:47 +0200
Message-Id: <20180901081248.22639-34-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901081248.22639-1-marcel@ziswiler.com>
References: <20180901081248.22639-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:be+m5MfP0iPG+lpYkERGFZZwZR3V7WFtHiER1BG6YF7UmupClbS
 gj49OLSMjCyF8ZwgFI9K42R3+6qyyRBng4VEOIOrJcv51cz5mVoXntWNBJMAlAltsf5bOKS
 20I6QV/GFO7UhT5QiHYs6qEFIK7692NV4f80swE+C+8HRa85I6pJLTpTLMx69j6mCzcW/tB
 mwl2nTREesvTRV/dSIVyA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:K6cs1GMoO04=:rqicw14LKRHUs1pQitWEZb
 4Wb/8sxVs+ZD/mMHS4XSmQQGbbXjvA0MVlT1NSQfAdnCnYCxIRWFzOw5iPS6bFrxXsla4fWfX
 1gJ9w/OHZyyaZ7uyKqjExxIaBKyCCGTS3VmTDoioYPbz6i+xPsSkWzhv3jdaInrXIKOl6XUtH
 iA9KBeVwF9RrwRVaY6kP1gTWab8WxFNWgMndLjhvit/iu8TgVyvR9XizaPtsy0SW2WVd4kdBO
 5jTj5JzqvH4FUtS29fiSTzrE0Bv44YJSmtmlTiEcYrR1zh8V30iz1rwIoFgYnkdkcrXjJTmw7
 OZgHflJY1Wk6fvLkOZTLJJf2FyeLwbMs39wfgh1tcjsBZUoBPmpa6WLg8+L+pCRe8s1zLkZzn
 Z4FqNLaGwhOM3nptZV03KC1Qn73Vzy9XR8ACnzUEjSmSLmQjtHxPLIXULIFKNN+l866NkVSiD
 4fUTB8c/zSPG8b7dFV4FEMxcRT6UwrZyj4GIx3RQD7i58kAob9jDfrbzcuA5rFxlTwwYemVae
 maiKFOubvDuJqL1Z7HbTENPFITlEfHtHZTIMIHij3Qk5kOxd6Kf3mG55gczSH/KFUpk8u2lve
 dmJozlMHssvab6fMCKW6LEV5IYVFjAgAW7NSm/H84NWCvWIUhQYShkVsZvCrz7xbBBAhiyWor
 hf0PWnk6jYsIEfdArPMz6RyO4q6E53wFBUZNV/VC0XvnMgIvIBXFViQN7Igcjul+nVh4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Both GEN2_I2C as well as CAM_I2C (I2C3) are unused in our design.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
index 9985d0a91f69..5965150ecdd2 100644
--- a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
@@ -70,6 +70,10 @@
 		};
 	};
 
+	/* GEN2_I2C: unused */
+
+	/* CAM_I2C (I2C3): unused */
+
 	/* DDC_CLOCK/DATA on X3 pin 15/16 (e.g. display EDID) */
 	i2c@7000c700 {
 		status = "okay";
-- 
2.14.4

