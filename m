Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBADC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4364020658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4364020658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbeHaUrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:47:22 -0400
Received: from mout.perfora.net ([74.208.4.196]:32983 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728555AbeHaUrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:47:21 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LhuU8-1faRzG2yWI-00n6Dn; Fri, 31 Aug 2018 18:38:57 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 16/34] ARM: tegra: apalis_t30: drop pwmleds
Date:   Fri, 31 Aug 2018 18:37:58 +0200
Message-Id: <20180831163817.23970-17-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180831163817.23970-1-marcel@ziswiler.com>
References: <20180831163817.23970-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:B9XThUSb/49sOBdr/sjsTY+P8YHmQBJ6qFryBU8VyIamQ4/sfn3
 HpY+i67sQk6KHqjZynw4CRorUsJdtVmqe3oukX6B131GjjHtdP3TXyZQOSDkzHcCDCykCcv
 a5P13dWcg1jTdUS4dHW2YAaTrZs4Y8zOk+JXPKMc/F5b8SWyFQX4hFe/wjKonphUIavOPSP
 Uwg42QZWBo+ACyaSWBJWw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JRstixR1fKg=:ouhYgu78rd+rzi4PL5ALAu
 xOoRa4/5GeOdssNqQgJn6XiSGdkjl9ZmLhHI9566S3YVVtK5QwrmdYCpbq12CaaBIU/LNlXow
 e+FhduSBPFKECaZHj3g5TonzV9UbQvUIHy9o2Ygp8aVS3EV3arI0O4bmytXlNuG/9DipPaWtv
 vk6t3SidQRpCYUUhq3yQauNRVTwEeayIMVnoZkMLZQ3wBDO6ZwtyddGOR5PHmuWbGuQGKn2Uu
 uqx41dgl08J4vOj6YOkQfVCCRQR19DIg4/DcD/WtK+3IyU3YGCxT0yeBV5SxmxE298tjxDCwK
 dm67sWf9KLZQ9WpbOXWSK4TLIk+e+JvgbCvHmBQJ0VjudgmAbbr1D3qc3U4Ip3QDJ79AIeUex
 +4+pGgor+QSErXyMjNtVVKSTVr8e92bEEoN7KipqlWHpys+2MQx8u8iwNdEVDKqUKDr1V0aRw
 gOQt6hjoV5naMw1PZQUZ8/lMIyqFHfqPo/QQ5w1SvtX9GHGret7KgOj+MPBRATsrhFT6KhTbF
 DmFVPfwD6YK/f4W/grBxZRACEtpUNFKvOI35xRzu657vodFBO4QQ5jaWZe+4+I4jOl8HXvuvt
 NQuP30V5wu3o7FdHhqPqE89XxydqZpM0tnSpw1u5DYodafCCulZmF6fTT69Ub8vlBX041Q2Tr
 CgskdgIb1zKruUFO5IZqo7cp/6fqHei5smLjZT1RH/Rx9ZnGKlBtXv+tswaBtvoytbt8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Drop pwmleds in favour of using regular PWMs.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra30-apalis-eval.dts | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis-eval.dts b/arch/arm/boot/dts/tegra30-apalis-eval.dts
index 300ce726ff4d..5d1bc8560dbe 100644
--- a/arch/arm/boot/dts/tegra30-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra30-apalis-eval.dts
@@ -215,28 +215,6 @@
 		power-supply = <&reg_3v3>;
 	};
 
-	pwmleds {
-		compatible = "pwm-leds";
-
-		pwm1 {
-			label = "PWM1";
-			pwms = <&pwm 3 19600>;
-			max-brightness = <255>;
-		};
-
-		pwm2 {
-			label = "PWM2";
-			pwms = <&pwm 2 19600>;
-			max-brightness = <255>;
-		};
-
-		pwm3 {
-			label = "PWM3";
-			pwms = <&pwm 1 19600>;
-			max-brightness = <255>;
-		};
-	};
-
 	reg_3v3: regulator-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "3.3V_SW";
-- 
2.14.4

