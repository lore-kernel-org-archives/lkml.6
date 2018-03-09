Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751830AbeCIFPa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 00:15:30 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33584 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751564AbeCIFPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 00:15:24 -0500
X-Google-Smtp-Source: AG47ELvd03UoYKdgqJjuuSTDNPzMigmgA3lfDbFdNlt7BGuIdoy6gu4551z6WbmvcMI1BZR3Iszk1A==
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: linus.walleij@linaro.org, robh+dt@kernel.org, afaerber@suse.de
Cc: liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        andy.shevchenko@gmail.com, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com, manivannanece23@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 5/9] arm64: dts: actions: Add S900 gpio nodes
Date: Fri,  9 Mar 2018 10:43:41 +0530
Message-Id: <20180309051345.1011-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180309051345.1011-1-manivannan.sadhasivam@linaro.org>
References: <20180309051345.1011-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add gpio nodes for Actions Semi S900 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/actions/s900.dtsi | 54 +++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s900.dtsi b/arch/arm64/boot/dts/actions/s900.dtsi
index 0156483f0f4d..69ead8a24b6b 100644
--- a/arch/arm64/boot/dts/actions/s900.dtsi
+++ b/arch/arm64/boot/dts/actions/s900.dtsi
@@ -180,6 +180,60 @@
 			clocks = <&cmu CLK_GPIO>;
 		};
 
+		gpioa: gpio@e01b0000 {
+			compatible = "actions,s900-gpio";
+			reg = <0x0 0xe01b0000 0x0 0x1000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl 0 0 32>;
+			ngpios = <32>;
+		};
+
+		gpiob: gpio@e01b000c {
+			compatible = "actions,s900-gpio";
+			reg = <0x0 0xe01b000c 0x0 0x1000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl 0 32 32>;
+			ngpios = <32>;
+		};
+
+		gpioc: gpio@e01b0018 {
+			compatible = "actions,s900-gpio";
+			reg = <0x0 0xe01b0018 0x0 0x1000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl 0 64 12>;
+			ngpios = <12>;
+		};
+
+		gpiod: gpio@e01b0024 {
+			compatible = "actions,s900-gpio";
+			reg = <0x0 0xe01b0024 0x0 0x1000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl 0 76 30>;
+			ngpios = <30>;
+		};
+
+		gpioe: gpio@e01b0030 {
+			compatible = "actions,s900-gpio";
+			reg = <0x0 0xe01b0030 0x0 0x1000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl 0 106 32>;
+			ngpios = <32>;
+		};
+
+		gpiof: gpio@e01b00f0 {
+			compatible = "actions,s900-gpio";
+			reg = <0x0 0xe01b00f0 0x0 0x1000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl 0 138 8>;
+			ngpios = <8>;
+		};
+
 		timer: timer@e0228000 {
 			compatible = "actions,s900-timer";
 			reg = <0x0 0xe0228000 0x0 0x8000>;
-- 
2.14.1
