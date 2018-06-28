Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665A8C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2367527288
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2367527288
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934027AbeF1LWj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 07:22:39 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45189 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751177AbeF1LWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 07:22:37 -0400
Received: by mail-lj1-f196.google.com with SMTP id g3-v6so4187393ljk.12;
        Thu, 28 Jun 2018 04:22:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=yIlnwAaRS5wjmVqFEBybonb6xCrCaypagsBglP836QU=;
        b=fdADtgZGz7j7CUh9lRtP7xcVc+uoKtKeaRw+5X1FtbypLR/UgbWM3HWGZ7JiMMPAXb
         T/8Q/F8AnGVOhply2Htv32WDRO2y9eyX7Nl3yaFfzIzL1+t32KpVZZo2/YgAv42OLKTg
         EdWrqV4xiSrAzhh6swnXnL6JE2kryo43N6dR9gr6QodcFRAEpP6HbAdJNvWSEftob4Dd
         cG1dA2rAXARimyaywH6Ab4XcFDXTVM62aeuXGtUOU16tJYDtxEPJfZaye6/YmaG/rIwa
         WlQ1Aa4t53z9A3XbKw78ZQqLuGCehfF+vX1xlWy3/x7GC675VqTgCnNcNyL88C1Wjcs6
         vf8Q==
X-Gm-Message-State: APt69E06uQoLBUp1rVHQukZLTkBl/CVp+9SVlKpZk+hnVGWkm7R8vbwO
        vdPFWa/ZvFC7vGdE9SyqNz0=
X-Google-Smtp-Source: AAOMgpdkblEv/846Ki61TDHr410k4a9x3hKaoJ/j1vx0wpRV00U8mUARzv9e5IwoFyB1GU7D1N0m7A==
X-Received: by 2002:a2e:82ce:: with SMTP id n14-v6mr6668150ljh.34.1530184955649;
        Thu, 28 Jun 2018 04:22:35 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 76-v6sm1252197lfz.88.2018.06.28.04.22.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Jun 2018 04:22:35 -0700 (PDT)
Date:   Thu, 28 Jun 2018 14:22:23 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, andy.shevchenko@gmail.com,
        axel.lin@ingics.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/2] regulator: bd71837: Editorial cleanups.
Message-ID: <3f1f74f57cbe2d4af395219da841df63daedc1f7.1530184909.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Address issues spotted by Andy Shevchenko during review of original patch
No functional changes intended

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/regulator/bd71837-regulator.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/regulator/bd71837-regulator.c b/drivers/regulator/bd71837-regulator.c
index f57f42ed7160..3a487255482c 100644
--- a/drivers/regulator/bd71837-regulator.c
+++ b/drivers/regulator/bd71837-regulator.c
@@ -2,19 +2,18 @@
 // Copyright (C) 2018 ROHM Semiconductors
 // bd71837-regulator.c ROHM BD71837MWV regulator driver
 
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
+#include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/gpio.h>
 #include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/mfd/bd71837.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
-#include <linux/delay.h>
-#include <linux/slab.h>
-#include <linux/gpio.h>
-#include <linux/mfd/bd71837.h>
 #include <linux/regulator/of_regulator.h>
+#include <linux/slab.h>
 
 struct bd71837_pmic {
 	struct regulator_desc descs[BD71837_REGULATOR_CNT];
@@ -39,7 +38,7 @@ static int bd71837_buck1234_set_ramp_delay(struct regulator_dev *rdev,
 	int id = rdev->desc->id;
 	unsigned int ramp_value = BUCK_RAMPRATE_10P00MV;
 
-	dev_dbg(&(pmic->pdev->dev), "Buck[%d] Set Ramp = %d\n", id + 1,
+	dev_dbg(&pmic->pdev->dev, "Buck[%d] Set Ramp = %d\n", id + 1,
 		ramp_delay);
 	switch (ramp_delay) {
 	case 1 ... 1250:
@@ -544,8 +543,7 @@ static int bd71837_probe(struct platform_device *pdev)
 
 	int i, err;
 
-	pmic = devm_kzalloc(&pdev->dev, sizeof(struct bd71837_pmic),
-			    GFP_KERNEL);
+	pmic = devm_kzalloc(&pdev->dev, sizeof(*pmic), GFP_KERNEL);
 	if (!pmic)
 		return -ENOMEM;
 
@@ -569,8 +567,8 @@ static int bd71837_probe(struct platform_device *pdev)
 		dev_err(&pmic->pdev->dev, "Failed to unlock PMIC (%d)\n", err);
 		goto err;
 	} else {
-		dev_dbg(&pmic->pdev->dev, "%s: Unlocked lock register 0x%x\n",
-			__func__, BD71837_REG_REGLOCK);
+		dev_dbg(&pmic->pdev->dev, "Unlocked lock register 0x%x\n",
+			BD71837_REG_REGLOCK);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(pmic_regulator_inits); i++) {
@@ -615,8 +613,6 @@ static int bd71837_probe(struct platform_device *pdev)
 		pmic->rdev[i] = rdev;
 	}
 
-	return 0;
-
 err:
 	return err;
 }
@@ -624,7 +620,6 @@ static int bd71837_probe(struct platform_device *pdev)
 static struct platform_driver bd71837_regulator = {
 	.driver = {
 		.name = "bd71837-pmic",
-		.owner = THIS_MODULE,
 	},
 	.probe = bd71837_probe,
 };
-- 
2.14.3

