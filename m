Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751923AbeFBLLu (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 07:11:50 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34678 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751837AbeFBLLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 07:11:46 -0400
X-Google-Smtp-Source: ADUXVKLlb4WvxFu9Oykk0zlZaWMTK7eQT0srgv0nfLJNzcfZLk2dQXCzt23/C2rk3MzwvybEbk+q4A==
From: Amit Kucheria <amit.kucheria@linaro.org>
To: linux-arm-msm@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org, edubezval@gmail.com,
        Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] tsens: Get rid of unused fields in structure
Date: Sat,  2 Jun 2018 14:11:13 +0300
Message-Id: <40aa5b9760b09be0970dbe82997db71756927eb0.1527937396.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1527937396.git.amit.kucheria@linaro.org>
References: <cover.1527937396.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1527937396.git.amit.kucheria@linaro.org>
References: <cover.1527937396.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

status_field and trdy are unused in any of the tsens drivers. Remove them.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index f15660d..77ed8dc 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -77,9 +77,7 @@ struct tsens_device {
 	struct device			*dev;
 	u32				num_sensors;
 	struct regmap			*map;
-	struct regmap_field		*status_field;
 	struct tsens_context		ctx;
-	bool				trdy;
 	const struct tsens_ops		*ops;
 	struct tsens_sensor		sensor[0];
 };
-- 
2.7.4
