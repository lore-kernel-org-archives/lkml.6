Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751888AbeEQH0V (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 03:26:21 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:41487 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbeEQH0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 03:26:19 -0400
Date: Thu, 17 May 2018 09:25:52 +0200 (CEST)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Stefan Mavrodiev <stefan@olimex.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org
Cc: linux-sunxi@googlegroups.com
Message-ID: <96201051.35560.1526541952287@email.1und1.de>
In-Reply-To: <1526470689-6275-1-git-send-email-stefan@olimex.com>
References: <1526470689-6275-1-git-send-email-stefan@olimex.com>
Subject: Re: [PATCH 1/1] ARM:dts:sunxi: Add Olimex A20-SOM-EVB-eMMC board
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev28
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:Sp7m3eE7YAB+v+uJQvYcGD9dn10YyJBsarUQd7DWcQ2YFzXBe3H
 aMfrmHj/SL3wJ88MacDn3efYmRdkS6fBPceC23dvwkW67K/U5E/BhvBVTSKxz9f9kBxAqgy
 /HQRQZLU6BtkIFtMNbTM5hHCaQTD9Nrjg7MVlrqbe2mS8W5W8kReTNA2m6O+QBf74gaosei
 vKh0f1C5bB2m9/2SEE/sg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/cUiUjjHQpU=:8gp9+588kOVyXZGYhQk+pm
 8QWPqleRki9zAiH+G5V9/Gucv1tVMIdw24IKWUg2uvgm9RwJjYv18h5i7qJiZoRUKxzNlCZw1
 uz3pjKcUDuQ7o0W58PLzFT405teDWmCTrETZFXWpDhazjlUOOIFMZTjj13rAWtHp1MOh003Sh
 gh0KOwtXrd9RXLvYkJXyFfiFs3W/WwejBeHjd+T8ZuKt3F/yUrldLwD9DxkBdc7NGVviX8N5a
 8yb089TyEmwtfWzDtgGdT+zj7H8+z+re8y5ohDYI/iftVzOYWMQ0W+YZKNsfi4Lx0EJ4nMhHB
 nnL8oHaji69/HvceZvZQ5pB40bQGT96vGnMaxAcdZI9PP2dwvJHb7TONf1SAUQ3FGOJ4HDUpm
 u+Gk2JYZ51MGZ29/HitEDApsFwj7/AmE6B5CK0VnwoW30YkkYG0UtP9Bxd+pfMSTG5vHVwBNQ
 8CagTac+i0AVQ5dLAHgpv0PhkaNhpbgctWM6koWs2ONBkyHxcFlvigJmMyzPWDkD4mYOIkOg8
 aG3b6hlzXjbKIBps2h7cz2D6maOoosd9DlhWEhXWp4yxqndCblxzPAjZAc2VxpjPTW3XHNOh/
 Iz3FX6MzGe98T7jtkoZV/9RgNCXZOsjg2EN8uIjVwcybr6iMOewEjp9MzQmNfgIYBRgIFt8T7
 ARPpgV7zUid+m2E15LvASmDIwjgxvqIw5RXRQpaIkHBudBtT+0wm4FL+8st1OGQdGkqp8pF4A
 0/Ad9nBxHoaOScSl
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

> Stefan Mavrodiev <stefan@olimex.com> hat am 16. Mai 2018 um 13:38 geschrieben:
> 
> 
> With the new rev.E of A20-SOM-EVB, there is option for 16GB eMMC.
> Currently used card is KLMAG2GEND, wired to MMC2 slot.
> 
> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
> ---
>  arch/arm/boot/dts/Makefile                         |  1 +
>  .../arm/boot/dts/sun7i-a20-olimex-som-evb-emmc.dts | 37 ++++++++++++++++++++++
>  2 files changed, 38 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun7i-a20-olimex-som-evb-emmc.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 1db91ec..7f1ee65 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -959,6 +959,7 @@ dtb-$(CONFIG_MACH_SUN7I) += \
>  	sun7i-a20-m3.dtb \
>  	sun7i-a20-mk808c.dtb \
>  	sun7i-a20-olimex-som-evb.dtb \
> +	sun7i-a20-olimex-som-evb-emmc.dtb \
>  	sun7i-a20-olimex-som204-evb.dtb \
>  	sun7i-a20-olimex-som204-evb-emmc.dtb \
>  	sun7i-a20-olinuxino-lime.dtb \
> diff --git a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb-emmc.dts b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb-emmc.dts
> new file mode 100644
> index 0000000..81ebc97
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb-emmc.dts
> @@ -0,0 +1,37 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Device Tree Source for A20-Olimex-SOM-EVB-eMMC Board
> + *
> + * Copyright (C) 2018 Olimex Ltd.
> + *   Author: Stefan Mavrodiev <stefan@olimex.com>
> + */
> +
> +/dts-v1/;
> +#include "sun7i-a20-olimex-som-evb.dts"
> +
> +/ {
> +
> +	model = "Olimex A20-Olimex-SOM-EVB-eMMC";
> +	compatible = "olimex,a20-olimex-som-evb-emmc", "allwinner,sun7i-a20";

the file Documentation/devicetree/bindings/arm/olimex.txt seems to be out of date. I cannot find any recent board compatible.

Didn't checkpatch complain about it?

Regards
Stefan
