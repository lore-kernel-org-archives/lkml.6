Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752015AbeFENYJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:24:09 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:37649 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751832AbeFENYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:24:06 -0400
X-Google-Smtp-Source: ADUXVKKT62xLrRtrMmfXIy5Dk1tSsFp4RGsNdA87vQUTHOft2XcvtXlHx3Z+IBMz6HiLOEXmzaaHlPED9sWmOdbwl9A=
MIME-Version: 1.0
In-Reply-To: <1528198148-23308-3-git-send-email-michel.pollet@bp.renesas.com>
References: <1528198148-23308-1-git-send-email-michel.pollet@bp.renesas.com> <1528198148-23308-3-git-send-email-michel.pollet@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 5 Jun 2018 15:24:04 +0200
X-Google-Sender-Auth: azOBMP08suUoC6j9q-YPp19xOT0
Message-ID: <CAMuHMdWsaLMkUBhdO6cOCRPTV942dAgssLco2YQZO85dAcYQsw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] arm: shmobile: Add the R9A06G032 SMP enabler driver
To: Michel Pollet <michel.pollet@bp.renesas.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Michel Pollet <buserror+upstream@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
        Douglas Anderson <dianders@chromium.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Frank Rowand <frank.rowand@sony.com>,
        Carlo Caione <carlo@endlessm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 1:28 PM, Michel Pollet
<michel.pollet@bp.renesas.com> wrote:
> The Renesas R9A06G032 second CA7 is parked in a ROM pen at boot time, it
> requires a special enable method to get it started.
>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- /dev/null
> +++ b/arch/arm/mach-shmobile/smp-r9a06g032.c
> @@ -0,0 +1,79 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * R9A06G032 Second CA7 enabler.
> + *
> + * Copyright (C) 2018 Renesas Electronics Europe Limited
> + *
> + * Michel Pollet <michel.pollet@bp.renesas.com>, <buserror@gmail.com>
> + * Derived from action,s500-smp

actions

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
