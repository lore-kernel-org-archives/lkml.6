Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EAAC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35292206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546887627;
	bh=6SI6jTgl6WdrBeaKgmPFiGtphxlzhLXpfIwfwTu6X94=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=y5pGAKt1QQesqm2MiHSUaG2CUm5sdO9jij9j/78/iLm8pv95/TY77TWut3nfuSnAC
	 wtNFbfOfM95T+6b97FSkOYBfO6AgjSovNEubqTQovYq0klcZWwsO6F2b4jWI4B8r8i
	 k/DpJgTJFCU0EI6Vhxrqc8O0cTdtYlyDc+8R3mow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbfAGS7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:59:16 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42796 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfAGS7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:59:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=j6IPE14bSTdSl8O64DoUax6quuqxKvjbwoSzT35o1F0=; b=XU3ZIdD9e8o1
        3FeUh5Z+YHJhu4cOBdQpbsRrlCM23VsUTD4lw49A0J4P4lCqi7ypSFWid3jn97BtcGsRV+3+M65dY
        d1ATqCt6XaSY0BUGq55k1cOg/Di8DuSEmoU8yykTR5ev/HcI0VvESacPX10oLxTD0d4AdJ5GMBMuX
        utu5w=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gga77-0007qV-Or; Mon, 07 Jan 2019 18:59:05 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 6663D1127491; Mon,  7 Jan 2019 18:59:05 +0000 (GMT)
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
Subject: Applied "spi: stm32: rename interrupt function" to the spi tree
In-Reply-To:  <1545688840-23992-9-git-send-email-cezary.gapinski@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190107185905.6663D1127491@debutante.sirena.org.uk>
Date:   Mon,  7 Jan 2019 18:59:05 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: stm32: rename interrupt function

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

From a9675337ad3e540cecb2411a7fc71fda133a3932 Mon Sep 17 00:00:00 2001
From: Cezary Gapinski <cezary.gapinski@gmail.com>
Date: Mon, 24 Dec 2018 23:00:34 +0100
Subject: [PATCH] spi: stm32: rename interrupt function

Interrupt function is used as a thread so rename it to express
meaning directly by more clear function name.

Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-stm32.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 2ece69a75ae4..9cb7d334a5cb 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -466,11 +466,11 @@ static bool stm32_spi_can_dma(struct spi_master *master,
 }
 
 /**
- * stm32_spi_irq - Interrupt handler for SPI controller events
+ * stm32_spi_irq_thread - Thread of interrupt handler for SPI controller
  * @irq: interrupt line
  * @dev_id: SPI controller master interface
  */
-static irqreturn_t stm32_spi_irq(int irq, void *dev_id)
+static irqreturn_t stm32_spi_irq_thread(int irq, void *dev_id)
 {
 	struct spi_master *master = dev_id;
 	struct stm32_spi *spi = spi_master_get_devdata(master);
@@ -1113,7 +1113,7 @@ static int stm32_spi_probe(struct platform_device *pdev)
 		goto err_master_put;
 	}
 	ret = devm_request_threaded_irq(&pdev->dev, spi->irq, NULL,
-					stm32_spi_irq, IRQF_ONESHOT,
+					stm32_spi_irq_thread, IRQF_ONESHOT,
 					pdev->name, master);
 	if (ret) {
 		dev_err(&pdev->dev, "irq%d request failed: %d\n", spi->irq,
-- 
2.20.1

