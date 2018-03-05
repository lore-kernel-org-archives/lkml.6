Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932672AbeCEJzT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 04:55:19 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:47980 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933890AbeCEJyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 04:54:18 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1D06A607E5
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
Subject: [PATCH 4/6] dt-bindings: remoteproc: Add Q6v5 Modem PIL binding for SDM845
Date: Mon,  5 Mar 2018 15:23:31 +0530
Message-Id: <1520243613-30393-5-git-send-email-sibis@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520243613-30393-1-git-send-email-sibis@codeaurora.org>
References: <1520243613-30393-1-git-send-email-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new compatible string for Qualcomm SDM845 SoCs

Signed-off-by: sibis <sibis@codeaurora.org>
---
 Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
index 00d3d58..11907db 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
@@ -9,8 +9,9 @@ on the Qualcomm Hexagon core.
 	Definition: must be one of:
 		    "qcom,q6v5-pil",
 		    "qcom,msm8916-mss-pil",
-		    "qcom,msm8974-mss-pil"
-		    "qcom,msm8996-mss-pil"
+		    "qcom,msm8974-mss-pil",
+		    "qcom,msm8996-mss-pil",
+		    "qcom,sdm845-mss-pil"
 
 - reg:
 	Usage: required
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
