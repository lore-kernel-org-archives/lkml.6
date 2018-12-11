Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86D5C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CD2520851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544491033;
	bh=kEH3y/bDOltS3xHv/fuLYPMkTnAju6qv56OpxJcpcHA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=iFxgZagsedHZNWNVSEAlXVTCrmAUaZ3EEDwu0OeI81XbrcPScG8NvJERMpgIAzJku
	 of23oKdvcquFik25+uyjDMY0PmWZMpTAl+XAOwyIZY4XZmHrAPORh2WjTOLnYoVZbG
	 fbxQmEBftYVz095dIvgCTANohCMuFEetC3Dd62Po=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CD2520851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbeLKBRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 20:17:11 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51156 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbeLKBQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 20:16:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=apbxeJ9bG5Xv8uNEyp9s+DWfaUC2NV0BHKfYkgq2yF0=; b=My19JJYtHzY8
        YzhxJn3YEAHc/0a6ybL18RG20y7UQ78722YgrnCjIRDkCLKRbugN19P6+0SY1fQ+Gdan87yLBpAYE
        N16qdaSUwhuQ5Roz3K0Le1pDDYC7NZiPOruDOX6ruFrFqBPQiMxETQRH9B7YSsCIltbjCvWUDH79D
        wC+Jw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gWWeh-0000Lu-QD; Tue, 11 Dec 2018 01:16:11 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 7A41811254C7; Tue, 11 Dec 2018 01:16:11 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "gpio: Enable nonexclusive gpiods from DT nodes" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20181211011611.7A41811254C7@debutante.sirena.org.uk>
Date:   Tue, 11 Dec 2018 01:16:11 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   gpio: Enable nonexclusive gpiods from DT nodes

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

From ec757001c818c175e6b610e8ef80c2a25d1ed1a5 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 6 Dec 2018 13:43:44 +0100
Subject: [PATCH] gpio: Enable nonexclusive gpiods from DT nodes

This makes gpiod_get_from_of_node() respect the
GPIOD_FLAGS_BIT_NONEXCLUSIVE flag which is especially
nice when getting regulator GPIOs right out of device
tree nodes.

Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Fixes: b0ce7b29bfcd ("regulator/gpio: Allow nonexclusive GPIO access")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/gpio/gpiolib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 230e41562462..a7e3fd512e2d 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4204,6 +4204,8 @@ struct gpio_desc *gpiod_get_from_of_node(struct device_node *node,
 	transitory = flags & OF_GPIO_TRANSITORY;
 
 	ret = gpiod_request(desc, label);
+	if (ret == -EBUSY && (flags & GPIOD_FLAGS_BIT_NONEXCLUSIVE))
+		return desc;
 	if (ret)
 		return ERR_PTR(ret);
 
-- 
2.19.0.rc2

