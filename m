Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F2DC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C2752082B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C2752082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbeH2MMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:12:50 -0400
Received: from mout.perfora.net ([74.208.4.196]:36391 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728247AbeH2MKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:10:18 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LpuUb-1fOs7y1CIJ-00fhuT; Wed, 29 Aug 2018 10:14:25 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 06/31] ARM: tegra: colibri_t20: reorder host1x/hdmi properties
Date:   Wed, 29 Aug 2018 10:13:42 +0200
Message-Id: <20180829081407.11304-7-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180829081407.11304-1-marcel@ziswiler.com>
References: <20180829081407.11304-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:xbtPryxlpYCqiUhETJzWOD23ydVlXo0KnI44EGXc7ZaWUILrone
 qj0u1+vpq+4SquUjjtrmV8wNHCTbp+CIS8x+H7DFy3pYE5xetv+A4m2md5WZchrPKvLFuaj
 BKo+XMFGdgRsVvy0t6Jv5O2xTwBjkTPrIxfmhcr4qZ5z4xzQ3rShRYynE3z8VqeFFdLnypa
 hcchEN7rWmxahLidDUrUQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/GMZUdP24YI=:T/NoUlrjykqlBk9S2o7buO
 l/UJ0GoEL1gazV3j4DTsaMyEoK8ElBQ11NWFT0RSGcDBf3lTr+oyWGOx09d1869nXiyyDltKc
 +cWDzL0Zk/Y2TzMEVKH2zKSYi7v1Z7ECB/pao2Qhf4s2UB5bgTjzXFaZb1Wt0LGqExT1h+H5M
 uz8VwCxL87Dmco4c+IDJEpBLgvFudLlZazO3q9F4McxZaT2Mp3A1peXN1iOs78kC5n+VDxIkq
 VVoPl+R863k+8KsElDbBrpVMN7ZkWuTWVZhzRgTnRY2DFrnfpn2vA0SbnxVUFidHlPa7vR6c5
 P0oZ/QVTFWKwsNC92oP/dZ6NQYudLL1iBVJIa501gcdzzGr1zBhF3ndsgAS1ovhFl7HG2uyxT
 H+NkWfINKmSQhHHc7W6MAADVIrtedkS6U7Gj8equdDn0oCDytRjC8f4YySbOODtcVwFrjgMv/
 S2HXIwa8T/TgR8qZ6JcQNkt4Hbp5Gets6HnwCtyD+naqe822L+MiibgvS7QKaEliBCfuWWg9n
 EyxSt3LhokQuxt1nRKUdHFQ3Ne8QDfg9b6Kxhs7j9yRxfwHH/XcNNKjBhCWrMNwhIsW7e4R+w
 JtwiIainrLxmnADy6ynVAuOyRe97/jtPq/lT8pQ6gaJyZV9Lg7n6fWBlZ5LXyus0Uwj505o9C
 kmGPmF8gBmoE+baZCLPVFnUenyK3gJBFWSCKCZH940YqJaQBPQTzWxme1/w0xiAQwVi4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Reorder Host1x/HDMI properties.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra20-colibri.dtsi | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-colibri.dtsi b/arch/arm/boot/dts/tegra20-colibri.dtsi
index ad816fa827f7..c060b58cb490 100644
--- a/arch/arm/boot/dts/tegra20-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
@@ -16,12 +16,11 @@
 
 	host1x@50000000 {
 		hdmi@54280000 {
-			vdd-supply = <&hdmi_vdd_reg>;
-			pll-supply = <&hdmi_pll_reg>;
-
 			nvidia,ddc-i2c-bus = <&i2c_ddc>;
-			nvidia,hpd-gpio = <&gpio TEGRA_GPIO(N, 7)
-				GPIO_ACTIVE_HIGH>;
+			nvidia,hpd-gpio =
+				<&gpio TEGRA_GPIO(N, 7) GPIO_ACTIVE_HIGH>;
+			pll-supply = <&hdmi_pll_reg>;
+			vdd-supply = <&hdmi_vdd_reg>;
 		};
 	};
 
-- 
2.14.4

