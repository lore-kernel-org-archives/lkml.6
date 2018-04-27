Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933880AbeD0PKD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 11:10:03 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:43123 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933690AbeD0OEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 10:04:23 -0400
X-Google-Smtp-Source: AB8JxZpHp5o3K/x/0CY1uxHh5atHEn3cXRwDoh/+6dLtuGYjYCCy33A6pAJ16GEWprTmtYaVBi8QxQ==
From: Alex Elder <elder@linaro.org>
To: andy.gross@linaro.org, david.brown@linaro.org
Cc: linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] soc: qcom: qmi: add a prompt to QCOM_QMI_HELPERS
Date: Fri, 27 Apr 2018 09:03:58 -0500
Message-Id: <20180427140358.30839-1-elder@linaro.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a prompt to the "tristate" attribute in the Kconfig file in
which QCOM_QMI_HELPERS is defined; I find it doesn't get selected
without it.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/soc/qcom/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 5c4535b545cc..81a501765cd9 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -36,7 +36,7 @@ config QCOM_PM
 	  low power modes.
 
 config QCOM_QMI_HELPERS
-	tristate
+	tristate "Qualcomm QMI Helpers"
 	depends on ARCH_QCOM && NET
 	help
 	  Helper library for handling QMI encoded messages.  QMI encoded
-- 
2.14.1
