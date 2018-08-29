Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83B5C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F8C2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89F8C2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbeH2MKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:10:49 -0400
Received: from mout.perfora.net ([74.208.4.194]:36997 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727712AbeH2MKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:10:48 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MCaCy-1g3D6M2OWI-009NIq; Wed, 29 Aug 2018 10:15:01 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 22/31] ARM: tegra: colibri_t20: annotate/rename lm95245 temperature sensor
Date:   Wed, 29 Aug 2018 10:13:58 +0200
Message-Id: <20180829081407.11304-23-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180829081407.11304-1-marcel@ziswiler.com>
References: <20180829081407.11304-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:W+yYnhkSxkAKk6gw97Gv5hETuJJqddsV2pKWv8F6kuxVKrhqBHs
 6mDs3fl9tuphtVk76/XJ8t3HlX5t0NNxOYOnkKGBCcHSF1rikYcUmrqjf+f6+tjqtHCInRn
 nOh7POF66RgKOJkhlcVuvbVZYNUHa1HENZSFJdynEmPMObWVq4uanrgU8LuQ9+df9AqwlJ0
 U8rmc/qV6+5K31nLGRiQQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:enU7dddxvCM=:rInbACe8DGxOO+yeGyExpl
 id3YQK3igtLPB5evNtjEPBn32d80W2bNBRqwgF7FzRhj8jDfJ/wZXlojM+8TpTfM3weNaG3st
 hTF5tiOnCqdMgHyFHyyLFzAJ/ysI/lxGhEoODOmP0O9WZ8F5pWE25bI7uS1r19xtdwK6N86af
 1BZ/KGBygGK8VvkBfE3SX/OBEY1WDhHIfTnkH2x5Uoapc261dwtjILRvUsvDOnP35U2od+gYW
 r5pwYbUvwQnS9NPuR93U+X/8tGTsIPLipse28HxYwFKteL36ZclmN2Ffts9R15koJPYsjIbSV
 R334LTgSdxCLloSGxCjTk5wCY6tAeLDR37fVX9MnkBgNaFHNO9xPgi3/BI5BkAq5nAmiOgf9S
 9ibikdYdAQZZF0kAq3OkoD3istsb3a/Mh5ZljBUrpTJdSbM/h0f4+RDRgN9oC5P1wSzT3NymS
 chlH/CSkitfOr0TisPMI4Z5FABpBLktxnwYWt1AkC7eIXyP8V5mXRIGjkl+U54duQRRc3bMtG
 emXrfTbxkcFhX8XwGNori6BNlHy3zlc0nKLWnDeWhkObG3DF6p3raNSDpldt6JOPAFPo6MRMR
 gei0AbgUdSE/3S7Q3HwXWJAvrZccXK/h+Z8LCQd+RheM+7EWccJ9VHBhaA0Gv/kPxo3LikfFp
 h3/stlT5bWKENldcRYkYRMNhg9dt3AHOzlpYZ/+C2qdJASqNEXWlAwSh0finyfHgUeZs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Rename and annotate LM95245 temperature sensor more in-line with our
other device trees.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra20-colibri.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra20-colibri.dtsi b/arch/arm/boot/dts/tegra20-colibri.dtsi
index 3d61175e2a9c..d03b2a290303 100644
--- a/arch/arm/boot/dts/tegra20-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
@@ -584,7 +584,8 @@
 			};
 		};
 
-		temperature-sensor@4c {
+		/* LM95245 temperature sensor */
+		temp-sensor@4c {
 			compatible = "national,lm95245";
 			reg = <0x4c>;
 		};
-- 
2.14.4

