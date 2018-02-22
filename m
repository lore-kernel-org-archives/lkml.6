Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752526AbeBVGMc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 01:12:32 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:59112 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752504AbeBVGM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 01:12:28 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EA1EA6079C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From: Rajendra Nayak <rnayak@codeaurora.org>
To: andy.gross@linaro.org
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sboyd@codeaurora.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        dianders@chromium.org, marc.zyngier@arm.com,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v5 1/4] dt-bindings: arm: Document kryo385 cpu
Date: Thu, 22 Feb 2018 11:42:05 +0530
Message-Id: <20180222061208.2031-2-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180222061208.2031-1-rnayak@codeaurora.org>
References: <20180222061208.2031-1-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatible string for the Kryo385 cpus found in qualcomm
SoCs.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 Documentation/devicetree/bindings/arm/cpus.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index a0009b72e9be..19611ccb61d9 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -184,6 +184,7 @@ described below.
 			    "nvidia,tegra186-denver"
 			    "qcom,krait"
 			    "qcom,kryo"
+			    "qcom,kryo385"
 			    "qcom,scorpion"
 	- enable-method
 		Value type: <stringlist>
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
