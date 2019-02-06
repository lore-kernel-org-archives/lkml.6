Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D1BC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4638218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549477081;
	bh=CpWxPvokjefAoot6u2USc2/IigkV7xrsOtLO2s+kQ/E=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=mcJ8i1Inljj9ckns/+vt/V6CkHEC5xmOhIhax03kI4nDhFpAt9DwjeQNoPlS5bhMR
	 PwZPcqelTd7HUJSX9//xjRI5BSz+VenEM+UoJguxAuSBnJSh27lyDMIfB89gN1Zw8e
	 J/1IQ5LqJY7+rZJ8d5teB3XG9pGwMIx4luwVHVw8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbfBFSSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:18:00 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38444 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727896AbfBFSR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:17:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=tv1s2F7Gu2MdDE8buRNPyPOu1jOyppDKe3FE1FAcDP4=; b=Ijx06+XyIyDT
        eIlXeW6icFpwF9AKgbQNa44RTvWGrN5LJDSdIKZtHRvplXkAWaDFwmg14GxNbTBAbHgIVhV/JIbEF
        VnOwcaudS/V6BsGz3ZRAOnpgKRlARCGOYlWHHr49Oj0qhJElT/LK30i9u54kDLnI9SQu7b4HXt/d9
        1SHhE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1grRld-0007Xp-7G; Wed, 06 Feb 2019 18:17:49 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B744D1127EA3; Wed,  6 Feb 2019 18:17:48 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com, bbrezillon@kernel.org,
        Cyrille.Pitchen@microchip.com, bugalski.piotr@gmail.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Tudor.Ambarus@microchip.com,
        linux-spi@vger.kernel.org
Subject: Applied "spi: atmel-quadspi: add support for sam9x60 qspi controller" to the spi tree
In-Reply-To:  <20190205173254.16388-14-tudor.ambarus@microchip.com>
X-Patchwork-Hint: ignore
Message-Id: <20190206181748.B744D1127EA3@debutante.sirena.org.uk>
Date:   Wed,  6 Feb 2019 18:17:48 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: atmel-quadspi: add support for sam9x60 qspi controller

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

From 2e5c888873586400e3e9197514995458c7f4c3e0 Mon Sep 17 00:00:00 2001
From: Tudor Ambarus <tudor.ambarus@microchip.com>
Date: Tue, 5 Feb 2019 17:33:38 +0000
Subject: [PATCH] spi: atmel-quadspi: add support for sam9x60 qspi controller

The sam9x60 qspi controller uses 2 clocks, one for the peripheral register
access, the other for the qspi core and phy. Both are mandatory. It uses
different transfer type bits in IFR register. It has dedicated registers
to specify a read or a write instruction: Read Instruction Code Register
(RICR) and Write Instruction Code Register (WICR). ICR/RICR/WICR have
identical fields.

Tested with sst26vf064b jedec,spi-nor flash. Backward compatibility test
done on sama5d2 qspi controller and mx25l25635e jedec,spi-nor flash.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/atmel-quadspi.c | 163 ++++++++++++++++++++++++++++--------
 1 file changed, 128 insertions(+), 35 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 336501d962e5..fffc21cd5f79 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -19,6 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi-mem.h>
 
@@ -35,7 +36,9 @@
 
 #define QSPI_IAR     0x0030  /* Instruction Address Register */
 #define QSPI_ICR     0x0034  /* Instruction Code Register */
+#define QSPI_WICR    0x0034  /* Write Instruction Code Register */
 #define QSPI_IFR     0x0038  /* Instruction Frame Register */
+#define QSPI_RICR    0x003C  /* Read Instruction Code Register */
 
 #define QSPI_SMR     0x0040  /* Scrambling Mode Register */
 #define QSPI_SKR     0x0044  /* Scrambling Key Register */
@@ -88,7 +91,7 @@
 #define QSPI_SCR_DLYBS_MASK             GENMASK(23, 16)
 #define QSPI_SCR_DLYBS(n)               (((n) << 16) & QSPI_SCR_DLYBS_MASK)
 
