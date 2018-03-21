Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752774AbeCUSsQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 14:48:16 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38509 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752614AbeCUSsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 14:48:14 -0400
X-Google-Smtp-Source: AG47ELsuYYW3RD5zKFsmIipbS4ojFZu9xXaXe0WEqz37lqxcNf8837FHXKlbzy9zSTfQIvC4/2nK1A==
From: Stephen Boyd <swboyd@chromium.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] regulator: qcom_smd: Drop regulator/{machine,of_regulator} includes
Date: Wed, 21 Mar 2018 11:48:11 -0700
Message-Id: <20180321184811.120996-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These seem to be leftovers from previous developments of the driver but
they never got removed. Dropping them still allows the code to compile
so everything must be fine.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/regulator/qcom_smd-regulator.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
index 940fe1b78411..0c6e681c7d89 100644
--- a/drivers/regulator/qcom_smd-regulator.c
+++ b/drivers/regulator/qcom_smd-regulator.c
@@ -17,8 +17,6 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
-#include <linux/regulator/machine.h>
-#include <linux/regulator/of_regulator.h>
 #include <linux/soc/qcom/smd-rpm.h>
 
 struct qcom_rpm_reg {
-- 
Sent by a computer through tubes
