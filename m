Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969307AbeEXLtD convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 07:49:03 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.3]:6861 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S967032AbeEXLs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 07:48:57 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGKsWRWlGSWpSXmKPExsUSt3Opse7yZWz
  RBo/niVtMffiEzWLu7EmMFve/HmW0uLxrDpvF1pfvmCwerpzDYnF0zz1mi75z7g4cHhPP6nrs
  nHWX3WPTqk42jzvX9rB5PFu4nsXj8ya5ALYo1sy8pPyKBNaMab/jCnYqVxw4sJalgbFVrouRk
  0NIYBmjxMJ2aRCbTcBQYt6b94wgtohAusS7CwuAbC4OZoGzTBKXF25mBkkIC1hK3J7WzwZRZC
  XR8vQBK4RtJHHywVWwOIuAqsS3l8/A4rwCARKrfz1gg1hWJXGqqYMdxOYUcJaYMv82WJxRQFb
  iS+NqsPnMAuISt57MZwKxJQQEJJbsOc8MYYtKvHz8jxXCVpC4/6YbKm4v8freO5YuRg4gW1+i
  r7EYImwosWraAaiwucSZPZEQ03UkFuz+xAZha0ssW/iaGeJKQYmTM5+wTGAUn4XkiFlIWmYha
  ZmFpGUBI8sqRrOkosz0jJLcxMwcXUMDA11DQyNdQ0tjXQu9xCrdRL3UUt3y1OISXUO9xPJive
  LK3OScFL281JJNjMA4ZwCCHYw7LyQfYpTkYFIS5XViZosW4kvKT6nMSCzOiC8qzUktPsQow8G
  hJMHbvRQoJ1iUmp5akZaZA0w4MGkJDh4lEd4nS4DSvMUFibnFmekQqVOMuhzHLk/rYRZiycvP
  S5US51UAmSEAUpRRmgc3Apb8LjHKSgnzMgIdJcRTkFqUm1mCKv+KUZyDUUmYtxRkCk9mXgncp
  ldARzABHXFxOTPIESWJCCmpBkbN+UHLdPs0+K6vOfNf4fP1rxdTyp8tvy3+s77F6VZfjnQm57
  Jjl97W3+W9ZX7j7b9u/6O+njoP1ubfvdIiO9kp8+O3zA9XWk1XVi6NaJnFEnjOM74/qef8xbC
  qZ/P36/7lm2Qx/+uOvJLoholO1S6l0lmiG8rdHZw+qj9edvyin/IjJ5f6zRxKLMUZiYZazEXF
  iQCTJFYNeQMAAA==
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-17.tower-268.messagelabs.com!1527162535!482216!1
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
        Steve Twiss <stwiss.opensource@diasemi.com>,
        "Wolfram Sang" <wsa+renesas@sang-engineering.com>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 6/6] mfd: da9063: Add DA9063L support
Thread-Topic: [PATCH 6/6] mfd: da9063: Add DA9063L support
Thread-Index: AQHT8os5coxuzP+3QEWWx7/bQ2GX+6Q+vSzw
Date: Thu, 24 May 2018 11:48:54 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB701941A47F0@SW-EX-MBX02.diasemi.com>
References: <20180523114230.10109-1-marek.vasut+renesas@gmail.com>
 <20180523114230.10109-6-marek.vasut+renesas@gmail.com>
In-Reply-To: <20180523114230.10109-6-marek.vasut+renesas@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.35.206]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub01.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 24/05/2018 10:04:00
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Marek,

> On 23 May 2018 12:43 Marek Vasut wrote,
>
> To: linux-kernel@vger.kernel.org
> Cc: Marek Vasut <marek.vasut+renesas@gmail.com>; Geert Uytterhoeven <geert+renesas@glider.be>;
> Lee Jones <lee.jones@linaro.org>; Mark Brown <broonie@kernel.org>; Steve Twiss <stwiss.opensource@diasemi.com>;
> Wolfram Sang <wsa+renesas@sang-engineering.com>; linux-renesas-soc@vger.kernel.org
> Subject: [PATCH 6/6] mfd: da9063: Add DA9063L support
>
> Add support for DA9063L, which is a reduced variant of the DA9063 with less regulators and without RTC.
>

There's potentially more to this file. Without an RTC the regmap access tables would change and the
usual DA9063 (BB silicon) tables would become invalid.
The tables for da9063_bb_readable_ranges, da9063_bb_writeable_ranges, da9063_bb_volatile_ranges,
would need to be updated for DA9063L, if a new chip model was needed.

