Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A1CC43444
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3469206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546887603;
	bh=GxQ1vY6KhgjOl8fEvyuozqqFAvaLX6Wp2tZcBFcAUPY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=iMWFZvsyA3JGdEXd1iV7nnTdunNWGZ5M2DDmAZzHBoExTkd/i+AXweWpJPVNVlGm3
	 Yook/fIR0OkDBzQYSl2GFmdLs+dETBfPSWwB6KzSqa0Oc8UuIkerr4uxbWRjX4ahkk
	 NkEwU/UFn2AgRqkw6YS0HEQkS5Y6I/KVMu7wyku0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbfAGTAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:00:01 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42980 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfAGS7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:59:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=yByXl2A8+yicO9Z/ZY2KqH8zT9da9R2jVYfM9knhs0A=; b=DWlPem5OOQBK
        BrdOQOlQStqLJq3KPb/h/VJPz3ZZ4NHm/y8UQ07EWiuNaXJn7yK/MbDCMHG23/B3gPt5KUZmKA74C
        vf1TK61mcJgTF6+Kru6PnGFqJ7GDA53hsVeDHw8/yaf8VE/WYLh+HC/I1NtnulIidEaPNe5sqQcOP
        N7VqU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gga7F-0007rD-AR; Mon, 07 Jan 2019 18:59:13 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id DFAAB1127491; Mon,  7 Jan 2019 18:59:12 +0000 (GMT)
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
Subject: Applied "spi: fix typo in SPI_STM32 help text" to the spi tree
In-Reply-To:  <1545688840-23992-5-git-send-email-cezary.gapinski@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190107185912.DFAAB1127491@debutante.sirena.org.uk>
Date:   Mon,  7 Jan 2019 18:59:12 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: fix typo in SPI_STM32 help text

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

From bb35c9f91a8dec397e76f332dd93637e396e9054 Mon Sep 17 00:00:00 2001
From: Cezary Gapinski <cezary.gapinski@gmail.com>
Date: Mon, 24 Dec 2018 23:00:30 +0100
Subject: [PATCH] spi: fix typo in SPI_STM32 help text

Fix typo from STMicroelectonics to STMicroelectronics.

Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index ba68fe1913cb..dc67eda1788a 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -676,7 +676,7 @@ config SPI_STM32
 	tristate "STMicroelectronics STM32 SPI controller"
 	depends on ARCH_STM32 || COMPILE_TEST
 	help
-	  SPI driver for STMicroelectonics STM32 SoCs.
+	  SPI driver for STMicroelectronics STM32 SoCs.
 
 	  STM32 SPI controller supports DMA and PIO modes. When DMA
 	  is not available, the driver automatically falls back to
-- 
2.20.1

