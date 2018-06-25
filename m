Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CC7C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA7025A2C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="vdJZcki2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CA7025A2C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933994AbeFYNQf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 09:16:35 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36928 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933730AbeFYNPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 09:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=8S0AYXc7a6efaksjxluUceN0EwG53v3ZQuh+3XgsqA8=; b=vdJZcki2xmiC
        cZbnbWh/I6qlyRFDPMPxsngQNLv8F6+K4dv4Qnr62VKrUx1Lp4RDQkswtsI1BSHiU72NugUBZvxqY
        bqCpT/QEqXIz0nPJgNTZ2HR6aJ3Fhjz7RhGjGSOqfloHAX9as/7s5jsmuq4F2MPDu6mytHX+6KRRS
        CBSas=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fXRLG-0007si-Gr; Mon, 25 Jun 2018 13:15:38 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fXRLG-00005A-3A; Mon, 25 Jun 2018 14:15:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vkoul@kernel.org>,
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
Subject: Applied "dmaengine: pxa: use a dma slave map" to the asoc tree
In-Reply-To:  <20180524070703.11901-2-robert.jarzmik@free.fr>
Message-Id: <E1fXRLG-00005A-3A@debutante>
Date:   Mon, 25 Jun 2018 14:15:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   dmaengine: pxa: use a dma slave map

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

From 420c0117db25db38b72b6230223f7a976d3070ea Mon Sep 17 00:00:00 2001
From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Sun, 17 Jun 2018 19:02:04 +0200
Subject: [PATCH] dmaengine: pxa: use a dma slave map

In order to remove the specific knowledge of the dma mapping from PXA
drivers, add a default slave map for pxa architectures.

This won't impact MMP architecture, but is aimed only at all PXA boards.

This is the first step, and once all drivers are converted,
pxad_filter_fn() will be made static, and the DMA resources removed from
device.c.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Reported-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/pxa_dma.c                 | 10 +++++++++-
 include/linux/platform_data/mmp_dma.h |  4 ++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index b53fb618bbf6..9505334f9c6e 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -179,6 +179,8 @@ static unsigned int pxad_drcmr(unsigned int line)
 	return 0x1000 + line * 4;
 }
 
+bool pxad_filter_fn(struct dma_chan *chan, void *param);
+
 /*
  * Debug fs
  */
@@ -1396,9 +1398,10 @@ static int pxad_probe(struct platform_device *op)
 {
 	struct pxad_device *pdev;
 	const struct of_device_id *of_id;
+	const struct dma_slave_map *slave_map = NULL;
 	struct mmp_dma_platdata *pdata = dev_get_platdata(&op->dev);
 	struct resource *iores;
-	int ret, dma_channels = 0, nb_requestors = 0;
+	int ret, dma_channels = 0, nb_requestors = 0, slave_map_cnt = 0;
 	const enum dma_slave_buswidth widths =
 		DMA_SLAVE_BUSWIDTH_1_BYTE   | DMA_SLAVE_BUSWIDTH_2_BYTES |
 		DMA_SLAVE_BUSWIDTH_4_BYTES;
@@ -1429,6 +1432,8 @@ static int pxad_probe(struct platform_device *op)
 	} else if (pdata && pdata->dma_channels) {
 		dma_channels = pdata->dma_channels;
 		nb_requestors = pdata->nb_requestors;
+		slave_map = pdata->slave_map;
+		slave_map_cnt = pdata->slave_map_cnt;
 	} else {
 		dma_channels = 32;	/* default 32 channel */
 	}
@@ -1440,6 +1445,9 @@ static int pxad_probe(struct platform_device *op)
 	pdev->slave.device_prep_dma_memcpy = pxad_prep_memcpy;
 	pdev->slave.device_prep_slave_sg = pxad_prep_slave_sg;
 	pdev->slave.device_prep_dma_cyclic = pxad_prep_dma_cyclic;
+	pdev->slave.filter.map = slave_map;
+	pdev->slave.filter.mapcnt = slave_map_cnt;
+	pdev->slave.filter.fn = pxad_filter_fn;
 
 	pdev->slave.copy_align = PDMA_ALIGNMENT;
 	pdev->slave.src_addr_widths = widths;
diff --git a/include/linux/platform_data/mmp_dma.h b/include/linux/platform_data/mmp_dma.h
index d1397c8ed94e..6397b9c8149a 100644
--- a/include/linux/platform_data/mmp_dma.h
+++ b/include/linux/platform_data/mmp_dma.h
@@ -12,9 +12,13 @@
 #ifndef MMP_DMA_H
 #define MMP_DMA_H
 
+struct dma_slave_map;
+
 struct mmp_dma_platdata {
 	int dma_channels;
 	int nb_requestors;
+	int slave_map_cnt;
+	const struct dma_slave_map *slave_map;
 };
 
 #endif /* MMP_DMA_H */
-- 
2.18.0.rc2

