Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5535C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845B2206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546887584;
	bh=Y5pQH565Twk9vE7fQB0P6t1nmdf/T5yv7ZGblnUt8fM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=L/rzDMmhkL6BmniAxxSr28zqaIn9QFSC8/9sbRXyo90wL4ecrI2WLw2vEhpHagVgr
	 2VUnx8FGV2+BTWYGeeq1be5iOMOrw3LPCg4FgFHjFoPoAZ61C8RsZTEBnVjhOluWVA
	 00iJklgAyOYwpEo7cbkoALldoWwqV3Ee+zehoaI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbfAGS7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:59:43 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43684 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbfAGS7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:59:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=v9fqs7B44Lj5MtiBBA4eDrSOhItJlMvrEonlb/5do5M=; b=GoxtLzlueeZV
        0XLs/4tuzx2XqCx5sPYACeDchQ45cgnv1L17o8k3R3BD9/Q/Va/FaKvAwEkA69LKN2FFO8BLHRjD2
        c8P0QA+TFrdkCHu2ad/psnzG7NiRxw7OnM6JSUCLQtXIjbVizqjy9KP83gaUke4Jn4Nf1KbY5O667
        RzEg0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gga7d-0007st-Ct; Mon, 07 Jan 2019 18:59:37 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 033D01127491; Mon,  7 Jan 2019 18:59:37 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     Mark Brown <broonie@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org
Subject: Applied "spi: lpspi: Fix wrong transmission when don't use CONT" to the spi tree
In-Reply-To:  <20190107074639.6336-5-xiaoning.wang@nxp.com>
X-Patchwork-Hint: ignore
Message-Id: <20190107185937.033D01127491@debutante.sirena.org.uk>
Date:   Mon,  7 Jan 2019 18:59:37 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: lpspi: Fix wrong transmission when don't use CONT

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

From 6a130448498c151d31f1fb6f3003f5cf37b829e0 Mon Sep 17 00:00:00 2001
From: Clark Wang <xiaoning.wang@nxp.com>
Date: Mon, 7 Jan 2019 07:47:41 +0000
Subject: [PATCH] spi: lpspi: Fix wrong transmission when don't use CONT

Add judgment on SR_MBF and FSR_RXCOUNT.

In PIO mode, if don't use CONT to keep cs selected in one transfer, the
transfer will go wrong. FCIE will be set after one frame transfer
finish. If use CONT, the frame refer to the whole data in one transfer.
If don't use CONT, the frame refer to one byte of whole data. This will
cause the transfer ending early.

This patch add a register reading in isr function, it might lead to a
slight decrease in the max transmission speed in PIO mode.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-lpspi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index ba207931e209..d0b2d551cc43 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -48,6 +48,7 @@
 #define CR_RTF		BIT(8)
 #define CR_RST		BIT(1)
 #define CR_MEN		BIT(0)
+#define SR_MBF		BIT(24)
 #define SR_TCF		BIT(10)
 #define SR_FCF		BIT(9)
 #define SR_RDF		BIT(1)
@@ -61,6 +62,7 @@
 #define CFGR1_PCSPOL	BIT(8)
 #define CFGR1_NOSTALL	BIT(3)
 #define CFGR1_MASTER	BIT(0)
+#define FSR_RXCOUNT	(BIT(16)|BIT(17)|BIT(18))
 #define RSR_RXEMPTY	BIT(1)
 #define TCR_CPOL	BIT(31)
 #define TCR_CPHA	BIT(30)
@@ -433,6 +435,13 @@ static irqreturn_t fsl_lpspi_isr(int irq, void *dev_id)
 		return IRQ_HANDLED;
 	}
 
+	if (temp_SR & SR_MBF ||
+	    readl(fsl_lpspi->base + IMX7ULP_FSR) & FSR_RXCOUNT) {
+		writel(SR_FCF, fsl_lpspi->base + IMX7ULP_SR);
+		fsl_lpspi_intctrl(fsl_lpspi, IER_FCIE);
+		return IRQ_HANDLED;
+	}
+
 	if (temp_SR & SR_FCF && (temp_IER & IER_FCIE)) {
 		writel(SR_FCF, fsl_lpspi->base + IMX7ULP_SR);
 			complete(&fsl_lpspi->xfer_done);
-- 
2.20.1

