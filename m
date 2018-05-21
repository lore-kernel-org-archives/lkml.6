Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753145AbeEUL1x (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 07:27:53 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:41602 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752836AbeEUL1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 07:27:48 -0400
X-Google-Smtp-Source: AB8JxZrrxBM56JDdOg9tExJltE8n/QvbMUFENmpkOEE0nV0dHzNNE/oXS72L1+hvl8QYmutE0OAGfSDE5YdYrGEUL+w=
MIME-Version: 1.0
In-Reply-To: <afc54477ac8bd9a69cfa8754270342cfc8487109.camel@linux.intel.com>
References: <20180514080640.12515-1-linus.walleij@linaro.org>
 <20180514080640.12515-2-linus.walleij@linaro.org> <afc54477ac8bd9a69cfa8754270342cfc8487109.camel@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 21 May 2018 13:27:47 +0200
Message-ID: <CACRpkdaJ7UjpXKDEi2jR65vzt-Fp42U5PnMGkuw5r-H83ggbSA@mail.gmail.com>
Subject: Re: [PATCH 01/19 v3] regulator: fixed: Convert to use GPIO descriptor only
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexander Shiyan <shc_work@mail.ru>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Daniel Mack <zonque@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 1:03 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, 2018-05-14 at 10:06 +0200, Linus Walleij wrote:

>> The hunk hitting the x86 BCM43xx driver is especially tricky as the
>> number
>> comes out of SFI which is a mystery to me. I definately need someone
>> to
>> look at this. (Hi Andy.)
>
> Since there is no link to repo with a branch and I wasn't Cc'ed to cover
> letter, asking here for a such. I would then pull it and test on real
> hardware.

I'm sorry about this.
This branch:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git/log/?h=gpio-descriptors-regulator

Has all the patches.

git pull git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
gpio-descriptors-regulator

will bring in the patches to a testing branch.

> The code itself looks good, so:
>
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> for Intel MID bits.

Thanks!

Yours,
Linus Walleij
