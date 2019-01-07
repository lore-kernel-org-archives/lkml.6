Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F40CC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10833206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546887561;
	bh=xQf5OOIFH1C0ekds+3UySRjTgPoJPNFSHO6167537dk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=eeWlbOS1L0U/9eTT0YSsqu+dGmYYbA5gpTpD88wZG1eYyOByq1K2PkBfonIflKExn
	 o7D99racO9hfbWItdBtQB4vB5cwR/fkkTqWtZv6v8WGVG9q/4oMEBomU1SBvjhSRdo
	 4vLvQkGM0vdXYgnxh+sXc4BF0qyjJcyim2ZAWOvE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbfAGS7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:59:20 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42836 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbfAGS7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:59:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=VGLnCNb29Bp/cVgPPCTiA46RTTECY0Mxm/8ztaIGeCk=; b=okmJnJoOvY2c
        f2fcJ5q63bo3CC885/SxPXc8EzgyV6FrXCHDealZIIs44k7dKTl+XyJSdgER5dE6vRVwKYdEQMNtk
        VJ33hpu3XVLqc07ni0QIVtHGaBZEtetDvnuyLSn862ZwFoiAnIuVFLbiVUYvXijLAS3miGK/jj8si
        64/DY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gga79-0007qY-Od; Mon, 07 Jan 2019 18:59:07 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 5A6331127491; Mon,  7 Jan 2019 18:59:07 +0000 (GMT)
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
Subject: Applied "spi: stm32: rename STM32 SPI registers to STM32H7" to the spi tree
In-Reply-To:  <1545688840-23992-8-git-send-email-cezary.gapinski@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190107185907.5A6331127491@debutante.sirena.org.uk>
Date:   Mon,  7 Jan 2019 18:59:07 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: stm32: rename STM32 SPI registers to STM32H7

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

From 8602663096ce671802c1b90272f798a827dbe45d Mon Sep 17 00:00:00 2001
From: Cezary Gapinski <cezary.gapinski@gmail.com>
Date: Mon, 24 Dec 2018 23:00:33 +0100
Subject: [PATCH] spi: stm32: rename STM32 SPI registers to STM32H7

Rename STM32 SPI registers to be related to STM32H7 SPI driver
and not STM32 generally.

Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-stm32.c | 381 +++++++++++++++++++++-------------------
 1 file changed, 199 insertions(+), 182 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index b639be752fe6..2ece69a75ae4 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -20,86 +20,86 @@
 
 #define DRIVER_NAME "spi_stm32"
 
