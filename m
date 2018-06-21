Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14070C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAE98208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:32:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAE98208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soulik.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933307AbeFUNc0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 09:32:26 -0400
Received: from kozue.soulik.info ([108.61.200.231]:40744 "EHLO
        kozue.soulik.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933218AbeFUNcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 09:32:24 -0400
Received: from misaki.sumomo.pri (unknown [IPv6:2001:470:b30d:2:ec4:7aff:fe92:7ff4])
        by kozue.soulik.info (Postfix) with ESMTPA id 34D73100CDA;
        Thu, 21 Jun 2018 22:33:04 +0900 (JST)
From:   Randy Li <ayaka@soulik.info>
To:     linux-rockchip@lists.infradead.org
Cc:     Randy Li <ayaka@soulik.info>, shawn.lin@rock-chips.com,
        klaus.goger@theobroma-systems.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, heiko@sntech.de,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] ARM64: dts: rockchip: add some pins to rk3399
Date:   Thu, 21 Jun 2018 21:32:10 +0800
Message-Id: <20180621133210.9359-1-ayaka@soulik.info>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those pins would be used by many boards.

Signed-off-by: Randy Li <ayaka@soulik.info>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 87 +++++++++++++++++++++++++++-----
 1 file changed, 73 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index e0040b648f43..f32d1a049550 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1936,19 +1936,49 @@
 			drive-strength = <12>;
 		};
 
+		pcfg_pull_none_13ma: pcfg-pull-none-13ma {
+			bias-disable;
+			drive-strength = <13>;
+		};
+
+		pcfg_pull_none_18ma: pcfg-pull-none-18ma {
+			bias-disable;
+			drive-strength = <18>;
+		};
+
+		pcfg_pull_none_20ma: pcfg-pull-none-20ma {
+			bias-disable;
+			drive-strength = <20>;
+		};
+
+		pcfg_pull_up_2ma: pcfg-pull-up-2ma {
+			bias-pull-up;
+			drive-strength = <2>;
+		};
+
 		pcfg_pull_up_8ma: pcfg-pull-up-8ma {
 			bias-pull-up;
 			drive-strength = <8>;
 		};
 
+		pcfg_pull_up_18ma: pcfg-pull-up-18ma {
+			bias-pull-up;
+			drive-strength = <18>;
+		};
+
+		pcfg_pull_up_20ma: pcfg-pull-up-20ma {
+			bias-pull-up;
+			drive-strength = <20>;
+		};
+
 		pcfg_pull_down_4ma: pcfg-pull-down-4ma {
 			bias-pull-down;
 			drive-strength = <4>;
 		};
 
-		pcfg_pull_up_2ma: pcfg-pull-up-2ma {
-			bias-pull-up;
-			drive-strength = <2>;
+		pcfg_pull_down_8ma: pcfg-pull-down-8ma {
+			bias-pull-down;
+			drive-strength = <8>;
 		};
 
 		pcfg_pull_down_12ma: pcfg-pull-down-12ma {
@@ -1956,9 +1986,22 @@
 			drive-strength = <12>;
 		};
 
-		pcfg_pull_none_13ma: pcfg-pull-none-13ma {
-			bias-disable;
-			drive-strength = <13>;
+		pcfg_pull_down_18ma: pcfg-pull-down-18ma {
+			bias-pull-down;
+			drive-strength = <18>;
+		};
+
+		pcfg_pull_down_20ma: pcfg-pull-down-20ma {
+			bias-pull-down;
+			drive-strength = <20>;
+		};
+
+		pcfg_output_high: pcfg-output-high {
+			output-high;
+		};
+
+		pcfg_output_low: pcfg-output-low {
+			output-low;
 		};
 
 		clock {
@@ -2481,45 +2524,61 @@
 		pwm0 {
 			pwm0_pin: pwm0-pin {
 				rockchip,pins =
-					<4 18 RK_FUNC_1 &pcfg_pull_none>;
+					<4 RK_PC2 RK_FUNC_1 &pcfg_pull_none>;
+			};
+
+			pwm0_pin_pull_down: pwm0-pin-pull-down {
+				rockchip,pins =
+					<4 RK_PC2 RK_FUNC_1 &pcfg_pull_down>;
 			};
 
 			vop0_pwm_pin: vop0-pwm-pin {
 				rockchip,pins =
-					<4 18 RK_FUNC_2 &pcfg_pull_none>;
+					<4 RK_PC2 RK_FUNC_2 &pcfg_pull_none>;
+			};
+
+			vop1_pwm_pin: vop1-pwm-pin {
+				rockchip,pins =
+					<4 RK_PC2 RK_FUNC_3 &pcfg_pull_none>;
 			};
+
 		};
 
 		pwm1 {
 			pwm1_pin: pwm1-pin {
 				rockchip,pins =
-					<4 22 RK_FUNC_1 &pcfg_pull_none>;
+					<4 RK_PC6 RK_FUNC_1 &pcfg_pull_none>;
 			};
 
-			vop1_pwm_pin: vop1-pwm-pin {
+			pwm1_pin_pull_down: pwm1-pin-pull-down {
 				rockchip,pins =
-					<4 18 RK_FUNC_3 &pcfg_pull_none>;
+					<4 RK_PC6 RK_FUNC_1 &pcfg_pull_down>;
 			};
 		};
 
 		pwm2 {
 			pwm2_pin: pwm2-pin {
 				rockchip,pins =
-					<1 19 RK_FUNC_1 &pcfg_pull_none>;
+					<1 RK_PC3 RK_FUNC_1 &pcfg_pull_none>;
+			};
+
+			pwm2_pin_pull_down: pwm2-pin-pull-down {
+				rockchip,pins =
+					<1 RK_PC3 RK_FUNC_1 &pcfg_pull_down>;
 			};
 		};
 
 		pwm3a {
 			pwm3a_pin: pwm3a-pin {
 				rockchip,pins =
-					<0 6 RK_FUNC_1 &pcfg_pull_none>;
+					<0 RK_PA6 RK_FUNC_1 &pcfg_pull_none>;
 			};
 		};
 
 		pwm3b {
 			pwm3b_pin: pwm3b-pin {
 				rockchip,pins =
-					<1 14 RK_FUNC_1 &pcfg_pull_none>;
+					<1 RK_PB6 RK_FUNC_1 &pcfg_pull_none>;
 			};
 		};
 
-- 
2.14.4

