Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965407AbeEYJ2i (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:28:38 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:35840 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965130AbeEYJ2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:28:35 -0400
X-Google-Smtp-Source: ADUXVKIgJwKWjtjjjBdeqW23KQYH8Vfq0DDWToo86m+mZKyAxs7O6ygzOSS3JuA+i0h+ZkNLeUe4p88HBegWfUPLZjU=
MIME-Version: 1.0
In-Reply-To: <1527154169-32380-5-git-send-email-michel.pollet@bp.renesas.com>
References: <1527154169-32380-1-git-send-email-michel.pollet@bp.renesas.com> <1527154169-32380-5-git-send-email-michel.pollet@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 25 May 2018 11:28:33 +0200
X-Google-Sender-Auth: 81IUBXF6k2E56snH-8bn-Q_yAPs
Message-ID: <CAMuHMdUy_5Q54mE9qiAhwW2OiYxoUgb7JFAn=JCr2r_spO+kcw@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] ARM: dts: Renesas RZN1D-DB Board base file
To: Michel Pollet <michel.pollet@bp.renesas.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Michel Pollet <buserror+upstream@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 11:28 AM, Michel Pollet
<michel.pollet@bp.renesas.com> wrote:
> This adds a base device tree file for the RZN1-DB board, with only the
> basic support allowing the system to boot to a prompt. Only one UART is
> used, with only a single CPU running.
>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- /dev/null
> +++ b/arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree Source for the RZN1D-DB Board
> + *
> + * Copyright (C) 2018 Renesas Electronics Europe Limited
> + *
> + */
> +
> +/dts-v1/;
> +
> +#include "r9a06g032.dtsi"
> +
> +/ {
> +       model = "RZN1D-DB Board";
> +       compatible = "renesas,rzn1d400-db",
> +                       "renesas,r9a06g032";

Nit: This could fit on a single line.

> +
> +       chosen {
> +               stdout-path = "serial0:115200n8";
> +       };
> +
> +       aliases {
> +               serial0 = &uart0;
> +       };
> +};

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
