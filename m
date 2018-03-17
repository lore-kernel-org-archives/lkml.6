Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753011AbeCQBt0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 21:49:26 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:42163 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751832AbeCQBtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 21:49:23 -0400
X-Google-Smtp-Source: AG47ELs4mdPuymALgqhkDOKetC9INbrvuuQE1Gn2Qh1QmXK+VICMfPsuZpxRtNQdJg1qTgZfZmB28w==
Date: Fri, 16 Mar 2018 18:49:19 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Baruch Siach <baruch@tkos.co.il>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Johannes Thumshirn <morbidrsa@gmail.com>,
        Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [v6] watchdog: add SPDX identifiers for watchdog subsystem
Message-ID: <20180317014919.GA24040@roeck-us.net>
References: <20180316151411.4412-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316151411.4412-1-marcus.folkesson@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 04:14:11PM +0100, Marcus Folkesson wrote:
> - Add SPDX identifier
> - Remove boiler plate license text
> - If MODULE_LICENSE and boiler plate does not match, go for boiler plate
>   license
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Acked-by: Baruch Siach <baruch@tkos.co.il>
> Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> Acked-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
> Acked-by: Johannes Thumshirn <jth@kernel.org>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> Acked-by: Mans Rullgard <mans@mansr.com>
> Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
> Acked-by: Michal Simek <michal.simek@xilinx.com>
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> Acked-by: Tomas Winkler <tomas.winkler@intel.com>
> Acked-by: Patrice Chotard <patrice.chotard@st.com>
> Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> Reviewed-by: Eric Anholt <eric@anholt.net>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> Notes:
>     v6:
>     	- Only include those drivers that has been acked-by.
>     
>     drivers/watchdog/da9052_wdt.c
>     drivers/watchdog/da9055_wdt.c
>     drivers/watchdog/da9062_wdt.c
>     drivers/watchdog/da9063_wdt.c
>     Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
>     
>     drivers/watchdog/digicolor_wdt.c
>     Acked-by: Baruch Siach <baruch@tkos.co.il>
>     
>     drivers/watchdog/wm831x_wdt.c
>     drivers/watchdog/wm8350_wdt.c
>     Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
>     
>     drivers/watchdog/ar7_wdt.c
>     drivers/watchdog/bcm2835_wdt.c
>     drivers/watchdog/bcm47xx_wdt.c
>     drivers/watchdog/bcm63xx_wdt.c
>     drivers/watchdog/bcm7038_wdt.c
>     drivers/watchdog/bcm_kona_wdt.c
>     drivers/watchdog/mtx-1_wdt.c
>     Acked-by: Florian Fainelli <f.fainelli@gmail.com>
>     
>     drivers/watchdog/uniphier_wdt.c
>     Acked-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
>     
>     drivers/watchdog/mena21_wdt
>     Acked-by: Johannes Thumshirn <jth@kernel.org>
>     
>     drivers/watchdog/tangox_wdt.c
>     Acked-by: Mans Rullgard <mans@mansr.com>
>     
>     drivers/watchdog/mtk_wdt.c
>     Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
>     
>     drivers/watchdog/cadence_wdt.c
>     drivers/watchdog/of_xilinx_wdt.c
>     Acked-by: Michal Simek <michal.simek@xilinx.com>
>     
>     drivers/watchdog/meson_gxbb_wdt.c
>     Acked-by: Neil Armstrong <narmstrong@baylibre.com>
>     
>     drivers/watchdog/at91rm9200_wdt.c
>     drivers/watchdog/at91sam9_wdt.c
>     drivers/watchdog/at91sam9_wdt.h
>     drivers/watchdog/sama5d4_wdt.c
>     Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>     
>     drivers/watchdog/tegra_wdt.c
>     Acked-by: Thierry Reding <treding@nvidia.com>
>     
>     drivers/watchdog/mei_wdt.c
>     Acked-by: Tomas Winkler <tomas.winkler@intel.com>
>     
>     drivers/watchdog/st_lpc_wdt.c
>     Acked-by: Patrice Chotard <patrice.chotard@st.com>
>     
>     drivers/watchdog/ebc-c384_wdt.c
>     Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
>     
>     v5:
>     	- Add missing SPDX tag for Kconfig, rc32434_wdt and rdc321x_wdt
>     v4:
>     	- Drop coh901327_wdt since it allready is a pending patch
>     v3:
>     	- Keep license text for ebc-c384_wdt
>     v2:
>     	- Put back removed copyright texts for meson_gxbb_wdt and coh901327_wdt
>     	- Change to BSD-3-Clause for meson_gxbb_wdt
>     v1: Please have an extra look at meson_gxbb_wdt.c
> 
>  drivers/watchdog/ar7_wdt.c        | 14 +----------
>  drivers/watchdog/at91rm9200_wdt.c |  5 +---
>  drivers/watchdog/at91sam9_wdt.c   |  5 +---
>  drivers/watchdog/at91sam9_wdt.h   |  5 +---
>  drivers/watchdog/bcm2835_wdt.c    |  5 +---
>  drivers/watchdog/bcm47xx_wdt.c    |  5 +---
>  drivers/watchdog/bcm63xx_wdt.c    |  5 +---
>  drivers/watchdog/bcm7038_wdt.c    | 12 ++--------
>  drivers/watchdog/bcm_kona_wdt.c   |  9 +------
>  drivers/watchdog/cadence_wdt.c    |  5 +---
>  drivers/watchdog/da9052_wdt.c     |  6 +----
>  drivers/watchdog/da9055_wdt.c     |  6 +----
>  drivers/watchdog/da9062_wdt.c     | 10 +-------
>  drivers/watchdog/da9063_wdt.c     |  5 +---
>  drivers/watchdog/digicolor_wdt.c  |  5 +---
>  drivers/watchdog/ebc-c384_wdt.c   |  1 +
>  drivers/watchdog/mei_wdt.c        | 12 ++--------
>  drivers/watchdog/mena21_wdt.c     |  4 +---
>  drivers/watchdog/meson_gxbb_wdt.c | 50 +--------------------------------------
>  drivers/watchdog/mtk_wdt.c        | 11 +--------
>  drivers/watchdog/mtx-1_wdt.c      | 11 +--------
>  drivers/watchdog/of_xilinx_wdt.c  |  8 ++-----
>  drivers/watchdog/st_lpc_wdt.c     |  6 +----
>  drivers/watchdog/tangox_wdt.c     |  6 +----
>  drivers/watchdog/tegra_wdt.c      | 10 +-------
>  drivers/watchdog/uniphier_wdt.c   | 10 +-------
>  drivers/watchdog/wm831x_wdt.c     |  5 +---
>  drivers/watchdog/wm8350_wdt.c     |  5 +---
>  28 files changed, 31 insertions(+), 210 deletions(-)
> 
> diff --git a/drivers/watchdog/ar7_wdt.c b/drivers/watchdog/ar7_wdt.c
> index 6d5ae251e309..ee1ab12ab04f 100644
> --- a/drivers/watchdog/ar7_wdt.c
> +++ b/drivers/watchdog/ar7_wdt.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * drivers/watchdog/ar7_wdt.c
>   *
> @@ -8,19 +9,6 @@
>   * National Semiconductor SCx200 Watchdog support
>   * Copyright (c) 2001,2002 Christer Weinigel <wingel@nano-system.com>
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>   */
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> diff --git a/drivers/watchdog/at91rm9200_wdt.c b/drivers/watchdog/at91rm9200_wdt.c
> index e12a797cb820..b45fc0aee667 100644
> --- a/drivers/watchdog/at91rm9200_wdt.c
> +++ b/drivers/watchdog/at91rm9200_wdt.c
> @@ -1,12 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Watchdog driver for Atmel AT91RM9200 (Thunder)
>   *
>   *  Copyright (C) 2003 SAN People (Pty) Ltd
>   *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * as published by the Free Software Foundation; either version
> - * 2 of the License, or (at your option) any later version.
>   */
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
> index 88c05d0448b2..f4050a229eb5 100644
> --- a/drivers/watchdog/at91sam9_wdt.c
> +++ b/drivers/watchdog/at91sam9_wdt.c
> @@ -1,12 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Watchdog driver for Atmel AT91SAM9x processors.
>   *
>   * Copyright (C) 2008 Renaud CERRATO r.cerrato@til-technologies.fr
>   *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * as published by the Free Software Foundation; either version
> - * 2 of the License, or (at your option) any later version.
>   */
>  
>  /*
> diff --git a/drivers/watchdog/at91sam9_wdt.h b/drivers/watchdog/at91sam9_wdt.h
> index b79a83b467ce..390941c65eee 100644
> --- a/drivers/watchdog/at91sam9_wdt.h
> +++ b/drivers/watchdog/at91sam9_wdt.h
> @@ -1,3 +1,4 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
>  /*
>   * drivers/watchdog/at91sam9_wdt.h
>   *
> @@ -7,10 +8,6 @@
>   * Watchdog Timer (WDT) - System peripherals regsters.
>   * Based on AT91SAM9261 datasheet revision D.
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
>   */
>  
>  #ifndef AT91_WDT_H
> diff --git a/drivers/watchdog/bcm2835_wdt.c b/drivers/watchdog/bcm2835_wdt.c
> index b339e0e67b4c..ed05514cc2dc 100644
> --- a/drivers/watchdog/bcm2835_wdt.c
> +++ b/drivers/watchdog/bcm2835_wdt.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Watchdog driver for Broadcom BCM2835
>   *
> @@ -7,10 +8,6 @@
>   *
>   * Copyright (C) 2013 Lubomir Rintel <lkundrak@v3.sk>
>   *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of the GNU General Public License as published by the
> - * Free Software Foundation; either version 2 of the License, or (at your
> - * option) any later version.
>   */
>  
>  #include <linux/delay.h>
> diff --git a/drivers/watchdog/bcm47xx_wdt.c b/drivers/watchdog/bcm47xx_wdt.c
> index f41b756d6dd5..05425c1dfd4c 100644
> --- a/drivers/watchdog/bcm47xx_wdt.c
> +++ b/drivers/watchdog/bcm47xx_wdt.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   *  Watchdog driver for Broadcom BCM47XX
>   *
> @@ -5,10 +6,6 @@
>   *  Copyright (C) 2009 Matthieu CASTET <castet.matthieu@free.fr>
>   *  Copyright (C) 2012-2013 Hauke Mehrtens <hauke@hauke-m.de>
>   *
> - *  This program is free software; you can redistribute it and/or
> - *  modify it under the terms of the GNU General Public License
> - *  as published by the Free Software Foundation; either version
> - *  2 of the License, or (at your option) any later version.
>   */
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> diff --git a/drivers/watchdog/bcm63xx_wdt.c b/drivers/watchdog/bcm63xx_wdt.c
> index 8555afc70f9b..d3c1113e774c 100644
> --- a/drivers/watchdog/bcm63xx_wdt.c
> +++ b/drivers/watchdog/bcm63xx_wdt.c
> @@ -1,13 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   *  Broadcom BCM63xx SoC watchdog driver
>   *
>   *  Copyright (C) 2007, Miguel Gaio <miguel.gaio@efixo.com>
>   *  Copyright (C) 2008, Florian Fainelli <florian@openwrt.org>
>   *
> - *  This program is free software; you can redistribute it and/or
> - *  modify it under the terms of the GNU General Public License
> - *  as published by the Free Software Foundation; either version
> - *  2 of the License, or (at your option) any later version.
>   */
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> diff --git a/drivers/watchdog/bcm7038_wdt.c b/drivers/watchdog/bcm7038_wdt.c
> index f88f546e8050..ce3f646e8077 100644
> --- a/drivers/watchdog/bcm7038_wdt.c
> +++ b/drivers/watchdog/bcm7038_wdt.c
> @@ -1,15 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Copyright (C) 2015 Broadcom Corporation
>   *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * as published by the Free Software Foundation; either version 2
> - * of the License, or (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
>   */
>  
>  #include <linux/clk.h>
> @@ -235,6 +227,6 @@ module_platform_driver(bcm7038_wdt_driver);
>  module_param(nowayout, bool, 0);
>  MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
>  	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> -MODULE_LICENSE("GPL v2");
> +MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("Driver for Broadcom 7038 SoCs Watchdog");
>  MODULE_AUTHOR("Justin Chen");
> diff --git a/drivers/watchdog/bcm_kona_wdt.c b/drivers/watchdog/bcm_kona_wdt.c
> index a5775dfd8d5f..1462be9e6fc5 100644
> --- a/drivers/watchdog/bcm_kona_wdt.c
> +++ b/drivers/watchdog/bcm_kona_wdt.c
> @@ -1,14 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (C) 2013 Broadcom Corporation
>   *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License as
> - * published by the Free Software Foundation version 2.
> - *
> - * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> - * kind, whether express or implied; without even the implied warranty
> - * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
>   */
>  
>  #include <linux/debugfs.h>
> diff --git a/drivers/watchdog/cadence_wdt.c b/drivers/watchdog/cadence_wdt.c
> index 064cf7b6c1c5..3ec1f418837d 100644
> --- a/drivers/watchdog/cadence_wdt.c
> +++ b/drivers/watchdog/cadence_wdt.c
> @@ -1,12 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Cadence WDT driver - Used by Xilinx Zynq
>   *
>   * Copyright (C) 2010 - 2014 Xilinx, Inc.
>   *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * as published by the Free Software Foundation; either version
> - * 2 of the License, or (at your option) any later version.
>   */
>  
>  #include <linux/clk.h>
> diff --git a/drivers/watchdog/da9052_wdt.c b/drivers/watchdog/da9052_wdt.c
> index d6d5006efa71..e263bad99574 100644
> --- a/drivers/watchdog/da9052_wdt.c
> +++ b/drivers/watchdog/da9052_wdt.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * System monitoring driver for DA9052 PMICs.
>   *
> @@ -5,11 +6,6 @@
>   *
>   * Author: Anthony Olech <Anthony.Olech@diasemi.com>
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
>   */
>  
>  #include <linux/module.h>
> diff --git a/drivers/watchdog/da9055_wdt.c b/drivers/watchdog/da9055_wdt.c
> index 50bdd1022186..26a5b2984094 100644
> --- a/drivers/watchdog/da9055_wdt.c
> +++ b/drivers/watchdog/da9055_wdt.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * System monitoring driver for DA9055 PMICs.
>   *
> @@ -5,11 +6,6 @@
>   *
>   * Author: David Dajun Chen <dchen@diasemi.com>
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
>   */
>  
>  #include <linux/module.h>
> diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
> index 814dff6045a4..a001782bbfdb 100644
> --- a/drivers/watchdog/da9062_wdt.c
> +++ b/drivers/watchdog/da9062_wdt.c
> @@ -1,16 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Watchdog device driver for DA9062 and DA9061 PMICs
>   * Copyright (C) 2015  Dialog Semiconductor Ltd.
>   *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * as published by the Free Software Foundation; either version 2
> - * of the License, or (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
>   */
>  
>  #include <linux/kernel.h>
> diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
> index 2a20fc163ed0..b17ac1bb1f28 100644
> --- a/drivers/watchdog/da9063_wdt.c
> +++ b/drivers/watchdog/da9063_wdt.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Watchdog driver for DA9063 PMICs.
>   *
> @@ -5,10 +6,6 @@
>   *
>   * Author: Mariusz Wojtasik <mariusz.wojtasik@diasemi.com>
>   *
> - * This program is free software; you can redistribute  it and/or modify it
> - * under  the terms of  the GNU General  Public License as published by the
> - * Free Software Foundation;  either version 2 of the  License, or (at your
> - * option) any later version.
>   */
>  
>  #include <linux/kernel.h>
> diff --git a/drivers/watchdog/digicolor_wdt.c b/drivers/watchdog/digicolor_wdt.c
> index 5e4ef93caa02..a9e11df155b8 100644
> --- a/drivers/watchdog/digicolor_wdt.c
> +++ b/drivers/watchdog/digicolor_wdt.c
> @@ -1,12 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Watchdog driver for Conexant Digicolor
>   *
>   * Copyright (C) 2015 Paradox Innovation Ltd.
>   *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of the GNU General Public License as published by the
> - * Free Software Foundation; either version 2 of the License, or (at your
> - * option) any later version.
>   */
>  
>  #include <linux/types.h>
> diff --git a/drivers/watchdog/ebc-c384_wdt.c b/drivers/watchdog/ebc-c384_wdt.c
> index 2170b275ea01..4c4c8ce78021 100644
> --- a/drivers/watchdog/ebc-c384_wdt.c
> +++ b/drivers/watchdog/ebc-c384_wdt.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Watchdog timer driver for the WinSystems EBC-C384
>   * Copyright (C) 2016 William Breathitt Gray
> diff --git a/drivers/watchdog/mei_wdt.c b/drivers/watchdog/mei_wdt.c
> index b8194b02abe0..8023cf28657a 100644
> --- a/drivers/watchdog/mei_wdt.c
> +++ b/drivers/watchdog/mei_wdt.c
> @@ -1,15 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Intel Management Engine Interface (Intel MEI) Linux driver
>   * Copyright (c) 2015, Intel Corporation.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms and conditions of the GNU General Public License,
> - * version 2, as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope it will be useful, but WITHOUT
> - * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> - * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
> - * more details.
>   */
>  
>  #include <linux/module.h>
> @@ -687,5 +679,5 @@ static struct mei_cl_driver mei_wdt_driver = {
>  module_mei_cl_driver(mei_wdt_driver);
>  
>  MODULE_AUTHOR("Intel Corporation");
> -MODULE_LICENSE("GPL");
> +MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("Device driver for Intel MEI iAMT watchdog");
> diff --git a/drivers/watchdog/mena21_wdt.c b/drivers/watchdog/mena21_wdt.c
> index 045201a6fdb3..25d5d2b8cfbe 100644
> --- a/drivers/watchdog/mena21_wdt.c
> +++ b/drivers/watchdog/mena21_wdt.c
> @@ -1,11 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Watchdog driver for the A21 VME CPU Boards
>   *
>   * Copyright (C) 2013 MEN Mikro Elektronik Nuernberg GmbH
>   *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * as published by the Free Software Foundation
>   */
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
> diff --git a/drivers/watchdog/meson_gxbb_wdt.c b/drivers/watchdog/meson_gxbb_wdt.c
> index 69a5a57f1446..69adeab3fde7 100644
> --- a/drivers/watchdog/meson_gxbb_wdt.c
> +++ b/drivers/watchdog/meson_gxbb_wdt.c
> @@ -1,56 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
>  /*
> - * This file is provided under a dual BSD/GPLv2 license.  When using or
> - * redistributing this file, you may do so under either license.
> - *
> - * GPL LICENSE SUMMARY
> - *
>   * Copyright (c) 2016 BayLibre, SAS.
>   * Author: Neil Armstrong <narmstrong@baylibre.com>
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, see <http://www.gnu.org/licenses/>.
> - * The full GNU General Public License is included in this distribution
> - * in the file called COPYING.
> - *
> - * BSD LICENSE
> - *
> - * Copyright (c) 2016 BayLibre, SAS.
> - * Author: Neil Armstrong <narmstrong@baylibre.com>
> - *
> - * Redistribution and use in source and binary forms, with or without
> - * modification, are permitted provided that the following conditions
> - * are met:
> - *
> - *   * Redistributions of source code must retain the above copyright
> - *     notice, this list of conditions and the following disclaimer.
> - *   * Redistributions in binary form must reproduce the above copyright
> - *     notice, this list of conditions and the following disclaimer in
> - *     the documentation and/or other materials provided with the
> - *     distribution.
> - *   * Neither the name of Intel Corporation nor the names of its
> - *     contributors may be used to endorse or promote products derived
> - *     from this software without specific prior written permission.
> - *
> - * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
> - * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> - * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
> - * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
> - * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
> - * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
> - * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
> - * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
> - * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> - * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
> - * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>   */
>  #include <linux/clk.h>
>  #include <linux/err.h>
> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> index 7ed417a765c7..498e7d4e1b66 100644
> --- a/drivers/watchdog/mtk_wdt.c
> +++ b/drivers/watchdog/mtk_wdt.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Mediatek Watchdog Driver
>   *
> @@ -5,16 +6,6 @@
>   *
>   * Matthias Brugger <matthias.bgg@gmail.com>
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
>   * Based on sunxi_wdt.c
>   */
>  
> diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
> index ca360d204548..1fa7d2b32494 100644
> --- a/drivers/watchdog/mtx-1_wdt.c
> +++ b/drivers/watchdog/mtx-1_wdt.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   *      Driver for the MTX-1 Watchdog.
>   *
> @@ -6,16 +7,6 @@
>   *                              http://www.4g-systems.biz
>   *
>   *	(C) Copyright 2007 OpenWrt.org, Florian Fainelli <florian@openwrt.org>
> - *
> - *      This program is free software; you can redistribute it and/or
> - *      modify it under the terms of the GNU General Public License
> - *      as published by the Free Software Foundation; either version
> - *      2 of the License, or (at your option) any later version.
> - *
> - *      Neither Michael Stickel nor 4G Systems admit liability nor provide
> - *      warranty for any of this software. This material is provided
> - *      "AS-IS" and at no charge.
> - *
>   *      (c) Copyright 2005    4G Systems <info@4g-systems.biz>
>   *
>   *      Release 0.01.
> diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
> index 1cf286945b7a..4acbe05e27bb 100644
> --- a/drivers/watchdog/of_xilinx_wdt.c
> +++ b/drivers/watchdog/of_xilinx_wdt.c
> @@ -1,13 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Watchdog Device Driver for Xilinx axi/xps_timebase_wdt
>   *
>   * (C) Copyright 2013 - 2014 Xilinx, Inc.
>   * (C) Copyright 2011 (Alejandro Cabrera <aldaya@gmail.com>)
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * as published by the Free Software Foundation; either version
> - * 2 of the License, or (at your option) any later version.
>   */
>  
>  #include <linux/clk.h>
> @@ -323,4 +319,4 @@ module_platform_driver(xwdt_driver);
>  
>  MODULE_AUTHOR("Alejandro Cabrera <aldaya@gmail.com>");
>  MODULE_DESCRIPTION("Xilinx Watchdog driver");
> -MODULE_LICENSE("GPL v2");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/watchdog/st_lpc_wdt.c b/drivers/watchdog/st_lpc_wdt.c
> index e6100e447dd8..177829b379da 100644
> --- a/drivers/watchdog/st_lpc_wdt.c
> +++ b/drivers/watchdog/st_lpc_wdt.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * ST's LPC Watchdog
>   *
> @@ -5,11 +6,6 @@
>   *
>   * Author: David Paris <david.paris@st.com> for STMicroelectronics
>   *         Lee Jones <lee.jones@linaro.org> for STMicroelectronics
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public Licence
> - * as published by the Free Software Foundation; either version
> - * 2 of the Licence, or (at your option) any later version.
>   */
>  
>  #include <linux/clk.h>
> diff --git a/drivers/watchdog/tangox_wdt.c b/drivers/watchdog/tangox_wdt.c
> index d5fcce062920..b1de8297fa40 100644
> --- a/drivers/watchdog/tangox_wdt.c
> +++ b/drivers/watchdog/tangox_wdt.c
> @@ -1,11 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   *  Copyright (C) 2015 Mans Rullgard <mans@mansr.com>
>   *  SMP86xx/SMP87xx Watchdog driver
> - *
> - *  This program is free software; you can redistribute it and/or modify it
> - *  under  the terms of the GNU General  Public License as published by the
> - *  Free Software Foundation;  either version 2 of the License, or (at your
> - *  option) any later version.
>   */
>  
>  #include <linux/bitops.h>
> diff --git a/drivers/watchdog/tegra_wdt.c b/drivers/watchdog/tegra_wdt.c
> index 9403c08816e3..877dd39bd41f 100644
> --- a/drivers/watchdog/tegra_wdt.c
> +++ b/drivers/watchdog/tegra_wdt.c
> @@ -1,14 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2014, NVIDIA CORPORATION.  All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms and conditions of the GNU General Public License,
> - * version 2, as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope it will be useful, but WITHOUT
> - * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> - * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> - * more details.
>   */
>  
>  #include <linux/kernel.h>
> diff --git a/drivers/watchdog/uniphier_wdt.c b/drivers/watchdog/uniphier_wdt.c
> index 0ea2339d9702..769d75344050 100644
> --- a/drivers/watchdog/uniphier_wdt.c
> +++ b/drivers/watchdog/uniphier_wdt.c
> @@ -1,18 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Watchdog driver for the UniPhier watchdog timer
>   *
>   * (c) Copyright 2014 Panasonic Corporation
>   * (c) Copyright 2016 Socionext Inc.
>   * All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
>   */
>  
>  #include <linux/bitops.h>
> diff --git a/drivers/watchdog/wm831x_wdt.c b/drivers/watchdog/wm831x_wdt.c
> index 1ddc1f742cd4..116c2f47b463 100644
> --- a/drivers/watchdog/wm831x_wdt.c
> +++ b/drivers/watchdog/wm831x_wdt.c
> @@ -1,11 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Watchdog driver for the wm831x PMICs
>   *
>   * Copyright (C) 2009 Wolfson Microelectronics
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * as published by the Free Software Foundation
>   */
>  
>  #include <linux/module.h>
> diff --git a/drivers/watchdog/wm8350_wdt.c b/drivers/watchdog/wm8350_wdt.c
> index 4ab4b8347d45..33c62d51f00a 100644
> --- a/drivers/watchdog/wm8350_wdt.c
> +++ b/drivers/watchdog/wm8350_wdt.c
> @@ -1,11 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Watchdog driver for the wm8350
>   *
>   * Copyright (C) 2007, 2008 Wolfson Microelectronics <linux@wolfsonmicro.com>
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * as published by the Free Software Foundation
>   */
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
