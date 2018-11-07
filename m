Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77EAC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9994F2085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="EztoJ70E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9994F2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387586AbeKHAeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:34:36 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44706 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbeKHAeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 19:34:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ZM3M02ltCo4ZBhVakdwH+hxxfsB/cgtEq48gNFkdukg=; b=EztoJ70EHd7x
        isnBqDxSdSKsGXd5UPKwk0fWn7D36g00UWqvukJofbB285EQLz/kE9Olo8Lsgrpc9Iklcq/opUVGi
        UwEQQp8MYev2MsJsYvklB6P2EVPRqoQfNlVwQodFOBgcZrIPdS9ra2G7Xp/p1ZK2ST6wf1+RlwLy2
        jDJmo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gKPMi-0006bg-MO; Wed, 07 Nov 2018 15:03:32 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 6C0171124E14; Wed,  7 Nov 2018 15:03:32 +0000 (GMT)
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
Subject: Applied "mtd: spi-nor: atmel-quadspi: Remove unused code from atmel-quadspi driver" to the spi tree
In-Reply-To:  <20181105103625.9644-5-bugalski.piotr@gmail.com>
Message-Id: <20181107150332.6C0171124E14@debutante.sirena.org.uk>
Date:   Wed,  7 Nov 2018 15:03:32 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   mtd: spi-nor: atmel-quadspi: Remove unused code from atmel-quadspi driver

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

From 6ca622c87149a20a47abbb954f896f515e2292a7 Mon Sep 17 00:00:00 2001
From: Piotr Bugalski <bugalski.piotr@gmail.com>
Date: Mon, 5 Nov 2018 11:36:23 +0100
Subject: [PATCH] mtd: spi-nor: atmel-quadspi: Remove unused code from
 atmel-quadspi driver

Code used for previous interface is no longer needed.
This change just removes obsolete code.

Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Piotr Bugalski <bugalski.piotr@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/mtd/spi-nor/atmel-quadspi.c | 388 ----------------------------
 1 file changed, 388 deletions(-)

diff --git a/drivers/mtd/spi-nor/atmel-quadspi.c b/drivers/mtd/spi-nor/atmel-quadspi.c
index 644e3f0c1558..ddc712410812 100644
--- a/drivers/mtd/spi-nor/atmel-quadspi.c
+++ b/drivers/mtd/spi-nor/atmel-quadspi.c
@@ -29,14 +29,9 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/partitions.h>
-#include <linux/mtd/spi-nor.h>
-#include <linux/platform_data/atmel.h>
 #include <linux/of.h>
 
 #include <linux/io.h>
-#include <linux/gpio/consumer.h>
 #include <linux/spi/spi-mem.h>
 
 /* QSPI register offsets */
@@ -160,35 +155,9 @@ struct atmel_qspi {
 	struct clk		*clk;
 	struct platform_device	*pdev;
 	u32			pending;
-
-	struct spi_nor		nor;
-	u32			clk_rate;
 	struct completion	cmd_completion;
 };
 
-struct atmel_qspi_command {
-	union {
-		struct {
-			u32	instruction:1;
-			u32	address:3;
-			u32	mode:1;
-			u32	dummy:1;
-			u32	data:1;
-			u32	reserved:25;
-		}		bits;
-		u32	word;
-	}	enable;
-	u8	instruction;
-	u8	mode;
-	u8	num_mode_cycles;
-	u8	num_dummy_cycles;
-	u32	address;
-
-	size_t		buf_len;
-	const void	*tx_buf;
-	void		*rx_buf;
-};
-
 struct qspi_mode {
 	u8 cmd_buswidth;
 	u8 addr_buswidth;
@@ -407,363 +376,6 @@ static int atmel_qspi_setup(struct spi_device *spi)
 	return 0;
 }
 
