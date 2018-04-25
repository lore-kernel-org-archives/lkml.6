Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755064AbeDYPKs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 11:10:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40344 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754395AbeDYPJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 11:09:35 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 93FCB60C5F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From: Sibi Sankar <sibis@codeaurora.org>
To: bjorn.andersson@linaro.org, p.zabel@pengutronix.de, robh+dt@kernel.org
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sibis@codeaurora.org,
        georgi.djakov@linaro.org, jassisinghbrar@gmail.com, ohad@wizery.com,
        mark.rutland@arm.com, kyan@codeaurora.org, sricharan@codeaurora.org,
        akdwived@codeaurora.org, linux-arm-msm@vger.kernel.org,
        tsoni@codeaurora.org
Subject: [PATCH v4 3/5] dt-bindings: remoteproc: Add Q6v5 Modem PIL binding for SDM845
Date: Wed, 25 Apr 2018 20:38:41 +0530
Message-Id: <20180425150843.26657-4-sibis@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425150843.26657-1-sibis@codeaurora.org>
References: <20180425150843.26657-1-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new compatible string for Qualcomm SDM845 SoCs

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
index 00d3d58a102f..d90182425450 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
@@ -11,6 +11,7 @@ on the Qualcomm Hexagon core.
 		    "qcom,msm8916-mss-pil",
 		    "qcom,msm8974-mss-pil"
 		    "qcom,msm8996-mss-pil"
+		    "qcom,sdm845-mss-pil"
 
 - reg:
 	Usage: required
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