-/* Bitfields in QSPI_ICR (Instruction Code Register) */
+/* Bitfields in QSPI_ICR (Read/Write Instruction Code Register) */
 #define QSPI_ICR_INST_MASK              GENMASK(7, 0)
 #define QSPI_ICR_INST(inst)             (((inst) << 0) & QSPI_ICR_INST_MASK)
 #define QSPI_ICR_OPT_MASK               GENMASK(23, 16)
@@ -118,6 +121,7 @@
 #define QSPI_IFR_CRM                    BIT(14)
 #define QSPI_IFR_NBDUM_MASK             GENMASK(20, 16)
 #define QSPI_IFR_NBDUM(n)               (((n) << 16) & QSPI_IFR_NBDUM_MASK)
+#define QSPI_IFR_APBTFRTYP_READ		BIT(24)	/* Defined in SAM9X60 */
 
 /* Bitfields in QSPI_SMR (Scrambling Mode Register) */
 #define QSPI_SMR_SCREN                  BIT(0)
@@ -133,12 +137,18 @@
 #define QSPI_WPSR_WPVSRC_MASK           GENMASK(15, 8)
 #define QSPI_WPSR_WPVSRC(src)           (((src) << 8) & QSPI_WPSR_WPVSRC)
 
+struct atmel_qspi_caps {
+	bool has_qspick;
+	bool has_ricr;
+};
 
 struct atmel_qspi {
 	void __iomem		*regs;
 	void __iomem		*mem;
 	struct clk		*pclk;
+	struct clk		*qspick;
 	struct platform_device	*pdev;
+	const struct atmel_qspi_caps *caps;
 	u32			pending;
 	u32			mr;
 	struct completion	cmd_completion;
@@ -151,7 +161,7 @@ struct atmel_qspi_mode {
 	u32 config;
 };
 
-static const struct atmel_qspi_mode sama5d2_qspi_modes[] = {
+static const struct atmel_qspi_mode atmel_qspi_modes[] = {
 	{ 1, 1, 1, QSPI_IFR_WIDTH_SINGLE_BIT_SPI },
 	{ 1, 1, 2, QSPI_IFR_WIDTH_DUAL_OUTPUT },
 	{ 1, 1, 4, QSPI_IFR_WIDTH_QUAD_OUTPUT },
@@ -180,8 +190,8 @@ static int atmel_qspi_find_mode(const struct spi_mem_op *op)
 {
 	u32 i;
 
-	for (i = 0; i < ARRAY_SIZE(sama5d2_qspi_modes); i++)
-		if (atmel_qspi_is_compatible(op, &sama5d2_qspi_modes[i]))
+	for (i = 0; i < ARRAY_SIZE(atmel_qspi_modes); i++)
+		if (atmel_qspi_is_compatible(op, &atmel_qspi_modes[i]))
 			return i;
 
 	return -ENOTSUPP;
@@ -201,36 +211,37 @@ static bool atmel_qspi_supports_op(struct spi_mem *mem,
 	return true;
 }
 
-static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
+static int atmel_qspi_set_cfg(struct atmel_qspi *aq,
+			      const struct spi_mem_op *op, u32 *offset)
 {
-	struct atmel_qspi *aq = spi_controller_get_devdata(mem->spi->master);
-	int mode;
+	u32 iar, icr, ifr;
 	u32 dummy_cycles = 0;
-	u32 iar, icr, ifr, sr;
-	int err = 0;
+	int mode;
 
 	iar = 0;
 	icr = QSPI_ICR_INST(op->cmd.opcode);
 	ifr = QSPI_IFR_INSTEN;
 
-	/*
-	 * If the QSPI controller is set in regular SPI mode, set it in
-	 * Serial Memory Mode (SMM).
-	 */
-	if (aq->mr != QSPI_MR_SMM) {
-		writel_relaxed(QSPI_MR_SMM, aq->regs + QSPI_MR);
-		aq->mr = QSPI_MR_SMM;
-	}
-
 	mode = atmel_qspi_find_mode(op);
 	if (mode < 0)
 		return mode;
-
-	ifr |= sama5d2_qspi_modes[mode].config;
+	ifr |= atmel_qspi_modes[mode].config;
 
 	if (op->dummy.buswidth && op->dummy.nbytes)
 		dummy_cycles = op->dummy.nbytes * 8 / op->dummy.buswidth;
 
+	/*
+	 * The controller allows 24 and 32-bit addressing while NAND-flash
+	 * requires 16-bit long. Handling 8-bit long addresses is done using
+	 * the option field. For the 16-bit addresses, the workaround depends
+	 * of the number of requested dummy bits. If there are 8 or more dummy
+	 * cycles, the address is shifted and sent with the first dummy byte.
+	 * Otherwise opcode is disabled and the first byte of the address
+	 * contains the command opcode (works only if the opcode and address
+	 * use the same buswidth). The limitation is when the 16-bit address is
+	 * used without enough dummy cycles and the opcode is using a different
+	 * buswidth than the address.
+	 */
 	if (op->addr.buswidth) {
 		switch (op->addr.nbytes) {
 		case 0:
@@ -264,6 +275,9 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 		}
 	}
 
+	/* offset of the data access in the QSPI memory space */
+	*offset = iar;
+
 	/* Set number of dummy cycles */
 	if (dummy_cycles)
 		ifr |= QSPI_IFR_NBDUM(dummy_cycles);
@@ -272,16 +286,51 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	if (op->data.nbytes)
 		ifr |= QSPI_IFR_DATAEN;
 
-	if (op->data.dir == SPI_MEM_DATA_OUT)
-		ifr |= QSPI_IFR_SAMA5D2_WRITE_TRSFR;
+	/*
+	 * If the QSPI controller is set in regular SPI mode, set it in
+	 * Serial Memory Mode (SMM).
+	 */
+	if (aq->mr != QSPI_MR_SMM) {
+		writel_relaxed(QSPI_MR_SMM, aq->regs + QSPI_MR);
+		aq->mr = QSPI_MR_SMM;
+	}
 
 	/* Clear pending interrupts */
 	(void)readl_relaxed(aq->regs + QSPI_SR);
 
-	/* Set QSPI Instruction Frame registers */
-	writel_relaxed(iar, aq->regs + QSPI_IAR);
-	writel_relaxed(icr, aq->regs + QSPI_ICR);
-	writel_relaxed(ifr, aq->regs + QSPI_IFR);
+	if (aq->caps->has_ricr) {
+		if (!op->addr.nbytes && op->data.dir == SPI_MEM_DATA_IN)
+			ifr |= QSPI_IFR_APBTFRTYP_READ;
+
+		/* Set QSPI Instruction Frame registers */
+		writel_relaxed(iar, aq->regs + QSPI_IAR);
+		if (op->data.dir == SPI_MEM_DATA_IN)
+			writel_relaxed(icr, aq->regs + QSPI_RICR);
+		else
+			writel_relaxed(icr, aq->regs + QSPI_WICR);
+		writel_relaxed(ifr, aq->regs + QSPI_IFR);
+	} else {
+		if (op->data.dir == SPI_MEM_DATA_OUT)
+			ifr |= QSPI_IFR_SAMA5D2_WRITE_TRSFR;
+
+		/* Set QSPI Instruction Frame registers */
+		writel_relaxed(iar, aq->regs + QSPI_IAR);
+		writel_relaxed(icr, aq->regs + QSPI_ICR);
+		writel_relaxed(ifr, aq->regs + QSPI_IFR);
+	}
+
+	return 0;
+}
+
+static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
+{
+	struct atmel_qspi *aq = spi_controller_get_devdata(mem->spi->master);
+	u32 sr, offset;
+	int err;
+
+	err = atmel_qspi_set_cfg(aq, op, &offset);
+	if (err)
+		return err;
 
 	/* Skip to the final steps if there is no data */
 	if (op->data.nbytes) {
@@ -290,11 +339,11 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 
 		/* Send/Receive data */
 		if (op->data.dir == SPI_MEM_DATA_IN)
-			_memcpy_fromio(op->data.buf.in,
-				aq->mem + iar, op->data.nbytes);
+			_memcpy_fromio(op->data.buf.in, aq->mem + offset,
+				       op->data.nbytes);
 		else
-			_memcpy_toio(aq->mem + iar,
-				op->data.buf.out, op->data.nbytes);
+			_memcpy_toio(aq->mem + offset, op->data.buf.out,
+				     op->data.nbytes);
 
 		/* Release the chip-select */
 		writel_relaxed(QSPI_CR_LASTXFER, aq->regs + QSPI_CR);
@@ -450,28 +499,55 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 		goto exit;
 	}
 
+	aq->caps = of_device_get_match_data(&pdev->dev);
+	if (!aq->caps) {
+		dev_err(&pdev->dev, "Could not retrieve QSPI caps\n");
+		err = -EINVAL;
+		goto exit;
+	}
+
+	if (aq->caps->has_qspick) {
+		/* Get the QSPI system clock */
+		aq->qspick = devm_clk_get(&pdev->dev, "qspick");
+		if (IS_ERR(aq->qspick)) {
+			dev_err(&pdev->dev, "missing system clock\n");
+			err = PTR_ERR(aq->qspick);
+			goto disable_pclk;
+		}
+
+		/* Enable the QSPI system clock */
+		err = clk_prepare_enable(aq->qspick);
+		if (err) {
+			dev_err(&pdev->dev,
+				"failed to enable the QSPI system clock\n");
+			goto disable_pclk;
+		}
+	}
+
 	/* Request the IRQ */
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(&pdev->dev, "missing IRQ\n");
 		err = irq;
-		goto disable_pclk;
+		goto disable_qspick;
 	}
 	err = devm_request_irq(&pdev->dev, irq, atmel_qspi_interrupt,
 			       0, dev_name(&pdev->dev), aq);
 	if (err)
-		goto disable_pclk;
+		goto disable_qspick;
 
 	err = atmel_qspi_init(aq);
 	if (err)
-		goto disable_pclk;
+		goto disable_qspick;
 
 	err = spi_register_controller(ctrl);
 	if (err)
-		goto disable_pclk;
+		goto disable_qspick;
 
 	return 0;
 
+disable_qspick:
+	clk_disable_unprepare(aq->qspick);
 disable_pclk:
 	clk_disable_unprepare(aq->pclk);
 exit:
@@ -487,6 +563,7 @@ static int atmel_qspi_remove(struct platform_device *pdev)
 
 	spi_unregister_controller(ctrl);
 	writel_relaxed(QSPI_CR_QSPIDIS, aq->regs + QSPI_CR);
+	clk_disable_unprepare(aq->qspick);
 	clk_disable_unprepare(aq->pclk);
 	return 0;
 }
@@ -495,6 +572,7 @@ static int __maybe_unused atmel_qspi_suspend(struct device *dev)
 {
 	struct atmel_qspi *aq = dev_get_drvdata(dev);
 
+	clk_disable_unprepare(aq->qspick);
 	clk_disable_unprepare(aq->pclk);
 
 	return 0;
@@ -505,6 +583,7 @@ static int __maybe_unused atmel_qspi_resume(struct device *dev)
 	struct atmel_qspi *aq = dev_get_drvdata(dev);
 
 	clk_prepare_enable(aq->pclk);
+	clk_prepare_enable(aq->qspick);
 
 	return atmel_qspi_init(aq);
 }
@@ -512,8 +591,22 @@ static int __maybe_unused atmel_qspi_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(atmel_qspi_pm_ops, atmel_qspi_suspend,
 			 atmel_qspi_resume);
 
+static const struct atmel_qspi_caps atmel_sama5d2_qspi_caps = {};
+
+static const struct atmel_qspi_caps atmel_sam9x60_qspi_caps = {
+	.has_qspick = true,
+	.has_ricr = true,
+};
+
 static const struct of_device_id atmel_qspi_dt_ids[] = {
-	{ .compatible = "atmel,sama5d2-qspi" },
+	{
+		.compatible = "atmel,sama5d2-qspi",
+		.data = &atmel_sama5d2_qspi_caps,
+	},
+	{
+		.compatible = "microchip,sam9x60-qspi",
+		.data = &atmel_sam9x60_qspi_caps,
+	},
 	{ /* sentinel */ }
 };
 
-- 
2.20.1

