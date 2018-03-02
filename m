Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425654AbeCBJYi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 04:24:38 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49278 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425250AbeCBJYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 04:24:22 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BEFBF602B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From: sibis <sibis@codeaurora.org>
To: bjorn.andersson@linaro.org
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sibis@codeaurora.org,
        georgi.djakov@linaro.org, jassisinghbrar@gmail.com,
        p.zabel@pengutronix.de, ohad@wizery.com, mark.rutland@arm.com,
        robh+dt@kernel.org, kyan@codeaurora.org, sricharan@codeaurora.org,
        akdwived@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 2/6] dt-bindings: mailbox: Add APCS global binding for SDM845 SoCs
Date: Fri,  2 Mar 2018 14:53:35 +0530
Message-Id: <1519982619-28336-3-git-send-email-sibis@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519982619-28336-1-git-send-email-sibis@codeaurora.org>
References: <1519982619-28336-1-git-send-email-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include SDM845 APCS binding to the list of possible bindings

Signed-off-by: sibis <sibis@codeaurora.org>
---
 Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
index 16964f0..a60d2b2 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
+++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
@@ -9,7 +9,8 @@ platforms.
 	Value type: <string>
 	Definition: must be one of:
 		    "qcom,msm8916-apcs-kpss-global",
-		    "qcom,msm8996-apcs-hmss-global"
+		    "qcom,msm8996-apcs-hmss-global",
+		    "qcom,sdm845-apcs-hmss-global"
 
 - reg:
 	Usage: required
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
