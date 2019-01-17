Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB8CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 582E820851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547728834;
	bh=IkzEgNK/NLM895ZOQO55AVwIF79l0tEkPKbyO3Qf3Ec=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=oOdgYaiZayiNFCTNauqBLEookm+r1hyK5wh9+gkbQt0TdDNcqFcY9AH2Q2NVLGOJH
	 NelTJXIDu8FQC1yPvr8/iXQX45S3SwHkYe5Jg2kUH7YE6d2EgsJIj0VYGv8AnulZJI
	 8okbZbxip6NaxQxB849Xk07H9hS1Qph0f173NGYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfAQMkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 07:40:23 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60490 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbfAQMkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 07:40:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=qsBdwsq+77gzvu4dQxeCJ/KKt32LH7f9pEazGgvO8Fk=; b=AELpN8CpBgCV
        eZgBgBXeomyCrijMdoJepwn022YTVeEJRlCi/jhlqH1Pt0NniyuSUbF4w8T2RSQQzr3dsgrL4MVjf
        HUFlLgrhvamQj8ecv+0pJFeo8LIjNk666DnqeSgKkF2Eybin/ZfQioL6QxNfIqaFQj7ySHMHxdmSV
        hj8RY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gk6y0-0000ZD-MN; Thu, 17 Jan 2019 12:40:16 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 3961D1126FE2; Thu, 17 Jan 2019 12:40:16 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Alban Bedel <albeu@free.fr>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-mips@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Applied "spi: ath79: Enable support for compile test" to the spi tree
In-Reply-To:  <20190116185549.23295-3-albeu@free.fr>
X-Patchwork-Hint: ignore
Message-Id: <20190117124016.3961D1126FE2@debutante.sirena.org.uk>
Date:   Thu, 17 Jan 2019 12:40:16 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: ath79: Enable support for compile test

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

From b172fd0c898022c47161a99cb40be5304b0d3fd0 Mon Sep 17 00:00:00 2001
From: Alban Bedel <albeu@free.fr>
Date: Wed, 16 Jan 2019 19:55:46 +0100
Subject: [PATCH] spi: ath79: Enable support for compile test

To allow building this driver in compile test we need to remove all
dependency on headers from arch/mips/include. To allow this we
explicitly define all the registers locally instead of using
ar71xx_regs.h and we move the platform data struct definition to
include/linux/platform_data/spi-ath79.h.

Signed-off-by: Alban Bedel <albeu@free.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/mips/ath79/dev-spi.h                         |  2 +-
 drivers/spi/Kconfig                               |  2 +-
 drivers/spi/spi-ath79.c                           | 15 ++++++++++++---
 .../linux/platform_data/spi-ath79.h               |  0
 4 files changed, 14 insertions(+), 5 deletions(-)
 rename arch/mips/include/asm/mach-ath79/ath79_spi_platform.h => include/linux/platform_data/spi-ath79.h (100%)

diff --git a/arch/mips/ath79/dev-spi.h b/arch/mips/ath79/dev-spi.h
index d732565ca736..6e15bc8651be 100644
--- a/arch/mips/ath79/dev-spi.h
+++ b/arch/mips/ath79/dev-spi.h
@@ -13,7 +13,7 @@
 #define _ATH79_DEV_SPI_H
 
 #include <linux/spi/spi.h>
-#include <asm/mach-ath79/ath79_spi_platform.h>
+#include <linux/platform_data/spi-ath79.h>
 
 void ath79_register_spi(struct ath79_spi_platform_data *pdata,
 			 struct spi_board_info const *info,
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 128892c7e21e..71d3d2d5e5d1 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -63,7 +63,7 @@ config SPI_ALTERA
 
 config SPI_ATH79
 	tristate "Atheros AR71XX/AR724X/AR913X SPI controller driver"
-	depends on ATH79
+	depends on ATH79 || COMPILE_TEST
 	select SPI_BITBANG
 	help
 	  This enables support for the SPI controller present on the
diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index edf695a359f4..09c4fb7fcf7a 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -23,15 +23,24 @@
 #include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/err.h>
-
-#include <asm/mach-ath79/ar71xx_regs.h>
-#include <asm/mach-ath79/ath79_spi_platform.h>
+#include <linux/platform_data/spi-ath79.h>
 
 #define DRV_NAME	"ath79-spi"
 
 #define ATH79_SPI_RRW_DELAY_FACTOR	12000
 #define MHZ				(1000 * 1000)
 
+#define AR71XX_SPI_REG_FS		0x00	/* Function Select */
+#define AR71XX_SPI_REG_CTRL		0x04	/* SPI Control */
+#define AR71XX_SPI_REG_IOC		0x08	/* SPI I/O Control */
+#define AR71XX_SPI_REG_RDS		0x0c	/* Read Data Shift */
+
+#define AR71XX_SPI_FS_GPIO		BIT(0)	/* Enable GPIO mode */
+
+#define AR71XX_SPI_IOC_DO		BIT(0)	/* Data Out pin */
+#define AR71XX_SPI_IOC_CLK		BIT(8)	/* CLK pin */
+#define AR71XX_SPI_IOC_CS(n)		BIT(16 + (n))
+
 struct ath79_spi {
 	struct spi_bitbang	bitbang;
 	u32			ioc_base;
diff --git a/arch/mips/include/asm/mach-ath79/ath79_spi_platform.h b/include/linux/platform_data/spi-ath79.h
similarity index 100%
rename from arch/mips/include/asm/mach-ath79/ath79_spi_platform.h
rename to include/linux/platform_data/spi-ath79.h
-- 
2.20.1

