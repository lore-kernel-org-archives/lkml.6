Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754751AbeCVMvF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 08:51:05 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:46218 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753796AbeCVMvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 08:51:02 -0400
X-Google-Smtp-Source: AG47ELtd+DwlnsJNeS5HZBl8Zq4I/oT2eARP2WrevDMZyhS3SoLB74wSTsIzI3PqAksouZXYa197OeUVYLX7wriNqRo=
MIME-Version: 1.0
In-Reply-To: <1521719091-25157-8-git-send-email-michel.pollet@bp.renesas.com>
References: <1521719091-25157-1-git-send-email-michel.pollet@bp.renesas.com> <1521719091-25157-8-git-send-email-michel.pollet@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 Mar 2018 13:51:01 +0100
X-Google-Sender-Auth: JpA4QV2Ko1o3z4z8kNc5EEbWz-U
Message-ID: <CAMuHMdUBS2+7UeAD9ZraOKY99o2YmLJgPEcuTGwLXPTj9Cfs_g@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] DT: arm: Add Renesas RZN1D-DB Board base file
To: Michel Pollet <michel.pollet@bp.renesas.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Reichel <sre@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michel,

On Thu, Mar 22, 2018 at 12:44 PM, Michel Pollet
<michel.pollet@bp.renesas.com> wrote:
> This adds a base device tree file for the RZN1-DB board, with only the
> basic support allowing the system to boot to a prompt. Only one UART is
> used, with only a single CPU running.
>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts
> @@ -0,0 +1,26 @@
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
> +#include "r9a06g0xx.dtsi"
> +
> +/ {
> +       model = "RZN1D-DB Board";
> +       compatible = "renesas,rzn1d400-db", "renesas,r9a06g032", "renesas,rzn1";

"renesas,rzn1" is not documented.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
