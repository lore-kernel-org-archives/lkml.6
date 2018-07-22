Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E571C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF3A20878
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FF3A20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730712AbeGVRrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 13:47:25 -0400
Received: from mout.perfora.net ([74.208.4.196]:51809 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730084AbeGVRrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 13:47:24 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0Lp5Pe-1gAowU1nmu-00essF; Sun, 22 Jul 2018 18:49:58 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 07/28] ARM: tegra: apalis_t30: reorder host1x/hdmi properties
Date:   Sun, 22 Jul 2018 18:49:15 +0200
Message-Id: <20180722164936.20581-8-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180722164936.20581-1-marcel@ziswiler.com>
References: <20180722164936.20581-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:TC7B8qEKxV4GKLBUnuFaG96JJKPVQaM930r2gwloMrnKwB3EMOz
 YPpnDXN+iI75sNnbz958Jw+78M1w2r5FN16s0TWcqgKwfb9f9CkBiEfJWuUCH4DDZspesd8
 OI2eF4RV4AUkCbZ0lGD0kldDeypUb/zHeQSe43aqK4d9CBjVclx6tz+Ladcl23obn1DNqRv
 pWbvTbvOSv9nwR8QDhYCg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3/2A/w5pHpM=:RPIakdc2iVIMLSBMCTuCrg
 Gfq7WGSLGjwwauOefo2PfMjwjYNxuZksI1Ys12FhvEFC86LORi7vYkublO6OIRy798uZVHf9P
 P/fRHs26qVZG1GURHuLG1PcuGQM8L0WiqTY0mNU0SIdjYYzDhOP9GR6Fa0DGSy5aNk8d7bk1y
 hs1Br9AV5SeQmAVdQ6SC1RcUf+llWwNS02/5rHNR7xzM2AkoRARf5vWrNywzy+5IBFeyRZk0U
 xXJBuHEthcgeymUo7J1OaBMpkXZUfKz+P/Et5mQ47WzrtGY4Ud7H3XUyqOIWWvXJS4rIkGiDs
 tYqmBozpCdczVRQRWG25MRFBEqMUTv20Zh1qjkoyIm96DJFdWzCFajsgbcCQgJtsh44QqzGam
 8i8P3G+eOMAStjxRRsR0jT8P20cnHKGINf+gKST4gICDteYxRa0pI1jKpYfMhn1a8YYkVZ7ka
 YPLxayQ5Dccf3sfIVX+XMKfR7JFzSJnH4vzS+QLI9UKGJdg1RMCgZ5YYqeAXzXQ05HmVLgliO
 y1Y0IGzP8UBwe4zpzc18vDoekaLfptKJ1IxyM7hfyrk4vSpsEFzQ2KodTtQdRY1Wy8M6xjP7J
 sHNkzM1vVp9/BCqzIyaxRJj/YHpNMIwdEgRswaoFVU+BTLV18ipcXW7VepHmm4TYMUvEH21AS
 2YgU3aTi8/FDVVFnKkko75WW3pieS+93T9e5ApLAlkELXzNMwqp3SzxAGgAmCNvBhhSg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Reorder Host1x/HDMI properties.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-apalis.dtsi | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index a1cc415b3893..d765cac7022a 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -46,12 +46,11 @@
 
 	host1x@50000000 {
 		hdmi@54280000 {
-			vdd-supply = <&avdd_hdmi_3v3_reg>;
-			pll-supply = <&avdd_hdmi_pll_1v8_reg>;
-
+			nvidia,ddc-i2c-bus = <&hdmiddc>;
 			nvidia,hpd-gpio =
 				<&gpio TEGRA_GPIO(N, 7) GPIO_ACTIVE_HIGH>;
-			nvidia,ddc-i2c-bus = <&hdmiddc>;
+			pll-supply = <&avdd_hdmi_pll_1v8_reg>;
+			vdd-supply = <&avdd_hdmi_3v3_reg>;
 		};
 	};
 
-- 
2.14.4

