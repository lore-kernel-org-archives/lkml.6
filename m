Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2ABC4151A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4F821738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548699967;
	bh=PPWxXeMCzHU0AtsfB9RPjivXaFZeXpSMMb7XNMVe3x4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=WcdhnKqs3CzRSmlIKT0FhSwpYtdVreVSAMYQcxq9pGM7cqkGvpMVwfMlXYmOEDKxT
	 rjydfvrC4tlgzCHzqBozul60SmC+9NMNsvMwK5AAOg9fi8ALIXAeiaxGm2cDrKXvqo
	 MN4r864Eavx78fnihSrEl9skipVdY0q5GCJutBB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbfA1S0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:26:06 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37582 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbfA1S0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:26:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=mfhnHH0x2E654fntPsAGavlrFArTu2BdabxZHTu/TvM=; b=V9iGdGm8ucFw
        FOntlS62UojUqPgesp06L5J9u4hMR4wJ5bHfYxghwAFrIPpCMlzqP4KgQSIpdq3xX/fDZWGxU+IEL
        KHslhE+BrHczLbb0XWn1dKzhkIEbQZozBgeUVjOw2deEuFU9VGdhlV/VJTAJSadriA2WnIalo645+
        7OH60=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1goBba-0003Cf-1l; Mon, 28 Jan 2019 18:25:58 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id A0AAA1127D29; Mon, 28 Jan 2019 18:25:57 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Jiwei Sun <jiwei.sun@windriver.com>
Cc:     Mark Brown <broonie@kernel.org>, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: pl022: add a message state STATE_TIMEOUT for timeout transfer" to the spi tree
In-Reply-To:  <20190118033229.22553-1-jiwei.sun@windriver.com>
X-Patchwork-Hint: ignore
Message-Id: <20190128182557.A0AAA1127D29@debutante.sirena.org.uk>
Date:   Mon, 28 Jan 2019 18:25:57 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: pl022: add a message state STATE_TIMEOUT for timeout transfer

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

From 7aef2b646b24247d880a353e09d4e10614a61cd6 Mon Sep 17 00:00:00 2001
From: Jiwei Sun <jiwei.sun@windriver.com>
Date: Fri, 18 Jan 2019 11:32:29 +0800
Subject: [PATCH] spi: pl022: add a message state STATE_TIMEOUT for timeout
 transfer

When transfer timeout, give -EAGAIN to the message's status, and it can
make the spi device driver choose repeated transimation or not. And if
transfer timeout, output some useful information for tracing the issue.

Signed-off-by: Jiwei Sun <jiwei.sun@windriver.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pl022.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 0c793e31d60f..26684178786f 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -253,6 +253,7 @@
 #define STATE_RUNNING			((void *) 1)
 #define STATE_DONE			((void *) 2)
 #define STATE_ERROR			((void *) -1)
+#define STATE_TIMEOUT			((void *) -2)
 
 /*
  * SSP State - Whether Enabled or Disabled
@@ -1484,6 +1485,30 @@ static void do_interrupt_dma_transfer(struct pl022 *pl022)
 	writew(irqflags, SSP_IMSC(pl022->virtbase));
 }
 
+static void print_current_status(struct pl022 *pl022)
+{
+	u32 read_cr0;
+	u16 read_cr1, read_dmacr, read_sr;
+
+	if (pl022->vendor->extended_cr)
+		read_cr0 = readl(SSP_CR0(pl022->virtbase));
+	else
+		read_cr0 = readw(SSP_CR0(pl022->virtbase));
+	read_cr1 = readw(SSP_CR1(pl022->virtbase));
+	read_dmacr = readw(SSP_DMACR(pl022->virtbase));
+	read_sr = readw(SSP_SR(pl022->virtbase));
+
+	dev_warn(&pl022->adev->dev, "spi-pl022 CR0: %x\n", read_cr0);
+	dev_warn(&pl022->adev->dev, "spi-pl022 CR1: %x\n", read_cr1);
+	dev_warn(&pl022->adev->dev, "spi-pl022 DMACR: %x\n", read_dmacr);
+	dev_warn(&pl022->adev->dev, "spi-pl022 SR: %x\n", read_sr);
+	dev_warn(&pl022->adev->dev,
+			"spi-pl022 exp_fifo_level/fifodepth: %u/%d\n",
+			pl022->exp_fifo_level,
+			pl022->vendor->fifodepth);
+
+}
+
 static void do_polling_transfer(struct pl022 *pl022)
 {
 	struct spi_message *message = NULL;
@@ -1535,7 +1560,8 @@ static void do_polling_transfer(struct pl022 *pl022)
 			if (time_after(time, timeout)) {
 				dev_warn(&pl022->adev->dev,
 				"%s: timeout!\n", __func__);
-				message->state = STATE_ERROR;
+				message->state = STATE_TIMEOUT;
+				print_current_status(pl022);
 				goto out;
 			}
 			cpu_relax();
@@ -1553,6 +1579,8 @@ static void do_polling_transfer(struct pl022 *pl022)
 	/* Handle end of message */
 	if (message->state == STATE_DONE)
 		message->status = 0;
+	else if (message->state == STATE_TIMEOUT)
+		message->status = -EAGAIN;
 	else
 		message->status = -EIO;
 
-- 
2.20.1

