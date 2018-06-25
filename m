Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAEAC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A32B25A1A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="q/o9e/3l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A32B25A1A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933959AbeFYNPu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 09:15:50 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36860 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933726AbeFYNPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 09:15:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=pG5Lif47lSeDNi70RAjG03Fj2KB43qSvRQlO7rrCKNw=; b=q/o9e/3lv8ci
        j7J3iDFBEVVLizw0dWJx9I2hV4MW5Y8P4+wB9WA9Zf2cuO0itmgAWKZx4RNb05QpMJj52fCi/dKTb
        K23q1F7H/VOUS1ogQVWOsDFtfMN56U2zitTFC60M3YD6Kin2QH2hM9m0atIjO9mPOjDkIg8Kd2R4W
        R2Yoc=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fXRL7-0007sE-Fq; Mon, 25 Jun 2018 13:15:29 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fXRL7-0008RT-0t; Mon, 25 Jun 2018 14:15:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        alsa-devel@alsa-project.org, netdev@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-mtd@lists.infradead.org,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-media@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "mmc: pxamci: remove the dmaengine compat need" to the asoc tree
In-Reply-To:  <20180524070703.11901-4-robert.jarzmik@free.fr>
Message-Id: <E1fXRL7-0008RT-0t@debutante>
Date:   Mon, 25 Jun 2018 14:15:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   mmc: pxamci: remove the dmaengine compat need

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

From 6b3348f9e6eb35d2c2d49ffa274039ef9a901adc Mon Sep 17 00:00:00 2001
From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Sun, 17 Jun 2018 19:02:07 +0200
Subject: [PATCH] mmc: pxamci: remove the dmaengine compat need

As the pxa architecture switched towards the dmaengine slave map, the
old compatibility mechanism to acquire the dma requestor line number and
priority are not needed anymore.

This patch simplifies the dma resource acquisition, using the more
generic function dma_request_slave_channel().

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/pxamci.c | 29 +++--------------------------
 1 file changed, 3 insertions(+), 26 deletions(-)

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index c763b404510f..6c94474e36f4 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -24,7 +24,6 @@
 #include <linux/interrupt.h>
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
-#include <linux/dma/pxa-dma.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/mmc/host.h>
@@ -637,10 +636,8 @@ static int pxamci_probe(struct platform_device *pdev)
 {
 	struct mmc_host *mmc;
 	struct pxamci_host *host = NULL;
-	struct resource *r, *dmarx, *dmatx;
-	struct pxad_param param_rx, param_tx;
+	struct resource *r;
 	int ret, irq, gpio_cd = -1, gpio_ro = -1, gpio_power = -1;
-	dma_cap_mask_t mask;
 
 	ret = pxamci_of_init(pdev);
 	if (ret)
@@ -739,34 +736,14 @@ static int pxamci_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, mmc);
 
-	if (!pdev->dev.of_node) {
-		dmarx = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-		dmatx = platform_get_resource(pdev, IORESOURCE_DMA, 1);
-		if (!dmarx || !dmatx) {
-			ret = -ENXIO;
-			goto out;
-		}
-		param_rx.prio = PXAD_PRIO_LOWEST;
-		param_rx.drcmr = dmarx->start;
-		param_tx.prio = PXAD_PRIO_LOWEST;
-		param_tx.drcmr = dmatx->start;
-	}
-
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-
-	host->dma_chan_rx =
-		dma_request_slave_channel_compat(mask, pxad_filter_fn,
-						 &param_rx, &pdev->dev, "rx");
+	host->dma_chan_rx = dma_request_slave_channel(&pdev->dev, "rx");
 	if (host->dma_chan_rx == NULL) {
 		dev_err(&pdev->dev, "unable to request rx dma channel\n");
 		ret = -ENODEV;
 		goto out;
 	}
 
-	host->dma_chan_tx =
-		dma_request_slave_channel_compat(mask, pxad_filter_fn,
-						 &param_tx,  &pdev->dev, "tx");
+	host->dma_chan_tx = dma_request_slave_channel(&pdev->dev, "tx");
 	if (host->dma_chan_tx == NULL) {
 		dev_err(&pdev->dev, "unable to request tx dma channel\n");
 		ret = -ENODEV;
-- 
2.18.0.rc2

