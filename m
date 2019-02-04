Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF946C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E7A1214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549271245;
	bh=M14GErllPnfKc9KYJEvdg/sDBTVdlHjsZj7v5Y755Rw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=sGiuhtitI343uyszhhWiVn9+kNQjANeJnG9o5ToIRvw2atlcMIWGw7YYukaWaQhm2
	 kBcyPBHr4LtK+ufAiSJpD4j9vYsyaUd5G0kzNpHQnnlei25sRntUI4gr4YKKp/IIOj
	 7OIGROgOfM8/ABH5GI9rYjsnFe0qnV1nhbW4ZAxs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbfBDJHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 04:07:23 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39674 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfBDJHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 04:07:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=o1In32XoIUo6mYHjRc8eBI8I3Bz7ZkhLWv5vyLL2KvA=; b=CF9eSOWZC9xp
        pFVmW4hY2Ac5dtNwpbEuBz1Ky7p5Hz/jSGX26SGlJuwCLKS3bdkZjr7/jPzgHLVPX3+oU0WXXkfBO
        Jk3gmjP661/aEhWHm5L6akupb26N9qkznYmBb4XUMDcRZb8hupOnwxVo7iMsgvjyUzOuuFpLZeYmW
        YrufI=;
Received: from 53.97-247-81.adsl-dyn.isp.belgacom.be ([81.247.97.53] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gqaDo-0000go-FG; Mon, 04 Feb 2019 09:07:20 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id CF1DC440082; Mon,  4 Feb 2019 09:07:18 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: axp20x: fix ALDO2, DLDO2 and ELDO3 definitions for AXP803" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190204090718.CF1DC440082@finisterre.ee.mobilebroadband>
Date:   Mon,  4 Feb 2019 09:07:18 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: axp20x: fix ALDO2, DLDO2 and ELDO3 definitions for AXP803

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

From 16c8a595740035c4a7ede608a60b4a59f67b76e6 Mon Sep 17 00:00:00 2001
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Fri, 25 Jan 2019 22:18:09 -0800
Subject: [PATCH] regulator: axp20x: fix ALDO2, DLDO2 and ELDO3 definitions for
 AXP803

Looks like refactoring didn't go well and left ALDO2, DLDO2 and ELDO3
definitions broken for AXP803 - now they are using register address
instead of mask. Fix it by using mask where necessary.

Fixes: db4a555f7c4cf ("regulator: axp20x: use defines for masks")
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/axp20x-regulator.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index dd0193d77960..1b51d557ab55 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -719,7 +719,7 @@ static const struct regulator_desc axp803_regulators[] = {
 		 AXP22X_ALDO1_V_OUT, AXP22X_ALDO1_V_OUT_MASK,
 		 AXP22X_PWR_OUT_CTRL3, AXP806_PWR_OUT_ALDO1_MASK),
 	AXP_DESC(AXP803, ALDO2, "aldo2", "aldoin", 700, 3300, 100,
-		 AXP22X_ALDO2_V_OUT, AXP22X_ALDO2_V_OUT,
+		 AXP22X_ALDO2_V_OUT, AXP22X_ALDO2_V_OUT_MASK,
 		 AXP22X_PWR_OUT_CTRL3, AXP806_PWR_OUT_ALDO2_MASK),
 	AXP_DESC(AXP803, ALDO3, "aldo3", "aldoin", 700, 3300, 100,
 		 AXP22X_ALDO3_V_OUT, AXP22X_ALDO3_V_OUT_MASK,
@@ -729,7 +729,7 @@ static const struct regulator_desc axp803_regulators[] = {
 		 AXP22X_PWR_OUT_CTRL2, AXP22X_PWR_OUT_DLDO1_MASK),
 	AXP_DESC_RANGES(AXP803, DLDO2, "dldo2", "dldoin",
 			axp803_dldo2_ranges, AXP803_DLDO2_NUM_VOLTAGES,
-			AXP22X_DLDO2_V_OUT, AXP22X_DLDO2_V_OUT,
+			AXP22X_DLDO2_V_OUT, AXP22X_DLDO2_V_OUT_MASK,
 			AXP22X_PWR_OUT_CTRL2, AXP22X_PWR_OUT_DLDO2_MASK),
 	AXP_DESC(AXP803, DLDO3, "dldo3", "dldoin", 700, 3300, 100,
 		 AXP22X_DLDO3_V_OUT, AXP22X_DLDO3_V_OUT_MASK,
@@ -744,7 +744,7 @@ static const struct regulator_desc axp803_regulators[] = {
 		 AXP22X_ELDO2_V_OUT, AXP22X_ELDO2_V_OUT_MASK,
 		 AXP22X_PWR_OUT_CTRL2, AXP22X_PWR_OUT_ELDO2_MASK),
 	AXP_DESC(AXP803, ELDO3, "eldo3", "eldoin", 700, 1900, 50,
-		 AXP22X_ELDO3_V_OUT, AXP22X_ELDO3_V_OUT,
+		 AXP22X_ELDO3_V_OUT, AXP22X_ELDO3_V_OUT_MASK,
 		 AXP22X_PWR_OUT_CTRL2, AXP22X_PWR_OUT_ELDO3_MASK),
 	AXP_DESC(AXP803, FLDO1, "fldo1", "fldoin", 700, 1450, 50,
 		 AXP803_FLDO1_V_OUT, AXP803_FLDO1_V_OUT_MASK,
-- 
2.20.1

