Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0864BC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B3420827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="N5Ur/KJ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0B3420827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbeKHAgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:36:53 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48510 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbeKHAgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 19:36:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=7tRCzqcPitxGL5dZoGjLNGsk5bDMjoui+2koknIzju0=; b=N5Ur/KJ1BzX4
        J1HzTafMOBoDFvO5/vI/qQgb6YrLkhaHfF68ZRLqIyoVqri7HxSneP5rs07lXKvvWqQRmQSpLDy5n
        7vcEh2obU8I4pijA9CZe12bGUEenFYXC6cGlMym8bsqcrZw9ooWBti5np1j3ugu/87WWOvnUtUk5W
        kgmL8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gKPOv-0006cA-Uw; Wed, 07 Nov 2018 15:05:50 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id A68641124E14; Wed,  7 Nov 2018 15:05:49 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Piotr Bugalski <bugalski.piotr@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Cyrille Pitchen <cyrille.pitchen@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        linux-spi@vger.kernel.org
Subject: Applied "mtd: spi-nor: atmel-quadspi: Add spi-mem support to atmel-quadspi" to the spi tree
In-Reply-To:  <20181105103625.9644-3-bugalski.piotr@gmail.com>
Message-Id: <20181107150549.A68641124E14@debutante.sirena.org.uk>
Date:   Wed,  7 Nov 2018 15:05:49 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   mtd: spi-nor: atmel-quadspi: Add spi-mem support to atmel-quadspi

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

From d5433def31531bd07984f167f6ab0afef70b6a3e Mon Sep 17 00:00:00 2001
From: Piotr Bugalski <bugalski.piotr@gmail.com>
Date: Mon, 5 Nov 2018 11:36:21 +0100
Subject: [PATCH] mtd: spi-nor: atmel-quadspi: Add spi-mem support to
 atmel-quadspi

This patch adds new interface to existing driver. New code is not used yet,
it will be enabled later.
Changes are prepared in small steps to keep patches readable.

Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Piotr Bugalski <bugalski.piotr@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/mtd/spi-nor/atmel-quadspi.c | 211 ++++++++++++++++++++++++++++
 1 file changed, 211 insertions(+)

diff --git a/drivers/mtd/spi-nor/atmel-quadspi.c b/drivers/mtd/spi-nor/atmel-quadspi.c
index 1c5ba8feaa5e..896478a290ec 100644
--- a/drivers/mtd/spi-nor/atmel-quadspi.c
+++ b/drivers/mtd/spi-nor/atmel-quadspi.c
@@ -2,8 +2,10 @@
  * Driver for Atmel QSPI Controller
  *
  * Copyright (C) 2015 Atmel Corporation
+ * Copyright (C) 2018 Cryptera A/S
  *
  * Author: Cyrille Pitchen <cyrille.pitchen@atmel.com>
+ * Author: Piotr Bugalski <bugalski.piotr@gmail.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -35,6 +37,7 @@
 
 #include <linux/io.h>
 #include <linux/gpio/consumer.h>
+#include <linux/spi/spi-mem.h>
 
 /* QSPI register offsets */
 #define QSPI_CR      0x0000  /* Control Register */
@@ -186,6 +189,23 @@ struct atmel_qspi_command {
 	void		*rx_buf;
 };
 
+struct qspi_mode {
+	u8 cmd_buswidth;
+	u8 addr_buswidth;
+	u8 data_buswidth;
+	u32 config;
+};
+
+static const struct qspi_mode sama5d2_qspi_modes[] = {
+	{ 1, 1, 1, QSPI_IFR_WIDTH_SINGLE_BIT_SPI },
+	{ 1, 1, 2, QSPI_IFR_WIDTH_DUAL_OUTPUT },
+	{ 1, 1, 4, QSPI_IFR_WIDTH_QUAD_OUTPUT },
+	{ 1, 2, 2, QSPI_IFR_WIDTH_DUAL_IO },
+	{ 1, 4, 4, QSPI_IFR_WIDTH_QUAD_IO },
+	{ 2, 2, 2, QSPI_IFR_WIDTH_DUAL_CMD },
+	{ 4, 4, 4, QSPI_IFR_WIDTH_QUAD_CMD },
+};
+
 /* Register access functions */
 static inline u32 qspi_readl(struct atmel_qspi *aq, u32 reg)
 {
@@ -197,6 +217,196 @@ static inline void qspi_writel(struct atmel_qspi *aq, u32 reg, u32 value)
 	writel_relaxed(value, aq->regs + reg);
 }
 
