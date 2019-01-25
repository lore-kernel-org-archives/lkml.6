Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD63C282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 101D6218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548439897;
	bh=10wHt3kDTYlVJE0OeS+8a1q2OPSiN9Um7mnpberkfFA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=aT1ZpO/gAs40LRiIgMunXoRqXp0L849RSvwcLfGEVNwN0SBxfX7guk9uhxXYp5e/I
	 YwmJ2bGqcYR0r4AnJvPNMJRPldTCg1I3bh206iPF5GszvUBbwASC/HoPZ7+5hA0pk2
	 ncvFbzbA6WD80vsVwWyTZbo3ydXKMuOYm+PqEmo0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbfAYSLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:11:34 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46774 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfAYSLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:11:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=VPdXhOEtaPoM420Vs6ZBb9aVcXkFp1+A6YoryXBQGYk=; b=GVUGfsVrmpfN
        CCwH2HXllu2J7eZwtbIricAchpaftS3laOcDGqcLIlsKJh95gbPsGbFPkttMnChgXaTaleDJqcyv5
        02zYai9T4h6Ff6Ja6Wsc7zX4Yt3WbhtTw6ReWp13aPf6HNJRZzZd1MZYuVkhVKwIF+AMlCsKjjfEi
        lJemU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gn5ww-0004XK-TL; Fri, 25 Jan 2019 18:11:30 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 6E93A1126FC0; Fri, 25 Jan 2019 18:11:25 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: da9052: Use lowercase regulator names to match the DT" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190125181125.6E93A1126FC0@debutante.sirena.org.uk>
Date:   Fri, 25 Jan 2019 18:11:25 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: da9052: Use lowercase regulator names to match the DT

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

From 45460fe9c0c628a14863a0f1dba1c46359841ed7 Mon Sep 17 00:00:00 2001
From: Rob Herring <robh@kernel.org>
Date: Fri, 25 Jan 2019 09:37:05 -0600
Subject: [PATCH] regulator: da9052: Use lowercase regulator names to match the
 DT

