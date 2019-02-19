Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16250C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9FC2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550661268;
	bh=6kiD0lIpLWPLH2+0ZYIjAsx6Lv6Q6VJA1IFCOFihcpY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=x/xmGagyISllJ5VjfQt6AMWVi1Ggo5NmG+pDJlHvrprT+1i4U4pg1PWfRX4XXBpYL
	 qwIn7UYAIf9JlheFRQeTDj8eB6I4yvB+NOFcer7LtvhIb6YoKxyCUaDVBsvPc5OLRi
	 Eg1EESdazjLUTOOqc4Xun3AsMmM7bRGg73PAeq0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfBTLOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:14:19 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45004 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbfBTLNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:13:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=HAE8MdF80EncqTiXtY1txFGVRlxhgHG/bodsxLT4sAc=; b=qu9EYvw4DGFN
        9XXGp7jah8OURYbv3DyxUJGcvhBvcW3oB2j4KhL4hdq8L3c6h1pmHgF3GNgLEoeQsAcTAt2bwCqu+
        JoI+dOji5UwsKHZJm6v8144TjJia+KFUhdxUCXMWRbrdaHVOPR9Q1RFQ808BEP1WHsMmxNNZ4OxpM
        nx1Xs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gwPom-00011p-EP; Wed, 20 Feb 2019 11:13:36 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 7091211284D5; Tue, 19 Feb 2019 15:50:46 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Mark Brown <broonie@kernel.org>, palmer@sifive.com,
        linux-spi@vger.kernel.org, linux-riscv@lists.infradead.org,
        broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, paul.walmsley@sifive.com,
        linux-spi@vger.kernel.org
Subject: Applied "spi: sifive: Add driver for the SiFive SPI controller" to the spi tree
In-Reply-To:  <1550576407-17778-3-git-send-email-yash.shah@sifive.com>
X-Patchwork-Hint: ignore
Message-Id: <20190219155046.7091211284D5@debutante.sirena.org.uk>
Date:   Tue, 19 Feb 2019 15:50:46 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: sifive: Add driver for the SiFive SPI controller

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

From 484a9a68d669f899657a97dbb369cb3e3be7e7f5 Mon Sep 17 00:00:00 2001
From: Yash Shah <yash.shah@sifive.com>
Date: Tue, 19 Feb 2019 17:10:07 +0530
Subject: [PATCH] spi: sifive: Add driver for the SiFive SPI controller

Add driver for the SiFive SPI controller
on the HiFive Unleashed board.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Yash Shah <yash.shah@sifive.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/Kconfig      |   6 +
 drivers/spi/Makefile     |   1 +
 drivers/spi/spi-sifive.c | 450 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 457 insertions(+)
 create mode 100644 drivers/spi/spi-sifive.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 17d79b91d7a8..f761655e2a36 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -651,6 +651,12 @@ config SPI_SH_HSPI
 	help
 	  SPI driver for SuperH HSPI blocks.
 
+config SPI_SIFIVE
+	tristate "SiFive SPI controller"
+	depends on HAS_IOMEM
+	help
+	  This exposes the SPI controller IP from SiFive.
+
 config SPI_SIRF
 	tristate "CSR SiRFprimaII SPI controller"
 	depends on SIRF_DMA
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 5c5af4676279..d8fc03c9faa2 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -95,6 +95,7 @@ obj-$(CONFIG_SPI_SH)			+= spi-sh.o
 obj-$(CONFIG_SPI_SH_HSPI)		+= spi-sh-hspi.o
 obj-$(CONFIG_SPI_SH_MSIOF)		+= spi-sh-msiof.o
 obj-$(CONFIG_SPI_SH_SCI)		+= spi-sh-sci.o
+obj-$(CONFIG_SPI_SIFIVE)		+= spi-sifive.o
 obj-$(CONFIG_SPI_SIRF)		+= spi-sirf.o
 obj-$(CONFIG_SPI_SLAVE_MT27XX)          += spi-slave-mt27xx.o
 obj-$(CONFIG_SPI_SPRD)			+= spi-sprd.o
