Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753214AbeCNFRj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 01:17:39 -0400
Received: from mx.socionext.com ([202.248.49.38]:50422 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750758AbeCNFRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 01:17:38 -0400
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org
Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [PATCH] ARM: dts: uniphier: add audio in/out pin-mux node
Date: Wed, 14 Mar 2018 14:17:32 +0900
Message-Id: <20180314051732.6177-1-suzuki.katsuhiro@socionext.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UniPhier AIO audio system needs I2S data in/out lines
and clock signal pins to connect external codec chip.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 arch/arm/boot/dts/uniphier-pinctrl.dtsi | 40 +++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-pinctrl.dtsi b/arch/arm/boot/dts/uniphier-pinctrl.dtsi
index de481c372467..c213f17a12ca 100644
--- a/arch/arm/boot/dts/uniphier-pinctrl.dtsi
+++ b/arch/arm/boot/dts/uniphier-pinctrl.dtsi
@@ -13,6 +13,46 @@
 		function = "aout";
 	};
 
+	pinctrl_ain1: ain1 {
+		groups = "ain1";
+		function = "ain1";
+	};
+
+	pinctrl_ain2: ain2 {
+		groups = "ain2";
+		function = "ain2";
+	};
+
+	pinctrl_ainiec1: ainiec1 {
+		groups = "ainiec1";
+		function = "ainiec1";
+	};
+
+	pinctrl_aout1: aout1 {
+		groups = "aout1";
+		function = "aout1";
+	};
+
+	pinctrl_aout2: aout2 {
+		groups = "aout2";
+		function = "aout2";
+	};
+
+	pinctrl_aout3: aout3 {
+		groups = "aout3";
+		function = "aout3";
+	};
+
+	pinctrl_aoutiec1: aoutiec1 {
+		groups = "aoutiec1";
+		function = "aoutiec1";
+	};
+
+	pinctrl_aoutiec2: aoutiec2 {
+		groups = "aoutiec2";
+		function = "aoutiec2";
+	};
+
 	pinctrl_emmc: emmc {
 		groups = "emmc", "emmc_dat8";
 		function = "emmc";
-- 
2.16.1
