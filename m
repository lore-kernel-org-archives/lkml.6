Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10FAC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69A920851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544490975;
	bh=K/Zu9gWSbvB+5jNV2E2ox3QIBwh2URb8XwkxmQ3DXow=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Q3X/B/C4O8pIKDWabxDJrl5YRmw6K+VKRvhYypKPDwvzs47YyBoAQS0BuCUw/Z3Of
	 mqUSxfOwAFAX9hzc67pZyBQCtjTHL3OEnc5xyI5ROjgbCKcUWwk5LiP/42YkBa9Zm3
	 hfyyGoAPEY4ladZ/eqe5n9/Mek5uvob7ff1mo+Ig=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B69A920851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbeLKBQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 20:16:14 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50930 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbeLKBQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 20:16:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=MXd+9IKx4+o0++18uXRoWwCQ3dYBlDnjO5as0It+1Pk=; b=oxrEPfrezPFf
        b7h2gGTj6FvQd/m2qA+wZAGvK78WNK0ScOEb1d5i7+410Gyef71zuPlXgJ8DUdXPJ5wKpk+w6phPa
        MEFH/qp3aWEWobsQbvRXr/5+ZQaFCpX6HpT3DPBQUfqUySzTjFHHu2ZtatUlfDBDiSvHBNaPkMiSK
        hJRMY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gWWec-0000LV-A8; Tue, 11 Dec 2018 01:16:06 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 041A011254C7; Tue, 11 Dec 2018 01:16:05 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: da9211: Hand over GPIO to regulator core" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20181211011605.041A011254C7@debutante.sirena.org.uk>
Date:   Tue, 11 Dec 2018 01:16:05 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: da9211: Hand over GPIO to regulator core

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

From b23328d76dba826265f4b0fc625280865eec9782 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 6 Dec 2018 13:43:48 +0100
Subject: [PATCH] regulator: da9211: Hand over GPIO to regulator core

The GPIO descriptors used by the DA9211 driver are retrieved
during probe() and it is really helpful to have those under
devres management because of all the errorpaths in the
intialization.

Using the new dev_gpiod_unhinge() call we can remove the
devres management of the descriptor right before handing
it over to the regulators core.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/da9211-regulator.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/regulator/da9211-regulator.c b/drivers/regulator/da9211-regulator.c
index 8f68c7a05d27..109ee12d4362 100644
--- a/drivers/regulator/da9211-regulator.c
+++ b/drivers/regulator/da9211-regulator.c
@@ -389,6 +389,12 @@ static int da9211_regulator_init(struct da9211 *chip)
 		else
 			config.ena_gpiod = NULL;
 
+		/*
+		 * Hand the GPIO descriptor management over to the regulator
+		 * core, remove it from GPIO devres management.
+		 */
+		if (config.ena_gpiod)
+			devm_gpiod_unhinge(chip->dev, config.ena_gpiod);
 		chip->rdev[i] = devm_regulator_register(chip->dev,
 			&da9211_regulators[i], &config);
 		if (IS_ERR(chip->rdev[i])) {
-- 
2.19.0.rc2