Since c32569e358ad ("regulator: Use of_node_name_eq for node name
comparisons"), regulator node name comparisons are case sensitive.
The DA9052 driver uses uppercase, but the DT has lowercase.

Fix this by using a lowercase regulator name to match the DT node name.

Fixes: c32569e358ad ("regulator: Use of_node_name_eq for node name comparisons")
Cc: Support Opensource <support.opensource@diasemi.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/da9052-regulator.c | 64 ++++++++++++++--------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/regulator/da9052-regulator.c b/drivers/regulator/da9052-regulator.c
index 207cb3859dcc..cefa3558236d 100644
--- a/drivers/regulator/da9052-regulator.c
+++ b/drivers/regulator/da9052-regulator.c
@@ -290,10 +290,10 @@ static const struct regulator_ops da9052_ldo_ops = {
 	.disable = regulator_disable_regmap,
 };
 
-#define DA9052_LDO(_id, step, min, max, sbits, ebits, abits) \
+#define DA9052_LDO(_id, _name, step, min, max, sbits, ebits, abits) \
 {\
 	.reg_desc = {\
-		.name = #_id,\
+		.name = #_name,\
 		.ops = &da9052_ldo_ops,\
 		.type = REGULATOR_VOLTAGE,\
 		.id = DA9052_ID_##_id,\
@@ -310,10 +310,10 @@ static const struct regulator_ops da9052_ldo_ops = {
 	.activate_bit = (abits),\
 }
 
-#define DA9052_DCDC(_id, step, min, max, sbits, ebits, abits) \
+#define DA9052_DCDC(_id, _name, step, min, max, sbits, ebits, abits) \
 {\
 	.reg_desc = {\
-		.name = #_id,\
+		.name = #_name,\
 		.ops = &da9052_dcdc_ops,\
 		.type = REGULATOR_VOLTAGE,\
 		.id = DA9052_ID_##_id,\
@@ -331,37 +331,37 @@ static const struct regulator_ops da9052_ldo_ops = {
 }
 
 static struct da9052_regulator_info da9052_regulator_info[] = {
-	DA9052_DCDC(BUCK1, 25, 500, 2075, 6, 6, DA9052_SUPPLY_VBCOREGO),
-	DA9052_DCDC(BUCK2, 25, 500, 2075, 6, 6, DA9052_SUPPLY_VBPROGO),
-	DA9052_DCDC(BUCK3, 25, 950, 2525, 6, 6, DA9052_SUPPLY_VBMEMGO),
-	DA9052_DCDC(BUCK4, 50, 1800, 3600, 5, 6, 0),
-	DA9052_LDO(LDO1, 50, 600, 1800, 5, 6, 0),
-	DA9052_LDO(LDO2, 25, 600, 1800, 6, 6, DA9052_SUPPLY_VLDO2GO),
-	DA9052_LDO(LDO3, 25, 1725, 3300, 6, 6, DA9052_SUPPLY_VLDO3GO),
-	DA9052_LDO(LDO4, 25, 1725, 3300, 6, 6, 0),
-	DA9052_LDO(LDO5, 50, 1200, 3600, 6, 6, 0),
-	DA9052_LDO(LDO6, 50, 1200, 3600, 6, 6, 0),
-	DA9052_LDO(LDO7, 50, 1200, 3600, 6, 6, 0),
-	DA9052_LDO(LDO8, 50, 1200, 3600, 6, 6, 0),
-	DA9052_LDO(LDO9, 50, 1250, 3650, 6, 6, 0),
-	DA9052_LDO(LDO10, 50, 1200, 3600, 6, 6, 0),
+	DA9052_DCDC(BUCK1, buck1, 25, 500, 2075, 6, 6, DA9052_SUPPLY_VBCOREGO),
+	DA9052_DCDC(BUCK2, buck2, 25, 500, 2075, 6, 6, DA9052_SUPPLY_VBPROGO),
+	DA9052_DCDC(BUCK3, buck3, 25, 950, 2525, 6, 6, DA9052_SUPPLY_VBMEMGO),
+	DA9052_DCDC(BUCK4, buck4, 50, 1800, 3600, 5, 6, 0),
+	DA9052_LDO(LDO1, ldo1, 50, 600, 1800, 5, 6, 0),
+	DA9052_LDO(LDO2, ldo2, 25, 600, 1800, 6, 6, DA9052_SUPPLY_VLDO2GO),
+	DA9052_LDO(LDO3, ldo3, 25, 1725, 3300, 6, 6, DA9052_SUPPLY_VLDO3GO),
+	DA9052_LDO(LDO4, ldo4, 25, 1725, 3300, 6, 6, 0),
+	DA9052_LDO(LDO5, ldo5, 50, 1200, 3600, 6, 6, 0),
+	DA9052_LDO(LDO6, ldo6, 50, 1200, 3600, 6, 6, 0),
+	DA9052_LDO(LDO7, ldo7, 50, 1200, 3600, 6, 6, 0),
+	DA9052_LDO(LDO8, ldo8, 50, 1200, 3600, 6, 6, 0),
+	DA9052_LDO(LDO9, ldo9, 50, 1250, 3650, 6, 6, 0),
+	DA9052_LDO(LDO10, ldo10, 50, 1200, 3600, 6, 6, 0),
 };
 
 static struct da9052_regulator_info da9053_regulator_info[] = {
-	DA9052_DCDC(BUCK1, 25, 500, 2075, 6, 6, DA9052_SUPPLY_VBCOREGO),
-	DA9052_DCDC(BUCK2, 25, 500, 2075, 6, 6, DA9052_SUPPLY_VBPROGO),
-	DA9052_DCDC(BUCK3, 25, 950, 2525, 6, 6, DA9052_SUPPLY_VBMEMGO),
-	DA9052_DCDC(BUCK4, 25, 950, 2525, 6, 6, 0),
-	DA9052_LDO(LDO1, 50, 600, 1800, 5, 6, 0),
-	DA9052_LDO(LDO2, 25, 600, 1800, 6, 6, DA9052_SUPPLY_VLDO2GO),
-	DA9052_LDO(LDO3, 25, 1725, 3300, 6, 6, DA9052_SUPPLY_VLDO3GO),
-	DA9052_LDO(LDO4, 25, 1725, 3300, 6, 6, 0),
-	DA9052_LDO(LDO5, 50, 1200, 3600, 6, 6, 0),
-	DA9052_LDO(LDO6, 50, 1200, 3600, 6, 6, 0),
-	DA9052_LDO(LDO7, 50, 1200, 3600, 6, 6, 0),
-	DA9052_LDO(LDO8, 50, 1200, 3600, 6, 6, 0),
-	DA9052_LDO(LDO9, 50, 1250, 3650, 6, 6, 0),
-	DA9052_LDO(LDO10, 50, 1200, 3600, 6, 6, 0),
+	DA9052_DCDC(BUCK1, buck1, 25, 500, 2075, 6, 6, DA9052_SUPPLY_VBCOREGO),
+	DA9052_DCDC(BUCK2, buck2, 25, 500, 2075, 6, 6, DA9052_SUPPLY_VBPROGO),
+	DA9052_DCDC(BUCK3, buck3, 25, 950, 2525, 6, 6, DA9052_SUPPLY_VBMEMGO),
+	DA9052_DCDC(BUCK4, buck4, 25, 950, 2525, 6, 6, 0),
+	DA9052_LDO(LDO1, ldo1, 50, 600, 1800, 5, 6, 0),
+	DA9052_LDO(LDO2, ldo2, 25, 600, 1800, 6, 6, DA9052_SUPPLY_VLDO2GO),
+	DA9052_LDO(LDO3, ldo3, 25, 1725, 3300, 6, 6, DA9052_SUPPLY_VLDO3GO),
+	DA9052_LDO(LDO4, ldo4, 25, 1725, 3300, 6, 6, 0),
+	DA9052_LDO(LDO5, ldo5, 50, 1200, 3600, 6, 6, 0),
+	DA9052_LDO(LDO6, ldo6, 50, 1200, 3600, 6, 6, 0),
+	DA9052_LDO(LDO7, ldo7, 50, 1200, 3600, 6, 6, 0),
+	DA9052_LDO(LDO8, ldo8, 50, 1200, 3600, 6, 6, 0),
+	DA9052_LDO(LDO9, ldo9, 50, 1250, 3650, 6, 6, 0),
+	DA9052_LDO(LDO10, ldo10, 50, 1200, 3600, 6, 6, 0),
 };
 
 static inline struct da9052_regulator_info *find_regulator_info(u8 chip_id,
-- 
2.20.1