+static inline bool is_compatible(const struct spi_mem_op *op,
+				 const struct qspi_mode *mode)
+{
+	if (op->cmd.buswidth != mode->cmd_buswidth)
+		return false;
+
+	if (op->addr.nbytes && op->addr.buswidth != mode->addr_buswidth)
+		return false;
+
+	if (op->data.nbytes && op->data.buswidth != mode->data_buswidth)
+		return false;
+
+	return true;
+}
+
+static int find_mode(const struct spi_mem_op *op)
+{
+	u32 i;
+
+	for (i = 0; i < ARRAY_SIZE(sama5d2_qspi_modes); i++)
+		if (is_compatible(op, &sama5d2_qspi_modes[i]))
+			return i;
+
+	return -1;
+}
+
+static bool atmel_qspi_supports_op(struct spi_mem *mem,
+				   const struct spi_mem_op *op)
+{
+	if (find_mode(op) < 0)
+		return false;
+
+	/* special case not supported by hardware */
+	if (op->addr.nbytes == 2 && op->cmd.buswidth != op->addr.buswidth &&
+		op->dummy.nbytes == 0)
+		return false;
+
+	return true;
+}
+
+static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
+{
+	struct atmel_qspi *aq = spi_controller_get_devdata(mem->spi->master);
+	int mode;
+	u32 dummy_cycles = 0;
+	u32 iar, icr, ifr, sr;
+	int err = 0;
+
+	iar = 0;
+	icr = QSPI_ICR_INST(op->cmd.opcode);
+	ifr = QSPI_IFR_INSTEN;
+
+	qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
+
+	mode = find_mode(op);
+	if (mode < 0)
+		return -ENOTSUPP;
+
+	ifr |= sama5d2_qspi_modes[mode].config;
+
+	if (op->dummy.buswidth && op->dummy.nbytes)
+		dummy_cycles = op->dummy.nbytes * 8 / op->dummy.buswidth;
+
+	if (op->addr.buswidth) {
+		switch (op->addr.nbytes) {
+		case 0:
+			break;
+		case 1:
+			ifr |= QSPI_IFR_OPTEN | QSPI_IFR_OPTL_8BIT;
+			icr |= QSPI_ICR_OPT(op->addr.val & 0xff);
+			break;
+		case 2:
+			if (dummy_cycles < 8 / op->addr.buswidth) {
+				ifr &= ~QSPI_IFR_INSTEN;
+				ifr |= QSPI_IFR_ADDREN;
+				iar = (op->cmd.opcode << 16) |
+					(op->addr.val & 0xffff);
+			} else {
+				ifr |= QSPI_IFR_ADDREN;
+				iar = (op->addr.val << 8) & 0xffffff;
+				dummy_cycles -= 8 / op->addr.buswidth;
+			}
+			break;
+		case 3:
+			ifr |= QSPI_IFR_ADDREN;
+			iar = op->addr.val & 0xffffff;
+			break;
+		case 4:
+			ifr |= QSPI_IFR_ADDREN | QSPI_IFR_ADDRL;
+			iar = op->addr.val & 0x7ffffff;
+			break;
+		default:
+			return -ENOTSUPP;
+		}
+	}
+
+	/* Set number of dummy cycles */
+	if (dummy_cycles)
+		ifr |= QSPI_IFR_NBDUM(dummy_cycles);
+
+	/* Set data enable */
+	if (op->data.nbytes)
+		ifr |= QSPI_IFR_DATAEN;
+
+	if (op->data.dir == SPI_MEM_DATA_IN && op->data.nbytes)
+		ifr |= QSPI_IFR_TFRTYP_TRSFR_READ;
+	else
+		ifr |= QSPI_IFR_TFRTYP_TRSFR_WRITE;
+
+	/* Clear pending interrupts */
+	(void)qspi_readl(aq, QSPI_SR);
+
+	/* Set QSPI Instruction Frame registers */
+	qspi_writel(aq, QSPI_IAR, iar);
+	qspi_writel(aq, QSPI_ICR, icr);
+	qspi_writel(aq, QSPI_IFR, ifr);
+
+	/* Skip to the final steps if there is no data */
+	if (op->data.nbytes) {
+		/* Dummy read of QSPI_IFR to synchronize APB and AHB accesses */
+		(void)qspi_readl(aq, QSPI_IFR);
+
+		/* Send/Receive data */
+		if (op->data.dir == SPI_MEM_DATA_IN)
+			_memcpy_fromio(op->data.buf.in,
+				aq->mem + iar, op->data.nbytes);
+		else
+			_memcpy_toio(aq->mem + iar,
+				op->data.buf.out, op->data.nbytes);
+
+		/* Release the chip-select */
+		qspi_writel(aq, QSPI_CR, QSPI_CR_LASTXFER);
+	}
+
+	/* Poll INSTRuction End status */
+	sr = qspi_readl(aq, QSPI_SR);
+	if ((sr & QSPI_SR_CMD_COMPLETED) == QSPI_SR_CMD_COMPLETED)
+		return err;
+
+	/* Wait for INSTRuction End interrupt */
+	reinit_completion(&aq->cmd_completion);
+	aq->pending = sr & QSPI_SR_CMD_COMPLETED;
+	qspi_writel(aq, QSPI_IER, QSPI_SR_CMD_COMPLETED);
+	if (!wait_for_completion_timeout(&aq->cmd_completion,
+					 msecs_to_jiffies(1000)))
+		err = -ETIMEDOUT;
+	qspi_writel(aq, QSPI_IDR, QSPI_SR_CMD_COMPLETED);
+
+	return err;
+}
+
+const char *atmel_qspi_get_name(struct spi_mem *spimem)
+{
+	return dev_name(spimem->spi->dev.parent);
+}
+
+static const struct spi_controller_mem_ops atmel_qspi_mem_ops = {
+	.supports_op = atmel_qspi_supports_op,
+	.exec_op = atmel_qspi_exec_op,
+	.get_name = atmel_qspi_get_name
+};
+
+static int atmel_qspi_setup(struct spi_device *spi)
+{
+	struct spi_controller *ctrl = spi->master;
+	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
+	unsigned long src_rate;
+	u32 scr, scbr;
+
+	if (ctrl->busy)
+		return -EBUSY;
+
+	if (!spi->max_speed_hz)
+		return -EINVAL;
+
+	src_rate = clk_get_rate(aq->clk);
+	if (!src_rate)
+		return -EINVAL;
+
+	/* Compute the QSPI baudrate */
+	scbr = DIV_ROUND_UP(src_rate, spi->max_speed_hz);
+	if (scbr > 0)
+		scbr--;
+
+	scr = QSPI_SCR_SCBR(scbr);
+	qspi_writel(aq, QSPI_SCR, scr);
+
+	return 0;
+}
+
 static int atmel_qspi_run_transfer(struct atmel_qspi *aq,
 				   const struct atmel_qspi_command *cmd)
 {
@@ -777,5 +987,6 @@ static struct platform_driver atmel_qspi_driver = {
 module_platform_driver(atmel_qspi_driver);
 
 MODULE_AUTHOR("Cyrille Pitchen <cyrille.pitchen@atmel.com>");
+MODULE_AUTHOR("Piotr Bugalski <bugalski.piotr@gmail.com");
 MODULE_DESCRIPTION("Atmel QSPI Controller driver");
 MODULE_LICENSE("GPL v2");
-- 
2.19.0.rc2

