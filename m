Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77CAC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9307D222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550061125;
	bh=Kzxvc2mACUfawZUm/Sz3cYCLfv36Knvs+88fYJ2MvrQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=j1EL+C5VEZFRZU153Xa9uVnZ5j5Qco7SywJjfRXZaRYdKdPACTHL2lpOmIUkL//hF
	 yB5EzXdHo+ZN5yStPe0h4UKohsQz8eOIVdcbKhI6IShrkKBPljChdv3YaXtwGSy26v
	 p1wL0YZR3/9jdgnsc6aO/X//t2HLPV6lQTw8wokU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404132AbfBMMcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 07:32:04 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57642 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404104AbfBMMcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 07:32:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=NH5yg8CciWBFh9VgbheQ4T+ybLvoRYqpdUt/gppvJoU=; b=wt9iKTpCEfaI
        zfSbMD30VEwafeVhOfpCcaRImu/vVQntTFkM/pxK3HPgARrBix0p9b4do0oSqKSCJ1yWUfjweT6pu
        RSNBnckKYnSbKvxDdDAZFZRO5KljCN//irVkuVAAbuXdwSRagSFsXK5n8nnuNjzXZ/7wVJxsj4NQE
        3wT4A=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gtthg-0004JQ-Ta; Wed, 13 Feb 2019 12:31:52 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 4D27A1128159; Wed, 13 Feb 2019 12:31:52 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Lanqing Liu <lanqing.liu@unisoc.com>
Cc:     Baolin Wang <baolin.wang@linaro.org>,
        Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, lanqing.liu@unisoc.com,
        baolin.wang@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: sprd: spi: sprd: Add DMA mode support" to the spi tree
In-Reply-To:  <3f9d23d4b250c5046f8c3411606aa9ffe807edd8.1550043082.git.baolin.wang@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20190213123152.4D27A1128159@debutante.sirena.org.uk>
Date:   Wed, 13 Feb 2019 12:31:52 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: sprd: spi: sprd: Add DMA mode support

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

From 386119bc7be9fa5114ced0274a22a943df890b4b Mon Sep 17 00:00:00 2001
From: Lanqing Liu <lanqing.liu@unisoc.com>
Date: Wed, 13 Feb 2019 15:36:11 +0800
Subject: [PATCH] spi: sprd: spi: sprd: Add DMA mode support

Add DMA mode support for the Spreadtrum SPI controller, and we will enable
SPI interrupt to help to complete the SPI transfer work in DMA mode.

Signed-off-by: Lanqing Liu <lanqing.liu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-sprd.c | 293 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 290 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
index 06578412b04d..a4398e737650 100644
--- a/drivers/spi/spi-sprd.c
+++ b/drivers/spi/spi-sprd.c
@@ -2,6 +2,9 @@
 // Copyright (C) 2018 Spreadtrum Communications Inc.
 
 #include <linux/clk.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/dma/sprd-dma.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
@@ -9,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/of_dma.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/spi/spi.h>
@@ -128,9 +132,25 @@
 #define SPRD_SPI_DEFAULT_SOURCE		26000000
 #define SPRD_SPI_MAX_SPEED_HZ		48000000
 #define SPRD_SPI_AUTOSUSPEND_DELAY	100
