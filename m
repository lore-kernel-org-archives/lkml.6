Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F13C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A5D21904
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549472327;
	bh=saXLS55HRTgQ22olYeMGtmX/pff2r741v2f9Y6fPt00=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=zmgKkgvejd5w1k2rCil7HCFsb6PXDxZElBK1Hcdiaxfr3/8wSWX4XoM/mMUdsDPtK
	 qNGYZxBJS5ea1UovVk6N29X3NryL7Gx+qNFxdeZBQqvBPYNrcZ8NOlBPpb0/RaAbtz
	 drRbsUFzyVb3zxqQshKbHPARNSl9R96y8ovwsplI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731547AbfBFQ6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:58:46 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46378 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731476AbfBFQ6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 11:58:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=xbWh0+1uZyuyJWfbEbi6zNg9zAH4Jiyy0eiVKAfriQg=; b=v5m1hSCDNRBy
        Y/oG3XZ+48omyoxnzXGsU3Qz00qQSxletU00G2vFDLYGpkYcpzcuWK4EijTHqk/Fu5Akz5gofhA/k
        +XAhVL96wvDSyZK9IQlhqFOy37+eGw2rLxByTgSrwIzP9jBlxocj7RORRtgjHRiAGn2YtSgASR+Rq
        7zsXM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1grQWz-000740-B2; Wed, 06 Feb 2019 16:58:37 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id EBDB81127EA3; Wed,  6 Feb 2019 16:58:36 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: as3722: Correct minor typo" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190206165836.EBDB81127EA3@debutante.sirena.org.uk>
Date:   Wed,  6 Feb 2019 16:58:36 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: as3722: Correct minor typo

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

From 46689b1e381a09e5907ffd3ddced733379c72ad5 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Tue, 5 Feb 2019 10:34:58 +0000
Subject: [PATCH] regulator: as3722: Correct minor typo

A comma has been accidentally used where a semi-colon was clearly
intended, correct this typo.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/as3722-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/as3722-regulator.c b/drivers/regulator/as3722-regulator.c
index 66337e12719b..e5fed289b52d 100644
--- a/drivers/regulator/as3722-regulator.c
+++ b/drivers/regulator/as3722-regulator.c
@@ -886,7 +886,7 @@ static int as3722_regulator_probe(struct platform_device *pdev)
 				as3722_regs->desc[id].min_uV = 410000;
 			} else {
 				as3722_regs->desc[id].n_voltages =
-					AS3722_SD0_VSEL_MAX + 1,
+					AS3722_SD0_VSEL_MAX + 1;
 				as3722_regs->desc[id].min_uV = 610000;
 			}
 			as3722_regs->desc[id].uV_step = 10000;
-- 
2.20.1

