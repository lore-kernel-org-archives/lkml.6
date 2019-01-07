Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B196C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C32A206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546887575;
	bh=XQ7/bmf2WoG2IlCfRCIEJwKS22WYlpiKHUazdEInegg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=m6a57+nlAo6Qy2u+ev95/RBCNjno98Peno02SsUegh2jVr4V17BU2tOTdM+OOqohI
	 y44wwyeuzhXPAqN+AzlWd+OCqiQkVMcJL1lRbeGC8uk9dXVeM69ASD+Qi8XObUwETc
	 S+ZFeCndhYlAvueZzEyvdVt+GEVLOi4PYwl+HWUY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbfAGS7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:59:33 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43194 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729040AbfAGS7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:59:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=nytVJz4a237Wu+Vo/dsPkYC0xGwVUSyO4uH6gbLoCp0=; b=hvRkJmGwk4Yp
        UnIeEkq4LtQHeHDuD0jwq/yCF3La/po8kzWnh33I3HtlhJ9cxBjYlpCCvcBhuOpwuH0Gp8VZW9dXw
        mUFkXQez4E8fILYyiYlvoNrDcZ+WhN21oSjild1ggI5V01BF+Vkd3eJpVfYy8DTGpwyjRkPF00JbV
        s5kD4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gga7M-0007rt-Oi; Mon, 07 Jan 2019 18:59:20 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 562411127491; Mon,  7 Jan 2019 18:59:20 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     shaftarger <sholchen@gmail.com>
Cc:     shaftarger <shol@livemail.tw>, Mark Brown <broonie@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, shaftarger <shol@livemail.tw>,
        linux-spi@vger.kernel.org
Subject: Applied "spi: dw: fix potential variable assignment error" to the spi tree
In-Reply-To:  <20181228083312.14928-1-shol@livemail.tw>
X-Patchwork-Hint: ignore
Message-Id: <20190107185920.562411127491@debutante.sirena.org.uk>
Date:   Mon,  7 Jan 2019 18:59:20 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: dw: fix potential variable assignment error

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

From e1bc204894eae69b153eb63d9fd65414466fb639 Mon Sep 17 00:00:00 2001
From: shaftarger <sholchen@gmail.com>
Date: Fri, 28 Dec 2018 16:33:12 +0800
Subject: [PATCH] spi: dw: fix potential variable assignment error

spi::mode is defined by framework for several SPI capabilities,
such as polarity, phase, bit-endian, wire number. Directly use this
variable for setting controller's polarity and phase causes other
bit in register being set. Since SPI framework has its definition,
SPI_CPOL and SPI_CPHA offset may be changed by framwork change.
Instead of just mask off the relevant bits,
fetch required bit in spi::mode and set to register.

Signed-off-by: shaftarger <shol@livemail.tw>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-dw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 2e822a56576a..a945fad3db62 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -317,7 +317,8 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 	/* Default SPI mode is SCPOL = 0, SCPH = 0 */
 	cr0 = (transfer->bits_per_word - 1)
 		| (chip->type << SPI_FRF_OFFSET)
-		| (spi->mode << SPI_MODE_OFFSET)
+		| ((((spi->mode & SPI_CPOL) ? 1 : 0) << SPI_SCOL_OFFSET) |
+			(((spi->mode & SPI_CPHA) ? 1 : 0) << SPI_SCPH_OFFSET))
 		| (chip->tmode << SPI_TMOD_OFFSET);
 
 	/*
-- 
2.20.1

