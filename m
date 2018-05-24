Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966524AbeEXMcV convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 08:32:21 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.6]:40260 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S966042AbeEXMcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 08:32:19 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDKsWRWlGSWpSXmKPExsUSt3Opse7FDWz
  RBv3rlS2mPnzCZjF39iRGi/tfjzJaXN41h81i68t3TBYPV85hsTi65x6zRd85dwcOj4lndT12
  zrrL7rFpVSebx51re9g8ni1cz+LxeZNcAFsUa2ZeUn5FAmvG3BdzmQrOulR8mX2KvYHxuWUXI
  xeHkMAyRomTt14wdjFycrAJGErMe/MezBYRSJd4d2EBI0gRs8BcJonrHyawgSSEBSwlbk/rZ4
  MospJoefqAFcbu77wMFmcRUJV4/fI7E4jNKxAgMXXjW2aIbQcYJXbNmAvUwMHBKRAo8WENWA2
  jgKzEl8bVzCA2s4C4xK0n88HiEgICEkv2nGeGsEUlXj7+xwphK0jcf9MNFbeXeH3vHQvISAkB
  fYm+xmKIsKHEqmkHWCBsc4kPZ9uhxutILNj9iQ3C1pZYtvA1M8SZghInZz5hmcAoPgvJFbOQt
  MxC0jILScsCRpZVjJZJRZnpGSW5iZk5uoYGBrqGhsa6RrqG5uZ6iVW6iXqppbrJqXklRYlAWb
  3E8mK94src5JwUvbzUkk2MwJhnAIIdjPePJR9ilORgUhLlDXvKHC3El5SfUpmRWJwRX1Sak1p
  8iFGGg0NJgtfnLVBOsCg1PbUiLTMHmHxg0hIcPEoivAwgad7igsTc4sx0iNQpRl2OY5en9TAL
  seTl56VKifMqgRQJgBRllObBjYAlwkuMslLCvIxARwnxFKQW5WaWoMq/YhTnYFQS5k0AmcKTm
  VcCt+kV0BFMQEdcXA52REkiQkqqgVFnVuLRf37lP/TFb/blLUzo0boTnePZ/ogtleniJUm2PX
  OtPDXPfo1pmDGj5aF/jZJ9yE9Rxf64uhfLmqfUuu/avWzJIkPzlyql+t7r5V7O8GBR27VYb+b
  fQtm11qKTLywUvPWA6ekW6982VjWO6UodBuYxEfoxIVdXZsiaGrcJxXC+WrGZTYmlOCPRUIu5
  qDgRANoThhJ/AwAA
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-34.tower-229.messagelabs.com!1527165137!745456!1
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
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 6/6] mfd: da9063: Add DA9063L support
Thread-Topic: [PATCH 6/6] mfd: da9063: Add DA9063L support
Thread-Index: AQHT8os5coxuzP+3QEWWx7/bQ2GX+6Q+vSzwgAAR9hA=
Date: Thu, 24 May 2018 12:32:15 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB701941A4866@SW-EX-MBX02.diasemi.com>
References: <20180523114230.10109-1-marek.vasut+renesas@gmail.com>
 <20180523114230.10109-6-marek.vasut+renesas@gmail.com>
 <6ED8E3B22081A4459DAC7699F3695FB701941A47F0@SW-EX-MBX02.diasemi.com>
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB701941A47F0@SW-EX-MBX02.diasemi.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.35.206]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub01.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 24/05/2018 11:32:00
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On 24 May 2018 @ 12:49 Steve Twiss wrote:

