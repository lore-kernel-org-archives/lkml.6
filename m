Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CE6C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC3920851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544491006;
	bh=TMYwddJZxPyeizYSx3W+iQeDLCMwVtwa/A4kpFx2TRg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=0Zk4RMgv0unnpaxMthTaBjIlruGiAJF/zndsgi/WF5vZPbFu3O8eYTiWSRKO/eRlh
	 RsYQnHHlOqu8RbGa54HHdNFUVtjunypDRWrCFOivU9LUaFEScgRcgK8oOw7S9RWDNp
	 TeeG1qA/1Kvp42LxaGbvY+ftgE76ZWQyVfYHY5mA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AC3920851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbeLKBQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 20:16:44 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51326 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728490AbeLKBQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 20:16:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=7043HACihHE3UK4bGyDMNL61JBlet1+RiUdpBn4JWQ4=; b=jqfkEXuHdGdh
        fwFJdGIbCLl52pHRAtBN+N1txp3Fpqascfg4U1rWjV3OVn6pA8d0KWDtKHN5l7P95VshY+ew+Sabb
        WOcOLDzpYjky59F4zPALxqyncAtJQz+F++RXGnkJVKw7X8FRozswFGrRKOY0mrB7MHw6Y3X5lIQpl
        EtOnM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gWWeo-0000MM-AL; Tue, 11 Dec 2018 01:16:18 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id F27A411254C7; Tue, 11 Dec 2018 01:16:17 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: lp8788-ldo: Let core handle GPIO descriptor" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20181211011617.F27A411254C7@debutante.sirena.org.uk>
Date:   Tue, 11 Dec 2018 01:16:17 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: lp8788-ldo: Let core handle GPIO descriptor

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

From 2bb8ede0b14187c19b5eedc62cf0b18b3bf00d3b Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 6 Dec 2018 13:43:40 +0100
Subject: [PATCH] regulator: lp8788-ldo: Let core handle GPIO descriptor

Use the gpiod_get() rather than the devm_* version so that the
regulator core can handle the lifecycle of these descriptors.

Fixes: 2468f0d51548 ("regulator: lp8788-ldo: Pass descriptor instead of GPIO number")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/lp8788-ldo.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/lp8788-ldo.c b/drivers/regulator/lp8788-ldo.c
index 553b4790050f..2ee22e7ea675 100644
--- a/drivers/regulator/lp8788-ldo.c
+++ b/drivers/regulator/lp8788-ldo.c
@@ -501,8 +501,12 @@ static int lp8788_config_ldo_enable_mode(struct platform_device *pdev,
 		return 0;
 	}
 
-	/* FIXME: check default mode for GPIO here: high or low? */
-	ldo->ena_gpiod = devm_gpiod_get_index_optional(&pdev->dev,
+	/*
+	 * Do not use devm* here: the regulator core takes over the
+	 * lifecycle management of the GPIO descriptor.
+	 * FIXME: check default mode for GPIO here: high or low?
+	 */
+	ldo->ena_gpiod = gpiod_get_index_optional(&pdev->dev,
 					       "enable",
 					       enable_id,
 					       GPIOD_OUT_HIGH |
-- 
2.19.0.rc2

