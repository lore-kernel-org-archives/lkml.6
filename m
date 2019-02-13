Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48B2C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65BB4222E5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550073436;
	bh=xRBmoFaXtomE0gIwocFoCQoZ04Twpu4FSzGWqjPL+4c=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=LNqLaLArVN2zeHbUkCYJox9jFKRIP6tPWWQYQNrS0h0DLo9Iuh3CaOY63LeiOEiad
	 1SwjhBae7dwv5iEnWcI0N+AFq0xyir+VweYn+lF92wOFf7OnkOrm5Oky6pSVkz6jxc
	 ptoGHgA3WTAwDMadqa0Kk29nCxG6sOAGTYhom+LE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392598AbfBMP5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:57:15 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35198 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732894AbfBMP5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 10:57:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=I2tNDv63WgH+n7eudj9KG2WTMcn46EoYUo9COIyTsMo=; b=QkQxO/oSEffb
        d7aqxJS9z6091uHS+9SxuTHIu8KDJjgqoXhbndAHoxm8wCVAQcsxxqUa5nlc8OooUS1o9tXGJPmmi
        EZ6ifoG2NzGHm17/Zypq2XljZx9iQx+hpzK6ix6DH3fRJtjL4/JUE2CAFlpgtjl9XTVNUGVB5xONW
        ToLEw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gtwuF-0005BA-Q7; Wed, 13 Feb 2019 15:57:03 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 14C9C1128158; Wed, 13 Feb 2019 15:57:03 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        orsonzhai@gmail.com, zhang.lyra@gmail.com, lanqing.liu@unisoc.com,
        baolin.wang@linaro.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Applied "spi: sprd: Add a prefix for SPI DMA channel macros" to the spi tree
In-Reply-To:  <94b245cf862bddcbeba065b6adc3e20f4155bdca.1550063176.git.baolin.wang@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20190213155703.14C9C1128158@debutante.sirena.org.uk>
Date:   Wed, 13 Feb 2019 15:57:03 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: sprd: Add a prefix for SPI DMA channel macros

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

From 5e060c48bc52d6e269cd01261cce3b260eba84ba Mon Sep 17 00:00:00 2001
From: Baolin Wang <baolin.wang@linaro.org>
Date: Wed, 13 Feb 2019 21:08:16 +0800
Subject: [PATCH] spi: sprd: Add a prefix for SPI DMA channel macros

