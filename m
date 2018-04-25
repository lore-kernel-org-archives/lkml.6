Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754651AbeDYOi0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 10:38:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56634 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754562AbeDYOiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 10:38:16 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4EA2360807
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
Subject: [PATCH 1/3] dt-bindings: mailbox: Add APSS shared binding for SDM845 SoCs
Date: Wed, 25 Apr 2018 20:08:01 +0530
Message-Id: <20180425143803.11260-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include SDM845 APSS shared to the list of possible bindings

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
index 16964f0c1773..8ea0f12b8d0b 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
+++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
@@ -10,6 +10,7 @@ platforms.
 	Definition: must be one of:
 		    "qcom,msm8916-apcs-kpss-global",
 		    "qcom,msm8996-apcs-hmss-global"
+		    "qcom,sdm845-apss-shared"
 
 - reg:
 	Usage: required
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
