Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF87BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE4FE214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547121283;
	bh=i4v/YMsZV2OQsuMFl24146W2+i7ZMn7+s0SEGtGDnKM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=A64qy5kxjwaBG0N8p/0VQ2FfmxCKlp9MyRTONZDJb+W/Wwl4auvhVdkaHOOMauxOX
	 4Vq1t8uLt0PiaxlltUShgjEDO9wO3LRWaR+PXnD3kBgKgQLwIFz0OqI0T21Ib7xETh
	 kax8Er0fjF4P7dVvq+NvVdHnR99U/ot2mDmwxFsI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbfAJLym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 06:54:42 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60936 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbfAJLym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 06:54:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=LoPgMtFHKLxYovTFVdiOStzQd0dkXxGJnaudw4ol18I=; b=gKbpB2IuYSG+
        t6S7r2glN+j95+Y3ci4WBD/BF5A0i+xqvlAlAN5ytDjsa42iSyY6YjTcTp4yMUIdp5euAKV8OUajb
        uPcpnDDIAlWEFlTqPY6lJP8x1lR0+zA9cpXnpFWTS6FbnRjPsvurTakmHP1dVibrZCWNMbqoE5icS
        afe3o=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ghYux-0003Pq-QX; Thu, 10 Jan 2019 11:54:35 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 6EE0F1127052; Thu, 10 Jan 2019 11:54:35 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: dw: fix warning unused variable 'ret'" to the spi tree
In-Reply-To:  <20190110101407.7583-1-anders.roxell@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20190110115435.6EE0F1127052@debutante.sirena.org.uk>
Date:   Thu, 10 Jan 2019 11:54:35 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: dw: fix warning unused variable 'ret'

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

From 4f0a0cd52d6c812fbf737e436b18f04eac2e312e Mon Sep 17 00:00:00 2001
From: Anders Roxell <anders.roxell@linaro.org>
Date: Thu, 10 Jan 2019 11:14:07 +0100
Subject: [PATCH] spi: dw: fix warning unused variable 'ret'
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When CONFIG_SPI_DESIGNWARE are enabled we see the unused variable
warning in dw_spi_setup.

../drivers/spi/spi-dw.c: In function ‘dw_spi_setup’:
../drivers/spi/spi-dw.c:400:6: warning: unused variable ‘ret’ [-Wunused-variable]
  int ret;
      ^~~

Remove the unused varable.

Fixes: 9400c41e77b8 ("spi: dw: Convert to use CS GPIO descriptors")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-dw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index f54b498001a9..7092e58add2c 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -397,7 +397,6 @@ static int dw_spi_setup(struct spi_device *spi)
 {
 	struct dw_spi_chip *chip_info = NULL;
 	struct chip_data *chip;
-	int ret;
 
 	/* Only alloc on first setup */
 	chip = spi_get_ctldata(spi);
-- 
2.20.1

