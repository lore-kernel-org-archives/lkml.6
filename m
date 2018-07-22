Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AECECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B467720874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:50:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B467720874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731279AbeGVRrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 13:47:52 -0400
Received: from mout.perfora.net ([74.208.4.197]:51739 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729936AbeGVRrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 13:47:51 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0Leswr-1gMcX72uKN-00qfEe; Sun, 22 Jul 2018 18:50:27 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 21/28] ARM: tegra: apalis_t30: further lm95245 temperature sensor annotation
Date:   Sun, 22 Jul 2018 18:49:29 +0200
Message-Id: <20180722164936.20581-22-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180722164936.20581-1-marcel@ziswiler.com>
References: <20180722164936.20581-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:bZusEGblLEv2NmHbApY0slPCE8bdeQgYspCVCtZpZNFDBGdx5ho
 la8ly3K1ItlspW7zC0+8VhrS4obzAl2qWsSXdzM1v0BOGATRkL5/8ChgFVq6YgueAqaNsS7
 5KL+MOqJyzFoD3jCq5EfM+rtXTzVxx/H/irQSzAbZLAuy/132hvPtI2SnB5VbiZgXiPBpBy
 tqJe+fstdUQlO0ek5XvXQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3wRZizzs9t4=:1C+wdAw3XnaorVrYK3hqxW
 2AdgfEsWp+xr39yPuuI87BfIBaNk48zptNtjt2ikSDBbjaXfQ5meJ8qDVMFmInlQQ1oXJqIEJ
 m52h7IoCAOK9YaLexgIKDuQTWENSYJtS5oKaPHgPC4r/4t1yOz/mM3R4G5yqyrs298FjDJbcl
 vmwkiKv01ieBqHk26J7hlIlnNGmsWzFlQ0YHClcdQXZ+ZsjiqQKdStWQOQ65gkPOn4in062LY
 wfW3sefEuEA+L2x9wKfZfOJW0XWiSFJr07DrYnQlDg+0t9kuT5TK/eDk1cFz709O4TvvrdHLM
 xAqfweOXAaGJWmNePtmD7d7Gp78Jne0ucr6KWAZQFPiPWW55h8kWJnF5tMuZWsBk6ZU6YJ/MQ
 guulm/YtUe29FNC4XBour85bHl0srsj//pqomSk59Cv9qhbDVOgvEgtYup5tsv3HVr5eKLCoh
 tYS/ggkM76ZPUHowFH+Whfjrfdv9fB8Iw1gWg9XaAj8tq+2fevqPaFhTvdhvLIfgRdIKjtrVK
 y5XpXNMeUnidWUM5Cju7yj7wPIYXg/a77ckxtn8r9uWRXSpvw9TpMb1JUWKFtwVXK3A7IYc7s
 UG1R6PsJGkifZcj5Fwt1OeZwTPERnYxa5J0tYgC2PbAk1/A9Ps6bFMoMPlsdq30JuITDk61UH
 Nvk7ZhoRQtHLRCCORgd5jlsxHnFQsqIpX15sRocixlZybdfLBgpyueB2nv/NVUdosjRE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Further LM95245 temperature sensor annotation.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-apalis.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index ab4fe7491bbf..4e8ea1a8d9ec 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -993,7 +993,7 @@
 
 		/*
 		 * LM95245 temperature sensor
-		 * Note: OVERT_N directly connected to PMIC PWRDN
+		 * Note: OVERT1# directly connected to TPS65911 PMIC PWRDN
 		 */
 		temp-sensor@4c {
 			compatible = "national,lm95245";
-- 
2.14.4

