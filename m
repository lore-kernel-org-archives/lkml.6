Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751399AbeEDMQc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 08:16:32 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57775 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751106AbeEDMQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 08:16:31 -0400
Date: Fri, 4 May 2018 14:16:19 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Lee Jones <lee.jones@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH REPOST] mfd: syscon: atmel-smc: include string.h
Message-ID: <20180504121619.GJ10960@piout.net>
References: <20180504103446.20104-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504103446.20104-1-bigeasy@linutronix.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2018 12:34:46+0200, Sebastian Andrzej Siewior wrote:
> The string.h header file is needed for the memset() definition. The RT
> build fails because it is not pulled in via other header files.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/mfd/atmel-smc.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- a/drivers/mfd/atmel-smc.c
> +++ b/drivers/mfd/atmel-smc.c
> @@ -12,6 +12,7 @@
>   */
>  
>  #include <linux/mfd/syscon/atmel-smc.h>
> +#include <linux/string.h>
>  
>  /**
>   * atmel_smc_cs_conf_init - initialize a SMC CS conf

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
