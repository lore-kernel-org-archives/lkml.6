Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752407AbeCNSOZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 14:14:25 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37100 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752313AbeCNSOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 14:14:23 -0400
Date: Wed, 14 Mar 2018 19:14:16 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH 09/47] rtc: remove bfin driver
Message-ID: <20180314181416.GB5899@piout.net>
References: <20180314153603.3127932-1-arnd@arndb.de>
 <20180314153603.3127932-10-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314153603.3127932-10-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2018 at 16:35:22 +0100, Arnd Bergmann wrote:
> The blackfin architecture is getting removed, so this one is
> now obsolete.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/rtc/Kconfig    |  10 --
>  drivers/rtc/Makefile   |   1 -
>  drivers/rtc/rtc-bfin.c | 448 -------------------------------------------------
>  3 files changed, 459 deletions(-)
>  delete mode 100644 drivers/rtc/rtc-bfin.c
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 0e1413a5ba3a..0ab8946f69b7 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1445,16 +1445,6 @@ config RTC_DRV_AU1XXX
>  	  This driver can also be built as a module. If so, the module
>  	  will be called rtc-au1xxx.
>  
> -config RTC_DRV_BFIN
> -	tristate "Blackfin On-Chip RTC"
> -	depends on BLACKFIN && !BF561
> -	help
> -	  If you say yes here you will get support for the
> -	  Blackfin On-Chip Real Time Clock.
> -
> -	  This driver can also be built as a module. If so, the module
> -	  will be called rtc-bfin.
> -
>  config RTC_DRV_RS5C313
>  	tristate "Ricoh RS5C313"
>  	depends on SH_LANDISK
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index f7a4b09557a0..5ff2fc0c361a 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -36,7 +36,6 @@ obj-$(CONFIG_RTC_DRV_ASM9260)	+= rtc-asm9260.o
>  obj-$(CONFIG_RTC_DRV_AT91RM9200)+= rtc-at91rm9200.o
>  obj-$(CONFIG_RTC_DRV_AT91SAM9)	+= rtc-at91sam9.o
>  obj-$(CONFIG_RTC_DRV_AU1XXX)	+= rtc-au1xxx.o
> -obj-$(CONFIG_RTC_DRV_BFIN)	+= rtc-bfin.o
>  obj-$(CONFIG_RTC_DRV_BRCMSTB)	+= rtc-brcmstb-waketimer.o
>  obj-$(CONFIG_RTC_DRV_BQ32K)	+= rtc-bq32k.o
>  obj-$(CONFIG_RTC_DRV_BQ4802)	+= rtc-bq4802.o
> diff --git a/drivers/rtc/rtc-bfin.c b/drivers/rtc/rtc-bfin.c
> deleted file mode 100644
> index 15344b7c07c5..000000000000
> -- 
> 2.9.0
> 

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
