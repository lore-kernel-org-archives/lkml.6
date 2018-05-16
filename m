Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751315AbeEPTxV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 15:53:21 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:43018 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbeEPTxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 15:53:19 -0400
X-Google-Smtp-Source: AB8JxZo/4FVIPrOL3ZkbXZ7M+Pxauz69tQPfVVR1Ga3MRfqFk1VJXrG8frVoLzBntrY90QikAisFOK/KY6VqcLDnR/U=
MIME-Version: 1.0
In-Reply-To: <cover.1526490085.git.hns@goldelico.com>
References: <cover.1526490085.git.hns@goldelico.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 16 May 2018 22:53:18 +0300
Message-ID: <CAHp75Vdm4q39hoXoodDQPwEdhi-C+jF7yaxHqHi41mrT0kXGnA@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] pcal6524 extensions and fixes for pca953x driver
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel
        <letux-kernel@openphoenux.org>,
        kernel@pyra-handheld.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 8:01 PM, H. Nikolaus Schaller <hns@goldelico.com> wrote:
> V6:
> * added proper attribution to the formula used for fixing the
>   pcal6524 register address (changes commit message only)
> * add back missing first patch from V2 that defines the
>   PCA_LATCH_INT constant
> * removed patches already merged
>

Thanks for an update.
I think we still need to address the constant representation in patch 2.

For the rest take my
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> 2018-04-28 18:33:42: V5:
> * fix wrong split up between patches 1/7 and 2/7.
>
> 2018-04-26 19:35:07: V4:
> * introduced PCA_LATCH_INT constant to make of_table more
>   readable (suggested by Andy Shevchenko)
> * converted all register constants to hex in a separate
>   patch (suggested by Andy Shevchenko)
> * separated additional pcal953x and pcal6524 register
>   definitions into separate patches (suggested by Andy Shevchenko)
> * made special pcal6524 address adjustment more readable
>   (suggested by Andy Shevchenko)
> * moved gpio-controller and interrupt-controller to the
>   "required" section (reviewed by Rob Herring)
>
> 2018-04-10 18:07:07: V3:
> * add Reported-by: and Reviewed-by:
> * fix wording for bindings description and example
> * convert all register offsets to hex
> * omit the LEVEL-IRQ RFC/hack commit
>
> 2018-04-04 21:00:27: V2:
> * added PCA_PCAL flags if matched through of-table
> * fix address calculation for extended PCAL6524 registers
> * hack to map LEVEL_LOW to EDGE_FALLING to be able to
>   test in combination with ts3a227e driver
> * improve description of bindings for optional vcc-supply
>   and interrupt-controller;
>
> 2018-03-10 09:32:53: no initial description
>
> H. Nikolaus Schaller (3):
>   gpio: pca953x: set the PCA_PCAL flag also when matching by DT
>   gpio: pca953x: define masks for addressing common and extended
>     registers
>   gpio: pca953x: fix address calculation for pcal6524
>
>  drivers/gpio/gpio-pca953x.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> --
> 2.12.2
>



-- 
With Best Regards,
Andy Shevchenko