The new ranges would be this (see below), and would remove any RTC accesses in the new chip model.

static const struct regmap_range da9063l_bb_readable_ranges[] = {
	{
		.range_min = DA9063_REG_PAGE_CON,
		.range_max = DA9063_REG_MON_A10_RES,
	}, {
		.range_min = DA9063_REG_SEQ,
		.range_max = DA9063_REG_ID_32_31,
	}, {
		.range_min = DA9063_REG_SEQ_A,
		.range_max = DA9063_REG_AUTO3_LOW,
	}, {
		.range_min = DA9063_REG_T_OFFSET,
		.range_max = DA9063_BB_REG_GP_ID_19,
	}, {
		.range_min = DA9063_REG_CHIP_ID,
		.range_max = DA9063_REG_CHIP_VARIANT,
	},
};

static const struct regmap_range da9063l_bb_writeable_ranges[] = {
	{
		.range_min = DA9063_REG_PAGE_CON,
		.range_max = DA9063_REG_PAGE_CON,
	}, {
		.range_min = DA9063_REG_FAULT_LOG,
		.range_max = DA9063_REG_VSYS_MON,
	}, {
		.range_min = DA9063_REG_SEQ,
		.range_max = DA9063_REG_ID_32_31,
	}, {
		.range_min = DA9063_REG_SEQ_A,
		.range_max = DA9063_REG_AUTO3_LOW,
	}, {
		.range_min = DA9063_REG_CONFIG_I,
		.range_max = DA9063_BB_REG_MON_REG_4,
	}, {
		.range_min = DA9063_BB_REG_GP_ID_0,
		.range_max = DA9063_BB_REG_GP_ID_19,
	},
};

static const struct regmap_range da9063l_bb_volatile_ranges[] = {
	{
		.range_min = DA9063_REG_PAGE_CON,
		.range_max = DA9063_REG_EVENT_D,
	}, {
		.range_min = DA9063_REG_CONTROL_A,
		.range_max = DA9063_REG_CONTROL_B,
	}, {
		.range_min = DA9063_REG_CONTROL_E,
		.range_max = DA9063_REG_CONTROL_F,
	}, {
		.range_min = DA9063_REG_BCORE2_CONT,
		.range_max = DA9063_REG_LDO11_CONT,
	}, {
		.range_min = DA9063_REG_DVC_1,
		.range_max = DA9063_REG_ADC_MAN,
	}, {
		.range_min = DA9063_REG_ADC_RES_L,
		.range_max = DA9063_REG_MON_A10_RES,
	}, {
		.range_min = DA9063_REG_SEQ,
		.range_max = DA9063_REG_SEQ,
	}, {
		.range_min = DA9063_REG_EN_32K,
		.range_max = DA9063_REG_EN_32K,
	}, {
		.range_min = DA9063_BB_REG_MON_REG_5,
		.range_max = DA9063_BB_REG_MON_REG_6,
	},
};

However this is a larger and more wide-ranging change compared to the one proposed by Marek,
and would require other alterations to fit this in. Also I'm undecided to what it would really add
apart from a new chip model: I have been told accessing the DA9063 RTC register locations has
no effect in the DA9063L.

If the maintainers are happy with this, and if a chip model addition is really needed in future
it can be added later if required.

Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>

Regards,
Steve

> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Steve Twiss <stwiss.opensource@diasemi.com>
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: linux-renesas-soc@vger.kernel.org
> ---
>  drivers/mfd/da9063-i2c.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c index 5544ce8e3363..84bbd2bbcd2a 100644
> --- a/drivers/mfd/da9063-i2c.c
> +++ b/drivers/mfd/da9063-i2c.c
> @@ -232,6 +232,7 @@ static struct regmap_config da9063_regmap_config = {
>  
>  static const struct of_device_id da9063_dt_ids[] = {
>  	{ .compatible = "dlg,da9063", },
> +	{ .compatible = "dlg,da9063l", },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, da9063_dt_ids); @@ -282,6 +283,7 @@ static int da9063_i2c_remove(struct i2c_client *i2c)
>  
>  static const struct i2c_device_id da9063_i2c_id[] = {
>  	{ "da9063", PMIC_TYPE_DA9063 },
> +	{ "da9063l", PMIC_TYPE_DA9063L },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(i2c, da9063_i2c_id);
> --
> 2.16.2
