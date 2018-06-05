Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752306AbeFETty convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 15:49:54 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.3]:3913 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751962AbeFETtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 15:49:53 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRWlGSWpSXmKPExsUSt3OpsW78S7F
  og9sP5CymPnzCZjF39iRGi/tfjzJaXN41h81i68t3TBYPV85hsTi65x6zRd85dwcOj4lndT12
  zrrL7rFpVSebx51re9g8ni1cz+LxeZNcAFsUa2ZeUn5FAmvG2yVnmAt2SFY0X3zA1sB4QrSLk
  YtDSGApo8TOow2MXYycHGwChhLz3rwHs0UE0iXeXVjACFLELHCZSWLb5k5WkISwQKjExidr2S
  GKwiTutN5jgrCNJB4vvgXWzCKgInFk1x8WEJtXIECiseUgmC0kUCUx9/YEsDmcAs4Sr9/sA6t
  nFJCV+NK4mhnEZhYQl7j1ZD7YTAkBAYkle84zQ9iiEi8f/2OFsBUk9v1ayQZh20u8vveOBcLW
  l3j0+BEjhG0osWraAai4ucTUnoeMEPN1JBbs/sQGYWtLLFv4mhniTkGJkzOfsExgFJ+F5IxZS
  FpmIWmZhaRlASPLKkazpKLM9IyS3MTMHF1DAwNdQ0MjXUNLY10LvcQq3US91FLd8tTiEl1Dvc
  TyYr3iytzknBS9vNSSTYzAeGcAgh2MOy8kH2KU5GBSEuXVWSQWLcSXlJ9SmZFYnBFfVJqTWny
  IUYaDQ0mC98xzoJxgUWp6akVaZg4w8cCkJTh4lER4uV4ApXmLCxJzizPTIVKnGBWlxHlfg/QJ
  gCQySvPg2mDJ7hKjrJQwLyPQIUI8BalFuZklqPKvGMU5GJWEeR+CTOHJzCuBm/4KaDET0OJnF
  cIgi0sSEVJSDYwm/JfqW38aqumesPvXKKAV5ZnHubXRqPKZ/Ryx+OD+B91rM9Mts3uDeWQYHl
  qFP+ttCHFn+uDmVrB+2kmlW+k7l1xcK8zbOi34aF9yU/1Dz8xEx7ktfI9Xbk64fvBN5etd6tG
  B3c3/Reqn5Ly9ZhX8yrTH7XZNpdQqXvF9y2RzOd4VHc1LVmIpzkg01GIuKk4EAC9rnyhxAwAA
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-23.tower-262.messagelabs.com!1528228191!1221468!1
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
Subject: RE: [PATCH v3 03/10] mfd: da9063: Rename PMIC_DA9063 to
 PMIC_CHIP_ID_DA9063
Thread-Topic: [PATCH v3 03/10] mfd: da9063: Rename PMIC_DA9063 to
 PMIC_CHIP_ID_DA9063
Thread-Index: AQHT+lowTneLOxdXIUmgCqzSDozouKRR7G5A
Date: Tue, 5 Jun 2018 19:49:50 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB701941AD6CE@SW-EX-MBX02.diasemi.com>
References: <20180602101155.26375-1-marek.vasut+renesas@gmail.com>
 <20180602101155.26375-3-marek.vasut+renesas@gmail.com>
In-Reply-To: <20180602101155.26375-3-marek.vasut+renesas@gmail.com>
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

> Subject: [PATCH v3 03/10] mfd: da9063: Rename PMIC_DA9063 to
> PMIC_CHIP_ID_DA9063
> 
> The PMIC_DA9063 is a complete misnomer, it denotes the value of the
> DA9063 chip ID register, so rename it as such. It is also the value
> of chip ID register of DA9063L though, so drop the enum as all the
> DA9063 "models" share the same chip ID and thus the distinction will
> have to be made using DT or otherwise.
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
>  drivers/mfd/da9063-core.c            | 2 +-
>  drivers/mfd/da9063-i2c.c             | 2 +-
>  drivers/regulator/da9063-regulator.c | 2 +-
>  include/linux/mfd/da9063/core.h      | 4 +---
>  4 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
> index 8226ebd8b96d..fb122316c421 100644
> --- a/drivers/mfd/da9063-core.c
> +++ b/drivers/mfd/da9063-core.c
> @@ -192,7 +192,7 @@ int da9063_device_init(struct da9063 *da9063, unsigned
> int irq)
>  		dev_err(da9063->dev, "Cannot read chip model id.\n");
>  		return -EIO;
>  	}
> -	if (model != PMIC_DA9063) {
> +	if (model != PMIC_CHIP_ID_DA9063) {
>  		dev_err(da9063->dev, "Invalid chip model id: 0x%02x\n", model);
>  		return -ENODEV;
>  	}
> diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
> index 981805a2c521..7f84030c8d53 100644
> --- a/drivers/mfd/da9063-i2c.c
> +++ b/drivers/mfd/da9063-i2c.c
> @@ -280,7 +280,7 @@ static int da9063_i2c_remove(struct i2c_client *i2c)
>  }
> 
>  static const struct i2c_device_id da9063_i2c_id[] = {
> -	{"da9063", PMIC_DA9063},
> +	{ "da9063", PMIC_CHIP_ID_DA9063 },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(i2c, da9063_i2c_id);
> diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-
> regulator.c
> index 6a8f9cd69f52..87c884ae0064 100644
> --- a/drivers/regulator/da9063-regulator.c
> +++ b/drivers/regulator/da9063-regulator.c
> @@ -585,7 +585,7 @@ static struct da9063_dev_model regulators_models[] = {
>  	{
>  		.regulator_info = da9063_regulator_info,
>  		.n_regulators = ARRAY_SIZE(da9063_regulator_info),
> -		.dev_model = PMIC_DA9063,
> +		.dev_model = PMIC_CHIP_ID_DA9063,
>  	},
>  	{ }
>  };
> diff --git a/include/linux/mfd/da9063/core.h b/include/linux/mfd/da9063/core.h
> index f3ae65db4c86..664f650d0086 100644
> --- a/include/linux/mfd/da9063/core.h
> +++ b/include/linux/mfd/da9063/core.h
> @@ -29,9 +29,7 @@
>  #define DA9063_DRVNAME_RTC		"da9063-rtc"
>  #define DA9063_DRVNAME_VIBRATION	"da9063-vibration"
> 
> -enum da9063_models {
> -	PMIC_DA9063 = 0x61,
> -};
> +#define PMIC_CHIP_ID_DA9063		0x61
> 
>  enum da9063_variant_codes {
>  	PMIC_DA9063_AD = 0x3,
> --
> 2.16.2

Hi Marek,

Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>

Regards,
Stephen
