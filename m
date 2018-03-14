Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752449AbeCNQEv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 12:04:51 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39175 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752266AbeCNQEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:04:49 -0400
X-Google-Smtp-Source: AG47ELuGhoElYwWiSrbF8YGM84rY1af4e6Y3/X8zPfSDISqdH31mS0miRt3J+rflvAETBJBToiIlwQ==
Date: Wed, 14 Mar 2018 09:04:47 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 28/47] input: misc: remove blackfin rotary driver
Message-ID: <20180314160447.GB18065@dtor-ws>
References: <20180314153603.3127932-1-arnd@arndb.de>
 <20180314153603.3127932-29-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314153603.3127932-29-arnd@arndb.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 04:35:41PM +0100, Arnd Bergmann wrote:
> The blackfin architecture is getting removed, so this
> one is obsolete as well.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Please take it through your tree with the rest of bfin removal patches.

> ---
>  drivers/input/misc/Kconfig                |   9 -
>  drivers/input/misc/Makefile               |   1 -
>  drivers/input/misc/bfin_rotary.c          | 294 ------------------------------
>  include/linux/platform_data/bfin_rotary.h | 117 ------------
>  4 files changed, 421 deletions(-)
>  delete mode 100644 drivers/input/misc/bfin_rotary.c
>  delete mode 100644 include/linux/platform_data/bfin_rotary.h
> 
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index 6a3c753b093b..572b15fa18c2 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -655,15 +655,6 @@ config INPUT_DM355EVM
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called dm355evm_keys.
>  
> -config INPUT_BFIN_ROTARY
> -	tristate "Blackfin Rotary support"
> -	depends on BF54x || BF52x
> -	help
> -	  Say Y here if you want to use the Blackfin Rotary.
> -
> -	  To compile this driver as a module, choose M here: the
> -	  module will be called bfin-rotary.
> -
>  config INPUT_WM831X_ON
>  	tristate "WM831X ON pin"
>  	depends on MFD_WM831X
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> index 8cc58f362bb8..72cde28649e2 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -19,7 +19,6 @@ obj-$(CONFIG_INPUT_ARIZONA_HAPTICS)	+= arizona-haptics.o
>  obj-$(CONFIG_INPUT_ATI_REMOTE2)		+= ati_remote2.o
>  obj-$(CONFIG_INPUT_ATLAS_BTNS)		+= atlas_btns.o
>  obj-$(CONFIG_INPUT_ATMEL_CAPTOUCH)	+= atmel_captouch.o
> -obj-$(CONFIG_INPUT_BFIN_ROTARY)		+= bfin_rotary.o
>  obj-$(CONFIG_INPUT_BMA150)		+= bma150.o
>  obj-$(CONFIG_INPUT_CM109)		+= cm109.o
>  obj-$(CONFIG_INPUT_CMA3000)		+= cma3000_d0x.o
> diff --git a/drivers/input/misc/bfin_rotary.c b/drivers/input/misc/bfin_rotary.c
> deleted file mode 100644
> index 799ce3d2820e..000000000000
> diff --git a/include/linux/platform_data/bfin_rotary.h b/include/linux/platform_data/bfin_rotary.h
> deleted file mode 100644
> index 98829370fee2..000000000000
> -- 
> 2.9.0
> 

-- 
Dmitry
