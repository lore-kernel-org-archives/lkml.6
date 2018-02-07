Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753579AbeBGI66 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 03:58:58 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:46708 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750815AbeBGI64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 03:58:56 -0500
X-Google-Smtp-Source: AH8x226NUzkhkZkENMhZxYixsRaH5UG39sDs9H2OW8UhN9jvaIQ9SZ2CZGsHnHaGOmw8VcPRjC+l2w==
Subject: Re: [PATCH] spi: kconfig: Remove AVR32 dep. from SPI_ATMEL
To: Ulf Magnusson <ulfalizer@gmail.com>, broonie@kernel.org,
        linux-kernel@vger.kernel.org
Cc: clabbe.montjoie@gmail.com, viresh.kumar@linaro.org,
        linux-pwm@vger.kernel.org, thierry.reding@gmail.com,
        b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch,
        christophe.leroy@c-s.fr, seanpaul@chromium.org,
        linux-spi@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
References: <20180206120825.GF5681@sirena.org.uk>
 <20180206225519.20248-1-ulfalizer@gmail.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <7f2bebe1-2931-7ec9-ef9f-0d3e6dda6c0b@gmail.com>
Date: Wed, 7 Feb 2018 09:58:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180206225519.20248-1-ulfalizer@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/06/2018 11:55 PM, Ulf Magnusson wrote:
> The AVR32 symbol was removed in commit 26202873bb51 ("avr32: remove
> support for AVR32 architecture").
> 
> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
> ---

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

>  drivers/spi/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 603783976b81..c1e455d46c7f 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -72,7 +72,7 @@ config SPI_ARMADA_3700
>  config SPI_ATMEL
>  	tristate "Atmel SPI Controller"
>  	depends on HAS_DMA
> -	depends on (ARCH_AT91 || AVR32 || COMPILE_TEST)
> +	depends on (ARCH_AT91 || COMPILE_TEST)
>  	help
>  	  This selects a driver for the Atmel SPI Controller, present on
>  	  many AT32 (AVR32) and AT91 (ARM) chips.
> 