-/* STM32 SPI registers */
-#define STM32_SPI_CR1		0x00
-#define STM32_SPI_CR2		0x04
-#define STM32_SPI_CFG1		0x08
-#define STM32_SPI_CFG2		0x0C
-#define STM32_SPI_IER		0x10
-#define STM32_SPI_SR		0x14
-#define STM32_SPI_IFCR		0x18
-#define STM32_SPI_TXDR		0x20
-#define STM32_SPI_RXDR		0x30
-#define STM32_SPI_I2SCFGR	0x50
-
-/* STM32_SPI_CR1 bit fields */
-#define SPI_CR1_SPE		BIT(0)
-#define SPI_CR1_MASRX		BIT(8)
-#define SPI_CR1_CSTART		BIT(9)
-#define SPI_CR1_CSUSP		BIT(10)
-#define SPI_CR1_HDDIR		BIT(11)
-#define SPI_CR1_SSI		BIT(12)
-
-/* STM32_SPI_CR2 bit fields */
-#define SPI_CR2_TSIZE_SHIFT	0
-#define SPI_CR2_TSIZE		GENMASK(15, 0)
-
-/* STM32_SPI_CFG1 bit fields */
-#define SPI_CFG1_DSIZE_SHIFT	0
-#define SPI_CFG1_DSIZE		GENMASK(4, 0)
-#define SPI_CFG1_FTHLV_SHIFT	5
-#define SPI_CFG1_FTHLV		GENMASK(8, 5)
-#define SPI_CFG1_RXDMAEN	BIT(14)
-#define SPI_CFG1_TXDMAEN	BIT(15)
-#define SPI_CFG1_MBR_SHIFT	28
-#define SPI_CFG1_MBR		GENMASK(30, 28)
-#define SPI_CFG1_MBR_MIN	0
-#define SPI_CFG1_MBR_MAX	(GENMASK(30, 28) >> 28)
-
-/* STM32_SPI_CFG2 bit fields */
-#define SPI_CFG2_MIDI_SHIFT	4
-#define SPI_CFG2_MIDI		GENMASK(7, 4)
-#define SPI_CFG2_COMM_SHIFT	17
-#define SPI_CFG2_COMM		GENMASK(18, 17)
-#define SPI_CFG2_SP_SHIFT	19
-#define SPI_CFG2_SP		GENMASK(21, 19)
-#define SPI_CFG2_MASTER		BIT(22)
-#define SPI_CFG2_LSBFRST	BIT(23)
-#define SPI_CFG2_CPHA		BIT(24)
-#define SPI_CFG2_CPOL		BIT(25)
-#define SPI_CFG2_SSM		BIT(26)
-#define SPI_CFG2_AFCNTR		BIT(31)
-
-/* STM32_SPI_IER bit fields */
-#define SPI_IER_RXPIE		BIT(0)
-#define SPI_IER_TXPIE		BIT(1)
-#define SPI_IER_DXPIE		BIT(2)
-#define SPI_IER_EOTIE		BIT(3)
-#define SPI_IER_TXTFIE		BIT(4)
-#define SPI_IER_OVRIE		BIT(6)
-#define SPI_IER_MODFIE		BIT(9)
-#define SPI_IER_ALL		GENMASK(10, 0)
-
-/* STM32_SPI_SR bit fields */
-#define SPI_SR_RXP		BIT(0)
-#define SPI_SR_TXP		BIT(1)
-#define SPI_SR_EOT		BIT(3)
-#define SPI_SR_OVR		BIT(6)
-#define SPI_SR_MODF		BIT(9)
-#define SPI_SR_SUSP		BIT(11)
-#define SPI_SR_RXPLVL_SHIFT	13
-#define SPI_SR_RXPLVL		GENMASK(14, 13)
-#define SPI_SR_RXWNE		BIT(15)
-
-/* STM32_SPI_IFCR bit fields */
-#define SPI_IFCR_ALL		GENMASK(11, 3)
-
-/* STM32_SPI_I2SCFGR bit fields */
-#define SPI_I2SCFGR_I2SMOD	BIT(0)
-
-/* SPI Master Baud Rate min/max divisor */
-#define SPI_MBR_DIV_MIN		(2 << SPI_CFG1_MBR_MIN)
-#define SPI_MBR_DIV_MAX		(2 << SPI_CFG1_MBR_MAX)
+/* STM32H7 SPI registers */
+#define STM32H7_SPI_CR1			0x00
+#define STM32H7_SPI_CR2			0x04
+#define STM32H7_SPI_CFG1		0x08
+#define STM32H7_SPI_CFG2		0x0C
+#define STM32H7_SPI_IER			0x10
+#define STM32H7_SPI_SR			0x14
+#define STM32H7_SPI_IFCR		0x18
+#define STM32H7_SPI_TXDR		0x20
+#define STM32H7_SPI_RXDR		0x30
+#define STM32H7_SPI_I2SCFGR		0x50
+
+/* STM32H7_SPI_CR1 bit fields */
+#define STM32H7_SPI_CR1_SPE		BIT(0)
+#define STM32H7_SPI_CR1_MASRX		BIT(8)
+#define STM32H7_SPI_CR1_CSTART		BIT(9)
+#define STM32H7_SPI_CR1_CSUSP		BIT(10)
+#define STM32H7_SPI_CR1_HDDIR		BIT(11)
+#define STM32H7_SPI_CR1_SSI		BIT(12)
+
+/* STM32H7_SPI_CR2 bit fields */
+#define STM32H7_SPI_CR2_TSIZE_SHIFT	0
+#define STM32H7_SPI_CR2_TSIZE		GENMASK(15, 0)
+
+/* STM32H7_SPI_CFG1 bit fields */
+#define STM32H7_SPI_CFG1_DSIZE_SHIFT	0
+#define STM32H7_SPI_CFG1_DSIZE		GENMASK(4, 0)
+#define STM32H7_SPI_CFG1_FTHLV_SHIFT	5
+#define STM32H7_SPI_CFG1_FTHLV		GENMASK(8, 5)
+#define STM32H7_SPI_CFG1_RXDMAEN	BIT(14)
+#define STM32H7_SPI_CFG1_TXDMAEN	BIT(15)
+#define STM32H7_SPI_CFG1_MBR_SHIFT	28
+#define STM32H7_SPI_CFG1_MBR		GENMASK(30, 28)
+#define STM32H7_SPI_CFG1_MBR_MIN	0
+#define STM32H7_SPI_CFG1_MBR_MAX	(GENMASK(30, 28) >> 28)
+
+/* STM32H7_SPI_CFG2 bit fields */
+#define STM32H7_SPI_CFG2_MIDI_SHIFT	4
+#define STM32H7_SPI_CFG2_MIDI		GENMASK(7, 4)
+#define STM32H7_SPI_CFG2_COMM_SHIFT	17
+#define STM32H7_SPI_CFG2_COMM		GENMASK(18, 17)
+#define STM32H7_SPI_CFG2_SP_SHIFT	19
+#define STM32H7_SPI_CFG2_SP		GENMASK(21, 19)
+#define STM32H7_SPI_CFG2_MASTER		BIT(22)
+#define STM32H7_SPI_CFG2_LSBFRST	BIT(23)
+#define STM32H7_SPI_CFG2_CPHA		BIT(24)
+#define STM32H7_SPI_CFG2_CPOL		BIT(25)
+#define STM32H7_SPI_CFG2_SSM		BIT(26)
+#define STM32H7_SPI_CFG2_AFCNTR		BIT(31)
+
+/* STM32H7_SPI_IER bit fields */
+#define STM32H7_SPI_IER_RXPIE		BIT(0)
+#define STM32H7_SPI_IER_TXPIE		BIT(1)
+#define STM32H7_SPI_IER_DXPIE		BIT(2)
+#define STM32H7_SPI_IER_EOTIE		BIT(3)
+#define STM32H7_SPI_IER_TXTFIE		BIT(4)
+#define STM32H7_SPI_IER_OVRIE		BIT(6)
+#define STM32H7_SPI_IER_MODFIE		BIT(9)
+#define STM32H7_SPI_IER_ALL		GENMASK(10, 0)
+
+/* STM32H7_SPI_SR bit fields */
+#define STM32H7_SPI_SR_RXP		BIT(0)
+#define STM32H7_SPI_SR_TXP		BIT(1)
+#define STM32H7_SPI_SR_EOT		BIT(3)
+#define STM32H7_SPI_SR_OVR		BIT(6)
+#define STM32H7_SPI_SR_MODF		BIT(9)
+#define STM32H7_SPI_SR_SUSP		BIT(11)
+#define STM32H7_SPI_SR_RXPLVL_SHIFT	13
+#define STM32H7_SPI_SR_RXPLVL		GENMASK(14, 13)
+#define STM32H7_SPI_SR_RXWNE		BIT(15)
+
+/* STM32H7_SPI_IFCR bit fields */
+#define STM32H7_SPI_IFCR_ALL		GENMASK(11, 3)
+
+/* STM32H7_SPI_I2SCFGR bit fields */
+#define STM32H7_SPI_I2SCFGR_I2SMOD	BIT(0)
+
+/* STM32H7 SPI Master Baud Rate min/max divisor */
+#define STM32H7_SPI_MBR_DIV_MIN		(2 << STM32H7_SPI_CFG1_MBR_MIN)
+#define STM32H7_SPI_MBR_DIV_MAX		(2 << STM32H7_SPI_CFG1_MBR_MAX)
 
 /* SPI Communication mode */
 #define SPI_FULL_DUPLEX		0
