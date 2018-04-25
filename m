Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754674AbeDYOic (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 10:38:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56758 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754626AbeDYOiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 10:38:21 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1279E60C64
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
Subject: [PATCH 2/3] mailbox: Add support for Qualcomm SDM845 SoCs
Date: Wed, 25 Apr 2018 20:08:02 +0530
Message-Id: <20180425143803.11260-2-sibis@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425143803.11260-1-sibis@codeaurora.org>
References: <20180425143803.11260-1-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the corresponding APSS shared offset for SDM845 SoC

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/mailbox/qcom-apcs-ipc-mailbox.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
index 57bde0dfd12f..75da44d25fac 100644
--- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
+++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
@@ -125,6 +125,7 @@ static int qcom_apcs_ipc_remove(struct platform_device *pdev)
 static const struct of_device_id qcom_apcs_ipc_of_match[] = {
 	{ .compatible = "qcom,msm8916-apcs-kpss-global", .data = (void *)8 },
 	{ .compatible = "qcom,msm8996-apcs-hmss-global", .data = (void *)16 },
+	{ .compatible = "qcom,sdm845-apss-shared", .data = (void *)12 },
 	{}
 };
 MODULE_DEVICE_TABLE(of, qcom_apcs_ipc_of_match);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