> To: Marek Vasut <marek.vasut@gmail.com>; linux-kernel@vger.kernel.org
> Cc: Marek Vasut <marek.vasut+renesas@gmail.com>; Geert Uytterhoeven <geert+renesas@glider.be>; Lee Jones <lee.jones@linaro.org>; Mark Brown <broonie@kernel.org>; Steve Twiss <stwiss.opensource@diasemi.com>; Wolfram Sang <wsa+renesas@sang-engineering.com>; linux-renesas-soc@vger.kernel.org
> Subject: RE: [PATCH 6/6] mfd: da9063: Add DA9063L support
>
> Thanks Marek,
>
> > On 23 May 2018 12:43 Marek Vasut wrote,
> >
> > To: linux-kernel@vger.kernel.org
> > Cc: Marek Vasut <marek.vasut+renesas@gmail.com>; Geert Uytterhoeven <geert+renesas@glider.be>; Lee Jones <lee.jones@linaro.org>;
> > Mark Brown <broonie@kernel.org>; Steve Twiss <stwiss.opensource@diasemi.com>; Wolfram Sang <wsa+renesas@sang-engineering.com>; linux-renesas-soc@vger.kernel.org
> > Subject: [PATCH 6/6] mfd: da9063: Add DA9063L support
> >
> > Add support for DA9063L, which is a reduced variant of the DA9063 with less regulators and without RTC.
> >
>
> There's potentially more to this file. Without an RTC the regmap access tables would change
> and the usual DA9063 (BB silicon) tables would become invalid.
> The tables for da9063_bb_readable_ranges, da9063_bb_writeable_ranges, da9063_bb_volatile_ranges,
> would need to be updated for DA9063L, if a new chip model was needed.
>
> The new ranges would be this (see below), and would remove any RTC accesses in the new chip model.
>
> static const struct regmap_range da9063l_bb_readable_ranges[] = {
>	{
>		.range_min = DA9063_REG_PAGE_CON,
>		.range_max = DA9063_REG_MON_A10_RES,
>	}, {
>		.range_min = DA9063_REG_SEQ,
>		.range_max = DA9063_REG_ID_32_31,
>	}, {
>		.range_min = DA9063_REG_SEQ_A,
>		.range_max = DA9063_REG_AUTO3_LOW,
>	}, {
>		.range_min = DA9063_REG_T_OFFSET,
>		.range_max = DA9063_BB_REG_GP_ID_19,
>	}, {
>		.range_min = DA9063_REG_CHIP_ID,
>		.range_max = DA9063_REG_CHIP_VARIANT,
>	},
> };
>
> static const struct regmap_range da9063l_bb_writeable_ranges[] = {
>	{
>		.range_min = DA9063_REG_PAGE_CON,
>		.range_max = DA9063_REG_PAGE_CON,
>	}, {
>		.range_min = DA9063_REG_FAULT_LOG,
>		.range_max = DA9063_REG_VSYS_MON,
>	}, {
>		.range_min = DA9063_REG_SEQ,
>		.range_max = DA9063_REG_ID_32_31,
>	}, {
>		.range_min = DA9063_REG_SEQ_A,
>		.range_max = DA9063_REG_AUTO3_LOW,
>	}, {
>		.range_min = DA9063_REG_CONFIG_I,
>		.range_max = DA9063_BB_REG_MON_REG_4,
>	}, {
>		.range_min = DA9063_BB_REG_GP_ID_0,
>		.range_max = DA9063_BB_REG_GP_ID_19,
>	},
> };
>
> static const struct regmap_range da9063l_bb_volatile_ranges[] = {
>	{
>		.range_min = DA9063_REG_PAGE_CON,
>		.range_max = DA9063_REG_EVENT_D,
>	}, {
>		.range_min = DA9063_REG_CONTROL_A,
>		.range_max = DA9063_REG_CONTROL_B,
>	}, {
>		.range_min = DA9063_REG_CONTROL_E,
>		.range_max = DA9063_REG_CONTROL_F,
>	}, {
>		.range_min = DA9063_REG_BCORE2_CONT,
>		.range_max = DA9063_REG_LDO11_CONT,
>	}, {
>		.range_min = DA9063_REG_DVC_1,
>		.range_max = DA9063_REG_ADC_MAN,
>	}, {
>		.range_min = DA9063_REG_ADC_RES_L,
>		.range_max = DA9063_REG_MON_A10_RES,
>	}, {
>		.range_min = DA9063_REG_SEQ,
>		.range_max = DA9063_REG_SEQ,
>	}, {
>		.range_min = DA9063_REG_EN_32K,
>		.range_max = DA9063_REG_EN_32K,
>	}, {
>		.range_min = DA9063_BB_REG_MON_REG_5,
>		.range_max = DA9063_BB_REG_MON_REG_6,
>	},
> };
>
> However this is a larger and more wide-ranging change compared to the one proposed by Marek,
> and would require other alterations to fit this in. Also I'm undecided to what it would really add 
> apart from a new chip model: I have been told accessing the DA9063 RTC register locations has no
> effect in the DA9063L.

