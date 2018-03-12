Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932641AbeCLHFr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 03:05:47 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:35890 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751899AbeCLHDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 03:03:50 -0400
X-UUID: fff9d022f5ee4508b0413662d0ec5297-20180312
From: Weiyi Lu <weiyi.lu@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>
CC: James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v2 4/5] arm64: dts: add clock device nodes of MT2712
Date: Mon, 12 Mar 2018 15:03:41 +0800
Message-ID: <20180312070342.4335-6-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 2.12.5
In-Reply-To: <20180312070342.4335-1-weiyi.lu@mediatek.com>
References: <20180312070342.4335-1-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add new clocks according to ECO design change

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
index fdf66f4fe7c3..d7688bc9db1b 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
@@ -199,6 +199,34 @@
 		clock-output-names = "clkaud_ext_i_2";
 	};
 
+	clki2si0_mck_i: oscillator@6 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <30000000>;
+		clock-output-names = "clki2si0_mck_i";
+	};
+
+	clki2si1_mck_i: oscillator@7 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <30000000>;
+		clock-output-names = "clki2si1_mck_i";
+	};
+
+	clki2si2_mck_i: oscillator@8 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <30000000>;
+		clock-output-names = "clki2si2_mck_i";
+	};
+
+	clktdmin_mclk_i: oscillator@9 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <30000000>;
+		clock-output-names = "clktdmin_mclk_i";
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupt-parent = <&gic>;
-- 
2.12.5
