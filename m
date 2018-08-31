Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA916C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E96820658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E96820658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbeHaUrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:47:49 -0400
Received: from mout.perfora.net ([74.208.4.196]:49957 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727258AbeHaUrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:47:48 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M1owm-1fcafp3T5u-00toIp; Fri, 31 Aug 2018 18:39:24 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 30/34] ARM: tegra: apalis_t30: rename hdmiddc to hdmi_ddc
Date:   Fri, 31 Aug 2018 18:38:12 +0200
Message-Id: <20180831163817.23970-31-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180831163817.23970-1-marcel@ziswiler.com>
References: <20180831163817.23970-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:0xwEOBHfnd/rVUIgxUVcRRWeJpvFaPN9+kZ+DTRAfqdY/J0E2ly
 uL6PC94QAWQg/IbGi1TZ9qxlkaTCrBDXGG2BLFGS73r0Q6LbmR8Onu+BJHR6VvY9zla8Bv0
 Wkm9NcAXh+MPGsxoDhNAaRA8uLLjw770UlDn/Py6XS/Uini+P2nuTv4l9mLOnsb/Yyb7kFR
 lT4Bqwk5O9JJNGi/tePeg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NtlFqrLdAYU=:us1CjHQIxeI8fTog6tJekm
 2idNOuc0SsKcUhd91hQC+bSo+qX7MG4eSBJ4jyCx+aKqrdWGZXJ2DJDvGGQZ4obDA6malmt5T
 CgUVReLQ3bgUsQxLdbytmZCOieyBdvLV4HN2cY1OtSoE8NZ5u/9F/G3tQVoUQtVuX0DZb1YDH
 vHED8p/szw/piNQ9LbHrXoYSqbhD2ZFdm9e+HJ1HmYrUzJimO8IU68GUTXu6kevEhB78HHlNh
 dKHGJd5QTciLGpYrBLJyu0vYhE8ELyzW2QPPVRzeIEaNkK4qp/tXfil9+gSMxZ1y/JTlB1stw
 hHwa5ejmNNDryxvZbdvRtZwM/tnvraiZ0CJkbql3Mwxph1d4tBsDADvRvk4MtGsLb72/ImyAD
 UnG6L2nA2uNNwCQ8LDWopXG4Ujn0MRyj2JY+85j6/afEkcucPpW2hDcrfVyEPAEzDtLEgUsnJ
 4S8kS0EiSQe6xGepu6L42TjlQ+AWLPUtCnb6ihlL0ajQSsB6atbQzAD73ygqT+5i9xhlmiVI7
 59F8zeDDIMcstlJioHam8xbFnre0hrgQRaRtfjjHGmA7TwXOZB6RKFWM52tHwfZHyIYX1Wpsx
 Yb3Oo2+rptM2pKUTs9aUh/Oo2T+OOHQ49WZbq/SCHf4NlLmPXHQapqJ1XzIv5BSFt3BTbPTo3
 erXUm/xo4mX309KOQKFfOExS+rZ2nHAlbKDY++MGtfZdI+HN+e0bbV7yvw7MFnGC29MQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Rename hdmiddc to hdmi_ddc to be more in-line with other device trees.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- New patch.

 arch/arm/boot/dts/tegra30-apalis-eval.dts | 2 +-
 arch/arm/boot/dts/tegra30-apalis.dtsi     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis-eval.dts b/arch/arm/boot/dts/tegra30-apalis-eval.dts
index 9d9dda6c0246..9381f65a9bf5 100644
--- a/arch/arm/boot/dts/tegra30-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra30-apalis-eval.dts
@@ -103,7 +103,7 @@
 	};
 
 	/* DDC: I2C2_SDA/SCL on MXM3 pin 205/207 (e.g. display EDID) */
-	hdmiddc: i2c@7000c700 {
+	i2c@7000c700 {
 		status = "okay";
 	};
 
diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index e7793f3b19d2..f15954995231 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -46,7 +46,7 @@
 
 	host1x@50000000 {
 		hdmi@54280000 {
-			nvidia,ddc-i2c-bus = <&hdmiddc>;
+			nvidia,ddc-i2c-bus = <&hdmi_ddc>;
 			nvidia,hpd-gpio =
 				<&gpio TEGRA_GPIO(N, 7) GPIO_ACTIVE_HIGH>;
 			pll-supply = <&reg_1v8_avdd_hdmi_pll>;
@@ -831,7 +831,7 @@
 		compatible = "nvidia,tegra30-hsuart";
 	};
 
-	hdmiddc: i2c@7000c700 {
+	hdmi_ddc: i2c@7000c700 {
 		clock-frequency = <10000>;
 	};
 
-- 
2.14.4

