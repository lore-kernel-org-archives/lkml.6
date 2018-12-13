Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1633C67873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 829512133F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544702948;
	bh=5LVaoW4OFOctX3qyXcgyU9rUEqeH/vvYZcEH53V20sM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=TvSQc/Phjx6UIOdr/jAMhp/oOGVKIuqC6FPYsEEmN0uDnZbhiYEetBQHkgKUNtith
	 PeCFkv81/a3P6zMhO3eLAFPz4O8c3z7yWl0YzXhuTlON2S0n0gvHYR5ERo+Q2Rrh4d
	 U8SWU9MWn9KtwQdDNDL6oJHC7z/mH7ei6th5cn9U=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 829512133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbeLMMJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:09:07 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50088 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728925AbeLMMJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:09:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=9+//NrgY/VYRJlS+r5DzZFLiYM1QU9/FQBbhQGYV4KA=; b=H7oeCh1ZCAfb
        +oijhBVEQ94kxAeaWRTzy3UsZmT5jMHHmeIdByrz3C9X4JmbHn55j4ZcQi5IzElPYyrsy4snTFyEu
        3NGcIvrOrl+jgOXFr+xPFIOaTY87DqrRkS7Yv8hmaEyC8h7iYM6IGNAvXuWHHbze1F65Sv3mmHm3b
        cNrpA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gXPnb-0000z4-74; Thu, 13 Dec 2018 12:09:03 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id E38FE11254D1; Thu, 13 Dec 2018 12:09:02 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: act8945a-regulator: fix line over 80 chars warning" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20181213120902.E38FE11254D1@debutante.sirena.org.uk>
Date:   Thu, 13 Dec 2018 12:09:02 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: act8945a-regulator: fix line over 80 chars warning

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

From 03ffbf9c0891caf8723c81967ceea5faf5d099d5 Mon Sep 17 00:00:00 2001
From: Claudiu Beznea <claudiu.beznea@microchip.com>
Date: Tue, 11 Dec 2018 15:56:45 +0000
Subject: [PATCH] regulator: act8945a-regulator: fix line over 80 chars warning

Fix line over 80 chars checkpatch.pl warning.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/act8945a-regulator.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/act8945a-regulator.c b/drivers/regulator/act8945a-regulator.c
index f37d1a860407..f4d60743efb3 100644
--- a/drivers/regulator/act8945a-regulator.c
+++ b/drivers/regulator/act8945a-regulator.c
@@ -310,7 +310,8 @@ static int act8945a_pmic_probe(struct platform_device *pdev)
 	config.dev->of_node = pdev->dev.parent->of_node;
 	config.driver_data = act8945a;
 	for (i = 0; i < num_regulators; i++) {
-		rdev = devm_regulator_register(&pdev->dev, &regulators[i], &config);
+		rdev = devm_regulator_register(&pdev->dev, &regulators[i],
+					       &config);
 		if (IS_ERR(rdev)) {
 			dev_err(&pdev->dev,
 				"failed to register %s regulator\n",
-- 
2.19.0.rc2