Looking at this further, there is also a new IRQ regmap.
Again this comes down to whether a full chip model is needed or not. If not, then the IRQ map does not
need to be changed as given. Otherwise the removal of the following:

	[DA9063_IRQ_ALARM] = {
		.reg_offset = DA9063_REG_EVENT_A_OFFSET,
		.mask = DA9063_M_ALARM,
	},
	[DA9063_IRQ_TICK] = {
		.reg_offset = DA9063_REG_EVENT_A_OFFSET,
		.mask = DA9063_M_TICK,
	},

prior to registering the IRQs in the chip model would be needed.
The new regmap_irq would be:

static const struct regmap_irq da9063l_irqs[] = {
	/* DA9063 event A register */
	[DA9063L_IRQ_ONKEY] = {
		.reg_offset = DA9063_REG_EVENT_A_OFFSET,
		.mask = DA9063_M_ONKEY,
	},
	[DA9063L_IRQ_ADC_RDY] = {
		.reg_offset = DA9063_REG_EVENT_A_OFFSET,
		.mask = DA9063_M_ADC_RDY,
	},
	[DA9063L_IRQ_SEQ_RDY] = {
		.reg_offset = DA9063_REG_EVENT_A_OFFSET,
		.mask = DA9063_M_SEQ_RDY,
	},
	/* DA9063 event B register */
	[DA9063L_IRQ_WAKE] = {
		.reg_offset = DA9063_REG_EVENT_B_OFFSET,
		.mask = DA9063_M_WAKE,
	},
	[DA9063L_IRQ_TEMP] = {
		.reg_offset = DA9063_REG_EVENT_B_OFFSET,
		.mask = DA9063_M_TEMP,
	},
	[DA9063L_IRQ_COMP_1V2] = {
		.reg_offset = DA9063_REG_EVENT_B_OFFSET,
		.mask = DA9063_M_COMP_1V2,
	},
	[DA9063L_IRQ_LDO_LIM] = {
		.reg_offset = DA9063_REG_EVENT_B_OFFSET,
		.mask = DA9063_M_LDO_LIM,
	},
	[DA9063L_IRQ_REG_UVOV] = {
		.reg_offset = DA9063_REG_EVENT_B_OFFSET,
		.mask = DA9063_M_UVOV,
	},
	[DA9063L_IRQ_DVC_RDY] = {
		.reg_offset = DA9063_REG_EVENT_B_OFFSET,
		.mask = DA9063_M_DVC_RDY,
	},
	[DA9063L_IRQ_VDD_MON] = {
		.reg_offset = DA9063_REG_EVENT_B_OFFSET,
		.mask = DA9063_M_VDD_MON,
	},
	[DA9063L_IRQ_WARN] = {
		.reg_offset = DA9063_REG_EVENT_B_OFFSET,
		.mask = DA9063_M_VDD_WARN,
	},
	/* DA9063 event C register */
	[DA9063L_IRQ_GPI0] = {
		.reg_offset = DA9063_REG_EVENT_C_OFFSET,
		.mask = DA9063_M_GPI0,
	},
	[DA9063L_IRQ_GPI1] = {
		.reg_offset = DA9063_REG_EVENT_C_OFFSET,
		.mask = DA9063_M_GPI1,
	},
	[DA9063L_IRQ_GPI2] = {
		.reg_offset = DA9063_REG_EVENT_C_OFFSET,
		.mask = DA9063_M_GPI2,
	},
	[DA9063L_IRQ_GPI3] = {
		.reg_offset = DA9063_REG_EVENT_C_OFFSET,
		.mask = DA9063_M_GPI3,
	},
	[DA9063L_IRQ_GPI4] = {
		.reg_offset = DA9063_REG_EVENT_C_OFFSET,
		.mask = DA9063_M_GPI4,
	},
	[DA9063L_IRQ_GPI5] = {
		.reg_offset = DA9063_REG_EVENT_C_OFFSET,
		.mask = DA9063_M_GPI5,
	},
	[DA9063L_IRQ_GPI6] = {
		.reg_offset = DA9063_REG_EVENT_C_OFFSET,
		.mask = DA9063_M_GPI6,
	},
	[DA9063L_IRQ_GPI7] = {
		.reg_offset = DA9063_REG_EVENT_C_OFFSET,
		.mask = DA9063_M_GPI7,
	},
	/* DA9063 event D register */
	[DA9063L_IRQ_GPI8] = {
		.reg_offset = DA9063_REG_EVENT_D_OFFSET,
		.mask = DA9063_M_GPI8,
	},
	[DA9063L_IRQ_GPI9] = {
		.reg_offset = DA9063_REG_EVENT_D_OFFSET,
		.mask = DA9063_M_GPI9,
	},
	[DA9063L_IRQ_GPI10] = {
		.reg_offset = DA9063_REG_EVENT_D_OFFSET,
		.mask = DA9063_M_GPI10,
	},
	[DA9063L_IRQ_GPI11] = {
		.reg_offset = DA9063_REG_EVENT_D_OFFSET,
		.mask = DA9063_M_GPI11,
	},
	[DA9063L_IRQ_GPI12] = {
		.reg_offset = DA9063_REG_EVENT_D_OFFSET,
		.mask = DA9063_M_GPI12,
	},
	[DA9063L_IRQ_GPI13] = {
		.reg_offset = DA9063_REG_EVENT_D_OFFSET,
		.mask = DA9063_M_GPI13,
	},
	[DA9063L_IRQ_GPI14] = {
		.reg_offset = DA9063_REG_EVENT_D_OFFSET,
		.mask = DA9063_M_GPI14,
	},
	[DA9063L_IRQ_GPI15] = {
		.reg_offset = DA9063_REG_EVENT_D_OFFSET,
		.mask = DA9063_M_GPI15,
	},
};

