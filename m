Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752731AbeC0PzH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 11:55:07 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35902 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752718AbeC0PzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 11:55:05 -0400
X-Google-Smtp-Source: AG47ELtqvjN45VhbLosW3HX2fmxyMVhQ2PIJMZngcVBPgXCmjf6e4LS3o3KuNEYXFlj947w9yG3Cew==
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: qcom: smd-rpm: Add msm8998 compatible
Date: Tue, 27 Mar 2018 08:55:15 -0700
Message-Id: <20180327155515.32077-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatible for the RPM in MSM8998, so that rpm resources can be
made available.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt | 1 +
 drivers/soc/qcom/smd-rpm.c                                  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt
index a48049ccf6d0..89e1cb9212f6 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt
@@ -22,6 +22,7 @@ resources.
 		    "qcom,rpm-apq8084"
 		    "qcom,rpm-msm8916"
 		    "qcom,rpm-msm8974"
+		    "qcom,rpm-msm8998"
 
 - qcom,smd-channels:
 	Usage: required
diff --git a/drivers/soc/qcom/smd-rpm.c b/drivers/soc/qcom/smd-rpm.c
index c2346752b3ea..93517ed83355 100644
--- a/drivers/soc/qcom/smd-rpm.c
+++ b/drivers/soc/qcom/smd-rpm.c
@@ -226,6 +226,7 @@ static const struct of_device_id qcom_smd_rpm_of_match[] = {
 	{ .compatible = "qcom,rpm-msm8916" },
 	{ .compatible = "qcom,rpm-msm8974" },
 	{ .compatible = "qcom,rpm-msm8996" },
+	{ .compatible = "qcom,rpm-msm8998" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, qcom_smd_rpm_of_match);
-- 
2.16.2