@@ -188,12 +188,12 @@ static int stm32_spi_get_fifo_size(struct stm32_spi *spi)
 
 	spin_lock_irqsave(&spi->lock, flags);
 
-	stm32_spi_set_bits(spi, STM32_SPI_CR1, SPI_CR1_SPE);
+	stm32_spi_set_bits(spi, STM32H7_SPI_CR1, STM32H7_SPI_CR1_SPE);
 
-	while (readl_relaxed(spi->base + STM32_SPI_SR) & SPI_SR_TXP)
-		writeb_relaxed(++count, spi->base + STM32_SPI_TXDR);
+	while (readl_relaxed(spi->base + STM32H7_SPI_SR) & STM32H7_SPI_SR_TXP)
+		writeb_relaxed(++count, spi->base + STM32H7_SPI_TXDR);
 
-	stm32_spi_clr_bits(spi, STM32_SPI_CR1, SPI_CR1_SPE);
+	stm32_spi_clr_bits(spi, STM32H7_SPI_CR1, STM32H7_SPI_CR1_SPE);
 
 	spin_unlock_irqrestore(&spi->lock, flags);
 
@@ -217,10 +217,11 @@ static int stm32_spi_get_bpw_mask(struct stm32_spi *spi)
 	 * The most significant bit at DSIZE bit field is reserved when the
 	 * maximum data size of periperal instances is limited to 16-bit
 	 */
-	stm32_spi_set_bits(spi, STM32_SPI_CFG1, SPI_CFG1_DSIZE);
+	stm32_spi_set_bits(spi, STM32H7_SPI_CFG1, STM32H7_SPI_CFG1_DSIZE);
 
-	cfg1 = readl_relaxed(spi->base + STM32_SPI_CFG1);
-	max_bpw = (cfg1 & SPI_CFG1_DSIZE) >> SPI_CFG1_DSIZE_SHIFT;
+	cfg1 = readl_relaxed(spi->base + STM32H7_SPI_CFG1);
+	max_bpw = (cfg1 & STM32H7_SPI_CFG1_DSIZE) >>
+		  STM32H7_SPI_CFG1_DSIZE_SHIFT;
 	max_bpw += 1;
 
 	spin_unlock_irqrestore(&spi->lock, flags);
@@ -250,8 +251,8 @@ static int stm32_spi_prepare_mbr(struct stm32_spi *spi, u32 speed_hz)
 	 * no need to check it there.
 	 * However, we need to ensure the following calculations.
 	 */
-	if (div < SPI_MBR_DIV_MIN ||
-	    div > SPI_MBR_DIV_MAX)
+	if (div < STM32H7_SPI_MBR_DIV_MIN ||
+	    div > STM32H7_SPI_MBR_DIV_MAX)
 		return -EINVAL;
 
 	/* Determine the first power of 2 greater than or equal to div */
