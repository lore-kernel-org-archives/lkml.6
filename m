Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754691AbeDYOir (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 10:38:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56898 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754562AbeDYOi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 10:38:27 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 67E4D60AE0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From: Sibi Sankar <sibis@codeaurora.org>
To: andy.gross@linaro.org, mark.rutland@arm.com,
        bjorn.andersson@linaro.org
Cc: david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org, devicetree@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        jassisinghbrar@gmail.com, will.deacon@arm.com, catalin.marinas@arm.com,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH 3/3] arm64: dts: qcom: Add APSS shared mailbox node to SDM845
Date: Wed, 25 Apr 2018 20:08:03 +0530
Message-Id: <20180425143803.11260-3-sibis@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425143803.11260-1-sibis@codeaurora.org>
References: <20180425143803.11260-1-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add the node to support APSS shared
mailbox on SDM845

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---

This patch depends on https://patchwork.kernel.org/patch/10276419/

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 486ace9a9e8b..9be763da0664 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -338,5 +338,11 @@
 				status = "disabled";
 			};
 		};
+
+		apss_shared: mailbox@17990000 {
+			compatible = "qcom,sdm845-apss-shared";
+			reg = <0x17990000 0x1000>;
+			#mbox-cells = <1>;
+		};
 	};
 };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
