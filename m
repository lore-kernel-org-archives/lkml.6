Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECECC433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E3B20841
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:13:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6E3B20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbeIAMYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 08:24:35 -0400
Received: from mout.perfora.net ([74.208.4.196]:44339 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727490AbeIAMYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 08:24:35 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MOA30-1g1XKr0w4q-005Y6m; Sat, 01 Sep 2018 10:13:17 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 09/34] ARM: tegra: colibri_t30: drop pwmleds
Date:   Sat,  1 Sep 2018 10:12:23 +0200
Message-Id: <20180901081248.22639-10-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901081248.22639-1-marcel@ziswiler.com>
References: <20180901081248.22639-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:F4U/lawotrhX7Pr7MC3OdEP7+y0Rx3Eu4ZVVh5sS+2moRTpAwpu
 R3bcbd33PlNwQ9p6P6WqA5TphpI8sz5uNK/PdRTBpkzAzUhH/9E+mu4wK8GhQK/hJVIquke
 HoFcAB0Ny7iJ7keZ7CL4j3tuFOzGew3ygIwySyrffJNHDsvBvByLdAcPG1/OUj7NJ9AZ8Cc
 F983kWlFA4rASzGOfLU0A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0j6GMqDvkJc=:43kak1d+mpl7n2v8o0VqIT
 +CoY3gp1dX3a6dp3+RECFVkZaSenfK3kjOep4ERwH7UXZ90itSmCXueGIppOVEgZbl9VJHUEu
 5BeVO9YZqixXcDMdsyAkn3zvjogSc0CLX8GucXi9WU8KD57EQ/UbOYhq7qrBWg5AfEHBG2Xs8
 El3eK5B4nEBycji09pqPuYwOG/mmE618UTikih7Xcwf4s/ciYzkVKcGebZJ92GZerJ/CIEuGt
 A5Ib2DXgsTgQ8hPJnjhkTcnnfXvs+hZAVzhZsWtt5kRaVHIPcwWzQtzEAhWgYZ0l0Sa+GRxmq
 FfB2AtkKpcCSH56s8OcQ/qTbfNLpPcqLCWML8IEMxJA/7YgZNn/IuZmHHr6bWdoDV9wvFRGlJ
 ZOnMrqbGQSEX+hug/RJkSaJq071P9ezLfr+yqc5o4pYH4DZy+RC0zAbfdgvNY9PyE7KQYrv0f
 8ZV7WC2gXYSmtlrDHtZcYMjMxb/eyrgj6Nn0pVGOVj0CxEDiDIXrvWFpgMw/T/pxyuUwa0V8A
 0aTs0xoHSFT/Ere8alG/syftqumLPmKrTLpYb/OZbl6AklGDw4LECEzTJ+aBcEDJNfZ3Neyr6
 5d4qC/bxmnX6R9Bfl0HD+3a/Tb6prqn/9Mkx3adkTqwYoV4V3m+JCXheaaxI4CvRQQMgYXR0p
 my8Y6COsaRrIY6GjyBVGBeRPhVoqmU8s/kOlnJs+B2NS76wH2yI1Ws2u1PSoj4kdhzGo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Drop pwmleds in favour of using regular PWMs.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
index 8c492daac165..2aaf87ba0c42 100644
--- a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
@@ -165,26 +165,6 @@
 		power-supply = <&reg_3v3>;
 	};
 
-	pwmleds {
-		compatible = "pwm-leds";
-
-		pwmb {
-			label = "PWM<B>";
-			pwms = <&pwm 1 19600>;
-			max-brightness = <255>;
-		};
-		pwmc {
-			label = "PWM<C>";
-			pwms = <&pwm 2 19600>;
-			max-brightness = <255>;
-		};
-		pwmd {
-			label = "PWM<D>";
-			pwms = <&pwm 3 19600>;
-			max-brightness = <255>;
-		};
-	};
-
 	reg_3v3: regulator-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "3.3V_SW";
-- 
2.14.4