@@ -302,23 +303,24 @@ static u32 stm32_spi_prepare_fthlv(struct stm32_spi *spi)
 static void stm32_spi_write_txfifo(struct stm32_spi *spi)
 {
 	while ((spi->tx_len > 0) &&
-	       (readl_relaxed(spi->base + STM32_SPI_SR) & SPI_SR_TXP)) {
+		       (readl_relaxed(spi->base + STM32H7_SPI_SR) &
+			STM32H7_SPI_SR_TXP)) {
 		u32 offs = spi->cur_xferlen - spi->tx_len;
 
 		if (spi->tx_len >= sizeof(u32)) {
 			const u32 *tx_buf32 = (const u32 *)(spi->tx_buf + offs);
 
-			writel_relaxed(*tx_buf32, spi->base + STM32_SPI_TXDR);
+			writel_relaxed(*tx_buf32, spi->base + STM32H7_SPI_TXDR);
 			spi->tx_len -= sizeof(u32);
 		} else if (spi->tx_len >= sizeof(u16)) {
 			const u16 *tx_buf16 = (const u16 *)(spi->tx_buf + offs);
 
-			writew_relaxed(*tx_buf16, spi->base + STM32_SPI_TXDR);
+			writew_relaxed(*tx_buf16, spi->base + STM32H7_SPI_TXDR);
 			spi->tx_len -= sizeof(u16);
 		} else {
 			const u8 *tx_buf8 = (const u8 *)(spi->tx_buf + offs);
 
-			writeb_relaxed(*tx_buf8, spi->base + STM32_SPI_TXDR);
+			writeb_relaxed(*tx_buf8, spi->base + STM32H7_SPI_TXDR);
 			spi->tx_len -= sizeof(u8);
 		}
 	}
@@ -335,35 +337,37 @@ static void stm32_spi_write_txfifo(struct stm32_spi *spi)
  */
 static void stm32_spi_read_rxfifo(struct stm32_spi *spi, bool flush)
 {
-	u32 sr = readl_relaxed(spi->base + STM32_SPI_SR);
-	u32 rxplvl = (sr & SPI_SR_RXPLVL) >> SPI_SR_RXPLVL_SHIFT;
+	u32 sr = readl_relaxed(spi->base + STM32H7_SPI_SR);
+	u32 rxplvl = (sr & STM32H7_SPI_SR_RXPLVL) >>
+		     STM32H7_SPI_SR_RXPLVL_SHIFT;
 
 	while ((spi->rx_len > 0) &&
-	       ((sr & SPI_SR_RXP) ||
-		(flush && ((sr & SPI_SR_RXWNE) || (rxplvl > 0))))) {
+	       ((sr & STM32H7_SPI_SR_RXP) ||
+		(flush && ((sr & STM32H7_SPI_SR_RXWNE) || (rxplvl > 0))))) {
 		u32 offs = spi->cur_xferlen - spi->rx_len;
 
 		if ((spi->rx_len >= sizeof(u32)) ||
-		    (flush && (sr & SPI_SR_RXWNE))) {
+		    (flush && (sr & STM32H7_SPI_SR_RXWNE))) {
 			u32 *rx_buf32 = (u32 *)(spi->rx_buf + offs);
 
-			*rx_buf32 = readl_relaxed(spi->base + STM32_SPI_RXDR);
+			*rx_buf32 = readl_relaxed(spi->base + STM32H7_SPI_RXDR);
 			spi->rx_len -= sizeof(u32);
 		} else if ((spi->rx_len >= sizeof(u16)) ||
 			   (flush && (rxplvl >= 2 || spi->cur_bpw > 8))) {
 			u16 *rx_buf16 = (u16 *)(spi->rx_buf + offs);
 
-			*rx_buf16 = readw_relaxed(spi->base + STM32_SPI_RXDR);
+			*rx_buf16 = readw_relaxed(spi->base + STM32H7_SPI_RXDR);
 			spi->rx_len -= sizeof(u16);
 		} else {
 			u8 *rx_buf8 = (u8 *)(spi->rx_buf + offs);
 
-			*rx_buf8 = readb_relaxed(spi->base + STM32_SPI_RXDR);
+			*rx_buf8 = readb_relaxed(spi->base + STM32H7_SPI_RXDR);
 			spi->rx_len -= sizeof(u8);
 		}
 
-		sr = readl_relaxed(spi->base + STM32_SPI_SR);
-		rxplvl = (sr & SPI_SR_RXPLVL) >> SPI_SR_RXPLVL_SHIFT;
+		sr = readl_relaxed(spi->base + STM32H7_SPI_SR);
+		rxplvl = (sr & STM32H7_SPI_SR_RXPLVL) >>
+			 STM32H7_SPI_SR_RXPLVL_SHIFT;
 	}
 
 	dev_dbg(spi->dev, "%s%s: %d bytes left\n", __func__,
@@ -381,7 +385,7 @@ static void stm32_spi_enable(struct stm32_spi *spi)
 {
 	dev_dbg(spi->dev, "enable controller\n");
 
-	stm32_spi_set_bits(spi, STM32_SPI_CR1, SPI_CR1_SPE);
+	stm32_spi_set_bits(spi, STM32H7_SPI_CR1, STM32H7_SPI_CR1_SPE);
 }
 
 /**
@@ -401,23 +405,23 @@ static void stm32_spi_disable(struct stm32_spi *spi)
 
 	spin_lock_irqsave(&spi->lock, flags);
 
-	cr1 = readl_relaxed(spi->base + STM32_SPI_CR1);
+	cr1 = readl_relaxed(spi->base + STM32H7_SPI_CR1);
 
-	if (!(cr1 & SPI_CR1_SPE)) {
+	if (!(cr1 & STM32H7_SPI_CR1_SPE)) {
 		spin_unlock_irqrestore(&spi->lock, flags);
 		return;
 	}
 
 	/* Wait on EOT or suspend the flow */
-	if (readl_relaxed_poll_timeout_atomic(spi->base + STM32_SPI_SR,
-					      sr, !(sr & SPI_SR_EOT),
+	if (readl_relaxed_poll_timeout_atomic(spi->base + STM32H7_SPI_SR,
+					      sr, !(sr & STM32H7_SPI_SR_EOT),
 					      10, 100000) < 0) {
-		if (cr1 & SPI_CR1_CSTART) {
-			writel_relaxed(cr1 | SPI_CR1_CSUSP,
-				       spi->base + STM32_SPI_CR1);
+		if (cr1 & STM32H7_SPI_CR1_CSTART) {
+			writel_relaxed(cr1 | STM32H7_SPI_CR1_CSUSP,
+				       spi->base + STM32H7_SPI_CR1);
 			if (readl_relaxed_poll_timeout_atomic(
-						spi->base + STM32_SPI_SR,
-						sr, !(sr & SPI_SR_SUSP),
+						spi->base + STM32H7_SPI_SR,
+						sr, !(sr & STM32H7_SPI_SR_SUSP),
 						10, 100000) < 0)
 				dev_warn(spi->dev,
 					 "Suspend request timeout\n");
@@ -432,14 +436,14 @@ static void stm32_spi_disable(struct stm32_spi *spi)
 	if (spi->cur_usedma && spi->dma_rx)
 		dmaengine_terminate_all(spi->dma_rx);
 
-	stm32_spi_clr_bits(spi, STM32_SPI_CR1, SPI_CR1_SPE);
+	stm32_spi_clr_bits(spi, STM32H7_SPI_CR1, STM32H7_SPI_CR1_SPE);
 
-	stm32_spi_clr_bits(spi, STM32_SPI_CFG1, SPI_CFG1_TXDMAEN |
-						SPI_CFG1_RXDMAEN);
+	stm32_spi_clr_bits(spi, STM32H7_SPI_CFG1, STM32H7_SPI_CFG1_TXDMAEN |
+						STM32H7_SPI_CFG1_RXDMAEN);
 
 	/* Disable interrupts and clear status flags */
-	writel_relaxed(0, spi->base + STM32_SPI_IER);
-	writel_relaxed(SPI_IFCR_ALL, spi->base + STM32_SPI_IFCR);
+	writel_relaxed(0, spi->base + STM32H7_SPI_IER);
+	writel_relaxed(STM32H7_SPI_IFCR_ALL, spi->base + STM32H7_SPI_IFCR);
 
 	spin_unlock_irqrestore(&spi->lock, flags);
 }
@@ -476,19 +480,19 @@ static irqreturn_t stm32_spi_irq(int irq, void *dev_id)
 
 	spin_lock_irqsave(&spi->lock, flags);
 
-	sr = readl_relaxed(spi->base + STM32_SPI_SR);
-	ier = readl_relaxed(spi->base + STM32_SPI_IER);
+	sr = readl_relaxed(spi->base + STM32H7_SPI_SR);
+	ier = readl_relaxed(spi->base + STM32H7_SPI_IER);
 
 	mask = ier;
 	/* EOTIE is triggered on EOT, SUSP and TXC events. */
-	mask |= SPI_SR_SUSP;
+	mask |= STM32H7_SPI_SR_SUSP;
 	/*
 	 * When TXTF is set, DXPIE and TXPIE are cleared. So in case of
 	 * Full-Duplex, need to poll RXP event to know if there are remaining
 	 * data, before disabling SPI.
 	 */
 	if (spi->rx_buf && !spi->cur_usedma)
-		mask |= SPI_SR_RXP;
+		mask |= STM32H7_SPI_SR_RXP;
 
 	if (!(sr & mask)) {
 		dev_dbg(spi->dev, "spurious IT (sr=0x%08x, ier=0x%08x)\n",
@@ -497,7 +501,7 @@ static irqreturn_t stm32_spi_irq(int irq, void *dev_id)
 		return IRQ_NONE;
 	}
 
-	if (sr & SPI_SR_SUSP) {
+	if (sr & STM32H7_SPI_SR_SUSP) {
 		dev_warn(spi->dev, "Communication suspended\n");
 		if (!spi->cur_usedma && (spi->rx_buf && (spi->rx_len > 0)))
 			stm32_spi_read_rxfifo(spi, false);
@@ -509,12 +513,12 @@ static irqreturn_t stm32_spi_irq(int irq, void *dev_id)
 			end = true;
 	}
 
-	if (sr & SPI_SR_MODF) {
+	if (sr & STM32H7_SPI_SR_MODF) {
 		dev_warn(spi->dev, "Mode fault: transfer aborted\n");
 		end = true;
 	}
 
-	if (sr & SPI_SR_OVR) {
+	if (sr & STM32H7_SPI_SR_OVR) {
 		dev_warn(spi->dev, "Overrun: received value discarded\n");
 		if (!spi->cur_usedma && (spi->rx_buf && (spi->rx_len > 0)))
 			stm32_spi_read_rxfifo(spi, false);
@@ -526,21 +530,21 @@ static irqreturn_t stm32_spi_irq(int irq, void *dev_id)
 			end = true;
 	}
 
-	if (sr & SPI_SR_EOT) {
+	if (sr & STM32H7_SPI_SR_EOT) {
 		if (!spi->cur_usedma && (spi->rx_buf && (spi->rx_len > 0)))
 			stm32_spi_read_rxfifo(spi, true);
 		end = true;
 	}
 
-	if (sr & SPI_SR_TXP)
+	if (sr & STM32H7_SPI_SR_TXP)
 		if (!spi->cur_usedma && (spi->tx_buf && (spi->tx_len > 0)))
 			stm32_spi_write_txfifo(spi);
 
-	if (sr & SPI_SR_RXP)
+	if (sr & STM32H7_SPI_SR_RXP)
 		if (!spi->cur_usedma && (spi->rx_buf && (spi->rx_len > 0)))
 			stm32_spi_read_rxfifo(spi, false);
 
-	writel_relaxed(mask, spi->base + STM32_SPI_IFCR);
+	writel_relaxed(mask, spi->base + STM32H7_SPI_IFCR);
 
 	spin_unlock_irqrestore(&spi->lock, flags);
 
@@ -593,19 +597,19 @@ static int stm32_spi_prepare_msg(struct spi_master *master,
 		dev_dbg(spi->dev, "%dns inter-data idleness\n", spi->cur_midi);
 
 	if (spi_dev->mode & SPI_CPOL)
-		cfg2_setb |= SPI_CFG2_CPOL;
+		cfg2_setb |= STM32H7_SPI_CFG2_CPOL;
 	else
-		cfg2_clrb |= SPI_CFG2_CPOL;
+		cfg2_clrb |= STM32H7_SPI_CFG2_CPOL;
 
 	if (spi_dev->mode & SPI_CPHA)
-		cfg2_setb |= SPI_CFG2_CPHA;
+		cfg2_setb |= STM32H7_SPI_CFG2_CPHA;
 	else
-		cfg2_clrb |= SPI_CFG2_CPHA;
+		cfg2_clrb |= STM32H7_SPI_CFG2_CPHA;
 
 	if (spi_dev->mode & SPI_LSB_FIRST)
-		cfg2_setb |= SPI_CFG2_LSBFRST;
+		cfg2_setb |= STM32H7_SPI_CFG2_LSBFRST;
 	else
-		cfg2_clrb |= SPI_CFG2_LSBFRST;
+		cfg2_clrb |= STM32H7_SPI_CFG2_LSBFRST;
 
 	dev_dbg(spi->dev, "cpol=%d cpha=%d lsb_first=%d cs_high=%d\n",
 		spi_dev->mode & SPI_CPOL,
@@ -617,9 +621,9 @@ static int stm32_spi_prepare_msg(struct spi_master *master,
 
 	if (cfg2_clrb || cfg2_setb)
 		writel_relaxed(
-			(readl_relaxed(spi->base + STM32_SPI_CFG2) &
+			(readl_relaxed(spi->base + STM32H7_SPI_CFG2) &
 				~cfg2_clrb) | cfg2_setb,
-			       spi->base + STM32_SPI_CFG2);
+			       spi->base + STM32H7_SPI_CFG2);
 
 	spin_unlock_irqrestore(&spi->lock, flags);
 
@@ -640,11 +644,11 @@ static void stm32_spi_dma_cb(void *data)
 
 	spin_lock_irqsave(&spi->lock, flags);
 
-	sr = readl_relaxed(spi->base + STM32_SPI_SR);
+	sr = readl_relaxed(spi->base + STM32H7_SPI_SR);
 
 	spin_unlock_irqrestore(&spi->lock, flags);
 
-	if (!(sr & SPI_SR_EOT))
+	if (!(sr & STM32H7_SPI_SR_EOT))
 		dev_warn(spi->dev, "DMA error (sr=0x%08x)\n", sr);
 
 	/* Now wait for EOT, or SUSP or OVR in case of error */
@@ -677,14 +681,14 @@ static void stm32_spi_dma_config(struct stm32_spi *spi,
 	memset(dma_conf, 0, sizeof(struct dma_slave_config));
 	dma_conf->direction = dir;
 	if (dma_conf->direction == DMA_DEV_TO_MEM) { /* RX */
-		dma_conf->src_addr = spi->phys_addr + STM32_SPI_RXDR;
+		dma_conf->src_addr = spi->phys_addr + STM32H7_SPI_RXDR;
 		dma_conf->src_addr_width = buswidth;
 		dma_conf->src_maxburst = maxburst;
 
 		dev_dbg(spi->dev, "Rx DMA config buswidth=%d, maxburst=%d\n",
 			buswidth, maxburst);
 	} else if (dma_conf->direction == DMA_MEM_TO_DEV) { /* TX */
-		dma_conf->dst_addr = spi->phys_addr + STM32_SPI_TXDR;
+		dma_conf->dst_addr = spi->phys_addr + STM32H7_SPI_TXDR;
 		dma_conf->dst_addr_width = buswidth;
 		dma_conf->dst_maxburst = maxburst;
 
@@ -707,14 +711,15 @@ static int stm32_spi_transfer_one_irq(struct stm32_spi *spi)
 
 	/* Enable the interrupts relative to the current communication mode */
 	if (spi->tx_buf && spi->rx_buf)	/* Full Duplex */
-		ier |= SPI_IER_DXPIE;
+		ier |= STM32H7_SPI_IER_DXPIE;
 	else if (spi->tx_buf)		/* Half-Duplex TX dir or Simplex TX */
-		ier |= SPI_IER_TXPIE;
+		ier |= STM32H7_SPI_IER_TXPIE;
 	else if (spi->rx_buf)		/* Half-Duplex RX dir or Simplex RX */
-		ier |= SPI_IER_RXPIE;
+		ier |= STM32H7_SPI_IER_RXPIE;
 
 	/* Enable the interrupts relative to the end of transfer */
-	ier |= SPI_IER_EOTIE | SPI_IER_TXTFIE |	SPI_IER_OVRIE |	SPI_IER_MODFIE;
+	ier |= STM32H7_SPI_IER_EOTIE | STM32H7_SPI_IER_TXTFIE |
+	       STM32H7_SPI_IER_OVRIE | STM32H7_SPI_IER_MODFIE;
 
 	spin_lock_irqsave(&spi->lock, flags);
 
@@ -724,9 +729,9 @@ static int stm32_spi_transfer_one_irq(struct stm32_spi *spi)
 	if (spi->tx_buf)
 		stm32_spi_write_txfifo(spi);
 
-	stm32_spi_set_bits(spi, STM32_SPI_CR1, SPI_CR1_CSTART);
+	stm32_spi_set_bits(spi, STM32H7_SPI_CR1, STM32H7_SPI_CR1_CSTART);
 
-	writel_relaxed(ier, spi->base + STM32_SPI_IER);
+	writel_relaxed(ier, spi->base + STM32H7_SPI_IER);
 
 	spin_unlock_irqrestore(&spi->lock, flags);
 
@@ -755,7 +760,8 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 		dmaengine_slave_config(spi->dma_rx, &rx_dma_conf);
 
 		/* Enable Rx DMA request */
-		stm32_spi_set_bits(spi, STM32_SPI_CFG1, SPI_CFG1_RXDMAEN);
+		stm32_spi_set_bits(spi, STM32H7_SPI_CFG1,
+				   STM32H7_SPI_CFG1_RXDMAEN);
 
 		rx_dma_desc = dmaengine_prep_slave_sg(
 					spi->dma_rx, xfer->rx_sg.sgl,
@@ -809,16 +815,18 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 		dma_async_issue_pending(spi->dma_tx);
 
 		/* Enable Tx DMA request */
-		stm32_spi_set_bits(spi, STM32_SPI_CFG1, SPI_CFG1_TXDMAEN);
+		stm32_spi_set_bits(spi, STM32H7_SPI_CFG1,
+				   STM32H7_SPI_CFG1_TXDMAEN);
 	}
 
 	/* Enable the interrupts relative to the end of transfer */
-	ier |= SPI_IER_EOTIE | SPI_IER_TXTFIE |	SPI_IER_OVRIE |	SPI_IER_MODFIE;
-	writel_relaxed(ier, spi->base + STM32_SPI_IER);
+	ier |= STM32H7_SPI_IER_EOTIE | STM32H7_SPI_IER_TXTFIE |
+	       STM32H7_SPI_IER_OVRIE | STM32H7_SPI_IER_MODFIE;
+	writel_relaxed(ier, spi->base + STM32H7_SPI_IER);
 
 	stm32_spi_enable(spi);
 
-	stm32_spi_set_bits(spi, STM32_SPI_CR1, SPI_CR1_CSTART);
+	stm32_spi_set_bits(spi, STM32H7_SPI_CR1, STM32H7_SPI_CR1_CSTART);
 
 	spin_unlock_irqrestore(&spi->lock, flags);
 
@@ -829,7 +837,7 @@ static int stm32_spi_transfer_one_dma(struct stm32_spi *spi,
 		dmaengine_terminate_all(spi->dma_rx);
 
 dma_desc_error:
-	stm32_spi_clr_bits(spi, STM32_SPI_CFG1, SPI_CFG1_RXDMAEN);
+	stm32_spi_clr_bits(spi, STM32H7_SPI_CFG1, STM32H7_SPI_CFG1_RXDMAEN);
 
 	spin_unlock_irqrestore(&spi->lock, flags);
 
@@ -861,14 +869,16 @@ static int stm32_spi_transfer_one_setup(struct stm32_spi *spi,
 		spi->cur_bpw = transfer->bits_per_word;
 		bpw = spi->cur_bpw - 1;
 
-		cfg1_clrb |= SPI_CFG1_DSIZE;
-		cfg1_setb |= (bpw << SPI_CFG1_DSIZE_SHIFT) & SPI_CFG1_DSIZE;
+		cfg1_clrb |= STM32H7_SPI_CFG1_DSIZE;
+		cfg1_setb |= (bpw << STM32H7_SPI_CFG1_DSIZE_SHIFT) &
+			     STM32H7_SPI_CFG1_DSIZE;
 
 		spi->cur_fthlv = stm32_spi_prepare_fthlv(spi);
 		fthlv = spi->cur_fthlv - 1;
 
-		cfg1_clrb |= SPI_CFG1_FTHLV;
-		cfg1_setb |= (fthlv << SPI_CFG1_FTHLV_SHIFT) & SPI_CFG1_FTHLV;
+		cfg1_clrb |= STM32H7_SPI_CFG1_FTHLV;
+		cfg1_setb |= (fthlv << STM32H7_SPI_CFG1_FTHLV_SHIFT) &
+			     STM32H7_SPI_CFG1_FTHLV;
 	}
 
 	if (spi->cur_speed != transfer->speed_hz) {
@@ -883,14 +893,15 @@ static int stm32_spi_transfer_one_setup(struct stm32_spi *spi,
 
 		transfer->speed_hz = spi->cur_speed;
 
-		cfg1_clrb |= SPI_CFG1_MBR;
-		cfg1_setb |= ((u32)mbr << SPI_CFG1_MBR_SHIFT) & SPI_CFG1_MBR;
+		cfg1_clrb |= STM32H7_SPI_CFG1_MBR;
+		cfg1_setb |= ((u32)mbr << STM32H7_SPI_CFG1_MBR_SHIFT) &
+			     STM32H7_SPI_CFG1_MBR;
 	}
 
 	if (cfg1_clrb || cfg1_setb)
-		writel_relaxed((readl_relaxed(spi->base + STM32_SPI_CFG1) &
+		writel_relaxed((readl_relaxed(spi->base + STM32H7_SPI_CFG1) &
 				~cfg1_clrb) | cfg1_setb,
-			       spi->base + STM32_SPI_CFG1);
+			       spi->base + STM32H7_SPI_CFG1);
 
 	mode = SPI_FULL_DUPLEX;
 	if (spi_dev->mode & SPI_3WIRE) { /* MISO/MOSI signals shared */
@@ -902,9 +913,11 @@ static int stm32_spi_transfer_one_setup(struct stm32_spi *spi,
 		 */
 		mode = SPI_HALF_DUPLEX;
 		if (!transfer->tx_buf)
-			stm32_spi_clr_bits(spi, STM32_SPI_CR1, SPI_CR1_HDDIR);
+			stm32_spi_clr_bits(spi, STM32H7_SPI_CR1,
+					   STM32H7_SPI_CR1_HDDIR);
 		else if (!transfer->rx_buf)
-			stm32_spi_set_bits(spi, STM32_SPI_CR1, SPI_CR1_HDDIR);
+			stm32_spi_set_bits(spi, STM32H7_SPI_CR1,
+					   STM32H7_SPI_CR1_HDDIR);
 	} else {
 		if (!transfer->tx_buf)
 			mode = SPI_SIMPLEX_RX;
@@ -914,26 +927,29 @@ static int stm32_spi_transfer_one_setup(struct stm32_spi *spi,
 	if (spi->cur_comm != mode) {
 		spi->cur_comm = mode;
 
-		cfg2_clrb |= SPI_CFG2_COMM;
-		cfg2_setb |= (mode << SPI_CFG2_COMM_SHIFT) & SPI_CFG2_COMM;
+		cfg2_clrb |= STM32H7_SPI_CFG2_COMM;
+		cfg2_setb |= (mode << STM32H7_SPI_CFG2_COMM_SHIFT) &
+			     STM32H7_SPI_CFG2_COMM;
 	}
 
-	cfg2_clrb |= SPI_CFG2_MIDI;
+	cfg2_clrb |= STM32H7_SPI_CFG2_MIDI;
 	if ((transfer->len > 1) && (spi->cur_midi > 0)) {
 		u32 sck_period_ns = DIV_ROUND_UP(SPI_1HZ_NS, spi->cur_speed);
 		u32 midi = min((u32)DIV_ROUND_UP(spi->cur_midi, sck_period_ns),
-			       (u32)SPI_CFG2_MIDI >> SPI_CFG2_MIDI_SHIFT);
+			       (u32)STM32H7_SPI_CFG2_MIDI >>
+			       STM32H7_SPI_CFG2_MIDI_SHIFT);
 
 		dev_dbg(spi->dev, "period=%dns, midi=%d(=%dns)\n",
 			sck_period_ns, midi, midi * sck_period_ns);
 
-		cfg2_setb |= (midi << SPI_CFG2_MIDI_SHIFT) & SPI_CFG2_MIDI;
+		cfg2_setb |= (midi << STM32H7_SPI_CFG2_MIDI_SHIFT) &
+			     STM32H7_SPI_CFG2_MIDI;
 	}
 
 	if (cfg2_clrb || cfg2_setb)
-		writel_relaxed((readl_relaxed(spi->base + STM32_SPI_CFG2) &
+		writel_relaxed((readl_relaxed(spi->base + STM32H7_SPI_CFG2) &
 				~cfg2_clrb) | cfg2_setb,
-			       spi->base + STM32_SPI_CFG2);
+			       spi->base + STM32H7_SPI_CFG2);
 
 	if (spi->cur_bpw <= 8)
 		nb_words = transfer->len;
@@ -941,10 +957,10 @@ static int stm32_spi_transfer_one_setup(struct stm32_spi *spi,
 		nb_words = DIV_ROUND_UP(transfer->len * 8, 16);
 	else
 		nb_words = DIV_ROUND_UP(transfer->len * 8, 32);
-	nb_words <<= SPI_CR2_TSIZE_SHIFT;
+	nb_words <<= STM32H7_SPI_CR2_TSIZE_SHIFT;
 
-	if (nb_words <= SPI_CR2_TSIZE) {
-		writel_relaxed(nb_words, spi->base + STM32_SPI_CR2);
+	if (nb_words <= STM32H7_SPI_CR2_TSIZE) {
+		writel_relaxed(nb_words, spi->base + STM32H7_SPI_CR2);
 	} else {
 		ret = -EMSGSIZE;
 		goto out;
@@ -1030,16 +1046,17 @@ static int stm32_spi_config(struct stm32_spi *spi)
 	spin_lock_irqsave(&spi->lock, flags);
 
 	/* Ensure I2SMOD bit is kept cleared */
-	stm32_spi_clr_bits(spi, STM32_SPI_I2SCFGR, SPI_I2SCFGR_I2SMOD);
+	stm32_spi_clr_bits(spi, STM32H7_SPI_I2SCFGR,
+			   STM32H7_SPI_I2SCFGR_I2SMOD);
 
 	/*
 	 * - SS input value high
 	 * - transmitter half duplex direction
 	 * - automatic communication suspend when RX-Fifo is full
 	 */
-	stm32_spi_set_bits(spi, STM32_SPI_CR1, SPI_CR1_SSI |
-					       SPI_CR1_HDDIR |
-					       SPI_CR1_MASRX);
+	stm32_spi_set_bits(spi, STM32H7_SPI_CR1, STM32H7_SPI_CR1_SSI |
+						 STM32H7_SPI_CR1_HDDIR |
+						 STM32H7_SPI_CR1_MASRX);
 
 	/*
 	 * - Set the master mode (default Motorola mode)
@@ -1047,9 +1064,9 @@ static int stm32_spi_config(struct stm32_spi *spi)
 	 *   SS input value is determined by the SSI bit
 	 * - keep control of all associated GPIOs
 	 */
-	stm32_spi_set_bits(spi, STM32_SPI_CFG2, SPI_CFG2_MASTER |
-						SPI_CFG2_SSM |
-						SPI_CFG2_AFCNTR);
+	stm32_spi_set_bits(spi, STM32H7_SPI_CFG2, STM32H7_SPI_CFG2_MASTER |
+						  STM32H7_SPI_CFG2_SSM |
+						  STM32H7_SPI_CFG2_AFCNTR);
 
 	spin_unlock_irqrestore(&spi->lock, flags);
 
@@ -1145,8 +1162,8 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	master->mode_bits = SPI_CPHA | SPI_CPOL | SPI_CS_HIGH | SPI_LSB_FIRST |
 			    SPI_3WIRE;
 	master->bits_per_word_mask = stm32_spi_get_bpw_mask(spi);
-	master->max_speed_hz = spi->clk_rate / SPI_MBR_DIV_MIN;
-	master->min_speed_hz = spi->clk_rate / SPI_MBR_DIV_MAX;
+	master->max_speed_hz = spi->clk_rate / STM32H7_SPI_MBR_DIV_MIN;
+	master->min_speed_hz = spi->clk_rate / STM32H7_SPI_MBR_DIV_MAX;
 	master->setup = stm32_spi_setup;
 	master->prepare_message = stm32_spi_prepare_msg;
 	master->transfer_one = stm32_spi_transfer_one;
-- 
2.20.1