diff --git a/drivers/spi/spi-sifive.c b/drivers/spi/spi-sifive.c
new file mode 100644
index 000000000000..961307c4a613
--- /dev/null
+++ b/drivers/spi/spi-sifive.c
@@ -0,0 +1,450 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright 2018 SiFive, Inc.
+//
+// SiFive SPI controller driver (master mode only)
+//
+// Author: SiFive, Inc.
+// sifive@sifive.com
+
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <linux/io.h>
+#include <linux/log2.h>
+
+#define SIFIVE_SPI_DRIVER_NAME           "sifive_spi"
+
+#define SIFIVE_SPI_MAX_CS                32
+#define SIFIVE_SPI_DEFAULT_DEPTH         8
+#define SIFIVE_SPI_DEFAULT_MAX_BITS      8
+
+/* register offsets */
+#define SIFIVE_SPI_REG_SCKDIV            0x00 /* Serial clock divisor */
+#define SIFIVE_SPI_REG_SCKMODE           0x04 /* Serial clock mode */
+#define SIFIVE_SPI_REG_CSID              0x10 /* Chip select ID */
+#define SIFIVE_SPI_REG_CSDEF             0x14 /* Chip select default */
+#define SIFIVE_SPI_REG_CSMODE            0x18 /* Chip select mode */
+#define SIFIVE_SPI_REG_DELAY0            0x28 /* Delay control 0 */
+#define SIFIVE_SPI_REG_DELAY1            0x2c /* Delay control 1 */
+#define SIFIVE_SPI_REG_FMT               0x40 /* Frame format */
+#define SIFIVE_SPI_REG_TXDATA            0x48 /* Tx FIFO data */
+#define SIFIVE_SPI_REG_RXDATA            0x4c /* Rx FIFO data */
+#define SIFIVE_SPI_REG_TXMARK            0x50 /* Tx FIFO watermark */
+#define SIFIVE_SPI_REG_RXMARK            0x54 /* Rx FIFO watermark */
+#define SIFIVE_SPI_REG_FCTRL             0x60 /* SPI flash interface control */
+#define SIFIVE_SPI_REG_FFMT              0x64 /* SPI flash instruction format */
+#define SIFIVE_SPI_REG_IE                0x70 /* Interrupt Enable Register */
+#define SIFIVE_SPI_REG_IP                0x74 /* Interrupt Pendings Register */
+
+/* sckdiv bits */
+#define SIFIVE_SPI_SCKDIV_DIV_MASK       0xfffU
+
+/* sckmode bits */
+#define SIFIVE_SPI_SCKMODE_PHA           BIT(0)
+#define SIFIVE_SPI_SCKMODE_POL           BIT(1)
+#define SIFIVE_SPI_SCKMODE_MODE_MASK     (SIFIVE_SPI_SCKMODE_PHA | \
+					  SIFIVE_SPI_SCKMODE_POL)
+
+/* csmode bits */
+#define SIFIVE_SPI_CSMODE_MODE_AUTO      0U
+#define SIFIVE_SPI_CSMODE_MODE_HOLD      2U
+#define SIFIVE_SPI_CSMODE_MODE_OFF       3U
+
+/* delay0 bits */
+#define SIFIVE_SPI_DELAY0_CSSCK(x)       ((u32)(x))
+#define SIFIVE_SPI_DELAY0_CSSCK_MASK     0xffU
+#define SIFIVE_SPI_DELAY0_SCKCS(x)       ((u32)(x) << 16)
+#define SIFIVE_SPI_DELAY0_SCKCS_MASK     (0xffU << 16)
+
+/* delay1 bits */
+#define SIFIVE_SPI_DELAY1_INTERCS(x)     ((u32)(x))
+#define SIFIVE_SPI_DELAY1_INTERCS_MASK   0xffU
+#define SIFIVE_SPI_DELAY1_INTERXFR(x)    ((u32)(x) << 16)
+#define SIFIVE_SPI_DELAY1_INTERXFR_MASK  (0xffU << 16)
+
+/* fmt bits */
+#define SIFIVE_SPI_FMT_PROTO_SINGLE      0U
+#define SIFIVE_SPI_FMT_PROTO_DUAL        1U
+#define SIFIVE_SPI_FMT_PROTO_QUAD        2U
+#define SIFIVE_SPI_FMT_PROTO_MASK        3U
+#define SIFIVE_SPI_FMT_ENDIAN            BIT(2)
+#define SIFIVE_SPI_FMT_DIR               BIT(3)
+#define SIFIVE_SPI_FMT_LEN(x)            ((u32)(x) << 16)
+#define SIFIVE_SPI_FMT_LEN_MASK          (0xfU << 16)
+
+/* txdata bits */
+#define SIFIVE_SPI_TXDATA_DATA_MASK      0xffU
+#define SIFIVE_SPI_TXDATA_FULL           BIT(31)
+
+/* rxdata bits */
+#define SIFIVE_SPI_RXDATA_DATA_MASK      0xffU
+#define SIFIVE_SPI_RXDATA_EMPTY          BIT(31)
+
+/* ie and ip bits */
+#define SIFIVE_SPI_IP_TXWM               BIT(0)
+#define SIFIVE_SPI_IP_RXWM               BIT(1)
+
+struct sifive_spi {
+	void __iomem      *regs;        /* virt. address of control registers */
+	struct clk        *clk;         /* bus clock */
+	unsigned int      fifo_depth;   /* fifo depth in words */
+	u32               cs_inactive;  /* level of the CS pins when inactive */
+	struct completion done;         /* wake-up from interrupt */
+};
+
+static void sifive_spi_write(struct sifive_spi *spi, int offset, u32 value)
+{
+	iowrite32(value, spi->regs + offset);
+}
+
+static u32 sifive_spi_read(struct sifive_spi *spi, int offset)
+{
+	return ioread32(spi->regs + offset);
+}
+
+static void sifive_spi_init(struct sifive_spi *spi)
+{
+	/* Watermark interrupts are disabled by default */
+	sifive_spi_write(spi, SIFIVE_SPI_REG_IE, 0);
+
+	/* Default watermark FIFO threshold values */
+	sifive_spi_write(spi, SIFIVE_SPI_REG_TXMARK, 1);
+	sifive_spi_write(spi, SIFIVE_SPI_REG_RXMARK, 0);
+
+	/* Set CS/SCK Delays and Inactive Time to defaults */
+	sifive_spi_write(spi, SIFIVE_SPI_REG_DELAY0,
+			 SIFIVE_SPI_DELAY0_CSSCK(1) |
+			 SIFIVE_SPI_DELAY0_SCKCS(1));
+	sifive_spi_write(spi, SIFIVE_SPI_REG_DELAY1,
+			 SIFIVE_SPI_DELAY1_INTERCS(1) |
+			 SIFIVE_SPI_DELAY1_INTERXFR(0));
+
+	/* Exit specialized memory-mapped SPI flash mode */
+	sifive_spi_write(spi, SIFIVE_SPI_REG_FCTRL, 0);
+}
+
+static int
+sifive_spi_prepare_message(struct spi_master *master, struct spi_message *msg)
+{
+	struct sifive_spi *spi = spi_master_get_devdata(master);
+	struct spi_device *device = msg->spi;
+
+	/* Update the chip select polarity */
+	if (device->mode & SPI_CS_HIGH)
+		spi->cs_inactive &= ~BIT(device->chip_select);
+	else
+		spi->cs_inactive |= BIT(device->chip_select);
+	sifive_spi_write(spi, SIFIVE_SPI_REG_CSDEF, spi->cs_inactive);
+
+	/* Select the correct device */
+	sifive_spi_write(spi, SIFIVE_SPI_REG_CSID, device->chip_select);
+
+	/* Set clock mode */
+	sifive_spi_write(spi, SIFIVE_SPI_REG_SCKMODE,
+			 device->mode & SIFIVE_SPI_SCKMODE_MODE_MASK);
+
+	return 0;
+}
+
+static void sifive_spi_set_cs(struct spi_device *device, bool is_high)
+{
+	struct sifive_spi *spi = spi_master_get_devdata(device->master);
+
+	/* Reverse polarity is handled by SCMR/CPOL. Not inverted CS. */
+	if (device->mode & SPI_CS_HIGH)
+		is_high = !is_high;
+
+	sifive_spi_write(spi, SIFIVE_SPI_REG_CSMODE, is_high ?
+			 SIFIVE_SPI_CSMODE_MODE_AUTO :
+			 SIFIVE_SPI_CSMODE_MODE_HOLD);
+}
+
+static int
+sifive_spi_prep_transfer(struct sifive_spi *spi, struct spi_device *device,
+			 struct spi_transfer *t)
+{
+	u32 cr;
+	unsigned int mode;
+
+	/* Calculate and program the clock rate */
+	cr = DIV_ROUND_UP(clk_get_rate(spi->clk) >> 1, t->speed_hz) - 1;
+	cr &= SIFIVE_SPI_SCKDIV_DIV_MASK;
+	sifive_spi_write(spi, SIFIVE_SPI_REG_SCKDIV, cr);
+
+	mode = max_t(unsigned int, t->rx_nbits, t->tx_nbits);
+
+	/* Set frame format */
+	cr = SIFIVE_SPI_FMT_LEN(t->bits_per_word);
+	switch (mode) {
+	case SPI_NBITS_QUAD:
+		cr |= SIFIVE_SPI_FMT_PROTO_QUAD;
+		break;
+	case SPI_NBITS_DUAL:
+		cr |= SIFIVE_SPI_FMT_PROTO_DUAL;
+		break;
+	default:
+		cr |= SIFIVE_SPI_FMT_PROTO_SINGLE;
+		break;
+	}
+	if (device->mode & SPI_LSB_FIRST)
+		cr |= SIFIVE_SPI_FMT_ENDIAN;
+	if (!t->rx_buf)
+		cr |= SIFIVE_SPI_FMT_DIR;
+	sifive_spi_write(spi, SIFIVE_SPI_REG_FMT, cr);
+
+	/* We will want to poll if the time we need to wait is
+	 * less than the context switching time.
+	 * Let's call that threshold 5us. The operation will take:
+	 *    (8/mode) * fifo_depth / hz <= 5 * 10^-6
+	 *    1600000 * fifo_depth <= hz * mode
+	 */
+	return 1600000 * spi->fifo_depth <= t->speed_hz * mode;
+}
+
+static irqreturn_t sifive_spi_irq(int irq, void *dev_id)
+{
+	struct sifive_spi *spi = dev_id;
+	u32 ip = sifive_spi_read(spi, SIFIVE_SPI_REG_IP);
+
+	if (ip & (SIFIVE_SPI_IP_TXWM | SIFIVE_SPI_IP_RXWM)) {
+		/* Disable interrupts until next transfer */
+		sifive_spi_write(spi, SIFIVE_SPI_REG_IE, 0);
+		complete(&spi->done);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static void sifive_spi_wait(struct sifive_spi *spi, u32 bit, int poll)
+{
+	if (poll) {
+		u32 cr;
+
+		do {
+			cr = sifive_spi_read(spi, SIFIVE_SPI_REG_IP);
+		} while (!(cr & bit));
+	} else {
+		reinit_completion(&spi->done);
+		sifive_spi_write(spi, SIFIVE_SPI_REG_IE, bit);
+		wait_for_completion(&spi->done);
+	}
+}
+
+static void sifive_spi_tx(struct sifive_spi *spi, const u8 *tx_ptr)
+{
+	WARN_ON_ONCE((sifive_spi_read(spi, SIFIVE_SPI_REG_TXDATA)
+				& SIFIVE_SPI_TXDATA_FULL) != 0);
+	sifive_spi_write(spi, SIFIVE_SPI_REG_TXDATA,
+			 *tx_ptr & SIFIVE_SPI_TXDATA_DATA_MASK);
+}
+
+static void sifive_spi_rx(struct sifive_spi *spi, u8 *rx_ptr)
+{
+	u32 data = sifive_spi_read(spi, SIFIVE_SPI_REG_RXDATA);
+
+	WARN_ON_ONCE((data & SIFIVE_SPI_RXDATA_EMPTY) != 0);
+	*rx_ptr = data & SIFIVE_SPI_RXDATA_DATA_MASK;
+}
+
+static int
+sifive_spi_transfer_one(struct spi_master *master, struct spi_device *device,
+			struct spi_transfer *t)
+{
+	struct sifive_spi *spi = spi_master_get_devdata(master);
+	int poll = sifive_spi_prep_transfer(spi, device, t);
+	const u8 *tx_ptr = t->tx_buf;
+	u8 *rx_ptr = t->rx_buf;
+	unsigned int remaining_words = t->len;
+
+	while (remaining_words) {
+		unsigned int n_words = min(remaining_words, spi->fifo_depth);
+		unsigned int i;
+
+		/* Enqueue n_words for transmission */
+		for (i = 0; i < n_words; i++)
+			sifive_spi_tx(spi, tx_ptr++);
+
+		if (rx_ptr) {
+			/* Wait for transmission + reception to complete */
+			sifive_spi_write(spi, SIFIVE_SPI_REG_RXMARK,
+					 n_words - 1);
+			sifive_spi_wait(spi, SIFIVE_SPI_IP_RXWM, poll);
+
+			/* Read out all the data from the RX FIFO */
+			for (i = 0; i < n_words; i++)
+				sifive_spi_rx(spi, rx_ptr++);
+		} else {
+			/* Wait for transmission to complete */
+			sifive_spi_wait(spi, SIFIVE_SPI_IP_TXWM, poll);
+		}
+
+		remaining_words -= n_words;
+	}
+
+	return 0;
+}
+
+static int sifive_spi_probe(struct platform_device *pdev)
+{
+	struct sifive_spi *spi;
+	struct resource *res;
+	int ret, irq, num_cs;
+	u32 cs_bits, max_bits_per_word;
+	struct spi_master *master;
+
+	master = spi_alloc_master(&pdev->dev, sizeof(struct sifive_spi));
+	if (!master) {
+		dev_err(&pdev->dev, "out of memory\n");
+		return -ENOMEM;
+	}
+
+	spi = spi_master_get_devdata(master);
+	init_completion(&spi->done);
+	platform_set_drvdata(pdev, master);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	spi->regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(spi->regs)) {
+		dev_err(&pdev->dev, "Unable to map IO resources\n");
+		ret = PTR_ERR(spi->regs);
+		goto put_master;
+	}
+
+	spi->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(spi->clk)) {
+		dev_err(&pdev->dev, "Unable to find bus clock\n");
+		ret = PTR_ERR(spi->clk);
+		goto put_master;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "Unable to find interrupt\n");
+		ret = irq;
+		goto put_master;
+	}
+
+	/* Optional parameters */
+	ret =
+	  of_property_read_u32(pdev->dev.of_node, "sifive,fifo-depth",
+			       &spi->fifo_depth);
+	if (ret < 0)
+		spi->fifo_depth = SIFIVE_SPI_DEFAULT_DEPTH;
+
+	ret =
+	  of_property_read_u32(pdev->dev.of_node, "sifive,max-bits-per-word",
+			       &max_bits_per_word);
+
+	if (!ret && max_bits_per_word < 8) {
+		dev_err(&pdev->dev, "Only 8bit SPI words supported by the driver\n");
+		ret = -EINVAL;
+		goto put_master;
+	}
+
+	/* Spin up the bus clock before hitting registers */
+	ret = clk_prepare_enable(spi->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "Unable to enable bus clock\n");
+		goto put_master;
+	}
+
+	/* probe the number of CS lines */
+	spi->cs_inactive = sifive_spi_read(spi, SIFIVE_SPI_REG_CSDEF);
+	sifive_spi_write(spi, SIFIVE_SPI_REG_CSDEF, 0xffffffffU);
+	cs_bits = sifive_spi_read(spi, SIFIVE_SPI_REG_CSDEF);
+	sifive_spi_write(spi, SIFIVE_SPI_REG_CSDEF, spi->cs_inactive);
+	if (!cs_bits) {
+		dev_err(&pdev->dev, "Could not auto probe CS lines\n");
+		ret = -EINVAL;
+		goto put_master;
+	}
+
+	num_cs = ilog2(cs_bits) + 1;
+	if (num_cs > SIFIVE_SPI_MAX_CS) {
+		dev_err(&pdev->dev, "Invalid number of spi slaves\n");
+		ret = -EINVAL;
+		goto put_master;
+	}
+
+	/* Define our master */
+	master->dev.of_node = pdev->dev.of_node;
+	master->bus_num = pdev->id;
+	master->num_chipselect = num_cs;
+	master->mode_bits = SPI_CPHA | SPI_CPOL
+			  | SPI_CS_HIGH | SPI_LSB_FIRST
+			  | SPI_TX_DUAL | SPI_TX_QUAD
+			  | SPI_RX_DUAL | SPI_RX_QUAD;
+	/* TODO: add driver support for bits_per_word < 8
+	 * we need to "left-align" the bits (unless SPI_LSB_FIRST)
+	 */
+	master->bits_per_word_mask = SPI_BPW_MASK(8);
+	master->flags = SPI_CONTROLLER_MUST_TX | SPI_MASTER_GPIO_SS;
+	master->prepare_message = sifive_spi_prepare_message;
+	master->set_cs = sifive_spi_set_cs;
+	master->transfer_one = sifive_spi_transfer_one;
+
+	pdev->dev.dma_mask = NULL;
+	/* Configure the SPI master hardware */
+	sifive_spi_init(spi);
+
+	/* Register for SPI Interrupt */
+	ret = devm_request_irq(&pdev->dev, irq, sifive_spi_irq, 0,
+			       dev_name(&pdev->dev), spi);
+	if (ret) {
+		dev_err(&pdev->dev, "Unable to bind to interrupt\n");
+		goto put_master;
+	}
+
+	dev_info(&pdev->dev, "mapped; irq=%d, cs=%d\n",
+		 irq, master->num_chipselect);
+
+	ret = devm_spi_register_master(&pdev->dev, master);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "spi_register_master failed\n");
+		goto put_master;
+	}
+
+	return 0;
+
+put_master:
+	spi_master_put(master);
+
+	return ret;
+}
+
+static int sifive_spi_remove(struct platform_device *pdev)
+{
+	struct spi_master *master = platform_get_drvdata(pdev);
+	struct sifive_spi *spi = spi_master_get_devdata(master);
+
+	/* Disable all the interrupts just in case */
+	sifive_spi_write(spi, SIFIVE_SPI_REG_IE, 0);
+	spi_master_put(master);
+
+	return 0;
+}
+
+static const struct of_device_id sifive_spi_of_match[] = {
+	{ .compatible = "sifive,spi0", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, sifive_spi_of_match);
+
+static struct platform_driver sifive_spi_driver = {
+	.probe = sifive_spi_probe,
+	.remove = sifive_spi_remove,
+	.driver = {
+		.name = SIFIVE_SPI_DRIVER_NAME,
+		.of_match_table = sifive_spi_of_match,
+	},
+};
+module_platform_driver(sifive_spi_driver);
+
+MODULE_AUTHOR("SiFive, Inc. <sifive@sifive.com>");
+MODULE_DESCRIPTION("SiFive SPI driver");
+MODULE_LICENSE("GPL");
-- 
2.20.1

