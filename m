Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E684DC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B73DB20663
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548764068;
	bh=jMl1uxZeot/+YQay74MX2eQ8+Ek4euEJeBmNHdjr23c=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=vi8F7mFKtbijokDtKQjfg1EdlJtsrbcxoZHxjBSOucoB+E4eSpd0syGqcCaGbJw5y
	 JXCeMM/Wo4p67zuPPfxi/Fvbe4LsuhrQnC0FWX0F1YH5R/WAsc9f2DTJhY68PWJD+A
	 4m1c2YiZ7+GhaMKRtlkEh1B/SO39YzyAzuLqiXW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbfA2MO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:14:27 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51940 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728441AbfA2MO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 07:14:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Ci6rKwoOd0W6htM2s+k3FdRC1c3zB2LGVvt7OK7GUlw=; b=VEmrxBJDd9fS
        utLEusruJ57q0kqdC6Ufgd9L9Vaj+OymgZLGhpcoL1i2erRRUd7Th59YRE4bFdQMGYO8dq9MGvcK7
        LTdcoLpBj4XQYIovgnS6YEPgeRZKBleM/90N1Q1gNLi2o2Iil3/foFK2MVGPcSbvVSA2prN+c4meP
        CH9LE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1goSHW-0008Ap-D1; Tue, 29 Jan 2019 12:14:22 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 0C02F1127D50; Tue, 29 Jan 2019 12:14:22 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Vignesh R <vigneshr@ti.com>
Cc:     stable@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: ti-qspi: Fix mmap read when more than one CS in use" to the spi tree
In-Reply-To:  <20190129074422.10025-1-vigneshr@ti.com>
X-Patchwork-Hint: ignore
Message-Id: <20190129121422.0C02F1127D50@debutante.sirena.org.uk>
Date:   Tue, 29 Jan 2019 12:14:22 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: ti-qspi: Fix mmap read when more than one CS in use

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

From 673c865efbdc5fec3cc525c46d71844d42c60072 Mon Sep 17 00:00:00 2001
From: Vignesh R <vigneshr@ti.com>
Date: Tue, 29 Jan 2019 13:14:22 +0530
Subject: [PATCH] spi: ti-qspi: Fix mmap read when more than one CS in use

Commit 4dea6c9b0b64 ("spi: spi-ti-qspi: add mmap mode read support") has
has got order of parameter wrong when calling regmap_update_bits() to
select CS for mmap access. Mask and value arguments are interchanged.
Code will work on a system with single slave, but fails when more than
one CS is in use. Fix this by correcting the order of parameters when
calling regmap_update_bits().

Fixes: 4dea6c9b0b64 ("spi: spi-ti-qspi: add mmap mode read support")
Cc: stable@vger.kernel.org
Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-ti-qspi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 5f19016bbf10..b9fb6493cd6b 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -490,8 +490,8 @@ static void ti_qspi_enable_memory_map(struct spi_device *spi)
 	ti_qspi_write(qspi, MM_SWITCH, QSPI_SPI_SWITCH_REG);
 	if (qspi->ctrl_base) {
 		regmap_update_bits(qspi->ctrl_base, qspi->ctrl_reg,
-				   MEM_CS_EN(spi->chip_select),
-				   MEM_CS_MASK);
+				   MEM_CS_MASK,
+				   MEM_CS_EN(spi->chip_select));
 	}
 	qspi->mmap_enabled = true;
 }
@@ -503,7 +503,7 @@ static void ti_qspi_disable_memory_map(struct spi_device *spi)
 	ti_qspi_write(qspi, 0, QSPI_SPI_SWITCH_REG);
 	if (qspi->ctrl_base)
 		regmap_update_bits(qspi->ctrl_base, qspi->ctrl_reg,
-				   0, MEM_CS_MASK);
+				   MEM_CS_MASK, 0);
 	qspi->mmap_enabled = false;
 }
 
-- 
2.20.1

