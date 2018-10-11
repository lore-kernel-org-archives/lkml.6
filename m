Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE1CC4161D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51AF82075C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="wP/UC873"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51AF82075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbeJKWX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 18:23:58 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46830 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbeJKWX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 18:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=+yFzsTIYiPNfVv4c7496e+wAx5tirB9XqAlADWztz4M=; b=wP/UC873p1KE
        ufJuL3XwPBZp2L63wpZOfV6+BKO5SGpFFOC3jiL4+e4l0tiKsV3+4/tqTDYgLVPuO1NODwyTLkCaV
        dkrThZJkY0DgUTpGh5Kc/rIe3HJKhbB2rc15fTdBWBnQjpoVfsS8hcp47t3TPNnmsZz4nlCErx6vN
        EHnsI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gAcNY-0001sX-WA; Thu, 11 Oct 2018 14:55:57 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B71F911223ED; Thu, 11 Oct 2018 15:55:56 +0100 (BST)
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
Subject: Applied "spi: rockchip: directly use direction constants" to the spi tree
In-Reply-To:  <20181010090038.20834-7-kernel@esmil.dk>
Message-Id: <20181011145556.B71F911223ED@debutante.sirena.org.uk>
Date:   Thu, 11 Oct 2018 15:55:56 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: rockchip: directly use direction constants

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

From d9071b7e9fc474e474e3b865428a8d30d88daaf4 Mon Sep 17 00:00:00 2001
From: Emil Renner Berthing <kernel@esmil.dk>
Date: Wed, 10 Oct 2018 11:00:37 +0200
Subject: [PATCH] spi: rockchip: directly use direction constants

The dma direction for the tx and rx dma channels never
change, so just use the constants directly rather
than storing them in device data.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rockchip.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 99943aa71bc1..6fa809da61dd 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -164,7 +164,6 @@ enum rockchip_ssi_type {
 
 struct rockchip_spi_dma_data {
 	struct dma_chan *ch;
-	enum dma_transfer_direction direction;
 	dma_addr_t addr;
 };
 
@@ -451,7 +450,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 
 	rxdesc = NULL;
 	if (rs->rx) {
-		rxconf.direction = rs->dma_rx.direction;
+		rxconf.direction = DMA_DEV_TO_MEM;
 		rxconf.src_addr = rs->dma_rx.addr;
 		rxconf.src_addr_width = rs->n_bytes;
 		rxconf.src_maxburst = 1;
@@ -460,7 +459,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 		rxdesc = dmaengine_prep_slave_sg(
 				rs->dma_rx.ch,
 				rs->rx_sg.sgl, rs->rx_sg.nents,
-				rs->dma_rx.direction, DMA_PREP_INTERRUPT);
+				DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);
 		if (!rxdesc)
 			return -EINVAL;
 
@@ -470,7 +469,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 
 	txdesc = NULL;
 	if (rs->tx) {
-		txconf.direction = rs->dma_tx.direction;
+		txconf.direction = DMA_MEM_TO_DEV;
 		txconf.dst_addr = rs->dma_tx.addr;
 		txconf.dst_addr_width = rs->n_bytes;
 		txconf.dst_maxburst = rs->fifo_len / 2;
@@ -479,7 +478,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 		txdesc = dmaengine_prep_slave_sg(
 				rs->dma_tx.ch,
 				rs->tx_sg.sgl, rs->tx_sg.nents,
-				rs->dma_tx.direction, DMA_PREP_INTERRUPT);
+				DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT);
 		if (!txdesc) {
 			if (rxdesc)
 				dmaengine_terminate_sync(rs->dma_rx.ch);
@@ -775,8 +774,6 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	if (rs->dma_tx.ch && rs->dma_rx.ch) {
 		rs->dma_tx.addr = (dma_addr_t)(mem->start + ROCKCHIP_SPI_TXDR);
 		rs->dma_rx.addr = (dma_addr_t)(mem->start + ROCKCHIP_SPI_RXDR);
-		rs->dma_tx.direction = DMA_MEM_TO_DEV;
-		rs->dma_rx.direction = DMA_DEV_TO_MEM;
 
 		master->can_dma = rockchip_spi_can_dma;
 		master->dma_tx = rs->dma_tx.ch;
-- 
2.19.0.rc2

