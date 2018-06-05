Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752256AbeFETwa convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 15:52:30 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.131]:29672 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751902AbeFETw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 15:52:28 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRWlGSWpSXmKPExsUSt3Opse6vl2L
  RBvv+KVpMffiEzWLu7EmMFve/HmW0uLxrDpvF1pfvmCwerpzDYnF0zz1mi75z7g4cHhPP6nrs
  nHWX3WPTqk42jzvX9rB5PFu4nsXj8ya5ALYo1sy8pPyKBNaMZZ33WQsWalZMPvCTuYHxv3IXI
  xeHkMBSRolnszqYuxg5OdgEDCXmvXnPCGKLCKRLvLuwgBGkiFngMpPEts2drCAJYQFPiVO73r
  BAFHlJXP2xFcjmALKNJK5vACthEVCR2HyhjQ3E5hUIkDjTdJsdxBYSqJI43POCCcTmFHCW6Py
  6G6yGUUBW4kvjarAbmAXEJW49mQ9WIyEgILFkz3lmCFtU4uXjf6wQtoLEvl8r2SBse4nX996B
  nSAhoC/R11gMETaUWDXtAAuEbS4xtechI8R4HYkFuz+xQdjaEssWvmaGOFNQ4uTMJywTGMVnI
  bliFpKWWUhaZiFpWcDIsorRIqkoMz2jJDcxM0fX0MBA19DQSNcIRBub6CVW6SbrpZbqlqcWl+
  ga6iWWF+sVV+Ym56To5aWWbGIExjsDEOxgvPct+RCjJAeTkiivziKxaCG+pPyUyozE4oz4otK
  c1OJDjDIcHEoSvPtfAOUEi1LTUyvSMnOAiQcmLcHBoyTC+xskzVtckJhbnJkOkTrFqCglzssJ
  TFdCAiCJjNI8uDZYsrvEKCslzMsIdIgQT0FqUW5mCar8K0ZxDkYlYd5IkPE8mXklcNNfAS1mA
  lr8rEIYZHFJIkJKqoHR6QVv63qF7qqvd27ue3gveu+8tHMs2jN6e0Ifel62kqiUd+NgWDxlo8
  ixMz4vJqRyz5U/uWOBdZS6hnbCZ94rCva8D8/MWrxy9WSlj64qn19cP/jGPeKI4WNX44/yKUc
  cl+yZq9qn6GT6siVW32mJNbPurskZ3Lt51hUwJbrNOv/rQO8fL/s6JZbijERDLeai4kQAjZMJ
  ZXEDAAA=
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-17.tower-302.messagelabs.com!1528228346!1110562!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Steve Twiss <stwiss.opensource@diasemi.com>
To: Marek Vasut <marek.vasut@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH v3 07/10] mfd: da9063: Add custom IRQ map for DA9063L
Thread-Topic: [PATCH v3 07/10] mfd: da9063: Add custom IRQ map for DA9063L
Thread-Index: AQHT+lozKwz3mlg9a0acsFGW5bI9eKRSEg+g
Date: Tue, 5 Jun 2018 19:52:25 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB701941AD6EC@SW-EX-MBX02.diasemi.com>
References: <20180602101155.26375-1-marek.vasut+renesas@gmail.com>
 <20180602101155.26375-7-marek.vasut+renesas@gmail.com>
In-Reply-To: <20180602101155.26375-7-marek.vasut+renesas@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.27.121]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub01.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 05/06/2018 15:14:00
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

Thanks.

On 02 June 2018 11:12, Marek Vasut wrote,

> Subject: [PATCH v3 07/10] mfd: da9063: Add custom IRQ map for DA9063L
> 
> While the datasheet for DA9063L (2v1, 23-Mar-2017) lists the RTC register
> block, the DA9063L does not have an RTC. Add custom IRQ map for DA9063L to
> ignore the Alarm and Tick IRQs from the PMIC.

I've added a request to remove the RTC references from the DA9063L datasheet.

Adding that first part to the sentence in the commit log: "While the datasheet for DA9063L
(2v1, 23-Mar-2017) lists the RTC register block" is just pointing out an ambiguity from the
datasheet since the it also identifies those registers in Table 102 on page 126 as
"Reserved".

I would like to suggest, the commit log entry: "Add custom IRQ map for DA9063L to ignore
the Alarm and Tick IRQs from the PMIC".

> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Steve Twiss <stwiss.opensource@diasemi.com>
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: linux-renesas-soc@vger.kernel.org
> ---
> V3: New patch
> ---
>  drivers/mfd/da9063-irq.c | 55
> ++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 53 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/da9063-irq.c b/drivers/mfd/da9063-irq.c
> index 5b406ecfc14a..b6a88861cc2e 100644
> --- a/drivers/mfd/da9063-irq.c
> +++ b/drivers/mfd/da9063-irq.c
> @@ -74,8 +74,55 @@ static const struct regmap_irq_chip da9063_irq_chip = {
>  	.init_ack_masked = true,
>  };
> 
> +static const struct regmap_irq da9063l_irqs[] = {
> +	/* DA9063 event A register */
> +	REGMAP_IRQ_REG(DA9063_IRQ_ONKEY,
> DA9063_REG_EVENT_A_OFFSET, DA9063_M_ONKEY),
> +	REGMAP_IRQ_REG(DA9063_IRQ_ADC_RDY,
> DA9063_REG_EVENT_A_OFFSET, DA9063_M_ADC_RDY),
> +	REGMAP_IRQ_REG(DA9063_IRQ_SEQ_RDY,
> DA9063_REG_EVENT_A_OFFSET, DA9063_M_SEQ_RDY),
> +	/* DA9063 event B register */
> +	REGMAP_IRQ_REG(DA9063_IRQ_WAKE,
> DA9063_REG_EVENT_B_OFFSET, DA9063_M_WAKE),
> +	REGMAP_IRQ_REG(DA9063_IRQ_TEMP,
> DA9063_REG_EVENT_B_OFFSET, DA9063_M_TEMP),
> +	REGMAP_IRQ_REG(DA9063_IRQ_COMP_1V2,
> DA9063_REG_EVENT_B_OFFSET, DA9063_M_COMP_1V2),
> +	REGMAP_IRQ_REG(DA9063_IRQ_LDO_LIM,
> DA9063_REG_EVENT_B_OFFSET, DA9063_M_LDO_LIM),
> +	REGMAP_IRQ_REG(DA9063_IRQ_REG_UVOV,
> DA9063_REG_EVENT_B_OFFSET, DA9063_M_UVOV),
> +	REGMAP_IRQ_REG(DA9063_IRQ_DVC_RDY,
> DA9063_REG_EVENT_B_OFFSET, DA9063_M_DVC_RDY),
> +	REGMAP_IRQ_REG(DA9063_IRQ_VDD_MON,
> DA9063_REG_EVENT_B_OFFSET, DA9063_M_VDD_MON),
> +	REGMAP_IRQ_REG(DA9063_IRQ_WARN,
> DA9063_REG_EVENT_B_OFFSET, DA9063_M_VDD_WARN),
> +	/* DA9063 event C register */
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI0, DA9063_REG_EVENT_C_OFFSET,
> DA9063_M_GPI0),
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI1, DA9063_REG_EVENT_C_OFFSET,
> DA9063_M_GPI1),
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI2, DA9063_REG_EVENT_C_OFFSET,
> DA9063_M_GPI2),
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI3, DA9063_REG_EVENT_C_OFFSET,
> DA9063_M_GPI3),
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI4, DA9063_REG_EVENT_C_OFFSET,
> DA9063_M_GPI4),
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI5, DA9063_REG_EVENT_C_OFFSET,
> DA9063_M_GPI5),
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI6, DA9063_REG_EVENT_C_OFFSET,
> DA9063_M_GPI6),
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI7, DA9063_REG_EVENT_C_OFFSET,
> DA9063_M_GPI7),
> +	/* DA9063 event D register */
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI8, DA9063_REG_EVENT_D_OFFSET,
> DA9063_M_GPI8),
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI9, DA9063_REG_EVENT_D_OFFSET,
> DA9063_M_GPI9),
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI10,
> DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI10),
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI11,
> DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI11),
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI12,
> DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI12),
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI13,
> DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI13),
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI14,
> DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI14),
> +	REGMAP_IRQ_REG(DA9063_IRQ_GPI15,
> DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI15),
> +};
> +
> +static const struct regmap_irq_chip da9063l_irq_chip = {
> +	.name = "da9063l-irq",
> +	.irqs = da9063l_irqs,
> +	.num_irqs = DA9063_NUM_IRQ,

Isn't the number of IRQs in the DA9063L different to the standard DA9063
because of the missing RTC?

Regards,
Steve

> +
> +	.num_regs = 4,
> +	.status_base = DA9063_REG_EVENT_A,
> +	.mask_base = DA9063_REG_IRQ_MASK_A,
> +	.ack_base = DA9063_REG_EVENT_A,
> +	.init_ack_masked = true,
> +};
> +
>  int da9063_irq_init(struct da9063 *da9063)
>  {
> +	struct regmap_irq_chip *irq_chip;
>  	int ret;
> 
>  	if (!da9063->chip_irq) {
> @@ -83,10 +130,14 @@ int da9063_irq_init(struct da9063 *da9063)
>  		return -EINVAL;
>  	}
> 
> +	if (da9063->type == PMIC_TYPE_DA9063)
> +		irq_chip = &da9063_irq_chip;
> +	else
> +		irq_chip = &da9063l_irq_chip;
> +
>  	ret = regmap_add_irq_chip(da9063->regmap, da9063->chip_irq,
>  			IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED,
> -			da9063->irq_base, &da9063_irq_chip,
> -			&da9063->regmap_irq);
> +			da9063->irq_base, irq_chip, &da9063->regmap_irq);
>  	if (ret) {
>  		dev_err(da9063->dev, "Failed to reguest IRQ %d: %d\n",
>  				da9063->chip_irq, ret);
> --
> 2.16.2
