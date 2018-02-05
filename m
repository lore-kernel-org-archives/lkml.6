Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753163AbeBEOrA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 09:47:00 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35299 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753091AbeBEOqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 09:46:54 -0500
X-Google-Smtp-Source: AH8x224v4oXYERp/5HwHtCp99QG+Is9DRcqN2sR3ZLPt7HS2UP5UY9CaHMQVMWsC6mq2eEAuqepG7A==
From: Georgi Djakov <georgi.djakov@linaro.org>
To: andy.gross@linaro.org
Cc: bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH 1/4] arm64: dts: qcom: msm8916: Add msm8916 A53 PLL DT node
Date: Mon,  5 Feb 2018 16:46:48 +0200
Message-Id: <20180205144651.5934-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a device tree node for the A53 PLL, which exists on msm8916
platforms.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index e51b04900726..d3592b19cfc9 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -326,6 +326,12 @@
 			status = "disabled";
 		};
 
+		a53pll: clock@b016000 {
+			compatible = "qcom,msm8916-a53pll";
+			reg = <0xb016000 0x40>;
+			#clock-cells = <0>;
+		};
+
 		apcs: syscon@b011000 {
 			compatible = "syscon";
 			reg = <0x0b011000 0x1000>;