Regards,
Steve

>
> If the maintainers are happy with this, and if a chip model addition is really needed in future it can
> be added later if required.
>
> Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>
>
> Regards,
> Steve

> > Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: Steve Twiss <stwiss.opensource@diasemi.com>
> > Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Cc: linux-renesas-soc@vger.kernel.org
> > ---
> >  drivers/mfd/da9063-i2c.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c index 
> > 5544ce8e3363..84bbd2bbcd2a 100644
> > --- a/drivers/mfd/da9063-i2c.c
> > +++ b/drivers/mfd/da9063-i2c.c
> > @@ -232,6 +232,7 @@ static struct regmap_config da9063_regmap_config = 
> > {
> >  
> >  static const struct of_device_id da9063_dt_ids[] = {
> >  	{ .compatible = "dlg,da9063", },
> > +	{ .compatible = "dlg,da9063l", },
> >  	{ }
> >  };
> >  MODULE_DEVICE_TABLE(of, da9063_dt_ids); @@ -282,6 +283,7 @@ static 
> > int da9063_i2c_remove(struct i2c_client *i2c)
> >  
> >  static const struct i2c_device_id da9063_i2c_id[] = {
> >  	{ "da9063", PMIC_TYPE_DA9063 },
> > +	{ "da9063l", PMIC_TYPE_DA9063L },
> >  	{},
> >  };
> >  MODULE_DEVICE_TABLE(i2c, da9063_i2c_id);
> > --
> > 2.16.2
