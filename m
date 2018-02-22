Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752606AbeBVGN3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 01:13:29 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:59220 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752442AbeBVGMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 01:12:31 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 64D076084A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From: Rajendra Nayak <rnayak@codeaurora.org>
To: andy.gross@linaro.org
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sboyd@codeaurora.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        dianders@chromium.org, marc.zyngier@arm.com,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v5 2/4] dt-bindings: qcom: Add SDM845 bindings
Date: Thu, 22 Feb 2018 11:42:06 +0530
Message-Id: <20180222061208.2031-3-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180222061208.2031-1-rnayak@codeaurora.org>
References: <20180222061208.2031-1-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a SoC string 'sdm845' for the qualcomm SDM845 SoC

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/qcom.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.txt b/Documentation/devicetree/bindings/arm/qcom.txt
index 0ed4d39d7fe1..ee532e705d6c 100644
--- a/Documentation/devicetree/bindings/arm/qcom.txt
+++ b/Documentation/devicetree/bindings/arm/qcom.txt
@@ -26,6 +26,7 @@ The 'SoC' element must be one of the following strings:
 	msm8996
 	mdm9615
 	ipq8074
+	sdm845
 
 The 'board' element must be one of the following strings:
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
