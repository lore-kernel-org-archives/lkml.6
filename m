Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751590AbeBQUpz (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 15:45:55 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38773 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751532AbeBQUps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 15:45:48 -0500
X-Google-Smtp-Source: AH8x2261x8PlImm8uLa9n9ilwQVyB35HDde/xauaP6wJeB5TXNHKfSoY/yW8IcVte89Ho8ghM7upiA==
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: linus.walleij@linaro.org, robh+dt@kernel.org, afaerber@suse.de
Cc: liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 06/10] arm64: dts: actions: Add S900 gpio nodes
Date: Sun, 18 Feb 2018 02:14:29 +0530
Message-Id: <20180217204433.3095-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180217204433.3095-1-manivannan.sadhasivam@linaro.org>
References: <20180217204433.3095-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add gpio nodes for Actions Semi S900 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/actions/s900.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s900.dtsi b/arch/arm64/boot/dts/actions/s900.dtsi
index 0156483f0f4d..e359509ad9d3 100644
--- a/arch/arm64/boot/dts/actions/s900.dtsi
+++ b/arch/arm64/boot/dts/actions/s900.dtsi
@@ -180,6 +180,13 @@
 			clocks = <&cmu CLK_GPIO>;
 		};
 
+		gpio: gpio@e01b0000 {
+			compatible = "actions,s900-gpio";
+			reg = <0x0 0xe01b0000 0x0 0x1000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
 		timer: timer@e0228000 {
 			compatible = "actions,s900-timer";
 			reg = <0x0 0xe0228000 0x0 0x8000>;
-- 
2.14.1
