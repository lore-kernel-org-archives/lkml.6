Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700E4C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4107F222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550061124;
	bh=Oczd+PhZ+R87RTW7x5twc+OGYDu8d+UYYQ2pNwzt4d4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=RtIVOt4kX4BpqZAF3YG3zRCPrZIr6aHu4YjaukoCPf6NrPJZ3VvWC7/o2wijL9vYD
	 yRlIVXQB9n+BebtVm0FgLQtWJ/k70xX3TzNXI+dg8sS9XXo+EbFjz+Fmr+ST83EU3D
	 n26yrkpgMJm/DWR9RA8sVLdsri930zx7QmcgbWZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404118AbfBMMcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 07:32:02 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57612 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730650AbfBMMcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 07:32:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=LdotbfTAEmUXoCKivs7r4R0xmwabJi3UspttoM6IPwQ=; b=Qp+0P6fJ6M66
        JphzCT5I9cN4GxtO1VrykpREKY3gs6hqNB9ogw2ND8vzLL5UOl2sQw8NSANxKy3laJWGs8ekH/9hI
        znelbBye0n7vSnxvvNGz9ZZpAKbPlPPVcpqPxmY9yUO3bVwUeFut/hP/xk3kO+qa/YmQA66ON/B+S
        DmFKc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gtthl-0004JW-0R; Wed, 13 Feb 2019 12:31:57 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 8AC751128159; Wed, 13 Feb 2019 12:31:56 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Lanqing Liu <lanqing.liu@unisoc.com>
Cc:     Baolin Wang <baolin.wang@linaro.org>,
        Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, lanqing.liu@unisoc.com,
        baolin.wang@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: sprd: Add the SPI irq function for the SPI DMA mode" to the spi tree
In-Reply-To:  <11e55b5f9b0d83649a5b81c7e3fdb667cd3ddc5b.1550043082.git.baolin.wang@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20190213123156.8AC751128159@debutante.sirena.org.uk>
Date:   Wed, 13 Feb 2019 12:31:56 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: sprd: Add the SPI irq function for the SPI DMA mode

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

From de082d866cced9e172ca909b084f91df631ae7fe Mon Sep 17 00:00:00 2001
From: Lanqing Liu <lanqing.liu@unisoc.com>
Date: Wed, 13 Feb 2019 15:36:09 +0800
Subject: [PATCH] spi: sprd: Add the SPI irq function for the SPI DMA mode

The SPI irq event will use to complete the SPI work in the SPI DMA mode,
so this patch is a preparation for the following DMA mode support.

Moreover the SPI interrupt can be fired when removing the SPI controller,
so we should make sure the SPI controller has stopped the queue in
remove function before freeing the SPI irq.

Signed-off-by: Lanqing Liu <lanqing.liu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-sprd.c | 51 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
index 8daa24eec624..06578412b04d 100644
--- a/drivers/spi/spi-sprd.c
+++ b/drivers/spi/spi-sprd.c
@@ -133,6 +133,7 @@ struct sprd_spi {
 	void __iomem *base;
 	struct device *dev;
 	struct clk *clk;
+	int irq;
 	u32 src_clk;
 	u32 hw_mode;
 	u32 trans_len;
@@ -141,6 +142,7 @@ struct sprd_spi {
 	u32 hw_speed_hz;
 	u32 len;
 	int status;
+	struct completion xfer_completion;
 	const void *tx_buf;
 	void *rx_buf;
 	int (*read_bufs)(struct sprd_spi *ss, u32 len);
@@ -573,6 +575,48 @@ static int sprd_spi_transfer_one(struct spi_controller *sctlr,
 	return ret;
 }
 
+static irqreturn_t sprd_spi_handle_irq(int irq, void *data)
+{
+	struct sprd_spi *ss = (struct sprd_spi *)data;
+	u32 val = readl_relaxed(ss->base + SPRD_SPI_INT_MASK_STS);
+
+	if (val & SPRD_SPI_MASK_TX_END) {
+		writel_relaxed(SPRD_SPI_TX_END_CLR, ss->base + SPRD_SPI_INT_CLR);
+		if (!(ss->trans_mode & SPRD_SPI_RX_MODE))
+			complete(&ss->xfer_completion);
+
+		return IRQ_HANDLED;
+	}
+
+	if (val & SPRD_SPI_MASK_RX_END) {
+		writel_relaxed(SPRD_SPI_RX_END_CLR, ss->base + SPRD_SPI_INT_CLR);
+		complete(&ss->xfer_completion);
+
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static int sprd_spi_irq_init(struct platform_device *pdev, struct sprd_spi *ss)
+{
+	int ret;
+
+	ss->irq = platform_get_irq(pdev, 0);
+	if (ss->irq < 0) {
+		dev_err(&pdev->dev, "failed to get irq resource\n");
+		return ss->irq;
+	}
+
+	ret = devm_request_irq(&pdev->dev, ss->irq, sprd_spi_handle_irq,
+				0, pdev->name, ss);
+	if (ret)
+		dev_err(&pdev->dev, "failed to request spi irq %d, ret = %d\n",
+			ss->irq, ret);
+
+	return ret;
+}
+
 static int sprd_spi_clk_init(struct platform_device *pdev, struct sprd_spi *ss)
 {
 	struct clk *clk_spi, *clk_parent;
@@ -633,11 +677,16 @@ static int sprd_spi_probe(struct platform_device *pdev)
 	sctlr->max_speed_hz = min_t(u32, ss->src_clk >> 1,
 				    SPRD_SPI_MAX_SPEED_HZ);
 
+	init_completion(&ss->xfer_completion);
 	platform_set_drvdata(pdev, sctlr);
 	ret = sprd_spi_clk_init(pdev, ss);
 	if (ret)
 		goto free_controller;
 
+	ret = sprd_spi_irq_init(pdev, ss);
+	if (ret)
+		goto free_controller;
+
 	ret = clk_prepare_enable(ss->clk);
 	if (ret)
 		goto free_controller;
@@ -688,6 +737,8 @@ static int sprd_spi_remove(struct platform_device *pdev)
 		return ret;
 	}
 
+	spi_controller_suspend(sctlr);
+
 	clk_disable_unprepare(ss->clk);
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-- 
2.20.1

