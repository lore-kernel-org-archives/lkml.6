Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498CEC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC6E21531
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pxGZa0gZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AC6E21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbeIZXzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:55:13 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35252 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728335AbeIZXzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 19:55:13 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8QHewMa126384;
        Wed, 26 Sep 2018 12:40:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537983658;
        bh=NBXvbiqajZDK0k8CeB1KzUBDn8imVgwBJBAHQmW7yO0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=pxGZa0gZ4Es+xIB0q0YBNOeF1F5BZzPyPZAGa19l/i4asyrunv6vX7YVEsRO4WmLn
         ltb61aF+OlpvH+zeQMfo0NlM7TNWdDwXzcqyNiIX9ky9EbHXO6qy8n+bBocrGPP2F7
         LA22AX7j8YJ6Na9KkV4x4Qh+A1+jxXldESviuREE=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8QHew3q007493;
        Wed, 26 Sep 2018 12:40:58 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 26
 Sep 2018 12:40:58 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 26 Sep 2018 12:40:58 -0500
Received: from [128.247.58.174] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8QHewMt031962;
        Wed, 26 Sep 2018 12:40:58 -0500
Subject: Re: [PATCH 2/2] can: tcan4x5x: Add tcan4x5x driver to the kernel
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20180910201241.24092-1-dmurphy@ti.com>
 <20180910201241.24092-2-dmurphy@ti.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <631340c2-78a6-eec3-0ab2-713dddd8e84f@ti.com>
Date:   Wed, 26 Sep 2018 12:40:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180910201241.24092-2-dmurphy@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bump

