Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753071AbeDPOk4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 10:40:56 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41154 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753046AbeDPOkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 10:40:51 -0400
X-Google-Smtp-Source: AIpwx4/xIIwkWZ7G6CqlHypGZ0rnmk0dnVAuNeRFdcJl7JzExiiy8OV5yJv2CXZDH2iplf7Ma2Wc4g==
Date: Mon, 16 Apr 2018 15:40:46 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>, Milo Kim <Milo.Kim@ti.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>,
        Jingoo Han <jingoohan1@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCHv4 04/10] mfd: ti-lmu: drop of_compatible for backlight
 driver
Message-ID: <20180416144046.zf4iaedm7nkymstn@dell>
References: <20180330172414.26575-1-sebastian.reichel@collabora.co.uk>
 <20180330172414.26575-5-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180330172414.26575-5-sebastian.reichel@collabora.co.uk>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Mar 2018, Sebastian Reichel wrote:

> This removes the of_compatible for the backlight sub-device. There
> will be no extra sub-node for the backlight.

Won't doing this in a separate patch break bisectability?

> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> ---
>  drivers/mfd/ti-lmu.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/mfd/ti-lmu.c b/drivers/mfd/ti-lmu.c
> index 2ee09d099832..de76298cf3a8 100644
> --- a/drivers/mfd/ti-lmu.c
> +++ b/drivers/mfd/ti-lmu.c
> @@ -58,7 +58,6 @@ static const struct mfd_cell lm3532_devices[] = {
>  	{
>  		.name          = "ti-lmu-backlight",
>  		.id            = LM3532,
> -		.of_compatible = "ti,lm3532-backlight",
>  	},
>  };
>  
> @@ -78,7 +77,6 @@ static const struct mfd_cell lm3631_devices[] = {
>  	{
>  		.name          = "ti-lmu-backlight",
>  		.id            = LM3631,
> -		.of_compatible = "ti,lm3631-backlight",
>  	},
>  };
>  
> @@ -89,7 +87,6 @@ static const struct mfd_cell lm3632_devices[] = {
>  	{
>  		.name          = "ti-lmu-backlight",
>  		.id            = LM3632,
> -		.of_compatible = "ti,lm3632-backlight",
>  	},
>  };
>  
> @@ -97,7 +94,6 @@ static const struct mfd_cell lm3633_devices[] = {
>  	{
>  		.name          = "ti-lmu-backlight",
>  		.id            = LM3633,
> -		.of_compatible = "ti,lm3633-backlight",
>  	},
>  	{
>  		.name          = "lm3633-leds",
> @@ -115,7 +111,6 @@ static const struct mfd_cell lm3695_devices[] = {
>  	{
>  		.name          = "ti-lmu-backlight",
>  		.id            = LM3695,
> -		.of_compatible = "ti,lm3695-backlight",
>  	},
>  };
>  
> @@ -123,7 +118,6 @@ static const struct mfd_cell lm3697_devices[] = {
>  	{
>  		.name          = "ti-lmu-backlight",
>  		.id            = LM3697,
> -		.of_compatible = "ti,lm3697-backlight",
>  	},
>  	/* Monitoring driver for open/short circuit detection */
>  	{

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
