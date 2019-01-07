Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343F1C43444
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011E021855
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546887564;
	bh=JqaegY3g0dom3G4SLduDpxjRW+BjlYX2/tVJe6uw6vQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=MtYRYqsh55YUcDXBD0of8QbjI7dcsyCwHxfmAdGOxTIi8lLZbfhvFH7XyAzzzDAI+
	 rkjMkHOBrV2VmePyjFkBQF7XfS1geXLNUrqMMZznIoGQabjaxfUF5net789/mXYSGm
	 sVlPTvD6/zYGa0by4fVbO44TVdcmi61qtRTAqcpU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbfAGS7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:59:23 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43050 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbfAGS7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:59:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=4iUNzxtt7ZSYvMlLvXPp8sp5INjhGUUdwXJ5DHd8oYE=; b=QtacVlU7TDdV
        2m01vC8LJYAyFyOlx9nlp1syFh8baeCeHOP25610GJDBBL+PK4qPmtEEr3t72l+yC36qN9bMr+yVv
        mwGO+ICQRYcYZKzDHi8damR4hRbemL+/Tq1ICxvtKf5cNk2WBntb1z1al8xCGE6N2xoJGdLM3exJa
        kwUL0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gga7H-0007rO-4L; Mon, 07 Jan 2019 18:59:15 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C22541127491; Mon,  7 Jan 2019 18:59:14 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Cezary Gapinski <cezary.gapinski@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org
Subject: Applied "spi: stm32: fix DMA configuration with only one channel" to the spi tree
In-Reply-To:  <1545688840-23992-4-git-send-email-cezary.gapinski@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190107185914.C22541127491@debutante.sirena.org.uk>
Date:   Mon,  7 Jan 2019 18:59:14 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: stm32: fix DMA configuration with only one channel

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

From 2cbee7f886b2ab6b723745b295379ec6475f2ee3 Mon Sep 17 00:00:00 2001
From: Cezary Gapinski <cezary.gapinski@gmail.com>
Date: Mon, 24 Dec 2018 23:00:29 +0100
Subject: [PATCH] spi: stm32: fix DMA configuration with only one channel

When SPI driver is configured to work only with TX or RX DMA channel
then dmaengine functions can dereferene NULL pointer.

Running full-duplex mode when when only RX or TX DMA channel is
available can cause overrun condition or incorrect writing to transmit
buffer so disable this types of DMA configuration and go back to
interrupt mode.

Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-stm32.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 51d7f720127b..8310f14fe273 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -427,9 +427,9 @@ static void stm32_spi_disable(struct stm32_spi *spi)
 	if (!spi->cur_usedma && spi->rx_buf && (spi->rx_len > 0))
 		stm32_spi_read_rxfifo(spi, true);
 
-	if (spi->cur_usedma && spi->tx_buf)
+	if (spi->cur_usedma && spi->dma_tx)
 		dmaengine_terminate_all(spi->dma_tx);
-	if (spi->cur_usedma && spi->rx_buf)
+	if (spi->cur_usedma && spi->dma_rx)
 		dmaengine_terminate_all(spi->dma_rx);
 
 	stm32_spi_clr_bits(spi, STM32_SPI_CR1, SPI_CR1_SPE);
@@ -750,7 +750,7 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 	spin_lock_irqsave(&spi->lock, flags);
 
 	rx_dma_desc = NULL;
-	if (spi->rx_buf) {
+	if (spi->rx_buf && spi->dma_rx) {
 		stm32_spi_dma_config(spi, &rx_dma_conf, DMA_DEV_TO_MEM);
 		dmaengine_slave_config(spi->dma_rx, &rx_dma_conf);
 
@@ -765,7 +765,7 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 	}
 
 	tx_dma_desc = NULL;
-	if (spi->tx_buf) {
+	if (spi->tx_buf && spi->dma_tx) {
 		stm32_spi_dma_config(spi, &tx_dma_conf, DMA_MEM_TO_DEV);
 		dmaengine_slave_config(spi->dma_tx, &tx_dma_conf);
 
@@ -776,8 +776,11 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 					DMA_PREP_INTERRUPT);
 	}
 
-	if ((spi->tx_buf && !tx_dma_desc) ||
-	    (spi->rx_buf && !rx_dma_desc))
+	if ((spi->tx_buf && spi->dma_tx && !tx_dma_desc) ||
+	    (spi->rx_buf && spi->dma_rx && !rx_dma_desc))
+		goto dma_desc_error;
+
+	if (spi->cur_comm == SPI_FULL_DUPLEX && (!tx_dma_desc || !rx_dma_desc))
 		goto dma_desc_error;
 
 	if (rx_dma_desc) {
@@ -822,7 +825,7 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 	return 1;
 
 dma_submit_error:
-	if (spi->rx_buf)
+	if (spi->dma_rx)
 		dmaengine_terminate_all(spi->dma_rx);
 
 dma_desc_error:
@@ -832,6 +835,7 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 
 	dev_info(spi->dev, "DMA issue: fall back to irq transfer\n");
 
+	spi->cur_usedma = false;
 	return stm32_spi_transfer_one_irq(spi);
 }
 
@@ -984,7 +988,7 @@ static int stm32_spi_transfer_one(struct spi_master *master,
 	spi->rx_len = spi->rx_buf ? transfer->len : 0;
 
 	spi->cur_usedma = (master->can_dma &&
-			   stm32_spi_can_dma(master, spi_dev, transfer));
+			   master->can_dma(master, spi_dev, transfer));
 
 	ret = stm32_spi_transfer_one_setup(spi, spi_dev, transfer);
 	if (ret) {
-- 
2.20.1

