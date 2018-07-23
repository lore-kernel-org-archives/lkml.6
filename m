Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E3CECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E88CC20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E88CC20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389147AbeGWNif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:38:35 -0400
Received: from mout.perfora.net ([74.208.4.196]:41545 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388362AbeGWNie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:38:34 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0Mhk4D-1fLoFb1uAF-00Mtnq; Mon, 23 Jul 2018 14:37:25 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 10/26] ARM: tegra: colibri_t30: drop pwmleds
Date:   Mon, 23 Jul 2018 14:36:41 +0200
Message-Id: <20180723123658.980-11-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180723123658.980-1-marcel@ziswiler.com>
References: <20180723123658.980-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:Cw6hxxCjQatLlSkO3t10HXE+OYVsNAyqP/AIDQ35162coqZU8LC
 tFEC3U+WP4MolACtQoio4l8vv7I8vU8p5gYtG3vElqOb41mdCR5Kvrk1M44KlLCDOYQWCmY
 s0bGgba26Us7+ZTLkhoIaymztFOhNTe1dtG/4ffq1kW2pgeTOBCFhKNqy6g2FFIcIRn/Rkc
 vdp9LpdVQvbMKrdCMXPaw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AQg3idTThzw=:NBU9BI/2yXRUgx48eXN0Ux
 Hq+H01WwQ9u4sYFCJYJFituhVT1Es+U+qTJC1Vji9AQ5t3960ivIPNn8rTOOi3vYznXfmMGI2
 w66DQnULSiWaEoKsztnXQFV6Au/6JEhtId3UcPXDQRZqQFmvMlsYbYcX5b2lHaiJD2Ze8zA2z
 Dj79KkCX23qefS1MSLAwzz8zE5C0K8k5ValpGPTrbo1jgwlfebvNmnbjZjk6AGrGBC5tbFVyT
 3MlQG2rJmtLIRkl+KYPr2fX502vvcpVenYoFy73PvrXQXIxzJ8l1VhkTossHvS9lv3zM36/ap
 K0EORwpY+vxrsvCqWRx/KQJVpdPJe1v/jI2T5ncPS4bj47j2Nmjhw69ybwNWgw/+67c1MrhQ7
 EC5yaX/iwUWxUMeFNid+wYtO2Q72kob/Ky7Oy4kHZQyg3myeG9oJLJL1RGLvsdiTwIJhJLjvr
 GyY8jXtfDPWnqVTWmz5CwuQ3+HiReI/6ufOuCyvetAGtFynO0PH4osWeHo0A+AmssqUlfqLQC
 8CyLp434uslf7e8w6KjScll59k4iSCzZVv6JbGhkOEgZfXTt3QPXeY0R2FvDYKGeyhD8ibtgo
 3UWjreakxh69cbD72V0zBNmkRhelGoBsBUuF6P2mce+whkPSVXR2+TvVil+2RupfzZQHEUwmj
 8vwNF6ANL4d/cqPYy0MZIwESEzHxp2C7DcqXizXjXTuNmP/vKZ82Aoc/1V9s1rogSkNU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Drop pwmleds in favour of using regular PWMs.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
index a3c607d07a1b..621cd15cdfd1 100644
--- a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
@@ -167,26 +167,6 @@
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