On 09/10/2018 03:12 PM, Dan Murphy wrote:
> Add the TCAN4x5x SPI CAN driver.  This device
> uses the Bosch MCAN IP core along with a SPI
> interface map.  The register and data are
> 32 bits wide.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  drivers/net/can/spi/Kconfig    |    5 +
>  drivers/net/can/spi/Makefile   |    1 +
>  drivers/net/can/spi/tcan4x5x.c | 1206 ++++++++++++++++++++++++++++++++
>  drivers/net/can/spi/tcan4x5x.h |  109 +++
>  4 files changed, 1321 insertions(+)
>  create mode 100644 drivers/net/can/spi/tcan4x5x.c
>  create mode 100644 drivers/net/can/spi/tcan4x5x.h
> 
> diff --git a/drivers/net/can/spi/Kconfig b/drivers/net/can/spi/Kconfig
> index 8f2e0dd7b756..8cac6ce37506 100644
> --- a/drivers/net/can/spi/Kconfig
> +++ b/drivers/net/can/spi/Kconfig
> @@ -13,4 +13,9 @@ config CAN_MCP251X
>  	---help---
>  	  Driver for the Microchip MCP251x SPI CAN controllers.
>  
> +config CAN_TCAN4X5X
> +	tristate "Texas Instruments TCAN4X5X SPI CAN controllers"
> +	depends on HAS_DMA
> +	---help---
> +	  Driver for the Texas Instruments TCAN4X5X SPI CAN controllers.
>  endmenu
> diff --git a/drivers/net/can/spi/Makefile b/drivers/net/can/spi/Makefile
> index f59fa3731073..8ecaace7a920 100644
> --- a/drivers/net/can/spi/Makefile
> +++ b/drivers/net/can/spi/Makefile
> @@ -5,3 +5,4 @@
>  
>  obj-$(CONFIG_CAN_HI311X)	+= hi311x.o
>  obj-$(CONFIG_CAN_MCP251X)	+= mcp251x.o
> +obj-$(CONFIG_CAN_TCAN4X5X)	+= tcan4x5x.o
> diff --git a/drivers/net/can/spi/tcan4x5x.c b/drivers/net/can/spi/tcan4x5x.c
> new file mode 100644
> index 000000000000..ca3753efe35a
> --- /dev/null
> +++ b/drivers/net/can/spi/tcan4x5x.c
> @@ -0,0 +1,1206 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// SPI to CAN driver for the Texas Instruments TCAN4x5x
> +// Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
> +
> +#include <linux/can/core.h>
> +#include <linux/can/dev.h>
> +#include <linux/can/led.h>
> +#include <linux/clk.h>
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/freezer.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/netdevice.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/spi/spi.h>
> +#include <linux/uaccess.h>
> +
> +#include <linux/regulator/consumer.h>
> +#include <linux/gpio/consumer.h>
> +
> +#include "tcan4x5x.h"
> +
> +#define DEVICE_NAME "tcan4x5x"
> +#define TCAN4X5X_EXT_CLK_DEF	40000000
> +
> +#define TCAN4X5X_CLEAR_ALL_INT	0xffffffff
> +#define TCAN4X5X_SET_ALL_INT	0xffffffff
> +
> +#define TCAN4X5X_TX_ECHO_SKB_MAX 1
> +#define TCAN4X5X_DATA_PKT_OFF	2
> +#define TCAN4X5X_WRITE_CMD	(0x61 << 24)
> +#define TCAN4X5X_READ_CMD	(0x41 << 24)
> +
> +#define TCAN4X5X_SID_SHIFT	18
> +#define TCAN4X5X_DLC_SHIFT	16
> +
> +#define TCAN4X5X_ESI_SHIFT	31
> +#define TCAN4X5X_XTD_SHIFT	30
> +#define TCAN4X5X_RTR_SHIFT	29
> +#define TCAN4X5X_FDF_SHIFT	21
> +#define TCAN4X5X_BRS_SHIFT	20
> +#define TCAN4X5X_DLC_SHIFT	16
> +
> +#define TCAN4X5X_ESI_MASK	BIT(31)
> +#define TCAN4X5X_XTD_MASK	BIT(30)
> +#define TCAN4X5X_RTR_MASK	BIT(29)
> +
> +#define TCAN4X5X_DLC_MASK	0xf0000
> +#define TCAN4X5X_SW_RESET	BIT(2)
> +
> +#define TCAN4X5X_MODE_SEL_MASK		(BIT(7) | BIT(6))
> +#define TCAN4X5X_MODE_SLEEP		0x00
> +#define TCAN4X5X_MODE_STANDBY		BIT(6)
> +#define TCAN4X5X_MODE_NORMAL		BIT(7)
> +#define TCAN4X5X_MCAN_CONFIGURED	BIT(5)
> +#define TCAN4X5X_WATCHDOG_EN		BIT(3)
> +#define TCAN4X5X_WD_60_MS_TIMER		0
> +#define TCAN4X5X_WD_600_MS_TIMER	BIT(28)
> +#define TCAN4X5X_WD_3_S_TIMER		BIT(29)
> +#define TCAN4X5X_WD_6_S_TIMER		(BIT(28) | BIT(29))
> +
> +/* Nominal Bit Timing & Prescaler Register */
> +#define TCAN4X5X_NSJW_SHIFT	25
> +#define TCAN4X5X_NBRP_SHIFT	16
> +#define TCAN4X5X_NTSEG1_SHIFT	8
> +
> +#define TCAN4X5X_TDCR_TDCO_SHIFT	8
> +
> +/* Data Bit Timing & Prescaler Register (DBTP) */
> +#define DBTP_TDC		BIT(23)
> +#define DBTP_DBRP_SHIFT		16
> +#define DBTP_DBRP_MASK		(0x1f << DBTP_DBRP_SHIFT)
> +#define DBTP_DTSEG1_SHIFT	8
> +#define DBTP_DTSEG1_MASK	(0x1f << DBTP_DTSEG1_SHIFT)
> +#define DBTP_DTSEG2_SHIFT	4
> +#define DBTP_DTSEG2_MASK	(0xf << DBTP_DTSEG2_SHIFT)
> +#define DBTP_DSJW_SHIFT		0
> +#define DBTP_DSJW_MASK		(0xf << DBTP_DSJW_SHIFT)
> +
> +#define TCAN4x5x_QUEUE_LVL_MASK		0x1f
> +#define TCAN4x5x_QUEUE_IDX_SHIFT	16
> +#define TCAN4x5x_QUEUE_IDX_MASK		0x1f00
> +
> +#define TCAN4X5X_CANBUSNOM_INT_EN	BIT(14)
> +
> +#define TCAN4X5X_NUM_TX_BUF	5
> +#define TCAN4X5X_TX_QUEUE_SHIFT	24
> +#define TCAN4X5X_TX_NDTB_SHIFT	16
> +#define TCAN4X5X_TX_BUF_START	0x324
> +
> +#define TCAN4X5X_NUM_RX_BUF		3
> +#define TCAN4X5X_RX_WATER_MARK		2
> +#define TCAN4X5X_RX_WATER_MARK_SHIFT	24
> +#define TCAN4X5X_RX_FIFO_SZ_SHIFT	16
> +#define TCAN4X5X_RX_BUF_START		0x4
> +
> +#define TCAN4X5X_RX_F1DS_SHIFT	4
> +#define TCAN4X5X_RX_RBDS_SHIFT	8
> +
> +#define TCAN4X5X_RX_FIFO0_MESSAGE	BIT(0)
> +#define TCAN4X5X_RX_FIFO1_MESSAGE	BIT(4)
> +#define TCAN4X5X_RX_BUFFER_MESSAGE	BIT(19)
> +#define TCAN4X5X_RX_INDEX_MASK		0x3f00
> +#define TCAN4X5X_RX_INDEX_SHIFT		8
> +
> +#define TCAN4X5X_RX_ADDR_OFFSET		0x8000
> +#define TCAN4X5X_RX_BUF_ADDR_OFFSET	0x8100
> +#define TCAN4X5X_RX_ADDR_MASK		0xffff
> +
> +#define TCAN4X5X_ERR_PROTOCOL_MASK	0x7
> +#define TCAN4X5X_ERR_STUFERR		0x1
> +#define TCAN4X5X_ERR_FRMERR		0x2
> +#define TCAN4X5X_ERR_ACKERR		0x3
> +#define TCAN4X5X_ERR_BIT1ERR		0x4
> +#define TCAN4X5X_ERR_BIT0ERR		0x5
> +#define TCAN4X5X_ERR_CRCERR		0x6
> +
> +/* Interrupt bits */
> +#define TCAN4X5X_CANBUSTERMOPEN_INT_EN	BIT(30)
> +#define TCAN4X5X_CANHCANL_INT_EN	BIT(29)
> +#define TCAN4X5X_CANHBAT_INT_EN		BIT(28)
> +#define TCAN4X5X_CANLGND_INT_EN		BIT(27)
> +#define TCAN4X5X_CANBUSOPEN_INT_EN	BIT(26)
> +#define TCAN4X5X_CANBUSGND_INT_EN	BIT(25)
> +#define TCAN4X5X_CANBUSBAT_INT_EN	BIT(24)
> +#define TCAN4X5X_UVSUP_INT_EN		BIT(22)
> +#define TCAN4X5X_UVIO_INT_EN		BIT(21)
> +#define TCAN4X5X_TSD_INT_EN		BIT(19)
> +#define TCAN4X5X_ECCERR_INT_EN		BIT(16)
> +#define TCAN4X5X_CANINT_INT_EN		BIT(15)
> +#define TCAN4X5X_LWU_INT_EN		BIT(14)
> +#define TCAN4X5X_CANSLNT_INT_EN		BIT(10)
> +#define TCAN4X5X_CANDOM_INT_EN		BIT(8)
> +#define TCAN4X5X_CANBUS_ERR_INT_EN	BIT(5)
> +#define TCAN4X5X_BUS_FAULT		BIT(4)
> +#define TCAN4X5X_MCAN_INT		BIT(1)
> +#define TCAN4X5X_ENABLE_ALL_INT		(TCAN4X5X_MCAN_INT | \
> +					TCAN4X5X_BUS_FAULT | \
> +					TCAN4X5X_CANBUS_ERR_INT_EN | \
> +					TCAN4X5X_CANINT_INT_EN)
> +
> +/* MCAN Interrupt bits */
> +#define TCAN4X5X_MCAN_IR_ARA		BIT(29)
> +#define TCAN4X5X_MCAN_IR_PED		BIT(28)
> +#define TCAN4X5X_MCAN_IR_PEA		BIT(27)
> +#define TCAN4X5X_MCAN_IR_WD		BIT(26)
> +#define TCAN4X5X_MCAN_IR_BO		BIT(25)
> +#define TCAN4X5X_MCAN_IR_EW		BIT(24)
> +#define TCAN4X5X_MCAN_IR_EP		BIT(23)
> +#define TCAN4X5X_MCAN_IR_ELO		BIT(22)
> +#define TCAN4X5X_MCAN_IR_BEU		BIT(21)
> +#define TCAN4X5X_MCAN_IR_BEC		BIT(20)
> +#define TCAN4X5X_MCAN_IR_DRX		BIT(19)
> +#define TCAN4X5X_MCAN_IR_TOO		BIT(18)
> +#define TCAN4X5X_MCAN_IR_MRAF		BIT(17)
> +#define TCAN4X5X_MCAN_IR_TSW		BIT(16)
> +#define TCAN4X5X_MCAN_IR_TEFL		BIT(15)
> +#define TCAN4X5X_MCAN_IR_TEFF		BIT(14)
> +#define TCAN4X5X_MCAN_IR_TEFW		BIT(13)
> +#define TCAN4X5X_MCAN_IR_TEFN		BIT(12)
> +#define TCAN4X5X_MCAN_IR_TFE		BIT(11)
> +#define TCAN4X5X_MCAN_IR_TCF		BIT(10)
> +#define TCAN4X5X_MCAN_IR_TC		BIT(9)
> +#define TCAN4X5X_MCAN_IR_HPM		BIT(8)
> +#define TCAN4X5X_MCAN_IR_RF1L		BIT(7)
> +#define TCAN4X5X_MCAN_IR_RF1F		BIT(6)
> +#define TCAN4X5X_MCAN_IR_RF1W		BIT(5)
> +#define TCAN4X5X_MCAN_IR_RF1N		BIT(4)
> +#define TCAN4X5X_MCAN_IR_RF0L		BIT(3)
> +#define TCAN4X5X_MCAN_IR_RF0F		BIT(2)
> +#define TCAN4X5X_MCAN_IR_RF0W		BIT(1)
> +#define TCAN4X5X_MCAN_IR_RF0N		BIT(0)
> +#define TCAN4X5X_ENABLE_MCAN_INT	(TCAN4X5X_MCAN_IR_TC | \
> +					TCAN4X5X_MCAN_IR_RF0N | \
> +					TCAN4X5X_MCAN_IR_RF1N | \
> +					TCAN4X5X_MCAN_IR_RF0F | \
> +					TCAN4X5X_MCAN_IR_RF1F)
> +
> +/* CCR bits */
> +#define TCAN4X5X_CCCR_NISO_BOSCH	BIT(15)
> +#define TCAN4X5X_CCCR_TXP		BIT(15)
> +#define TCAN4X5X_CCCR_EFBI		BIT(13)
> +#define TCAN4X5X_CCCR_PXHD_DIS		BIT(12)
> +#define TCAN4X5X_CCCR_BRSE		BIT(9)
> +#define TCAN4X5X_CCCR_FDOE		BIT(8)
> +#define TCAN4X5X_CCCR_TEST		BIT(7)
> +#define TCAN4X5X_CCCR_DAR_DIS		BIT(6)
> +#define TCAN4X5X_CCCR_MON		BIT(5)
> +#define TCAN4X5X_CCCR_CSR		BIT(4)
> +#define TCAN4X5X_CCCR_CSA		BIT(3)
> +#define TCAN4X5X_CCCR_ASM		BIT(2)
> +#define TCAN4X5X_CCCR_CCE		BIT(1)
> +#define TCAN4X5X_CCCR_INIT		BIT(0)
> +
> +#define TCAN4X5X_EINT0			BIT(0)
> +#define TCAN4X5X_EINT1			BIT(1)
> +
> +struct tcan4x5x_rx_regs {
> +	u32 fifo_status_reg;
> +	u32 fifo_config_reg;
> +	u32 fifo_ack_reg;
> +	u32 rx_buf_shift;
> +};
> +
> +struct tcan4x5x_rx_regs tcan4x5x_fifo_regs[] = {
> +	{ TCAN4X5X_MCAN_RXF0S, TCAN4X5X_MCAN_RXF0C, TCAN4X5X_MCAN_RXF0A, 0},
> +	{ TCAN4X5X_MCAN_RXF1S, TCAN4X5X_MCAN_RXF1C, TCAN4X5X_MCAN_RXF1A, 4},
> +	{ TCAN4X5X_MCAN_NDAT1, TCAN4X5X_MCAN_RXBC, TCAN4X5X_MCAN_NDAT1, 8},
> +};
> +
> +enum tcan4x5x_data_size {
> +	TCAN4X5X_8_BYTE = 0,
> +	TCAN4X5X_12_BYTE,
> +	TCAN4X5X_16_BYTE,
> +	TCAN4X5X_20_BYTE,
> +	TCAN4X5X_24_BYTE,
> +	TCAN4X5X_32_BYTE,
> +	TCAN4X5X_48_BYTE,
> +	TCAN4X5X_64_BYTE,
> +};
> +
> +static const struct can_bittiming_const tcan4x5x_bittiming_const = {
> +	.name = DEVICE_NAME,
> +	.tseg1_min = 2,
> +	.tseg1_max = 31,
> +	.tseg2_min = 2,
> +	.tseg2_max = 16,
> +	.sjw_max = 16,
> +	.brp_min = 1,
> +	.brp_max = 32,
> +	.brp_inc = 1,
> +};
> +
> +static const struct can_bittiming_const tcan4x5x_data_bittiming_const = {
> +	.name = DEVICE_NAME,
> +	.tseg1_min = 1,
> +	.tseg1_max = 32,
> +	.tseg2_min = 1,
> +	.tseg2_max = 16,
> +	.sjw_max = 16,
> +	.brp_min = 1,
> +	.brp_max = 32,
> +	.brp_inc = 1,
> +};
> +
> +static void tcan4x5x_clean(struct net_device *net)
> +{
> +	struct tcan4x5x_priv *priv = netdev_priv(net);
> +
> +	if (priv->tx_skb || priv->tx_len)
> +		net->stats.tx_errors++;
> +	if (priv->tx_skb)
> +		dev_kfree_skb(priv->tx_skb);
> +	if (priv->tx_len)
> +		can_free_echo_skb(priv->net, 0);
> +
> +	priv->tx_skb = NULL;
> +	priv->tx_len = 0;
> +}
> +
> +static int regmap_spi_gather_write(void *context, const void *reg,
> +				   size_t reg_len, const void *val,
> +				   size_t val_len)
> +{
> +	struct device *dev = context;
> +	struct spi_device *spi = to_spi_device(dev);
> +	u32 addr;
> +	struct spi_message m;
> +	struct spi_transfer t[2] = {{ .tx_buf = &addr, .len = 4, .cs_change = 0,},
> +				   { .tx_buf = val, .len = val_len, },};
> +
> +	addr = TCAN4X5X_WRITE_CMD | (*((u16 *)reg) << 8) | val_len >> 2;
> +
> +	spi_message_init(&m);
> +	spi_message_add_tail(&t[0], &m);
> +	spi_message_add_tail(&t[1], &m);
> +
> +	return spi_sync(spi, &m);
> +}
> +
> +static int tcan4x5x_regmap_write(void *context, const void *data, size_t count)
> +{
> +	u16 *reg = (u16 *)(data);
> +	const u32 *val = data + 2;
> +
> +	return regmap_spi_gather_write(context, reg, 2, val, count - 2);
> +}
> +
> +static int regmap_spi_async_write(void *context,
> +				  const void *reg, size_t reg_len,
> +				  const void *val, size_t val_len,
> +				  struct regmap_async *a)
> +{
> +	return -ENOTSUPP;
> +}
> +
> +static struct regmap_async *regmap_spi_async_alloc(void)
> +{
> +	return NULL;
> +}
> +
> +static int tcan4x5x_regmap_read(void *context,
> +				const void *reg, size_t reg_size,
> +				void *val, size_t val_size)
> +{
> +	struct device *dev = context;
> +	struct spi_device *spi = to_spi_device(dev);
> +
> +	u32 addr = TCAN4X5X_READ_CMD | (*((u16 *)reg) << 8) | val_size >> 2;
> +
> +	return spi_write_then_read(spi, &addr, 4, val, val_size);
> +}
> +
> +static struct regmap_bus tcan4x5x_bus = {
> +	.write = tcan4x5x_regmap_write,
> +	.gather_write = regmap_spi_gather_write,
> +	.async_write = regmap_spi_async_write,
> +	.async_alloc = regmap_spi_async_alloc,
> +	.read = tcan4x5x_regmap_read,
> +	.read_flag_mask = 0x00,
> +	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
> +	.val_format_endian_default = REGMAP_ENDIAN_NATIVE,
> +};
> +
> +static uint8_t tcan4x5x_dlc_conv(uint8_t input)
> +{
> +	const static u8 lookup[7] = {12, 16, 20, 24, 32, 48, 64};
> +
> +	if (input < 9)
> +		return input;
> +
> +	if (input < 16)
> +		return lookup[(unsigned int)(input - 9)];
> +
> +	return 0;
> +}
> +
> +static uint8_t tcan4x5x_txrxesc_value(uint8_t input)
> +{
> +	const u8 lookup[8] = {8, 12, 16, 20, 24, 32, 48, 64};
> +	return lookup[(unsigned int)(input & 0x07)];
> +}
> +
> +static void tcan4x5x_hw_tx(struct tcan4x5x_priv *tcan4x5x)
> +{
> +	u32 sid, eid, exide, rtr, brs, esi, fdf, xtd, data_len;
> +	u32 mcan_address, mcan_tx_element_sz;
> +	int queue_stat, queue_lvl, queue_idx;
> +	struct canfd_frame *fd_frame;
> +	struct can_frame *frame;
> +	int tx_element_sz, i, temp;
> +	canid_t frame_id;
> +	u8 dlc_len;
> +
> +	regmap_read(tcan4x5x->regmap, TCAN4X5X_MCAN_TXFQS, &queue_stat);
> +	queue_lvl = queue_stat & TCAN4x5x_QUEUE_LVL_MASK;
> +	queue_idx = (queue_stat & TCAN4x5x_QUEUE_IDX_MASK) >> TCAN4x5x_QUEUE_IDX_SHIFT;
> +
> +	if (tcan4x5x->tx_skb->len == CAN_MTU) {
> +		fd_frame = NULL;
> +		frame = (struct can_frame *)tcan4x5x->tx_skb->data;
> +		frame_id = frame->can_id;
> +		dlc_len = frame->can_dlc;
> +		data_len = ((dlc_len % 4) + dlc_len) / 4;
> +		brs = 0;
> +	} else if (tcan4x5x->tx_skb->len == CANFD_MTU) {
> +		frame = NULL;
> +		fd_frame = (struct canfd_frame *)tcan4x5x->tx_skb->data;
> +		frame_id = fd_frame->can_id;
> +		dlc_len = fd_frame->len;
> +		data_len = ((dlc_len % 4) + dlc_len) / 4;
> +		brs = fd_frame->flags & CANFD_BRS;
> +		esi = fd_frame->flags & CANFD_ESI;
> +		fdf = 1;
> +	} else {
> +		return;
> +	}
> +
> +	eid = frame_id & CAN_EFF_MASK;
> +	rtr = (frame_id & CAN_RTR_FLAG) ? 1 : 0;
> +
> +	exide = (frame_id & CAN_EFF_FLAG) ? 1 : 0;
> +	if (exide) {
> +		sid = frame_id & CAN_EFF_MASK;
> +		xtd = 1;
> +	} else {
> +		sid = (frame_id & CAN_SFF_MASK) << TCAN4X5X_SID_SHIFT;
> +		xtd = 0;
> +	}
> +
> +	regmap_read(tcan4x5x->regmap, TCAN4X5X_MCAN_TXBC, &mcan_address);
> +
> +	mcan_address = (mcan_address & 0xffff) + TCAN4X5X_MRAM_START;
> +	temp = (uint8_t)((mcan_address >> 24) & 0x3F);
> +
> +	tx_element_sz = temp > 32 ? 32 : temp;
> +	temp = (uint8_t)((mcan_address >> 16) & 0x3F);
> +
> +	tx_element_sz += temp > 32 ? 32 : temp;
> +	mcan_address += ((uint32_t)tx_element_sz * queue_idx);
> +	regmap_read(tcan4x5x->regmap, TCAN4X5X_MCAN_TXESC, &mcan_tx_element_sz);
> +	tx_element_sz = tcan4x5x_txrxesc_value(mcan_tx_element_sz & 0x07) + 8;
> +	mcan_address += ((uint32_t)tx_element_sz * 0);
> +
> +	tx_element_sz = (tcan4x5x_dlc_conv(dlc_len & 0x0F) + 8) >> 2;
> +	if (tcan4x5x_dlc_conv(dlc_len & 0x0F) % 4)
> +		tx_element_sz += 1;
> +
> +	tcan4x5x->spi_tx_buf[0] = esi << TCAN4X5X_ESI_SHIFT |
> +				  xtd << TCAN4X5X_XTD_SHIFT |
> +				  rtr << TCAN4X5X_RTR_SHIFT | sid;
> +
> +	tcan4x5x->spi_tx_buf[1] = fdf << TCAN4X5X_FDF_SHIFT |
> +		 brs << TCAN4X5X_BRS_SHIFT | dlc_len << TCAN4X5X_DLC_SHIFT;
> +
> +	if (tcan4x5x->tx_skb->len == CAN_MTU)
> +		memcpy(tcan4x5x->spi_tx_buf + TCAN4X5X_DATA_PKT_OFF,
> +		       frame->data, dlc_len);
> +	else
> +		memcpy(tcan4x5x->spi_tx_buf + TCAN4X5X_DATA_PKT_OFF,
> +		       fd_frame->data, dlc_len);
> +
> +	for (i = dlc_len + 1; i < TCAN4X5X_BUF_LEN / 4; i++)
> +		tcan4x5x->spi_tx_buf[i] = 0;
> +
> +	regmap_bulk_write(tcan4x5x->regmap, mcan_address, tcan4x5x->spi_tx_buf,
> +			  TCAN4X5X_BUF_LEN);
> +
> +	regmap_write(tcan4x5x->regmap, TCAN4X5X_MCAN_TXBAR, (1 << (queue_idx)));
> +}
> +
> +int tcan4x5x_hw_rx(struct tcan4x5x_priv *tcan4x5x)
> +{
> +	u32 queue_idx, fifo_idx, fifo_start_addr, rx_buf_size, msg_type;
> +	u32 data_buffer[TCAN4X5X_BUF_LEN] = {0x0};
> +	u32 rx_header[2] = {0x0};
> +	struct tcan4x5x_rx_regs *buffer_regs;
> +	struct canfd_frame *fd_frame;
> +	int dlc_len, data_len;
> +	struct sk_buff *skb;
> +
> +	skb = alloc_canfd_skb(tcan4x5x->net, &fd_frame);
> +	if (!skb) {
> +		dev_err(&tcan4x5x->spi->dev, "cannot allocate RX skb\n");
> +		tcan4x5x->net->stats.rx_dropped++;
> +		return -ENOMEM;
> +	}
> +
> +	regmap_read(tcan4x5x->regmap, TCAN4X5X_MCAN_INT_FLAG, &msg_type);
> +	if (msg_type & TCAN4X5X_RX_FIFO0_MESSAGE) {
> +		buffer_regs = &tcan4x5x_fifo_regs[0];
> +	} else if (msg_type & TCAN4X5X_RX_FIFO1_MESSAGE) {
> +		buffer_regs = &tcan4x5x_fifo_regs[1];
> +	} else if (msg_type & TCAN4X5X_RX_BUFFER_MESSAGE) {
> +		buffer_regs = &tcan4x5x_fifo_regs[2];
> +	} else {
> +		buffer_regs = NULL;
> +		return -EINVAL;
> +	}
> +
> +	rx_buf_size = TCAN4X5X_BUF_LEN;
> +
> +	/* Determine which FIFO needs service */
> +	regmap_read(tcan4x5x->regmap, buffer_regs->fifo_status_reg, &fifo_idx);
> +	if (msg_type & TCAN4X5X_RX_BUFFER_MESSAGE)
> +		queue_idx = fifo_idx - 1;
> +	else
> +		queue_idx = (TCAN4X5X_RX_INDEX_MASK & fifo_idx) >> TCAN4X5X_RX_INDEX_SHIFT;
> +
> +	/* Calculate the FIFO start address to service */
> +	regmap_read(tcan4x5x->regmap, buffer_regs->fifo_config_reg, &fifo_start_addr);
> +	fifo_start_addr = (TCAN4X5X_RX_ADDR_MASK & fifo_start_addr);
> +	if (msg_type & TCAN4X5X_RX_BUFFER_MESSAGE)
> +		fifo_start_addr = fifo_start_addr + TCAN4X5X_RX_BUF_ADDR_OFFSET +
> +				  (rx_buf_size * queue_idx);
> +	else
> +		fifo_start_addr = fifo_start_addr + TCAN4X5X_RX_ADDR_OFFSET +
> +				  (rx_buf_size * queue_idx);
> +
> +	regmap_bulk_read(tcan4x5x->regmap, fifo_start_addr, rx_header, 2);
> +
> +	dlc_len = (rx_header[1] & TCAN4X5X_DLC_MASK) >> TCAN4X5X_DLC_SHIFT;
> +	if (dlc_len <= 8)
> +		data_len = dlc_len;
> +	else
> +		data_len = tcan4x5x_txrxesc_value(dlc_len);
> +
> +	regmap_bulk_read(tcan4x5x->regmap, fifo_start_addr + 8,
> +			 data_buffer, data_len / 4);
> +
> +	/* Acknowledge receipt of the data */
> +	regmap_write(tcan4x5x->regmap, buffer_regs->fifo_ack_reg, queue_idx);
> +
> +	if (rx_header[0] &  TCAN4X5X_XTD_MASK) {
> +		fd_frame->can_id = CAN_EFF_FLAG;
> +		fd_frame->can_id |= (rx_header[0] & CAN_EFF_MASK);
> +	} else {
> +		fd_frame->can_id |= ((rx_header[0] >> TCAN4X5X_SID_SHIFT) &
> +				    CAN_SFF_MASK);
> +	}
> +
> +	if (rx_header[0] & TCAN4X5X_RTR_MASK)
> +		fd_frame->can_id |= CAN_RTR_FLAG;
> +
> +	if (rx_header[0] & TCAN4X5X_ESI_MASK) {
> +		fd_frame->can_id |= CAN_ERR_FLAG;
> +		fd_frame->flags |= CANFD_ESI;
> +		netdev_dbg(tcan4x5x->net, "ESI Error\n");
> +	}
> +
> +	fd_frame->len = data_len;
> +	memcpy(fd_frame->data, data_buffer, fd_frame->len);
> +
> +	tcan4x5x->net->stats.rx_packets++;
> +	tcan4x5x->net->stats.rx_bytes += fd_frame->len;
> +
> +	can_led_event(tcan4x5x->net, CAN_LED_EVENT_RX);
> +	netif_rx_ni(skb);
> +
> +	return 0;
> +}
> +
> +static void tcan4x5x_sleep(struct spi_device *spi)
> +{
> +	struct tcan4x5x_priv *tcan4x5x = spi_get_drvdata(spi);
> +
> +	regmap_update_bits(tcan4x5x->regmap, TCAN4X5X_CONFIG,
> +			   TCAN4X5X_MODE_SEL_MASK, TCAN4X5X_MODE_STANDBY);
> +}
> +
> +static int tcan4x5x_reset(struct net_device *net)
> +{
> +	struct tcan4x5x_priv *tcan4x5x = netdev_priv(net);
> +
> +	if (tcan4x5x->reset_gpio) {
> +		gpiod_set_value_cansleep(tcan4x5x->reset_gpio, 1);
> +		udelay(10);
> +		gpiod_set_value_cansleep(tcan4x5x->reset_gpio, 0);
> +	} else {
> +		regmap_write(tcan4x5x->regmap, TCAN4X5X_CONFIG,
> +			     TCAN4X5X_SW_RESET);
> +	}
> +
> +	return 0;
> +}
> +
> +static int tcan4x5x_power_enable(struct regulator *reg, int enable)
> +{
> +	if (IS_ERR_OR_NULL(reg))
> +		return 0;
> +
> +	if (enable)
> +		return regulator_enable(reg);
> +	else
> +		return regulator_disable(reg);
> +}
> +
> +static irqreturn_t tcan4x5x_can_ist(int irq, void *dev_id)
> +{
> +	struct tcan4x5x_priv *tcan4x5x = dev_id;
> +	struct spi_device *spi = tcan4x5x->spi;
> +	struct net_device *net = tcan4x5x->net;
> +	enum can_state new_state;
> +	int intf, eflag, mcan_intf;
> +
> +	mutex_lock(&tcan4x5x->tcan4x5x_lock);
> +
> +	regmap_read(tcan4x5x->regmap, TCAN4X5X_INT_FLAGS, &intf);
> +	if (intf & TCAN4X5X_MCAN_INT)
> +		tcan4x5x_hw_rx(tcan4x5x);
> +
> +	regmap_read(tcan4x5x->regmap, TCAN4X5X_MCAN_INT_FLAG, &mcan_intf);
> +
> +	regmap_read(tcan4x5x->regmap, TCAN4X5X_STATUS, &eflag);
> +	/* Update can state */
> +	if (eflag & TCAN4X5X_MCAN_IR_BO)
> +		new_state = CAN_STATE_BUS_OFF;
> +	else if (eflag & TCAN4X5X_MCAN_IR_EP)
> +		new_state = CAN_STATE_ERROR_PASSIVE;
> +	else if (eflag & TCAN4X5X_MCAN_IR_EW)
> +		new_state = CAN_STATE_ERROR_WARNING;
> +	else
> +		new_state = CAN_STATE_ERROR_ACTIVE;
> +
> +	if (new_state != tcan4x5x->can.state) {
> +		struct can_frame *cf;
> +		struct sk_buff *skb;
> +		enum can_state rx_state, tx_state;
> +		u32 error_count;
> +
> +		skb = alloc_can_err_skb(net, &cf);
> +		if (!skb)
> +			goto ist_out;
> +
> +		regmap_read(tcan4x5x->regmap, TCAN4X5X_MCAN_ECR, &error_count);
> +		cf->data[6] = error_count & 0xff;
> +		cf->data[7] = error_count & 0x7f00 >> 8;
> +		tx_state = cf->data[6] >= cf->data[7] ? new_state : 0;
> +		rx_state = cf->data[6] <= cf->data[7] ? new_state : 0;
> +		can_change_state(net, cf, tx_state, rx_state);
> +		netif_rx_ni(skb);
> +
> +		if (new_state == CAN_STATE_BUS_OFF) {
> +			can_bus_off(net);
> +			if (tcan4x5x->can.restart_ms == 0) {
> +				tcan4x5x->force_quit = 1;
> +				tcan4x5x_sleep(spi);
> +				goto ist_out;
> +			}
> +		}
> +	}
> +
> +	/* Update bus errors */
> +	if ((intf & TCAN4X5X_BUS_FAULT) &&
> +	    (tcan4x5x->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)) {
> +		struct can_frame *cf;
> +		struct sk_buff *skb;
> +		u32 psr_err, error_count;
> +
> +		/* Check for protocol errors */
> +		regmap_read(tcan4x5x->regmap, TCAN4X5X_MCAN_PSR, &psr_err);
> +		if (psr_err & TCAN4X5X_ERR_PROTOCOL_MASK) {
> +			skb = alloc_can_err_skb(net, &cf);
> +			if (!skb)
> +				goto ist_out;
> +
> +			cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
> +			tcan4x5x->can.can_stats.bus_error++;
> +			tcan4x5x->net->stats.rx_errors++;
> +			if (psr_err & TCAN4X5X_ERR_BIT0ERR)
> +				cf->data[2] |= CAN_ERR_PROT_BIT0;
> +			else if (psr_err & TCAN4X5X_ERR_BIT1ERR)
> +				cf->data[2] |= CAN_ERR_PROT_BIT1;
> +			else if (psr_err & TCAN4X5X_ERR_FRMERR)
> +				cf->data[2] |= CAN_ERR_PROT_FORM;
> +			else if (psr_err & TCAN4X5X_ERR_STUFERR)
> +				cf->data[2] |= CAN_ERR_PROT_STUFF;
> +			else if (psr_err & TCAN4X5X_ERR_CRCERR)
> +				cf->data[3] |= CAN_ERR_PROT_LOC_CRC_SEQ;
> +			else if (psr_err & TCAN4X5X_ERR_ACKERR)
> +				cf->data[3] |= CAN_ERR_PROT_LOC_ACK;
> +
> +			regmap_read(tcan4x5x->regmap, TCAN4X5X_MCAN_ECR,
> +				    &error_count);
> +			cf->data[6] = error_count & 0xff;
> +			cf->data[7] = error_count & 0x7f00 >> 8;
> +			netdev_dbg(tcan4x5x->net, "Bus Error\n");
> +			netif_rx_ni(skb);
> +		}
> +	}
> +
> +	if (mcan_intf & TCAN4X5X_MCAN_IR_TC) {
> +		net->stats.tx_packets++;
> +		net->stats.tx_bytes += tcan4x5x->tx_len - 1;
> +		can_led_event(net, CAN_LED_EVENT_TX);
> +		if (tcan4x5x->tx_len) {
> +			can_get_echo_skb(net, 0);
> +			tcan4x5x->tx_len = 0;
> +		}
> +		netif_wake_queue(net);
> +	}
> +
> +ist_out:
> +	regmap_write(tcan4x5x->regmap, TCAN4X5X_INT_FLAGS, TCAN4X5X_CLEAR_ALL_INT);
> +	regmap_write(tcan4x5x->regmap, TCAN4X5X_STATUS, TCAN4X5X_CLEAR_ALL_INT);
> +	regmap_write(tcan4x5x->regmap, TCAN4X5X_MCAN_INT_FLAG,
> +		     TCAN4X5X_CLEAR_ALL_INT);
> +
> +	mutex_unlock(&tcan4x5x->tcan4x5x_lock);
> +	return IRQ_HANDLED;
> +}
> +
> +static int tcan4x5x_do_set_bittiming(struct net_device *net)
> +{
> +	struct tcan4x5x_priv *priv = netdev_priv(net);
> +	struct can_bittiming *bt = &priv->can.bittiming;
> +	struct can_bittiming *dbt = &priv->can.data_bittiming;
> +	u16 brp, sjw, tseg1, tseg2;
> +	int ret;
> +	u32 val;
> +
> +	brp = bt->brp - 1;
> +	sjw = bt->sjw - 1;
> +	tseg1 = bt->prop_seg + bt->phase_seg1 - 1;
> +	tseg2 = bt->phase_seg2 - 1;
> +	val = (brp << TCAN4X5X_NBRP_SHIFT) | (sjw << TCAN4X5X_NSJW_SHIFT) |
> +		(tseg1 << TCAN4X5X_NTSEG1_SHIFT) | tseg2;
> +
> +	ret = regmap_write(priv->regmap, TCAN4X5X_MCAN_NBTP, val);
> +	if (ret)
> +		return -EIO;
> +
> +	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
> +		val = 0;
> +		brp = dbt->brp - 1;
> +		sjw = dbt->sjw - 1;
> +		tseg1 = dbt->prop_seg + dbt->phase_seg1 - 1;
> +		tseg2 = dbt->phase_seg2 - 1;
> +
> +		/* TDC is only needed for bitrates beyond 2.5 MBit/s.
> +		 * This is mentioned in the "Bit Time Requirements for CAN FD"
> +		 * paper presented at the International CAN Conference 2013
> +		 */
> +		if (dbt->bitrate > 2500000) {
> +			u32 tdco, ssp;
> +
> +			/* Use the same value of secondary sampling point
> +			 * as the data sampling point
> +			 */
> +			ssp = dbt->sample_point;
> +
> +			/* Equation based on Bosch's M_CAN User Manual's
> +			 * Transmitter Delay Compensation Section
> +			 */
> +			tdco = (priv->can.clock.freq / 1000) *
> +			       ssp / dbt->bitrate;
> +
> +			/* Max valid TDCO value is 127 */
> +			if (tdco > 127) {
> +				netdev_warn(net, "TDCO value of %u is beyond maximum. Using maximum possible value\n",
> +					    tdco);
> +				tdco = 127;
> +			}
> +
> +			val |= DBTP_TDC;
> +			ret = regmap_write(priv->regmap, TCAN4X5X_MCAN_TDCR,
> +					   tdco << TCAN4X5X_TDCR_TDCO_SHIFT);
> +			if (ret)
> +				return -EIO;
> +		}
> +
> +		val |= (brp << DBTP_DBRP_SHIFT) |
> +			   (sjw << DBTP_DSJW_SHIFT) |
> +			   (tseg1 << DBTP_DTSEG1_SHIFT) |
> +			   (tseg2 << DBTP_DTSEG2_SHIFT);
> +
> +		ret = regmap_write(priv->regmap, TCAN4X5X_MCAN_DBTP, val);
> +	}
> +
> +	return ret;
> +}
> +
> +static int tcan4x5x_setup(struct spi_device *spi)
> +{
> +	struct tcan4x5x_priv *tcan4x5x = spi_get_drvdata(spi);
> +	int start_reg = TCAN4X5X_MRAM_START;
> +	int end_reg = start_reg + TCAN4X5X_MRAM_SIZE;
> +	int ret;
> +
> +	ret = regmap_write(tcan4x5x->regmap, TCAN4X5X_MCAN_INT_REG,
> +			   TCAN4X5X_CLEAR_ALL_INT);
> +	if (ret)
> +		return -EIO;
> +
> +	ret = regmap_write(tcan4x5x->regmap, TCAN4X5X_MCAN_INT_EN,
> +			   TCAN4X5X_ENABLE_MCAN_INT);
> +	if (ret)
> +		return -EIO;
> +
> +	ret = regmap_write(tcan4x5x->regmap, TCAN4X5X_MCAN_CCCR,
> +			   TCAN4X5X_CCCR_INIT | TCAN4X5X_CCCR_CCE);
> +	if (ret)
> +		return -EIO;
> +
> +	ret = regmap_write(tcan4x5x->regmap, TCAN4X5X_MCAN_CCCR,
> +			   TCAN4X5X_CCCR_INIT | TCAN4X5X_CCCR_CCE |
> +			   TCAN4X5X_CCCR_FDOE | TCAN4X5X_CCCR_BRSE);
> +	if (ret)
> +		return -EIO;
> +
> +	ret = tcan4x5x_do_set_bittiming(tcan4x5x->net);
> +	if (ret)
> +		return -EIO;
> +
> +	ret = regmap_write(tcan4x5x->regmap, TCAN4X5X_MCAN_TXESC,
> +			   TCAN4X5X_64_BYTE);
> +	if (ret)
> +		return -EIO;
> +
> +	ret = regmap_write(tcan4x5x->regmap, TCAN4X5X_MCAN_TXBC,
> +			   (TCAN4X5X_NUM_TX_BUF << TCAN4X5X_TX_QUEUE_SHIFT |
> +			   TCAN4X5X_TX_BUF_START));
> +	if (ret)
> +		return -EIO;
> +
> +	ret = regmap_write(tcan4x5x->regmap, TCAN4X5X_MCAN_RXF0C,
> +			   (TCAN4X5X_RX_WATER_MARK << TCAN4X5X_RX_WATER_MARK_SHIFT |
> +			   TCAN4X5X_NUM_RX_BUF << TCAN4X5X_RX_FIFO_SZ_SHIFT |
> +			   TCAN4X5X_RX_BUF_START));
> +	if (ret)
> +		return -EIO;
> +
> +	ret = regmap_write(tcan4x5x->regmap, TCAN4X5X_MCAN_RXESC,
> +			   (TCAN4X5X_64_BYTE << TCAN4X5X_RX_RBDS_SHIFT |
> +			   TCAN4X5X_64_BYTE << TCAN4X5X_RX_F1DS_SHIFT |
> +			   TCAN4X5X_64_BYTE));
> +	if (ret)
> +		return -EIO;
> +
> +	ret = regmap_write(tcan4x5x->regmap, TCAN4X5X_MCAN_TXBTIE,
> +			   TCAN4X5X_SET_ALL_INT);
> +	if (ret)
> +		return -EIO;
> +
> +
> +	ret = regmap_update_bits(tcan4x5x->regmap, TCAN4X5X_CONFIG,
> +				 TCAN4X5X_MODE_SEL_MASK, TCAN4X5X_MODE_NORMAL);
> +	if (ret)
> +		return -EIO;
> +
> +	ret = regmap_write(tcan4x5x->regmap, TCAN4X5X_MCAN_ILE, TCAN4X5X_EINT0);
> +	if (ret)
> +		return -EIO;
> +
> +	/* Zero out the MCAN buffers */
> +	while (start_reg < end_reg) {
> +		regmap_write(tcan4x5x->regmap, start_reg, 0);
> +		start_reg += 4;
> +	}
> +
> +	return ret;
> +}
> +
> +static void tcan4x5x_tx_work_handler(struct work_struct *ws)
> +{
> +	struct tcan4x5x_priv *tcan4x5x = container_of(ws, struct tcan4x5x_priv,
> +						tx_work);
> +	struct net_device *net = tcan4x5x->net;
> +	struct can_frame *frame;
> +
> +	mutex_lock(&tcan4x5x->tcan4x5x_lock);
> +	if (tcan4x5x->tx_skb) {
> +		if (tcan4x5x->can.state == CAN_STATE_BUS_OFF) {
> +			tcan4x5x_clean(net);
> +		} else {
> +			frame = (struct can_frame *)tcan4x5x->tx_skb->data;
> +			tcan4x5x_hw_tx(tcan4x5x);
> +			tcan4x5x->tx_len = 1 + frame->can_dlc;
> +			can_put_echo_skb(tcan4x5x->tx_skb, net, 0);
> +			tcan4x5x->tx_skb = NULL;
> +		}
> +	}
> +	mutex_unlock(&tcan4x5x->tcan4x5x_lock);
> +}
> +
> +static void tcan4x5x_restart_work_handler(struct work_struct *ws)
> +{
> +	struct tcan4x5x_priv *tcan4x5x = container_of(ws, struct tcan4x5x_priv,
> +						restart_work);
> +	struct spi_device *spi = tcan4x5x->spi;
> +	struct net_device *net = tcan4x5x->net;
> +
> +	mutex_lock(&tcan4x5x->tcan4x5x_lock);
> +	if (tcan4x5x->after_suspend) {
> +		tcan4x5x_reset(net);
> +		tcan4x5x_setup(spi);
> +		if (tcan4x5x->after_suspend & AFTER_SUSPEND_RESTART) {
> +			tcan4x5x_setup(spi);
> +		} else if (tcan4x5x->after_suspend & AFTER_SUSPEND_UP) {
> +			netif_device_attach(net);
> +			tcan4x5x_clean(net);
> +			tcan4x5x_setup(spi);
> +			netif_wake_queue(net);
> +		} else {
> +			tcan4x5x_sleep(spi);
> +		}
> +		tcan4x5x->after_suspend = 0;
> +		tcan4x5x->force_quit = 0;
> +	}
> +
> +	if (tcan4x5x->restart_tx) {
> +		tcan4x5x->restart_tx = 0;
> +		tcan4x5x_reset(net);
> +		tcan4x5x_clean(net);
> +		tcan4x5x_setup(spi);
> +		netif_wake_queue(net);
> +	}
> +	mutex_unlock(&tcan4x5x->tcan4x5x_lock);
> +}
> +
> +static int tcan4x5x_open(struct net_device *net)
> +{
> +	struct tcan4x5x_priv *priv = netdev_priv(net);
> +	struct spi_device *spi = priv->spi;
> +	unsigned long flags = IRQF_ONESHOT | IRQF_TRIGGER_LOW;
> +	int ret;
> +
> +	ret = open_candev(net);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&priv->tcan4x5x_lock);
> +	tcan4x5x_power_enable(priv->power, 1);
> +
> +	priv->force_quit = 0;
> +	priv->tx_skb = NULL;
> +	priv->tx_len = 0;
> +
> +	ret = request_threaded_irq(priv->irq, NULL, tcan4x5x_can_ist,
> +				   flags, DEVICE_NAME, priv);
> +	if (ret) {
> +		dev_err(&spi->dev, "failed to acquire irq %d %i\n",
> +			priv->irq, ret);
> +		goto out_close;
> +	}
> +
> +	priv->wq = alloc_workqueue("tcan4x5x_wq", WQ_FREEZABLE | WQ_MEM_RECLAIM,
> +				   0);
> +	if (!priv->wq) {
> +		ret = -ENOMEM;
> +		goto out_free_irq;
> +	}
> +
> +	INIT_WORK(&priv->tx_work, tcan4x5x_tx_work_handler);
> +	INIT_WORK(&priv->restart_work, tcan4x5x_restart_work_handler);
> +
> +	priv->spi_tx_buf = devm_kzalloc(&spi->dev, TCAN4X5X_BUF_LEN,
> +					GFP_KERNEL);
> +	if (!priv->spi_tx_buf) {
> +		ret = -ENOMEM;
> +		goto  out_free_wq;
> +	}
> +
> +	priv->spi_rx_buf = devm_kzalloc(&spi->dev, TCAN4X5X_BUF_LEN,
> +					GFP_KERNEL);
> +	if (!priv->spi_rx_buf) {
> +		ret = -ENOMEM;
> +		goto  out_free_wq;
> +	}
> +
> +	if (priv->wake_gpio)
> +		gpiod_set_value_cansleep(priv->wake_gpio, 1);
> +
> +	ret = tcan4x5x_reset(net);
> +	if (ret)
> +		goto out_free_wq;
> +
> +	ret = tcan4x5x_setup(spi);
> +	if (ret)
> +		goto out_free_wq;
> +
> +	can_led_event(net, CAN_LED_EVENT_OPEN);
> +	netif_wake_queue(net);
> +	mutex_unlock(&priv->tcan4x5x_lock);
> +
> +	return 0;
> +
> + out_free_wq:
> +	destroy_workqueue(priv->wq);
> + out_free_irq:
> +	free_irq(priv->irq, priv);
> +	tcan4x5x_sleep(spi);
> + out_close:
> +	tcan4x5x_power_enable(priv->power, 0);
> +	close_candev(net);
> +	mutex_unlock(&priv->tcan4x5x_lock);
> +	return ret;
> +}
> +
> +static int tcan4x5x_stop(struct net_device *net)
> +{
> +	struct tcan4x5x_priv *priv = netdev_priv(net);
> +	struct spi_device *spi = priv->spi;
> +
> +	close_candev(net);
> +
> +	priv->force_quit = 1;
> +	free_irq(priv->irq, priv);
> +	destroy_workqueue(priv->wq);
> +	priv->wq = NULL;
> +
> +	mutex_lock(&priv->tcan4x5x_lock);
> +
> +	priv->can.state = CAN_STATE_STOPPED;
> +	tcan4x5x_sleep(spi);
> +	tcan4x5x_power_enable(priv->power, 0);
> +
> +	mutex_unlock(&priv->tcan4x5x_lock);
> +
> +	can_led_event(net, CAN_LED_EVENT_STOP);
> +
> +	return 0;
> +}
> +
> +static netdev_tx_t tcan4x5x_hard_start_xmit(struct sk_buff *skb,
> +					    struct net_device *net)
> +{
> +	struct tcan4x5x_priv *priv = netdev_priv(net);
> +	struct spi_device *spi = priv->spi;
> +
> +	if (priv->tx_skb || priv->tx_len) {
> +		dev_warn(&spi->dev, "hard_xmit called while tx busy\n");
> +		return NETDEV_TX_BUSY;
> +	}
> +
> +	if (can_dropped_invalid_skb(net, skb))
> +		return NETDEV_TX_OK;
> +
> +	netif_stop_queue(net);
> +	priv->tx_skb = skb;
> +	queue_work(priv->wq, &priv->tx_work);
> +
> +	return NETDEV_TX_OK;
> +}
> +
> +static int tcan4x5x_do_set_mode(struct net_device *net, enum can_mode mode)
> +{
> +	struct tcan4x5x_priv *priv = netdev_priv(net);
> +
> +	switch (mode) {
> +	case CAN_MODE_START:
> +		tcan4x5x_clean(net);
> +		priv->can.state = CAN_STATE_ERROR_ACTIVE;
> +		priv->restart_tx = 1;
> +		queue_work(priv->wq, &priv->restart_work);
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct net_device_ops tcan4x5x_netdev_ops = {
> +	.ndo_open = tcan4x5x_open,
> +	.ndo_stop = tcan4x5x_stop,
> +	.ndo_start_xmit = tcan4x5x_hard_start_xmit,
> +	.ndo_change_mtu = can_change_mtu,
> +};
> +
> +static int tcan4x5x_parse_config(struct tcan4x5x_priv *tcan4x5x)
> +{
> +	tcan4x5x->reset_gpio = devm_gpiod_get_optional(&tcan4x5x->spi->dev,
> +						       "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(tcan4x5x->reset_gpio))
> +		tcan4x5x->reset_gpio = NULL;
> +
> +	tcan4x5x->wake_gpio = devm_gpiod_get_optional(&tcan4x5x->spi->dev,
> +						      "wake-up", GPIOD_OUT_LOW);
> +	if (IS_ERR(tcan4x5x->wake_gpio))
> +		tcan4x5x->wake_gpio = NULL;
> +
> +	tcan4x5x->interrupt_gpio = devm_gpiod_get(&tcan4x5x->spi->dev,
> +						  "data-ready", GPIOD_IN);
> +	if (IS_ERR(tcan4x5x->interrupt_gpio)) {
> +		dev_err(&tcan4x5x->spi->dev, "data-ready gpio not defined\n");
> +		return -EINVAL;
> +	}
> +
> +	tcan4x5x->irq = gpiod_to_irq(tcan4x5x->interrupt_gpio);
> +
> +	tcan4x5x->power = devm_regulator_get_optional(&tcan4x5x->spi->dev,
> +						      "vsup");
> +	if (PTR_ERR(tcan4x5x->power) == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;
> +
> +	return 0;
> +}
> +
> +static const struct regmap_config tcan4x5x_regmap = {
> +	.reg_bits = 16,
> +	.val_bits = 32,
> +	.cache_type = REGCACHE_NONE,
> +	.max_register = TCAN4X5X_MAX_REGISTER,
> +};
> +
> +static int tcan4x5x_can_probe(struct spi_device *spi)
> +{
> +	struct net_device *net;
> +	struct tcan4x5x_priv *priv;
> +	struct clk *clk;
> +	int freq, ret;
> +
> +	clk = devm_clk_get(&spi->dev, NULL);
> +	if (IS_ERR(clk)) {
> +		dev_err(&spi->dev, "no CAN clock source defined\n");
> +		freq = TCAN4X5X_EXT_CLK_DEF;
> +	} else {
> +		freq = clk_get_rate(clk);
> +	}
> +
> +	/* Sanity check */
> +	if (freq < 20000000 || freq > TCAN4X5X_EXT_CLK_DEF)
> +		return -ERANGE;
> +
> +	/* Allocate can/net device */
> +	net = alloc_candev(sizeof(*priv), TCAN4X5X_TX_ECHO_SKB_MAX);
> +	if (!net)
> +		return -ENOMEM;
> +
> +	if (!IS_ERR(clk)) {
> +		ret = clk_prepare_enable(clk);
> +		if (ret)
> +			goto out_free;
> +	}
> +
> +	net->netdev_ops = &tcan4x5x_netdev_ops;
> +	net->flags |= IFF_ECHO;
> +	net->mtu = CANFD_MTU;
> +
> +	priv = netdev_priv(net);
> +	priv->can.bittiming_const = &tcan4x5x_bittiming_const;
> +	priv->can.data_bittiming_const = &tcan4x5x_data_bittiming_const;
> +	priv->can.do_set_mode = tcan4x5x_do_set_mode;
> +	priv->can.clock.freq = freq;
> +	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
> +				       CAN_CTRLMODE_LISTENONLY |
> +				       CAN_CTRLMODE_BERR_REPORTING |
> +				       CAN_CTRLMODE_FD |
> +				       CAN_CTRLMODE_FD_NON_ISO;
> +	priv->net = net;
> +	priv->spi = spi;
> +	priv->clk = clk;
> +	spi_set_drvdata(spi, priv);
> +
> +	ret = tcan4x5x_parse_config(priv);
> +	if (ret)
> +		goto out_clk;
> +
> +	/* Configure the SPI bus */
> +	spi->bits_per_word = 32;
> +	ret = spi_setup(spi);
> +	if (ret)
> +		goto out_clk;
> +
> +	mutex_init(&priv->tcan4x5x_lock);
> +
> +	priv->regmap = devm_regmap_init(&spi->dev, &tcan4x5x_bus,
> +					&spi->dev, &tcan4x5x_regmap);
> +
> +	SET_NETDEV_DEV(net, &spi->dev);
> +	ret = register_candev(net);
> +	if (ret)
> +		goto error_probe;
> +
> +	devm_can_led_init(net);
> +
> +	netdev_info(net, "TCAN4X5X successfully initialized.\n");
> +	return 0;
> +
> +error_probe:
> +	tcan4x5x_power_enable(priv->power, 0);
> +out_clk:
> +	if (!IS_ERR(clk))
> +		clk_disable_unprepare(clk);
> +out_free:
> +	free_candev(net);
> +	dev_err(&spi->dev, "Probe failed, err=%d\n", -ret);
> +	return ret;
> +}
> +
> +static int tcan4x5x_can_remove(struct spi_device *spi)
> +{
> +	struct tcan4x5x_priv *priv = spi_get_drvdata(spi);
> +	struct net_device *net = priv->net;
> +
> +	unregister_candev(net);
> +
> +	tcan4x5x_power_enable(priv->power, 0);
> +
> +	if (!IS_ERR(priv->clk))
> +		clk_disable_unprepare(priv->clk);
> +
> +	free_candev(net);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id tcan4x5x_of_match[] = {
> +	{ .compatible = "ti,tcan4x5x", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, tcan4x5x_of_match);
> +
> +static const struct spi_device_id tcan4x5x_id_table[] = {
> +	{
> +		.name		= "tcan4x5x",
> +		.driver_data	= 0,
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, tcan4x5x_id_table);
> +
> +static struct spi_driver tcan4x5x_can_driver = {
> +	.driver = {
> +		.name = DEVICE_NAME,
> +		.of_match_table = tcan4x5x_of_match,
> +		.pm = NULL,
> +	},
> +	.id_table = tcan4x5x_id_table,
> +	.probe = tcan4x5x_can_probe,
> +	.remove = tcan4x5x_can_remove,
> +};
> +module_spi_driver(tcan4x5x_can_driver);
> +
> +MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com>");
> +MODULE_DESCRIPTION("Texas Instruments TCAN4x5x CAN driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/net/can/spi/tcan4x5x.h b/drivers/net/can/spi/tcan4x5x.h
> new file mode 100644
> index 000000000000..5e14ba571d49
> --- /dev/null
> +++ b/drivers/net/can/spi/tcan4x5x.h
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// SPI to CAN driver for the Texas Instruments TCA4x5x
> +// Flash driver chip family
> +// Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
> +
> +#define TCAN4X5X_DEV_ID0	0x00
> +#define TCAN4X5X_DEV_ID1	0x04
> +#define TCAN4X5X_REV		0x08
> +#define TCAN4X5X_STATUS		0x0C
> +#define TCAN4X5X_ERROR_STATUS	0x10
> +#define TCAN4X5X_CONTROL	0x14
> +
> +#define TCAN4X5X_CONFIG		0x800
> +#define TCAN4X5X_TS_PRESCALE	0x804
> +#define TCAN4X5X_TEST_REG	0x808
> +#define TCAN4X5X_INT_FLAGS	0x820
> +#define TCAN4X5X_MCAN_INT_REG	0x824
> +#define TCAN4X5X_INT_EN		0x830
> +
> +#define TCAN4X5X_MCAN_CREL	0x1000
> +#define TCAN4X5X_MCAN_ENDN	0x1004
> +#define TCAN4X5X_MCAN_CUST	0x1008
> +#define TCAN4X5X_MCAN_DBTP	0x100C
> +#define TCAN4X5X_MCAN_TEST	0x1010
> +#define TCAN4X5X_MCAN_RWD	0x1014
> +#define TCAN4X5X_MCAN_CCCR	0x1018
> +#define TCAN4X5X_MCAN_NBTP	0x101C
> +#define TCAN4X5X_MCAN_TSCC	0x1020
> +#define TCAN4X5X_MCAN_TSCV	0x1024
> +#define TCAN4X5X_MCAN_TOCC	0x1028
> +#define TCAN4X5X_MCAN_TOCV	0x102C
> +#define TCAN4X5X_MCAN_ECR	0x1040
> +#define TCAN4X5X_MCAN_PSR	0x1044
> +#define TCAN4X5X_MCAN_TDCR	0x1048
> +#define TCAN4X5X_MCAN_INT_FLAG	0x1050
> +#define TCAN4X5X_MCAN_INT_EN	0x1054
> +#define TCAN4X5X_MCAN_ILS	0x1058
> +#define TCAN4X5X_MCAN_ILE	0x105C
> +#define TCAN4X5X_MCAN_GFC	0x1080
> +#define TCAN4X5X_MCAN_SIDFC	0x1084
> +#define TCAN4X5X_MCAN_XIDFC	0x1088
> +#define TCAN4X5X_MCAN_XIDAM	0x1090
> +#define TCAN4X5X_MCAN_HPMS	0x1094
> +#define TCAN4X5X_MCAN_NDAT1	0x1098
> +#define TCAN4X5X_MCAN_NDAT2	0x109C
> +#define TCAN4X5X_MCAN_RXF0C	0x10A0
> +#define TCAN4X5X_MCAN_RXF0S	0x10A4
> +#define TCAN4X5X_MCAN_RXF0A	0x10A8
> +#define TCAN4X5X_MCAN_RXBC	0x10AC
> +#define TCAN4X5X_MCAN_RXF1C	0x10B0
> +#define TCAN4X5X_MCAN_RXF1S	0x10B4
> +#define TCAN4X5X_MCAN_RXF1A	0x10B8
> +#define TCAN4X5X_MCAN_RXESC	0x10BC
> +#define TCAN4X5X_MCAN_TXBC	0x10C0
> +#define TCAN4X5X_MCAN_TXFQS	0x10C4
> +#define TCAN4X5X_MCAN_TXESC	0x10C8
> +#define TCAN4X5X_MCAN_TXBRP	0x10CC
> +#define TCAN4X5X_MCAN_TXBAR	0x10D0
> +#define TCAN4X5X_MCAN_TXBCR	0x10D4
> +#define TCAN4X5X_MCAN_TXBTO	0x10D8
> +#define TCAN4X5X_MCAN_TXBCF	0x10DC
> +#define TCAN4X5X_MCAN_TXBTIE	0x10E0
> +#define TCAN4X5X_MCAN_TXBCIE	0x10E4
> +#define TCAN4X5X_MCAN_TXEFC	0x10F0
> +#define TCAN4X5X_MCAN_TXEFS	0x10F4
> +#define TCAN4X5X_MCAN_TXEFA	0x10F8
> +
> +#define TCAN4X5X_MRAM_START	0x8000
> +#define TCAN4X5X_MRAM_SIZE	2048
> +
> +#define TCAN4X5X_MAX_REGISTER	0x8fff
> +
> +/* 64 byte buffer + 8 byte MCAN header */
> +#define TCAN4X5X_BUF_LEN 	72
> +
> +struct tcan4x5x_priv {
> +	struct can_priv can;
> +	struct net_device *net;
> +	struct regmap *regmap;
> +	struct spi_device *spi;
> +
> +	struct mutex tcan4x5x_lock; /* SPI device lock */
> +
> +	struct gpio_desc *reset_gpio;
> +	struct gpio_desc *interrupt_gpio;
> +	struct gpio_desc *wake_gpio;
> +	struct regulator *power;
> +	struct clk *clk;
> +
> +	struct sk_buff *tx_skb;
> +	int tx_len;
> +
> +	struct workqueue_struct *wq;
> +	struct work_struct tx_work;
> +	struct work_struct restart_work;
> +
> +	u32 *spi_tx_buf;
> +	u32 *spi_rx_buf;
> +
> +	int force_quit;
> +	int after_suspend;
> +#define AFTER_SUSPEND_UP 1
> +#define AFTER_SUSPEND_DOWN 2
> +#define AFTER_SUSPEND_POWER 4
> +#define AFTER_SUSPEND_RESTART 8
> +	int restart_tx;
> +
> +	int irq;
> +};
> 


-- 
------------------
Dan Murphy