-static int atmel_qspi_run_transfer(struct atmel_qspi *aq,
-				   const struct atmel_qspi_command *cmd)
-{
-	void __iomem *ahb_mem;
-
-	/* Then fallback to a PIO transfer (memcpy() DOES NOT work!) */
-	ahb_mem = aq->mem;
-	if (cmd->enable.bits.address)
-		ahb_mem += cmd->address;
-	if (cmd->tx_buf)
-		_memcpy_toio(ahb_mem, cmd->tx_buf, cmd->buf_len);
-	else
-		_memcpy_fromio(cmd->rx_buf, ahb_mem, cmd->buf_len);
-
-	return 0;
-}
-
-#ifdef DEBUG
-static void atmel_qspi_debug_command(struct atmel_qspi *aq,
-				     const struct atmel_qspi_command *cmd,
-				     u32 ifr)
-{
-	u8 cmd_buf[SPI_NOR_MAX_CMD_SIZE];
-	size_t len = 0;
-	int i;
-
-	if (cmd->enable.bits.instruction)
-		cmd_buf[len++] = cmd->instruction;
-
-	for (i = cmd->enable.bits.address-1; i >= 0; --i)
-		cmd_buf[len++] = (cmd->address >> (i << 3)) & 0xff;
-
-	if (cmd->enable.bits.mode)
-		cmd_buf[len++] = cmd->mode;
-
-	if (cmd->enable.bits.dummy) {
-		int num = cmd->num_dummy_cycles;
-
-		switch (ifr & QSPI_IFR_WIDTH_MASK) {
-		case QSPI_IFR_WIDTH_SINGLE_BIT_SPI:
-		case QSPI_IFR_WIDTH_DUAL_OUTPUT:
-		case QSPI_IFR_WIDTH_QUAD_OUTPUT:
-			num >>= 3;
-			break;
-		case QSPI_IFR_WIDTH_DUAL_IO:
-		case QSPI_IFR_WIDTH_DUAL_CMD:
-			num >>= 2;
-			break;
-		case QSPI_IFR_WIDTH_QUAD_IO:
-		case QSPI_IFR_WIDTH_QUAD_CMD:
-			num >>= 1;
-			break;
-		default:
-			return;
-		}
-
-		for (i = 0; i < num; ++i)
-			cmd_buf[len++] = 0;
-	}
-
-	/* Dump the SPI command */
-	print_hex_dump(KERN_DEBUG, "qspi cmd: ", DUMP_PREFIX_NONE,
-		       32, 1, cmd_buf, len, false);
-
-#ifdef VERBOSE_DEBUG
-	/* If verbose debug is enabled, also dump the TX data */
-	if (cmd->enable.bits.data && cmd->tx_buf)
-		print_hex_dump(KERN_DEBUG, "qspi tx : ", DUMP_PREFIX_NONE,
-			       32, 1, cmd->tx_buf, cmd->buf_len, false);
-#endif
-}
-#else
-#define atmel_qspi_debug_command(aq, cmd, ifr)
-#endif
-
-static int atmel_qspi_run_command(struct atmel_qspi *aq,
-				  const struct atmel_qspi_command *cmd,
-				  u32 ifr_tfrtyp, enum spi_nor_protocol proto)
-{
-	u32 iar, icr, ifr, sr;
-	int err = 0;
-
-	iar = 0;
-	icr = 0;
-	ifr = ifr_tfrtyp;
-
-	/* Set the SPI protocol */
-	switch (proto) {
-	case SNOR_PROTO_1_1_1:
-		ifr |= QSPI_IFR_WIDTH_SINGLE_BIT_SPI;
-		break;
-
-	case SNOR_PROTO_1_1_2:
-		ifr |= QSPI_IFR_WIDTH_DUAL_OUTPUT;
-		break;
-
-	case SNOR_PROTO_1_1_4:
-		ifr |= QSPI_IFR_WIDTH_QUAD_OUTPUT;
-		break;
-
-	case SNOR_PROTO_1_2_2:
-		ifr |= QSPI_IFR_WIDTH_DUAL_IO;
-		break;
-
-	case SNOR_PROTO_1_4_4:
-		ifr |= QSPI_IFR_WIDTH_QUAD_IO;
-		break;
-
-	case SNOR_PROTO_2_2_2:
-		ifr |= QSPI_IFR_WIDTH_DUAL_CMD;
-		break;
-
-	case SNOR_PROTO_4_4_4:
-		ifr |= QSPI_IFR_WIDTH_QUAD_CMD;
-		break;
-
-	default:
-		return -EINVAL;
-	}
-
-	/* Compute instruction parameters */
-	if (cmd->enable.bits.instruction) {
-		icr |= QSPI_ICR_INST(cmd->instruction);
-		ifr |= QSPI_IFR_INSTEN;
-	}
-
-	/* Compute address parameters */
-	switch (cmd->enable.bits.address) {
-	case 4:
-		ifr |= QSPI_IFR_ADDRL;
-		/* fall through to the 24bit (3 byte) address case. */
-	case 3:
-		iar = (cmd->enable.bits.data) ? 0 : cmd->address;
-		ifr |= QSPI_IFR_ADDREN;
-		break;
-	case 0:
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	/* Compute option parameters */
-	if (cmd->enable.bits.mode && cmd->num_mode_cycles) {
-		u32 mode_cycle_bits, mode_bits;
-
-		icr |= QSPI_ICR_OPT(cmd->mode);
-		ifr |= QSPI_IFR_OPTEN;
-
-		switch (ifr & QSPI_IFR_WIDTH_MASK) {
-		case QSPI_IFR_WIDTH_SINGLE_BIT_SPI:
-		case QSPI_IFR_WIDTH_DUAL_OUTPUT:
-		case QSPI_IFR_WIDTH_QUAD_OUTPUT:
-			mode_cycle_bits = 1;
-			break;
-		case QSPI_IFR_WIDTH_DUAL_IO:
-		case QSPI_IFR_WIDTH_DUAL_CMD:
-			mode_cycle_bits = 2;
-			break;
-		case QSPI_IFR_WIDTH_QUAD_IO:
-		case QSPI_IFR_WIDTH_QUAD_CMD:
-			mode_cycle_bits = 4;
-			break;
-		default:
-			return -EINVAL;
-		}
-
-		mode_bits = cmd->num_mode_cycles * mode_cycle_bits;
-		switch (mode_bits) {
-		case 1:
-			ifr |= QSPI_IFR_OPTL_1BIT;
-			break;
-
-		case 2:
-			ifr |= QSPI_IFR_OPTL_2BIT;
-			break;
-
-		case 4:
-			ifr |= QSPI_IFR_OPTL_4BIT;
-			break;
-
-		case 8:
-			ifr |= QSPI_IFR_OPTL_8BIT;
-			break;
-
-		default:
-			return -EINVAL;
-		}
-	}
-
-	/* Set number of dummy cycles */
-	if (cmd->enable.bits.dummy)
-		ifr |= QSPI_IFR_NBDUM(cmd->num_dummy_cycles);
-
-	/* Set data enable */
-	if (cmd->enable.bits.data) {
-		ifr |= QSPI_IFR_DATAEN;
-
-		/* Special case for Continuous Read Mode */
-		if (!cmd->tx_buf && !cmd->rx_buf)
-			ifr |= QSPI_IFR_CRM;
-	}
-
-	/* Clear pending interrupts */
-	(void)qspi_readl(aq, QSPI_SR);
-
-	/* Set QSPI Instruction Frame registers */
-	atmel_qspi_debug_command(aq, cmd, ifr);
-	qspi_writel(aq, QSPI_IAR, iar);
-	qspi_writel(aq, QSPI_ICR, icr);
-	qspi_writel(aq, QSPI_IFR, ifr);
-
-	/* Skip to the final steps if there is no data */
-	if (!cmd->enable.bits.data)
-		goto no_data;
-
-	/* Dummy read of QSPI_IFR to synchronize APB and AHB accesses */
-	(void)qspi_readl(aq, QSPI_IFR);
-
-	/* Stop here for continuous read */
-	if (!cmd->tx_buf && !cmd->rx_buf)
-		return 0;
-	/* Send/Receive data */
-	err = atmel_qspi_run_transfer(aq, cmd);
-
-	/* Release the chip-select */
-	qspi_writel(aq, QSPI_CR, QSPI_CR_LASTXFER);
-
-	if (err)
-		return err;
-
-#if defined(DEBUG) && defined(VERBOSE_DEBUG)
-	/*
-	 * If verbose debug is enabled, also dump the RX data in addition to
-	 * the SPI command previously dumped by atmel_qspi_debug_command()
-	 */
-	if (cmd->rx_buf)
-		print_hex_dump(KERN_DEBUG, "qspi rx : ", DUMP_PREFIX_NONE,
-			       32, 1, cmd->rx_buf, cmd->buf_len, false);
-#endif
-no_data:
-	/* Poll INSTRuction End status */
-	sr = qspi_readl(aq, QSPI_SR);
-	if ((sr & QSPI_SR_CMD_COMPLETED) == QSPI_SR_CMD_COMPLETED)
-		return err;
-
-	/* Wait for INSTRuction End interrupt */
-	reinit_completion(&aq->cmd_completion);
-	aq->pending = sr & QSPI_SR_CMD_COMPLETED;
-	qspi_writel(aq, QSPI_IER, QSPI_SR_CMD_COMPLETED);
-	if (!wait_for_completion_timeout(&aq->cmd_completion,
-					 msecs_to_jiffies(1000)))
-		err = -ETIMEDOUT;
-	qspi_writel(aq, QSPI_IDR, QSPI_SR_CMD_COMPLETED);
-
-	return err;
-}
-
-static int atmel_qspi_read_reg(struct spi_nor *nor, u8 opcode,
-			       u8 *buf, int len)
-{
-	struct atmel_qspi *aq = nor->priv;
-	struct atmel_qspi_command cmd;
-
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.enable.bits.instruction = 1;
-	cmd.enable.bits.data = 1;
-	cmd.instruction = opcode;
-	cmd.rx_buf = buf;
-	cmd.buf_len = len;
-	return atmel_qspi_run_command(aq, &cmd, QSPI_IFR_TFRTYP_TRSFR_READ,
-				      nor->reg_proto);
-}
-
-static int atmel_qspi_write_reg(struct spi_nor *nor, u8 opcode,
-				u8 *buf, int len)
-{
-	struct atmel_qspi *aq = nor->priv;
-	struct atmel_qspi_command cmd;
-
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.enable.bits.instruction = 1;
-	cmd.enable.bits.data = (buf != NULL && len > 0);
-	cmd.instruction = opcode;
-	cmd.tx_buf = buf;
-	cmd.buf_len = len;
-	return atmel_qspi_run_command(aq, &cmd, QSPI_IFR_TFRTYP_TRSFR_WRITE,
-				      nor->reg_proto);
-}
-
-static ssize_t atmel_qspi_write(struct spi_nor *nor, loff_t to, size_t len,
-				const u_char *write_buf)
-{
-	struct atmel_qspi *aq = nor->priv;
-	struct atmel_qspi_command cmd;
-	ssize_t ret;
-
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.enable.bits.instruction = 1;
-	cmd.enable.bits.address = nor->addr_width;
-	cmd.enable.bits.data = 1;
-	cmd.instruction = nor->program_opcode;
-	cmd.address = (u32)to;
-	cmd.tx_buf = write_buf;
-	cmd.buf_len = len;
-	ret = atmel_qspi_run_command(aq, &cmd, QSPI_IFR_TFRTYP_TRSFR_WRITE_MEM,
-				     nor->write_proto);
-	return (ret < 0) ? ret : len;
-}
-
-static int atmel_qspi_erase(struct spi_nor *nor, loff_t offs)
-{
-	struct atmel_qspi *aq = nor->priv;
-	struct atmel_qspi_command cmd;
-
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.enable.bits.instruction = 1;
-	cmd.enable.bits.address = nor->addr_width;
-	cmd.instruction = nor->erase_opcode;
-	cmd.address = (u32)offs;
-	return atmel_qspi_run_command(aq, &cmd, QSPI_IFR_TFRTYP_TRSFR_WRITE,
-				      nor->reg_proto);
-}
-
-static ssize_t atmel_qspi_read(struct spi_nor *nor, loff_t from, size_t len,
-			       u_char *read_buf)
-{
-	struct atmel_qspi *aq = nor->priv;
-	struct atmel_qspi_command cmd;
-	u8 num_mode_cycles, num_dummy_cycles;
-	ssize_t ret;
-
-	if (nor->read_dummy >= 2) {
-		num_mode_cycles = 2;
-		num_dummy_cycles = nor->read_dummy - 2;
-	} else {
-		num_mode_cycles = nor->read_dummy;
-		num_dummy_cycles = 0;
-	}
-
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.enable.bits.instruction = 1;
-	cmd.enable.bits.address = nor->addr_width;
-	cmd.enable.bits.mode = (num_mode_cycles > 0);
-	cmd.enable.bits.dummy = (num_dummy_cycles > 0);
-	cmd.enable.bits.data = 1;
-	cmd.instruction = nor->read_opcode;
-	cmd.address = (u32)from;
-	cmd.mode = 0xff; /* This value prevents from entering the 0-4-4 mode */
-	cmd.num_mode_cycles = num_mode_cycles;
-	cmd.num_dummy_cycles = num_dummy_cycles;
-	cmd.rx_buf = read_buf;
-	cmd.buf_len = len;
-	ret = atmel_qspi_run_command(aq, &cmd, QSPI_IFR_TFRTYP_TRSFR_READ_MEM,
-				     nor->read_proto);
-	return (ret < 0) ? ret : len;
-}
-
 static int atmel_qspi_init(struct atmel_qspi *aq)
 {
 	/* Reset the QSPI controller */
-- 
2.19.0.rc2

