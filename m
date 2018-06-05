Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbeFETrR convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 15:47:17 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.66]:25289 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751849AbeFETrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 15:47:15 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAKsWRWlGSWpSXmKPExsUSt3Opse7BF2L
  RBp9PyltMffiEzWLu7EmMFve/HmW0uLxrDpvF1pfvmCwerpzDYnF0zz1mi75z7g4cHhPP6nrs
  nHWX3WPTqk42jzvX9rB5PFu4nsXj8ya5ALYo1sy8pPyKBNaM25NesRUc5Km4Ov0oSwPjDa4uR
  i4OIYGljBKfJl5m6mLk5GATMJSY9+Y9I4gtIpAu8e7CAkaQImaBy0wS2zZ3soIkhAXsJD4s7o
  YqspfofN8BZRtJ7Pr7AqyGRUBFYs3qycwgNq9AgMSv/xPBbCGBaollXw+ygdicAi4Sly6+AIs
  zCshKfGlcDWYzC4hL3HoyH+wgCQEBiSV7zjND2KISLx//Y4WwFST2/VrJBmHbS7y+944FwtaX
  ePT4ESOEbSixatoBqLi5xNSeh4wQ83UkFuz+xAZha0ssW/ga6k5BiZMzn7BMYBSfheSMWUhaZ
  iFpmYWkZQEjyypGi6SizPSMktzEzBxdQwMDXUNDI11DSzNdQyNjvcQq3SS91FLd8tTiEl1Dvc
  TyYr3iytzknBS9vNSSTYzAmGcAgh2May8kH2KU5GBSEuXVWSQWLcSXlJ9SmZFYnBFfVJqTWny
  IUYaDQ0mC98xzoJxgUWp6akVaZg4w+cCkJTh4lER4pUDSvMUFibnFmekQqVOMilLivPNBEgIg
  iYzSPLg2WMK7xCgrJczLCHSIEE9BalFuZgmq/CtGcQ5GJWHeLJApPJl5JXDTXwEtZgJa/KxCG
  GRxSSJCSqqBcft7nh8bTzeX2vNN8BJW5kkP41pjuCP9+Py38xTKM95YG89pZ6s++GQ7R4DZoq
  tXGJ/tCLs+WWD6tYZJzM9/Mv71cjh7ROe4iUGZyudPLHMXe2hZal5rtsh7sSa85ebcLf9/bLm
  r+YN/ZVql1vJQK6sSh9cifdmHS9Y3nO3n6G+e1bb9m866ZCWW4oxEQy3mouJEABt/Q1BzAwAA
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-20.tower-282.messagelabs.com!1528228033!1232249!1
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
Subject: RE: [PATCH v3 10/10] mfd: da9063: Add DA9063L support
Thread-Topic: [PATCH v3 10/10] mfd: da9063: Add DA9063L support
Thread-Index: AQHT+lo1Y+5WZxh+8E+X8GNay+qAx6RSFrcQ
Date: Tue, 5 Jun 2018 19:47:11 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB701941AD6AD@SW-EX-MBX02.diasemi.com>
References: <20180602101155.26375-1-marek.vasut+renesas@gmail.com>
 <20180602101155.26375-10-marek.vasut+renesas@gmail.com>
In-Reply-To: <20180602101155.26375-10-marek.vasut+renesas@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.27.121]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub02.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 05/06/2018 15:14:00
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02 June 2018 11:12, Marek Vasut wrote,

> Subject: [PATCH v3 10/10] mfd: da9063: Add DA9063L support
> 
> Add support for DA9063L, which is a reduced variant of the DA9063
> with less regulators and without RTC.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Steve Twiss <stwiss.opensource@diasemi.com>
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: linux-renesas-soc@vger.kernel.org
> Acked-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> V2: No change
> V3: No change
> ---
>  drivers/mfd/da9063-i2c.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
> index f0d92a37df6b..74a3b10a7208 100644
> --- a/drivers/mfd/da9063-i2c.c
> +++ b/drivers/mfd/da9063-i2c.c
> @@ -319,6 +319,7 @@ static struct regmap_config da9063_regmap_config = {
> 
>  static const struct of_device_id da9063_dt_ids[] = {
>  	{ .compatible = "dlg,da9063", },
> +	{ .compatible = "dlg,da9063l", },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, da9063_dt_ids);
> @@ -373,6 +374,7 @@ static int da9063_i2c_remove(struct i2c_client *i2c)
> 
>  static const struct i2c_device_id da9063_i2c_id[] = {
>  	{ "da9063", PMIC_TYPE_DA9063 },
> +	{ "da9063l", PMIC_TYPE_DA9063L },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(i2c, da9063_i2c_id);
> --
> 2.16.2

Hi Marek,

Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>

Regards,
Steve 
