Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932279AbeAaQVp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 11:21:45 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:33994 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753356AbeAaQVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 11:21:42 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 430D860112
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From: Rajendra Nayak <rnayak@codeaurora.org>
To: andy.gross@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        sboyd@codeaurora.org, evgreen@chromium.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v2 1/3] Documentation: dt-bindings: arm: Document kryo385 cpu
Date: Wed, 31 Jan 2018 21:49:39 +0530
Message-Id: <20180131161941.29865-2-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180131161941.29865-1-rnayak@codeaurora.org>
References: <20180131161941.29865-1-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatible string for the Kryo385 cpus found in qualcomm
SoCs.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
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
