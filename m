Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4103BC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AEBA2147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546887608;
	bh=p/DdroJMFgEXnG2KYtTiwIdEoaA6mZ1ziphGo8SfOMg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=AqSSwP2erRn1C+TrlLSR0nYEw6ldo3UK9pgDwZr3yk112ljq/FmbJ3M5erFiTGm5O
	 FdJXTKZ1YAmzryoNrC+9mAKnVUyjLJAJ/wC9soG0qAlv1ZbO9XiuhIFnrW87EbjUkq
	 cReJ0IUU8A2mhagtAyhlvAC8HiWFqrcMEPTu8Xhc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbfAGS7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:59:17 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42834 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbfAGS7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:59:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=D6rRoRHGNOEotqIojnDFYyGKFIVK8jseIdsHc7KMPEA=; b=tdt91KE22XKl
        qt9uv1IAbTHJXNCmYlLccetIJMclAUZNXIoFV6b8KzAdnvfng4EmTqBpt9cXkRY8oK+o6xfA94w6o
        vx70/tTde0HDNW15Zd/z5yWq+pXojFcst3DR+aY/t/qe2DFvVOsndcYQADMyGr1YpJn/muQqgLEvx
        Di36o=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gga7B-0007qj-Hz; Mon, 07 Jan 2019 18:59:09 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 334171127491; Mon,  7 Jan 2019 18:59:09 +0000 (GMT)
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
Subject: Applied "spi: stm32: remove SPI LOOP mode" to the spi tree
In-Reply-To:  <1545688840-23992-7-git-send-email-cezary.gapinski@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190107185909.334171127491@debutante.sirena.org.uk>
Date:   Mon,  7 Jan 2019 18:59:09 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: stm32: remove SPI LOOP mode

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

From 6962b055a1c8db217786c70ebbb907fddc9ba462 Mon Sep 17 00:00:00 2001
From: Cezary Gapinski <cezary.gapinski@gmail.com>
Date: Mon, 24 Dec 2018 23:00:32 +0100
Subject: [PATCH] spi: stm32: remove SPI LOOP mode

This driver does not support SPI LOOP mode by configuration
in registers.

Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-stm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index f7056b767477..b639be752fe6 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1143,7 +1143,7 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	master->auto_runtime_pm = true;
 	master->bus_num = pdev->id;
 	master->mode_bits = SPI_CPHA | SPI_CPOL | SPI_CS_HIGH | SPI_LSB_FIRST |
-			    SPI_3WIRE | SPI_LOOP;
+			    SPI_3WIRE;
 	master->bits_per_word_mask = stm32_spi_get_bpw_mask(spi);
 	master->max_speed_hz = spi->clk_rate / SPI_MBR_DIV_MIN;
 	master->min_speed_hz = spi->clk_rate / SPI_MBR_DIV_MAX;
-- 
2.20.1

