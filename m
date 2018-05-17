Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751844AbeEQTux (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 15:50:53 -0400
Received: from muru.com ([72.249.23.125]:42872 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750938AbeEQTuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 15:50:52 -0400
Date: Thu, 17 May 2018 12:50:47 -0700
From: Tony Lindgren <tony@atomide.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Daniel Mack <zonque@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH 01/19 v3] regulator: fixed: Convert to use GPIO
 descriptor only
Message-ID: <20180517195047.GO98604@atomide.com>
References: <20180514080640.12515-1-linus.walleij@linaro.org>
 <20180514080640.12515-2-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514080640.12515-2-linus.walleij@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Walleij <linus.walleij@linaro.org> [180514 08:08]:
> As we augmented the regulator core to accept a GPIO descriptor instead
> of a GPIO number, we can augment the fixed GPIO regulator to look up
> and pass that descriptor directly from device tree or board GPIO
> descriptor look up tables.
...
>  arch/arm/mach-omap1/board-ams-delta.c         | 14 +++++++-
>  arch/arm/mach-omap2/pdata-quirks.c            | 16 ++++++++-

Looks OK to me:

Acked-by: Tony Lindgren <tony@atomide.com>
