Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752486AbeCLIIK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 04:08:10 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60910 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752474AbeCLIID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 04:08:03 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C4A6C60300
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From: Rajendra Nayak <rnayak@codeaurora.org>
To: andy.gross@linaro.org
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        evgreen@chromium.org, bjorn.andersson@linaro.org,
        dianders@chromium.org, marc.zyngier@arm.com, swboyd@chromium.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v6 2/3] dt-bindings: qcom: Add SDM845 bindings
Date: Mon, 12 Mar 2018 13:36:55 +0530
Message-Id: <20180312080656.13247-3-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180312080656.13247-1-rnayak@codeaurora.org>
References: <20180312080656.13247-1-rnayak@codeaurora.org>
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
