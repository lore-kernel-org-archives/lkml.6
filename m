Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751997AbeCIIQJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:16:09 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55999 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751696AbeCIIQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:16:07 -0500
X-Google-Smtp-Source: AG47ELsIcnLCLlubW1a+FMUZlPgHmBGSPx1nFuhYNRA3EHiG6o599g8almf339l8vtJ6bW1kq8K3eQ==
Date: Fri, 9 Mar 2018 08:16:03 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, broonie@kernel.org,
        alexandre.belloni@bootlin.com, linux-rtc@vger.kernel.org,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Stephen Boyd <sboyd@kernel.org>,
        Gabriel Fernandez <gabriel.fernandez@st.com>,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 0/4] Set name of regmap_config
Message-ID: <20180309081603.4u5pgwwsfxernodm@dell>
References: <20180309015146.8297-1-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180309015146.8297-1-jeffy.chen@rock-chips.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Mar 2018, Jeffy Chen wrote:

> 
> After 9b947a13e7f6 ("regmap: use debugfs even when no device"), we are
> allowing regmap to create debugfs without a valid device. Some of them
> would end up using "dummy*" as debugfs name.
> 
> This series try to set names in some regmap_config to avoid that.
> 
> 
> Changes in v4:
> Not to use rtc dev to init regmap, the gpbr is not directly related to
> the rtc.
> 
> Changes in v3:
> Modify commit message.
> 
> Jeffy Chen (4):
>   mfd: syscon: Set name of regmap_config
>   rtc: at91sam9: Set name of regmap_config
>   clk: lpc32xx: Set name of regmap_config
>   ARM: rockchip: Set name of regmap_config
> 
>  arch/arm/mach-rockchip/platsmp.c | 1 +
>  drivers/clk/nxp/clk-lpc32xx.c    | 1 +
>  drivers/mfd/syscon.c             | 1 +

It's difficult to review, since we cannot see what's happening with
the rest of the patch set.  Would you mind re-sending the whole set to
all parties please?

>  drivers/rtc/rtc-at91sam9.c       | 1 +
>  4 files changed, 4 insertions(+)
> 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
