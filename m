Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DE2C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC50218AF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548889385;
	bh=tv47m9z3fi1op/+a8iTf0AtuZj4kXTUgQ49Zo0LFoY4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=LJLv4D5y7GHfpd3I3hI2D5X5Dq0fju5KF6Y9LWoG30mENAPMw6I5F9PLlZSJqnvxK
	 s6BJAr8h1fsUEqvs14v3YCLjEu/039ooZlz8cbwcWPTr09AFUZQInPOvhF0syY1KDQ
	 4mU7hoHrbLKqwT16bIglBp35IQXhqnJBeCiztR1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbfA3XDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:03:04 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56420 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfA3XC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:02:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=LQY6Rl/QQPWOOJEftcW1GrzBpJlT0qScx46dLh7/KiE=; b=QcuPORGFYnUq
        5XnpDKQxGwAbpo8nIdD0nV3vI8w2aZFQxeke9Gs2/CU+MFJ3lGfY15S61CbSx5YPaFTN+Hikq1DbM
        gdMhH98C61Mo0y9SCozYw7VuNAnDP6zQSur9b0bWzx5+kw+ruu5SvFG7GqX+E42kt08VlQMhqMwOf
        0LYWk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1goysc-0000DG-GN; Wed, 30 Jan 2019 23:02:50 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id C3857440082; Wed, 30 Jan 2019 23:02:47 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Jonas Bonn <jonas@norrbonn.se>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi-atmel: support inter-word delay" to the spi tree
In-Reply-To:  <20190130084005.18649-3-jonas@norrbonn.se>
X-Patchwork-Hint: ignore
Message-Id: <20190130230247.C3857440082@finisterre.ee.mobilebroadband>
Date:   Wed, 30 Jan 2019 23:02:47 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi-atmel: support inter-word delay

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

From 473a78a7bbeb7c77b81b596095f59ce4fbbd49dc Mon Sep 17 00:00:00 2001
From: Jonas Bonn <jonas@norrbonn.se>
Date: Wed, 30 Jan 2019 09:40:05 +0100
Subject: [PATCH] spi-atmel: support inter-word delay

If the SPI slave requires an inter-word delay, configure the DLYBCT
register accordingly.

Tested on a SAMA5D2 board (derived from SAMA5D2-Xplained reference
board).

Signed-off-by: Jonas Bonn <jonas@norrbonn.se>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
CC: Nicolas Ferre <nicolas.ferre@microchip.com>
CC: Mark Brown <broonie@kernel.org>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>
CC: Ludovic Desroches <ludovic.desroches@microchip.com>
CC: linux-spi@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-atmel.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index f53f0c5e63da..4954f0ab1606 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1201,13 +1201,14 @@ static int atmel_spi_setup(struct spi_device *spi)
 		csr |= SPI_BIT(CSAAT);
 
 	/* DLYBS is mostly irrelevant since we manage chipselect using GPIOs.
-	 *
-	 * DLYBCT would add delays between words, slowing down transfers.
-	 * It could potentially be useful to cope with DMA bottlenecks, but
-	 * in those cases it's probably best to just use a lower bitrate.
 	 */
 	csr |= SPI_BF(DLYBS, 0);
-	csr |= SPI_BF(DLYBCT, 0);
+
+	/* DLYBCT adds delays between words.  This is useful for slow devices
+	 * that need a bit of time to setup the next transfer.
+	 */
+	csr |= SPI_BF(DLYBCT,
+			(as->spi_clk / 1000000 * spi->word_delay_usecs) >> 5);
 
 	asd = spi->controller_state;
 	if (!asd) {
-- 
2.20.1

