Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F155C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E2102085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Toxw/12v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E2102085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbeJKWX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 18:23:59 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46860 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728267AbeJKWX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 18:23:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=6mzytH+J8Cw6AUzUWgDuNGQurFFAHpCh17Gtts8/qdE=; b=Toxw/12vG/2c
        BC8Z4BsoCl6eMsty/PjtpF0BCqMtcare1HZi2yHtx+/7GSXz+9mwsAM1jQXuCcfHQsLNG/psOc1cV
        mzxvRXDJOMngVtQeCNJ6GjZveXhs3LjWE4H+pCv/GppvMebh+OBNHalZQpN1w3pyqFNGqNSMzjWWP
        c+7eA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gAcNc-0001sm-SA; Thu, 11 Oct 2018 14:56:00 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 9F3DC11223ED; Thu, 11 Oct 2018 15:56:00 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Mark Brown <broonie@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Randy Li <ayaka@soulik.info>, Chris Zhong <zyw@rock-chips.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: rockchip: mark use_dma as bool" to the spi tree
In-Reply-To:  <20181010090038.20834-6-kernel@esmil.dk>
Message-Id: <20181011145600.9F3DC11223ED@debutante.sirena.org.uk>
Date:   Thu, 11 Oct 2018 15:56:00 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: rockchip: mark use_dma as bool

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

From f340b920511a666b02d371e88801d3817ea7a880 Mon Sep 17 00:00:00 2001
From: Emil Renner Berthing <kernel@esmil.dk>
Date: Wed, 10 Oct 2018 11:00:36 +0200
Subject: [PATCH] spi: rockchip: mark use_dma as bool

The driver data has a u32 field use_dma which is
only ever used as a boolean, so change its type
to reflect that.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rockchip.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 6a53b940f2f5..99943aa71bc1 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -202,7 +202,7 @@ struct rockchip_spi {
 
 	bool cs_asserted[ROCKCHIP_SPI_MAX_CS_NUM];
 
-	u32 use_dma;
+	bool use_dma;
 	struct sg_table tx_sg;
 	struct sg_table rx_sg;
 	struct rockchip_spi_dma_data dma_rx;
@@ -628,9 +628,9 @@ static int rockchip_spi_transfer_one(
 
 	/* we need prepare dma before spi was enabled */
 	if (master->can_dma && master->can_dma(master, spi, xfer))
-		rs->use_dma = 1;
+		rs->use_dma = true;
 	else
-		rs->use_dma = 0;
+		rs->use_dma = false;
 
 	rockchip_spi_config(rs);
 
-- 
2.19.0.rc2