Add a prefix for SPI DMA channel macros to avoid namespace conflicts,
and no functional changes.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-sprd.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
index a4398e737650..f6c8838f7dc3 100644
--- a/drivers/spi/spi-sprd.c
+++ b/drivers/spi/spi-sprd.c
@@ -135,14 +135,14 @@
 #define SPRD_SPI_DMA_STEP		8
 
 enum sprd_spi_dma_channel {
-	SPI_RX,
-	SPI_TX,
-	SPI_MAX,
+	SPRD_SPI_RX,
+	SPRD_SPI_TX,
+	SPRD_SPI_MAX,
 };
 
 struct sprd_spi_dma {
 	bool enable;
-	struct dma_chan *dma_chan[SPI_MAX];
+	struct dma_chan *dma_chan[SPRD_SPI_MAX];
 	enum dma_slave_buswidth width;
 	u32 fragmens_len;
 	u32 rx_len;
@@ -514,7 +514,7 @@ static int sprd_spi_dma_submit(struct dma_chan *dma_chan,
 
 static int sprd_spi_dma_rx_config(struct sprd_spi *ss, struct spi_transfer *t)
 {
-	struct dma_chan *dma_chan = ss->dma.dma_chan[SPI_RX];
+	struct dma_chan *dma_chan = ss->dma.dma_chan[SPRD_SPI_RX];
 	struct dma_slave_config config = {
 		.src_addr = ss->phy_base,
 		.src_addr_width = ss->dma.width,
@@ -532,7 +532,7 @@ static int sprd_spi_dma_rx_config(struct sprd_spi *ss, struct spi_transfer *t)
 
 static int sprd_spi_dma_tx_config(struct sprd_spi *ss, struct spi_transfer *t)
 {
-	struct dma_chan *dma_chan = ss->dma.dma_chan[SPI_TX];
+	struct dma_chan *dma_chan = ss->dma.dma_chan[SPRD_SPI_TX];
 	struct dma_slave_config config = {
 		.dst_addr = ss->phy_base,
 		.src_addr_width = ss->dma.width,
@@ -550,23 +550,23 @@ static int sprd_spi_dma_tx_config(struct sprd_spi *ss, struct spi_transfer *t)
 
 static int sprd_spi_dma_request(struct sprd_spi *ss)
 {
-	ss->dma.dma_chan[SPI_RX] = dma_request_chan(ss->dev, "rx_chn");
-	if (IS_ERR_OR_NULL(ss->dma.dma_chan[SPI_RX])) {
-		if (PTR_ERR(ss->dma.dma_chan[SPI_RX]) == -EPROBE_DEFER)
-			return PTR_ERR(ss->dma.dma_chan[SPI_RX]);
+	ss->dma.dma_chan[SPRD_SPI_RX] = dma_request_chan(ss->dev, "rx_chn");
+	if (IS_ERR_OR_NULL(ss->dma.dma_chan[SPRD_SPI_RX])) {
+		if (PTR_ERR(ss->dma.dma_chan[SPRD_SPI_RX]) == -EPROBE_DEFER)
+			return PTR_ERR(ss->dma.dma_chan[SPRD_SPI_RX]);
 
 		dev_err(ss->dev, "request RX DMA channel failed!\n");
-		return PTR_ERR(ss->dma.dma_chan[SPI_RX]);
+		return PTR_ERR(ss->dma.dma_chan[SPRD_SPI_RX]);
 	}
 
-	ss->dma.dma_chan[SPI_TX]  = dma_request_chan(ss->dev, "tx_chn");
-	if (IS_ERR_OR_NULL(ss->dma.dma_chan[SPI_TX])) {
-		if (PTR_ERR(ss->dma.dma_chan[SPI_TX]) == -EPROBE_DEFER)
-			return PTR_ERR(ss->dma.dma_chan[SPI_TX]);
+	ss->dma.dma_chan[SPRD_SPI_TX]  = dma_request_chan(ss->dev, "tx_chn");
+	if (IS_ERR_OR_NULL(ss->dma.dma_chan[SPRD_SPI_TX])) {
+		if (PTR_ERR(ss->dma.dma_chan[SPRD_SPI_TX]) == -EPROBE_DEFER)
+			return PTR_ERR(ss->dma.dma_chan[SPRD_SPI_TX]);
 
 		dev_err(ss->dev, "request TX DMA channel failed!\n");
-		dma_release_channel(ss->dma.dma_chan[SPI_RX]);
-		return PTR_ERR(ss->dma.dma_chan[SPI_TX]);
+		dma_release_channel(ss->dma.dma_chan[SPRD_SPI_RX]);
+		return PTR_ERR(ss->dma.dma_chan[SPRD_SPI_TX]);
 	}
 
 	return 0;
@@ -574,11 +574,11 @@ static int sprd_spi_dma_request(struct sprd_spi *ss)
 
 static void sprd_spi_dma_release(struct sprd_spi *ss)
 {
-	if (ss->dma.dma_chan[SPI_RX])
-		dma_release_channel(ss->dma.dma_chan[SPI_RX]);
+	if (ss->dma.dma_chan[SPRD_SPI_RX])
+		dma_release_channel(ss->dma.dma_chan[SPRD_SPI_RX]);
 
-	if (ss->dma.dma_chan[SPI_TX])
-		dma_release_channel(ss->dma.dma_chan[SPI_TX]);
+	if (ss->dma.dma_chan[SPRD_SPI_TX])
+		dma_release_channel(ss->dma.dma_chan[SPRD_SPI_TX]);
 }
 
 static int sprd_spi_dma_txrx_bufs(struct spi_device *sdev,
-- 
2.20.1

