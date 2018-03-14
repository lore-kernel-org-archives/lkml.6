Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752227AbeCNSOI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 14:14:08 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37031 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751456AbeCNSOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 14:14:07 -0400
Date: Wed, 14 Mar 2018 19:14:00 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH 08/47] rtc: remove tile driver
Message-ID: <20180314181400.GA5899@piout.net>
References: <20180314153603.3127932-1-arnd@arndb.de>
 <20180314153603.3127932-9-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314153603.3127932-9-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2018 at 16:35:21 +0100, Arnd Bergmann wrote:
> The tile architecture is getting removed, so this driver is
> no longer needed.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/rtc/Kconfig    |   7 ---
>  drivers/rtc/Makefile   |   1 -
>  drivers/rtc/rtc-tile.c | 143 -------------------------------------------------
>  3 files changed, 151 deletions(-)
>  delete mode 100644 drivers/rtc/rtc-tile.c
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 5457d15bbcc0..0e1413a5ba3a 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1667,13 +1667,6 @@ config RTC_DRV_TEGRA
>  	  This drive can also be built as a module. If so, the module
>  	  will be called rtc-tegra.
>  
> -config RTC_DRV_TILE
> -	tristate "Tilera hypervisor RTC support"
> -	depends on TILE
> -	help
> -	  Enable support for the Linux driver side of the Tilera
> -	  hypervisor's real-time clock interface.
> -
>  config RTC_DRV_PUV3
>  	tristate "PKUnity v3 RTC support"
>  	depends on ARCH_PUV3
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index f481661a6eae..f7a4b09557a0 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -163,7 +163,6 @@ obj-$(CONFIG_RTC_DRV_SUN6I)	+= rtc-sun6i.o
>  obj-$(CONFIG_RTC_DRV_SUNXI)	+= rtc-sunxi.o
>  obj-$(CONFIG_RTC_DRV_TEGRA)	+= rtc-tegra.o
>  obj-$(CONFIG_RTC_DRV_TEST)	+= rtc-test.o
> -obj-$(CONFIG_RTC_DRV_TILE)	+= rtc-tile.o
>  obj-$(CONFIG_RTC_DRV_TPS6586X)	+= rtc-tps6586x.o
>  obj-$(CONFIG_RTC_DRV_TPS65910)	+= rtc-tps65910.o
>  obj-$(CONFIG_RTC_DRV_TPS80031)	+= rtc-tps80031.o
> diff --git a/drivers/rtc/rtc-tile.c b/drivers/rtc/rtc-tile.c
> deleted file mode 100644
> index ef1cdabf05b4..000000000000
> -- 
> 2.9.0
> 

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
