Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967183AbeEXMuR convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 08:50:17 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.114]:50470 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935296AbeEXMuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 08:50:11 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDKsWRWlGSWpSXmKPExsUSt3OpsS7TVrZ
  og5l7OSymPnzCZjF39iRGi/tfjzJaXN41h81i68t3TBYPV85hsTi65x6zRd85dwcOj4lndT12
  zrrL7rFpVSebx51re9g8ni1cz+LxeZNcAFsUa2ZeUn5FAmvGnocbWQtuiVcsvJ7RwNgg0sXIx
  SEksIxR4ujV+SxdjJwcbAKGEvPevGcEsUUE0iXeXVjACFLELHCWSeLyws3MIAlhAVuJ9ccWs0
  IU2Uns3PIAyjaS2HD7MpjNIqAq0XDmDZDNwcErECDxrsEUxBQSqJL40wFWwSngLHG9rRdsFaO
  ArMSXxtVg05kFxCVuPZnPBGJLCAhILNlznhnCFpV4+fgfK4StIHH/TTdU3F7i9b13LBC2vsSj
  x48YIWxDiVXTDkDFzSU+nG2Hmq8jsWD3JzYIW1ti2cLXYHFeAUGJkzOfsExgFJ+F5IxZSFpmI
  WmZhaRlASPLKkbzpKLM9IyS3MTMHF1DAwNdQ0NjXRNdM73EKt0kvdRS3eTUvJKiRKCcXmJ5sV
  5xZW5yTopeXmrJJkZgrDMAwQ7GK2+TDzFKcjApifKGPWWOFuJLyk+pzEgszogvKs1JLT7EKMP
  BoSTB6/MWKCdYlJqeWpGWmQNMOjBpCQ4eJRFeBpA0b3FBYm5xZjpE6hSjopQ4rxJIQgAkkVGa
  B9cGS3SXGGWlhHkZgQ4R4ilILcrNLEGVf8UozsGoJMybADKFJzOvBG76K6DFTECLLy4HW1ySi
  JCSamAM/t4ydQ3HhstzM67WHrj4/Vd6n+CVpkqnX/M+rfYXvr9j9a5FPhWB+h841i74b1UZ/O
  6Hc9XqkmNF4vnX902dW7wvvSH3tb/YzNRCw+mLbeWfyh4//0lccnfx9Ql5h2Mni8/84n9pE7u
  FZorrpr2f3/ZLrslckWNr19kY8fTMLxOh/Q7XsrdsUWIpzkg01GIuKk4EAK+vYjFvAwAA
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-14.tower-239.messagelabs.com!1527166209!744531!1
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
Subject: RE: [PATCH 4/6] mfd: da9063: Disallow RTC on DA9063L
Thread-Topic: [PATCH 4/6] mfd: da9063: Disallow RTC on DA9063L
Thread-Index: AQHT8osyzhJTN0cRsUGP0zmiJT/5I6Q+zGHA
Date: Thu, 24 May 2018 12:50:08 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB701941A488A@SW-EX-MBX02.diasemi.com>
References: <20180523114230.10109-1-marek.vasut+renesas@gmail.com>
 <20180523114230.10109-4-marek.vasut+renesas@gmail.com>
In-Reply-To: <20180523114230.10109-4-marek.vasut+renesas@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.35.206]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub02.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 24/05/2018 11:32:00
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Marek,

On 23 May 2018 12:42 Marek Vasut wrote,

> To: linux-kernel@vger.kernel.org
> Cc: Marek Vasut <marek.vasut+renesas@gmail.com>; Geert Uytterhoeven <geert+renesas@glider.be>; Lee Jones <lee.jones@linaro.org>; Mark Brown <broonie@kernel.org>; Steve Twiss <stwiss.opensource@diasemi.com>; Wolfram Sang <wsa+renesas@sang-engineering.com>; linux-renesas-soc@vger.kernel.org
> Subject: [PATCH 4/6] mfd: da9063: Disallow RTC on DA9063L
>
> The DA9063L does not contain RTC block, unlike the full DA9063.
> Do not allow binding RTC driver on this variant of the chip.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Steve Twiss <stwiss.opensource@diasemi.com>
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: linux-renesas-soc@vger.kernel.org
> ---
>  drivers/mfd/da9063-core.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c index 7360b76b4f72..263c83006413 100644
> --- a/drivers/mfd/da9063-core.c
> +++ b/drivers/mfd/da9063-core.c
> @@ -101,14 +101,14 @@ static const struct mfd_cell da9063_devs[] = {
>  		.of_compatible = "dlg,da9063-onkey",
>  	},
>  	{
> +		.name		= DA9063_DRVNAME_VIBRATION,
> +	},
> +	{	/* Only present on DA9063 , not on DA9063L */
>  		.name		= DA9063_DRVNAME_RTC,
>  		.num_resources	= ARRAY_SIZE(da9063_rtc_resources),
>  		.resources	= da9063_rtc_resources,
>  		.of_compatible	= "dlg,da9063-rtc",
>  	},
> -	{
> -		.name		= DA9063_DRVNAME_VIBRATION,
> -	},
>  };
>  
>  static int da9063_clear_fault_log(struct da9063 *da9063) @@ -163,7 +163,7 @@ int da9063_device_init(struct da9063 *da9063, unsigned int irq)  {
>  	struct da9063_pdata *pdata = da9063->dev->platform_data;
>  	int model, variant_id, variant_code;
> -	int ret;
> +	int da9063_devs_len, ret;
>  
>  	ret = da9063_clear_fault_log(da9063);
>  	if (ret < 0)
> @@ -225,9 +225,13 @@ int da9063_device_init(struct da9063 *da9063, unsigned int irq)
>  
>  	da9063->irq_base = regmap_irq_chip_get_base(da9063->regmap_irq);
>  
> -	ret = mfd_add_devices(da9063->dev, -1, da9063_devs,
> -			      ARRAY_SIZE(da9063_devs), NULL, da9063->irq_base,
> -			      NULL);
> +	da9063_devs_len = ARRAY_SIZE(da9063_devs);
> +	/* RTC, the last device in the list, is only present on DA9063 */
> +	if (da9063->type == PMIC_TYPE_DA9063L)
> +		da9063_devs_len -= 1;
> +
> +	ret = mfd_add_devices(da9063->dev, -1, da9063_devs, da9063_devs_len,
> +			      NULL, da9063->irq_base, NULL);
>  	if (ret)
>  		dev_err(da9063->dev, "Cannot add MFD cells\n");
>  
> --
> 2.16.2

MFD cells definitely has less impact than regmap_range and regmap_irq.
I agree, there's no point in having a completely new 
static const struct mfd_cell da9063l_devs[] = { ... }  for DA9063L

Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>

Regards,
Steve
