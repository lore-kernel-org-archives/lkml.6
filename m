Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753190AbeC1Rxx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 13:53:53 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35874 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753094AbeC1Rxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 13:53:50 -0400
X-Google-Smtp-Source: AIpwx49S5DJcNGVh8VfBm7JmoCOP8xdULfzFb0D1TnUK5zqJiXiUjp/hj7tNzd/SmUghwMAOl8fF5w==
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: linus.walleij@linaro.org, robh+dt@kernel.org, afaerber@suse.de
Cc: liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        andy.shevchenko@gmail.com, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com, manivannanece23@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 1/9] arm64: dts: actions: Add pinctrl node for S900
Date: Wed, 28 Mar 2018 23:16:55 +0530
Message-Id: <20180328174703.19778-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180328174703.19778-1-manivannan.sadhasivam@linaro.org>
References: <20180328174703.19778-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl nodes for Actions Semi S900 SoC

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm64/boot/dts/actions/s900.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s900.dtsi b/arch/arm64/boot/dts/actions/s900.dtsi
index fee0c9557656..0156483f0f4d 100644
--- a/arch/arm64/boot/dts/actions/s900.dtsi
+++ b/arch/arm64/boot/dts/actions/s900.dtsi
@@ -174,6 +174,12 @@
 			#clock-cells = <1>;
 		};
 
+		pinctrl: pinctrl@e01b0000 {
+			compatible = "actions,s900-pinctrl";
+			reg = <0x0 0xe01b0000 0x0 0x1000>;
+			clocks = <&cmu CLK_GPIO>;
+		};
+
 		timer: timer@e0228000 {
 			compatible = "actions,s900-timer";
 			reg = <0x0 0xe0228000 0x0 0x8000>;
-- 
2.14.1
