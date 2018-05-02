Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751479AbeEBMcK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 08:32:10 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:37274 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751342AbeEBMcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 08:32:08 -0400
X-Google-Smtp-Source: AB8JxZrEEN/zTgdSAhkzxl/1tbq5fMYWx/nUXu+F5+SslyqxpPsS/blP/EyqBXME242TwpTOs41VwlFni902YG7mxCA=
MIME-Version: 1.0
In-Reply-To: <cover.1524933096.git.hns@goldelico.com>
References: <cover.1524933096.git.hns@goldelico.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 2 May 2018 15:32:07 +0300
Message-ID: <CAHp75VfA84FWyymRz6_53soEoLNAPP9YpsR3Vzkf6EJWLLTw=g@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] pcal6524 extensions and fixes for pca953x driver
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

On Sat, Apr 28, 2018 at 7:31 PM, H. Nikolaus Schaller <hns@goldelico.com> wrote:
> V5:
> * fix wrong split up between patches 1/7and 2/7.
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

After addressing comments for two patches,

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

for patches 1-5.

> H. Nikolaus Schaller (7):
>   gpio: pca953x: convert register constants to hex
>   gpio: pca953x: add more register definitions for pcal953x
>   gpio: pca953x: add more register definitions for pcal6524
>   gpio: pca953x: define masks for addressing common and extended
>     registers
>   gpio: pca953x: fix address calculation for pcal6524
>   DTS: Bindings: pca953x add an optional vcc-supply property
>   DTS: Bindings: pca953x: add example how to use interrupt-controller
>     and gpio-controller
>
>  .../devicetree/bindings/gpio/gpio-pca953x.txt      | 34 ++++++++++++++
>  drivers/gpio/gpio-pca953x.c                        | 53 ++++++++++++++--------
>  2 files changed, 69 insertions(+), 18 deletions(-)
>
> --
> 2.12.2
>



-- 
With Best Regards,
Andy Shevchenko
