Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754043AbeDJN4i (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 09:56:38 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51085 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753370AbeDJN4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 09:56:36 -0400
X-Google-Smtp-Source: AIpwx4/wu/sGYKmkM/2iDkXIWTjLnePgYSJYnbD9CyBwGxCGac1kUG6JTZ+XWv3xmTVQ6Kx03/XfRg==
From: srinivas.kandagatla@linaro.org
To: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org
Cc: david.brown@linaro.org, robh+dt@kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] arm64: dts: apq8096-db820c: Add micro sd card supplies
Date: Tue, 10 Apr 2018 14:54:26 +0100
Message-Id: <20180410135426.15508-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds missing microSD card supplies, without this uSD
card will not be detected.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index 1c8f1b86472d..f8191f64eb84 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -87,6 +87,8 @@
 			pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_on>;
 			pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
 			cd-gpios = <&msmgpio 38 0x1>;
+			vmmc-supply = <&pm8994_l21>;
+			vqmmc-supply = <&pm8994_l13>;
 			status = "okay";
 		};
 
-- 
2.16.2
