Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D255C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49DE720874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:51:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49DE720874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbeGVRs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 13:48:57 -0400
Received: from mout.perfora.net ([74.208.4.194]:39299 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731106AbeGVRrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 13:47:43 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LwYMD-1g55eP2l5T-018Ke0; Sun, 22 Jul 2018 18:50:19 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 17/28] ARM: tegra: apalis_t30: drop pwmleds
Date:   Sun, 22 Jul 2018 18:49:25 +0200
Message-Id: <20180722164936.20581-18-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180722164936.20581-1-marcel@ziswiler.com>
References: <20180722164936.20581-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:vrxjzt+Jn8RoMI5QWEkvtgtKSg+a7eQxNxOX+BIFAKEbfooveSA
 /9ZleiZaduXHVI5QV63J7EGa1ORkCiklZsdqVLFP04kZbffTHEP09hjNN75ZBVu9y+PjFoT
 x1F7sm/j3NvGm4a7PpVcihp6qVwVEkB/s4p+hyxQ+xLTKMxzoMLRZF03K4CMdtqFZoNSfbf
 TRWlDJVdEXVipQBS0jsmQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XgEKY2hYX5o=:igsjPBhy2MZIsRXjcwn3I3
 vQ+DjYzvZx3w5Q9DnsFxUYDPFqclXo0Zmr9+fLbsRvHrszVwquA48WWD2wKE8GL/awp7rEGsW
 Rp3JgOIFob4MfzSvN8twwsJd22QtafpT2YkxZKakOaoSbBgmzC2MhLlfC4+QwDLIDH+ZmqjuG
 a3bedFVJ+QjaCvRCxLbkvc+xmqv23UKllyaS+gQfz5FXRvVRZJJFMPRcVQFnH8q/9JMcyaQC6
 etjHCTGn5TO6SXdq61U0xYvzM5VxWhdlZgxCW/PKipG/p1E79aZIGn0KdL3Z61WPeurozQ1Pr
 lE516Q2pQVEgPyY10t63gqkYEfk51sx9D75CekTee2DiWfQ4KFXTKY3LlTAZz2fLXTw6fKmax
 VWNe1i7lqgf/w5T8oRnFORQ4raWnUs+hk++9OuevWEZ5lIJ4s6DqngzyV3wrIw2BKPdw8z/NH
 8i3v8bgf0dSXEwGTDn8j02y+YHkGIP7gN/A9NTXB3Ch5BwsjoWObvYjCUcxPgGnSYPZ2raCTK
 scYRjHcJYHb+uziUJZ1vV2o/hy6jG2Qha/Q4i/61bcp9nj6N+T2ktDT7my3RtpkCQ1qF69YAP
 PDfal+BRbesX46Rnzv5dU7yHqjZRmh2j5ej6JBA7Rct3xPYbXOfkF/v5gy6fy3/rnJ7u4L8h1
 5Xz+ZFt5FChcT7sTj6M6j2nYQYc07pK9+XV144eSk2fsh5m5mTC3FDrqPFnpBc3Y+yIk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Drop pwmleds in favour of using regular PWMs.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-apalis-eval.dts | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis-eval.dts b/arch/arm/boot/dts/tegra30-apalis-eval.dts
index c4153e8e8b8c..6978e3626fae 100644
--- a/arch/arm/boot/dts/tegra30-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra30-apalis-eval.dts
@@ -223,28 +223,6 @@
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

