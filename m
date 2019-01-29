Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C7DC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E85C620663
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548764082;
	bh=ohtcg1YiY1HUQe9xY+6ZR4XzPgy7ICM4q91PNlZgwL8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=jBahrxFsBNSurAMswak21zlocZQ+1txfQVKyQxhApgGK16pLQlIAxhYTAbFF9TQBc
	 yUvhvQGbp1uJocAGF3Wu285ZWB5XH5ti0A9YkjfA38HeQ3C2e3VrjFKtpqKLmd+4ET
	 9u0t29NO+BewXTZfrnWD4XZewJW6ruVDC8nlhWdk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbfA2MOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:14:40 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52348 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728441AbfA2MOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 07:14:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=axb0vk6XEGuzklGvWB5ppwLz5+cZsUDpjfGLPFJOdac=; b=iMYfNxn2OEdv
        tndkeDpdsFr5GHG2efJBYezyiMG5t4VOUGh65DnQiFAsEjpPCWo6yJBBtSkaF0byq1DTOYSQjvtRb
        h8aa/fHrudE0vKT9+APNSRZJziFd40zPqQ4loCb+MvSNse9H7T3VBi+ef5BOkyX6D05JcvmNvOF4n
        72h6U=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1goSHY-0008Aw-GI; Tue, 29 Jan 2019 12:14:24 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 23FA01127D50; Tue, 29 Jan 2019 12:14:24 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Brown <broonie@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
        linux-spi@vger.kernel.org
Subject: Applied "spi: spi-mem: spi-nxp-fspi: add module license info" to the spi tree
In-Reply-To:  <1548755240-27319-1-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Patchwork-Hint: ignore
Message-Id: <20190129121424.23FA01127D50@debutante.sirena.org.uk>
Date:   Tue, 29 Jan 2019 12:14:24 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: spi-mem: spi-nxp-fspi: add module license info

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

From ce6f0697ebadb90cc37a6ef081384c115bdda196 Mon Sep 17 00:00:00 2001
From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Date: Tue, 29 Jan 2019 09:49:22 +0000
Subject: [PATCH] spi: spi-mem: spi-nxp-fspi: add module license info

Add MODULE_LICENSE info to fix below warning:
WARNING: modpost: missing MODULE_LICENSE() in drivers/spi/spi-nxp-fspi.o

Typo fix in Boris Brezillon last name.

Fixes: a5356aef6a90 ("spi: spi-mem: Add driver for NXP FlexSPI controller")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-nxp-fspi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 0327216ef7aa..8894f98cc99c 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -26,7 +26,7 @@
  *
  * Author:
  *     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
- *     Boris Brezillion <bbrezillon@kernel.org>
+ *     Boris Brezillon <bbrezillon@kernel.org>
  *     Frieder Schrempf <frieder.schrempf@kontron.de>
  */
 
@@ -1101,5 +1101,6 @@ module_platform_driver(nxp_fspi_driver);
 MODULE_DESCRIPTION("NXP FSPI Controller Driver");
 MODULE_AUTHOR("NXP Semiconductor");
 MODULE_AUTHOR("Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>");
-MODULE_AUTHOR("Boris Brezillion <bbrezillon@kernel.org>");
+MODULE_AUTHOR("Boris Brezillon <bbrezillon@kernel.org>");
 MODULE_AUTHOR("Frieder Schrempf <frieder.schrempf@kontron.de>");
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