+#define SPRD_SPI_DMA_STEP		8
+
+enum sprd_spi_dma_channel {
+	SPI_RX,
+	SPI_TX,
+	SPI_MAX,
+};
+
+struct sprd_spi_dma {
+	bool enable;
+	struct dma_chan *dma_chan[SPI_MAX];
+	enum dma_slave_buswidth width;
+	u32 fragmens_len;
+	u32 rx_len;
+};
 
 struct sprd_spi {
 	void __iomem *base;
+	phys_addr_t phy_base;
 	struct device *dev;
 	struct clk *clk;
 	int irq;
@@ -142,6 +162,7 @@ struct sprd_spi {
 	u32 hw_speed_hz;
 	u32 len;
 	int status;
+	struct sprd_spi_dma dma;
 	struct completion xfer_completion;
 	const void *tx_buf;
 	void *rx_buf;
@@ -431,6 +452,208 @@ static int sprd_spi_txrx_bufs(struct spi_device *sdev, struct spi_transfer *t)
 	return ret;
 }
 
+static void sprd_spi_irq_enable(struct sprd_spi *ss)
+{
+	u32 val;
+
+	/* Clear interrupt status before enabling interrupt. */
+	writel_relaxed(SPRD_SPI_TX_END_CLR | SPRD_SPI_RX_END_CLR,
+		ss->base + SPRD_SPI_INT_CLR);
+	/* Enable SPI interrupt only in DMA mode. */
+	val = readl_relaxed(ss->base + SPRD_SPI_INT_EN);
+	writel_relaxed(val | SPRD_SPI_TX_END_INT_EN |
+		       SPRD_SPI_RX_END_INT_EN,
+		       ss->base + SPRD_SPI_INT_EN);
+}
+
+static void sprd_spi_irq_disable(struct sprd_spi *ss)
+{
+	writel_relaxed(0, ss->base + SPRD_SPI_INT_EN);
+}
+
+static void sprd_spi_dma_enable(struct sprd_spi *ss, bool enable)
+{
+	u32 val = readl_relaxed(ss->base + SPRD_SPI_CTL2);
+
+	if (enable)
+		val |= SPRD_SPI_DMA_EN;
+	else
+		val &= ~SPRD_SPI_DMA_EN;
+
+	writel_relaxed(val, ss->base + SPRD_SPI_CTL2);
+}
+
+static int sprd_spi_dma_submit(struct dma_chan *dma_chan,
+			       struct dma_slave_config *c,
+			       struct sg_table *sg,
+			       enum dma_transfer_direction dir)
+{
+	struct dma_async_tx_descriptor *desc;
+	dma_cookie_t cookie;
+	unsigned long flags;
+	int ret;
+
+	ret = dmaengine_slave_config(dma_chan, c);
+	if (ret < 0)
+		return ret;
+
+	flags = SPRD_DMA_FLAGS(SPRD_DMA_CHN_MODE_NONE, SPRD_DMA_NO_TRG,
+			       SPRD_DMA_FRAG_REQ, SPRD_DMA_TRANS_INT);
+	desc = dmaengine_prep_slave_sg(dma_chan, sg->sgl, sg->nents, dir, flags);
+	if (!desc)
+		return  -ENODEV;
+
+	cookie = dmaengine_submit(desc);
+	if (dma_submit_error(cookie))
+		return dma_submit_error(cookie);
+
+	dma_async_issue_pending(dma_chan);
+
+	return 0;
+}
+
+static int sprd_spi_dma_rx_config(struct sprd_spi *ss, struct spi_transfer *t)
+{
+	struct dma_chan *dma_chan = ss->dma.dma_chan[SPI_RX];
+	struct dma_slave_config config = {
+		.src_addr = ss->phy_base,
+		.src_addr_width = ss->dma.width,
+		.dst_addr_width = ss->dma.width,
+		.dst_maxburst = ss->dma.fragmens_len,
+	};
+	int ret;
+
+	ret = sprd_spi_dma_submit(dma_chan, &config, &t->rx_sg, DMA_DEV_TO_MEM);
+	if (ret)
+		return ret;
+
+	return ss->dma.rx_len;
+}
+
+static int sprd_spi_dma_tx_config(struct sprd_spi *ss, struct spi_transfer *t)
+{
+	struct dma_chan *dma_chan = ss->dma.dma_chan[SPI_TX];
+	struct dma_slave_config config = {
+		.dst_addr = ss->phy_base,
+		.src_addr_width = ss->dma.width,
+		.dst_addr_width = ss->dma.width,
+		.src_maxburst = ss->dma.fragmens_len,
+	};
+	int ret;
+
+	ret = sprd_spi_dma_submit(dma_chan, &config, &t->tx_sg, DMA_MEM_TO_DEV);
+	if (ret)
+		return ret;
+
+	return t->len;
+}
+
+static int sprd_spi_dma_request(struct sprd_spi *ss)
+{
+	ss->dma.dma_chan[SPI_RX] = dma_request_chan(ss->dev, "rx_chn");
+	if (IS_ERR_OR_NULL(ss->dma.dma_chan[SPI_RX])) {
+		if (PTR_ERR(ss->dma.dma_chan[SPI_RX]) == -EPROBE_DEFER)
+			return PTR_ERR(ss->dma.dma_chan[SPI_RX]);
+
+		dev_err(ss->dev, "request RX DMA channel failed!\n");
+		return PTR_ERR(ss->dma.dma_chan[SPI_RX]);
+	}
+
+	ss->dma.dma_chan[SPI_TX]  = dma_request_chan(ss->dev, "tx_chn");
+	if (IS_ERR_OR_NULL(ss->dma.dma_chan[SPI_TX])) {
+		if (PTR_ERR(ss->dma.dma_chan[SPI_TX]) == -EPROBE_DEFER)
+			return PTR_ERR(ss->dma.dma_chan[SPI_TX]);
+
+		dev_err(ss->dev, "request TX DMA channel failed!\n");
+		dma_release_channel(ss->dma.dma_chan[SPI_RX]);
+		return PTR_ERR(ss->dma.dma_chan[SPI_TX]);
+	}
+
+	return 0;
+}
+
+static void sprd_spi_dma_release(struct sprd_spi *ss)
+{
+	if (ss->dma.dma_chan[SPI_RX])
+		dma_release_channel(ss->dma.dma_chan[SPI_RX]);
+
+	if (ss->dma.dma_chan[SPI_TX])
+		dma_release_channel(ss->dma.dma_chan[SPI_TX]);
+}
+
+static int sprd_spi_dma_txrx_bufs(struct spi_device *sdev,
+				  struct spi_transfer *t)
+{
+	struct sprd_spi *ss = spi_master_get_devdata(sdev->master);
+	u32 trans_len = ss->trans_len;
+	int ret, write_size = 0;
+
+	reinit_completion(&ss->xfer_completion);
+	sprd_spi_irq_enable(ss);
+	if (ss->trans_mode & SPRD_SPI_TX_MODE) {
+		write_size = sprd_spi_dma_tx_config(ss, t);
+		sprd_spi_set_tx_length(ss, trans_len);
+
+		/*
+		 * For our 3 wires mode or dual TX line mode, we need
+		 * to request the controller to transfer.
+		 */
+		if (ss->hw_mode & SPI_3WIRE || ss->hw_mode & SPI_TX_DUAL)
+			sprd_spi_tx_req(ss);
+	} else {
+		sprd_spi_set_rx_length(ss, trans_len);
+
+		/*
+		 * For our 3 wires mode or dual TX line mode, we need
+		 * to request the controller to read.
+		 */
+		if (ss->hw_mode & SPI_3WIRE || ss->hw_mode & SPI_TX_DUAL)
+			sprd_spi_rx_req(ss);
+		else
+			write_size = ss->write_bufs(ss, trans_len);
+	}
+
+	if (write_size < 0) {
+		ret = write_size;
+		dev_err(ss->dev, "failed to write, ret = %d\n", ret);
+		goto trans_complete;
+	}
+
+	if (ss->trans_mode & SPRD_SPI_RX_MODE) {
+		/*
+		 * Set up the DMA receive data length, which must be an
+		 * integral multiple of fragment length. But when the length
+		 * of received data is less than fragment length, DMA can be
+		 * configured to receive data according to the actual length
+		 * of received data.
+		 */
+		ss->dma.rx_len = t->len > ss->dma.fragmens_len ?
+			(t->len - t->len % ss->dma.fragmens_len) :
+			 t->len;
+		ret = sprd_spi_dma_rx_config(ss, t);
+		if (ret < 0) {
+			dev_err(&sdev->dev,
+				"failed to configure rx DMA, ret = %d\n", ret);
+			goto trans_complete;
+		}
+	}
+
+	sprd_spi_dma_enable(ss, true);
+	wait_for_completion(&(ss->xfer_completion));
+
+	if (ss->trans_mode & SPRD_SPI_TX_MODE)
+		ret = write_size;
+	else
+		ret = ss->dma.rx_len;
+
+trans_complete:
+	sprd_spi_dma_enable(ss, false);
+	sprd_spi_enter_idle(ss);
+	sprd_spi_irq_disable(ss);
+
+	return ret;
+}
+
 static void sprd_spi_set_speed(struct sprd_spi *ss, u32 speed_hz)
 {
 	/*
@@ -516,16 +739,22 @@ static int sprd_spi_setup_transfer(struct spi_device *sdev,
 		ss->trans_len = t->len;
 		ss->read_bufs = sprd_spi_read_bufs_u8;
 		ss->write_bufs = sprd_spi_write_bufs_u8;
+		ss->dma.width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+		ss->dma.fragmens_len = SPRD_SPI_DMA_STEP;
 		break;
 	case 16:
 		ss->trans_len = t->len >> 1;
 		ss->read_bufs = sprd_spi_read_bufs_u16;
 		ss->write_bufs = sprd_spi_write_bufs_u16;
+		ss->dma.width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+		ss->dma.fragmens_len = SPRD_SPI_DMA_STEP << 1;
 		break;
 	case 32:
 		ss->trans_len = t->len >> 2;
 		ss->read_bufs = sprd_spi_read_bufs_u32;
 		ss->write_bufs = sprd_spi_write_bufs_u32;
+		ss->dma.width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		ss->dma.fragmens_len = SPRD_SPI_DMA_STEP << 2;
 		break;
 	default:
 		return -EINVAL;
@@ -563,7 +792,11 @@ static int sprd_spi_transfer_one(struct spi_controller *sctlr,
 	if (ret)
 		goto setup_err;
 
-	ret = sprd_spi_txrx_bufs(sdev, t);
+	if (sctlr->can_dma(sctlr, sdev, t))
+		ret = sprd_spi_dma_txrx_bufs(sdev, t);
+	else
+		ret = sprd_spi_txrx_bufs(sdev, t);
+
 	if (ret == t->len)
 		ret = 0;
 	else if (ret >= 0)
@@ -590,6 +823,11 @@ static irqreturn_t sprd_spi_handle_irq(int irq, void *data)
 
 	if (val & SPRD_SPI_MASK_RX_END) {
 		writel_relaxed(SPRD_SPI_RX_END_CLR, ss->base + SPRD_SPI_INT_CLR);
+		if (ss->dma.rx_len < ss->len) {
+			ss->rx_buf += ss->dma.rx_len;
+			ss->dma.rx_len +=
+				ss->read_bufs(ss, ss->len - ss->dma.rx_len);
+		}
 		complete(&ss->xfer_completion);
 
 		return IRQ_HANDLED;
@@ -647,6 +885,35 @@ static int sprd_spi_clk_init(struct platform_device *pdev, struct sprd_spi *ss)
 	return 0;
 }
 
+static bool sprd_spi_can_dma(struct spi_controller *sctlr,
+			     struct spi_device *spi, struct spi_transfer *t)
+{
+	struct sprd_spi *ss = spi_controller_get_devdata(sctlr);
+
+	return ss->dma.enable && (t->len > SPRD_SPI_FIFO_SIZE);
+}
+
+static int sprd_spi_dma_init(struct platform_device *pdev, struct sprd_spi *ss)
+{
+	int ret;
+
+	ret = sprd_spi_dma_request(ss);
+	if (ret) {
+		if (ret == -EPROBE_DEFER)
+			return ret;
+
+		dev_warn(&pdev->dev,
+			 "failed to request dma, enter no dma mode, ret = %d\n",
+			 ret);
+
+		return 0;
+	}
+
+	ss->dma.enable = true;
+
+	return 0;
+}
+
 static int sprd_spi_probe(struct platform_device *pdev)
 {
 	struct spi_controller *sctlr;
@@ -667,12 +934,14 @@ static int sprd_spi_probe(struct platform_device *pdev)
 		goto free_controller;
 	}
 
+	ss->phy_base = res->start;
 	ss->dev = &pdev->dev;
 	sctlr->dev.of_node = pdev->dev.of_node;
 	sctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_3WIRE | SPI_TX_DUAL;
 	sctlr->bus_num = pdev->id;
 	sctlr->set_cs = sprd_spi_chipselect;
 	sctlr->transfer_one = sprd_spi_transfer_one;
+	sctlr->can_dma = sprd_spi_can_dma;
 	sctlr->auto_runtime_pm = true;
 	sctlr->max_speed_hz = min_t(u32, ss->src_clk >> 1,
 				    SPRD_SPI_MAX_SPEED_HZ);
@@ -687,10 +956,14 @@ static int sprd_spi_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_controller;
 
-	ret = clk_prepare_enable(ss->clk);
+	ret = sprd_spi_dma_init(pdev, ss);
 	if (ret)
 		goto free_controller;
 
+	ret = clk_prepare_enable(ss->clk);
+	if (ret)
+		goto release_dma;
+
 	ret = pm_runtime_set_active(&pdev->dev);
 	if (ret < 0)
 		goto disable_clk;
@@ -719,6 +992,8 @@ static int sprd_spi_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 disable_clk:
 	clk_disable_unprepare(ss->clk);
+release_dma:
+	sprd_spi_dma_release(ss);
 free_controller:
 	spi_controller_put(sctlr);
 
@@ -739,6 +1014,8 @@ static int sprd_spi_remove(struct platform_device *pdev)
 
 	spi_controller_suspend(sctlr);
 
+	if (ss->dma.enable)
+		sprd_spi_dma_release(ss);
 	clk_disable_unprepare(ss->clk);
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
@@ -751,6 +1028,9 @@ static int __maybe_unused sprd_spi_runtime_suspend(struct device *dev)
 	struct spi_controller *sctlr = dev_get_drvdata(dev);
 	struct sprd_spi *ss = spi_controller_get_devdata(sctlr);
 
+	if (ss->dma.enable)
+		sprd_spi_dma_release(ss);
+
 	clk_disable_unprepare(ss->clk);
 
 	return 0;
@@ -766,7 +1046,14 @@ static int __maybe_unused sprd_spi_runtime_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	return 0;
+	if (!ss->dma.enable)
+		return 0;
+
+	ret = sprd_spi_dma_request(ss);
+	if (ret)
+		clk_disable_unprepare(ss->clk);
+
+	return ret;
 }
 
 static const struct dev_pm_ops sprd_spi_pm_ops = {
-- 
2.20.1

