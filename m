Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE77C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75C7D208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544702987;
	bh=GRoAKM/hcyxUT2KQatksz7ANOJqDf+1CEFvvQhDILww=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=ZyV/tmcsONMC37XxX+bui2rDa/HuaiS/A1YHaDX9pJoc31/7gQ9kurV0czcfuPwkx
	 0dkIuhUc0qTX5KnzUo2GTigvqXBlqJvXXr0SXXt1apUiL2x+HN3sTYLIfkuEFMpthi
	 ybjLx30MXT+E627OoUJqUdQ8UNIs8d5OjqZ9EZzU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75C7D208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbeLMMJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:09:39 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50190 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728962AbeLMMJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:09:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=NfmUPjgCUL+KnJXJY/1GlR0M79cR7GSAAm6TSpd2mQA=; b=GJOYULWq6YZr
        GNjPplhG9+uIL2UF02jvbOAAWTNKgWHSQJ/RvNnYn8bxyypavhrBAdmRFaSj30xW2A0NMUPTTXK+7
        tK4s/GpMaagDRD3/FGGfUOYbTdIoobHjrHOBrvdtCqjV0ZkUIf4QcRsgHTkHb7eHIGG1kuM9Kg82i
        rWNKc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gXPne-0000zJ-G3; Thu, 13 Dec 2018 12:09:06 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 3290711254D1; Thu, 13 Dec 2018 12:09:06 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: act8945a-regulator: unlock expert registers" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20181213120906.3290711254D1@debutante.sirena.org.uk>
Date:   Thu, 13 Dec 2018 12:09:06 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: act8945a-regulator: unlock expert registers

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 90bc8ac220aab82df91322e67587d0418ec3b251 Mon Sep 17 00:00:00 2001
From: Claudiu Beznea <claudiu.beznea@microchip.com>
Date: Tue, 11 Dec 2018 15:56:36 +0000
Subject: [PATCH] regulator: act8945a-regulator: unlock expert registers

Unlock expert registers for act8945a.
This is based on orginal work of Boris Brezillon at [1].

[1] https://www.spinics.net/lists/kernel/msg2942960.html

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/act8945a-regulator.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/act8945a-regulator.c b/drivers/regulator/act8945a-regulator.c
index 43fda8b4455a..8d71d9893d0d 100644
--- a/drivers/regulator/act8945a-regulator.c
+++ b/drivers/regulator/act8945a-regulator.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 
@@ -23,6 +24,7 @@
  */
 #define ACT8945A_SYS_MODE	0x00
 #define ACT8945A_SYS_CTRL	0x01
+#define ACT8945A_SYS_UNLK_REGS	0x0b
 #define ACT8945A_DCDC1_VSET1	0x20
 #define ACT8945A_DCDC1_VSET2	0x21
 #define ACT8945A_DCDC1_CTRL	0x22
@@ -123,9 +125,17 @@ static int act8945a_pmic_probe(struct platform_device *pdev)
 	struct regulator_config config = { };
 	const struct regulator_desc *regulators;
 	struct regulator_dev *rdev;
+	struct regmap *regmap;
 	int i, num_regulators;
 	bool voltage_select;
 
+	regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!regmap) {
+		dev_err(&pdev->dev,
+			"could not retrieve regmap from parent device\n");
+		return -EINVAL;
+	}
+
 	voltage_select = of_property_read_bool(pdev->dev.parent->of_node,
 					       "active-semi,vsel-high");
 
@@ -149,7 +159,8 @@ static int act8945a_pmic_probe(struct platform_device *pdev)
 		}
 	}
 
-	return 0;
+	/* Unlock expert registers. */
+	return regmap_write(regmap, ACT8945A_SYS_UNLK_REGS, 0xef);
 }
 
 static struct platform_driver act8945a_pmic_driver = {
-- 
2.19.0.rc2

