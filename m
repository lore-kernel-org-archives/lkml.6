Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA387C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993B620657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392331AbfAPLCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:02:01 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:27285 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389534AbfAPLCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:02:01 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id C730E13F892;
        Wed, 16 Jan 2019 12:01:44 +0100 (CET)
Subject: [RFC PATCH v2 3/4] Add regulator-allow-set-load
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     MSM <linux-arm-msm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
References: <88e04336-723f-c157-0384-c5054a73e0a4@free.fr>
Message-ID: <2d43231d-e417-9df0-3e20-f63ad3306bc6@free.fr>
Date:   Wed, 16 Jan 2019 11:58:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <88e04336-723f-c157-0384-c5054a73e0a4@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BLURB
---
Set the prop for all vregs or just the UFS vregs?
---
 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi | 32 +++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
index cd1c9e84eab7..3d18a97d1563 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
@@ -100,132 +100,164 @@
 		vreg_s3a_1p35: s3 {
 			regulator-min-microvolt = <1352000>;
 			regulator-max-microvolt = <1352000>;
+			regulator-allow-set-load;
 		};
 		vreg_s4a_1p8: s4 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
+			regulator-allow-set-load;
 		};
 		vreg_s5a_2p04: s5 {
 			regulator-min-microvolt = <1904000>;
 			regulator-max-microvolt = <2040000>;
+			regulator-allow-set-load;
 		};
 		vreg_s7a_1p025: s7 {
 			regulator-min-microvolt = <900000>;
 			regulator-max-microvolt = <1028000>;
+			regulator-allow-set-load;
 		};
 		vreg_l1a_0p875: l1 {
 			regulator-min-microvolt = <880000>;
 			regulator-max-microvolt = <880000>;
+			regulator-allow-set-load;
 		};
 		vreg_l2a_1p2: l2 {
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1200000>;
+			regulator-allow-set-load;
 		};
 		vreg_l3a_1p0: l3 {
 			regulator-min-microvolt = <1000000>;
 			regulator-max-microvolt = <1000000>;
+			regulator-allow-set-load;
 		};
 		vreg_l5a_0p8: l5 {
 			regulator-min-microvolt = <800000>;
 			regulator-max-microvolt = <800000>;
+			regulator-allow-set-load;
 		};
 		vreg_l6a_1p8: l6 {
 			regulator-min-microvolt = <1808000>;
 			regulator-max-microvolt = <1808000>;
+			regulator-allow-set-load;
 		};
 		vreg_l7a_1p8: l7 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
+			regulator-allow-set-load;
 		};
 		vreg_l8a_1p2: l8 {
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1200000>;
+			regulator-allow-set-load;
 		};
 		vreg_l9a_1p8: l9 {
 			regulator-min-microvolt = <1808000>;
 			regulator-max-microvolt = <2960000>;
+			regulator-allow-set-load;
 		};
 		vreg_l10a_1p8: l10 {
 			regulator-min-microvolt = <1808000>;
 			regulator-max-microvolt = <2960000>;
+			regulator-allow-set-load;
 		};
 		vreg_l11a_1p0: l11 {
 			regulator-min-microvolt = <1000000>;
 			regulator-max-microvolt = <1000000>;
+			regulator-allow-set-load;
 		};
 		vreg_l12a_1p8: l12 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
+			regulator-allow-set-load;
 		};
 		vreg_l13a_2p95: l13 {
 			regulator-min-microvolt = <1808000>;
 			regulator-max-microvolt = <2960000>;
+			regulator-allow-set-load;
 		};
 		vreg_l14a_1p88: l14 {
 			regulator-min-microvolt = <1880000>;
 			regulator-max-microvolt = <1880000>;
+			regulator-allow-set-load;
 		};
 		vreg_15a_1p8: l15 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
+			regulator-allow-set-load;
 		};
 		vreg_l16a_2p7: l16 {
 			regulator-min-microvolt = <2704000>;
 			regulator-max-microvolt = <2704000>;
+			regulator-allow-set-load;
 		};
 		vreg_l17a_1p3: l17 {
 			regulator-min-microvolt = <1304000>;
 			regulator-max-microvolt = <1304000>;
+			regulator-allow-set-load;
 		};
 		vreg_l18a_2p7: l18 {
 			regulator-min-microvolt = <2704000>;
 			regulator-max-microvolt = <2704000>;
+			regulator-allow-set-load;
 		};
 		vreg_l19a_3p0: l19 {
 			regulator-min-microvolt = <3008000>;
 			regulator-max-microvolt = <3008000>;
+			regulator-allow-set-load;
 		};
 		vreg_l20a_2p95: l20 {
 			regulator-min-microvolt = <2960000>;
 			regulator-max-microvolt = <2960000>;
+			regulator-allow-set-load;
 		};
 		vreg_l21a_2p95: l21 {
 			regulator-min-microvolt = <2960000>;
 			regulator-max-microvolt = <2960000>;
+			regulator-allow-set-load;
 		};
 		vreg_l22a_2p85: l22 {
 			regulator-min-microvolt = <2864000>;
 			regulator-max-microvolt = <2864000>;
+			regulator-allow-set-load;
 		};
 		vreg_l23a_3p3: l23 {
 			regulator-min-microvolt = <3312000>;
 			regulator-max-microvolt = <3312000>;
+			regulator-allow-set-load;
 		};
 		vreg_l24a_3p075: l24 {
 			regulator-min-microvolt = <3088000>;
 			regulator-max-microvolt = <3088000>;
+			regulator-allow-set-load;
 		};
 		vreg_l25a_3p3: l25 {
 			regulator-min-microvolt = <3104000>;
 			regulator-max-microvolt = <3312000>;
+			regulator-allow-set-load;
 		};
 		vreg_l26a_1p2: l26 {
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1200000>;
+			regulator-allow-set-load;
 		};
 		vreg_l28_3p0: l28 {
 			regulator-min-microvolt = <3008000>;
 			regulator-max-microvolt = <3008000>;
+			regulator-allow-set-load;
 		};
 
 		vreg_lvs1a_1p8: lvs1 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
+			regulator-allow-set-load;
 		};
 
 		vreg_lvs2a_1p8: lvs2 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
+			regulator-allow-set-load;
 		};
 
 	};
-- 
2.17.1
