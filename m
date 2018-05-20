Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751614AbeETFTD (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 01:19:03 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46697 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751521AbeETFS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 01:18:59 -0400
X-Google-Smtp-Source: AB8JxZqbmlT1iplDX2ij9spQ24QUIwexcV1aUZozvoUUMLkD6KoI7YFIrpfRXUzqRiaubsRQMTmWYg==
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: linus.walleij@linaro.org, robh+dt@kernel.org, afaerber@suse.de
Cc: liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        andy.shevchenko@gmail.com, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com, manivannanece23@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 2/5] arm64: dts: actions: Add gpio properties to pinctrl node for S900
Date: Sun, 20 May 2018 10:47:33 +0530
Message-Id: <20180520051736.4842-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180520051736.4842-1-manivannan.sadhasivam@linaro.org>
References: <20180520051736.4842-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add gpio properties to pinctrl node for Actions Semi S900 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/actions/s900.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s900.dtsi b/arch/arm64/boot/dts/actions/s900.dtsi
index 0156483f0f4d..aa3a49b0d646 100644
--- a/arch/arm64/boot/dts/actions/s900.dtsi
+++ b/arch/arm64/boot/dts/actions/s900.dtsi
@@ -178,6 +178,9 @@
 			compatible = "actions,s900-pinctrl";
 			reg = <0x0 0xe01b0000 0x0 0x1000>;
 			clocks = <&cmu CLK_GPIO>;
+			gpio-controller;
+			gpio-ranges = <&pinctrl 0 0 146>;
+			#gpio-cells = <2>;
 		};
 
 		timer: timer@e0228000 {
-- 
2.14.1
