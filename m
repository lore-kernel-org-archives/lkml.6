Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751735AbeEVSmu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 14:42:50 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:33708 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751469AbeEVSms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 14:42:48 -0400
X-Google-Smtp-Source: AB8JxZofgEDBBIIGyTvBQff6ZMYrvBol55LftFpyR5UT2Izp11Kv8sR3NzIY+GuS5qWyTFnq6itpm60vmL72Dr/1IAU=
MIME-Version: 1.0
In-Reply-To: <1526983321-41949-4-git-send-email-michel.pollet@bp.renesas.com>
References: <1526983321-41949-1-git-send-email-michel.pollet@bp.renesas.com> <1526983321-41949-4-git-send-email-michel.pollet@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 22 May 2018 20:42:46 +0200
X-Google-Sender-Auth: uH3ASG17bWm1dDlrxctnxiQurxg
Message-ID: <CAMuHMdUW-tteZ26J4rd9=KsrHotjCs7BR_pjyjFQnfoOF5=oFQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] dt-bindings: clock: renesas,rzn1-clocks: document
 RZ/N1 clock driver
To: Michel Pollet <michel.pollet@bp.renesas.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Michel Pollet <buserror+upstream@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michel,

On Tue, May 22, 2018 at 12:01 PM, Michel Pollet
<michel.pollet@bp.renesas.com> wrote:
> The Renesas RZ/N1 Family (Part #R9A06G0xx) requires a driver
> to provide the SoC clock infrastructure for Linux.
>
> This documents the driver bindings.
>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/renesas,rzn1-clocks.txt
> @@ -0,0 +1,44 @@
> +* Renesas RZ/N1 Clock Driver
> +
> +This driver provides the clock infrastructure used by all the other drivers.
> +
> +One of the 'special' feature of this infrastructure is that Linux doesn't
> +necessary 'own' all the clocks on the SoC, some other OS runs on
> +the Cortex-M3 core and that OS can access and claim it's own clocks.
> +
> +Required Properties:
> +
> +  - compatible: Must be
> +    - "renesas,r9a06g032-clocks" for the RZ/N1D
> +    and "renesas,rzn1-clocks" as a fallback.

Why the fallback? I doubt all existing (and future) RZ/N1D SoCs provide the
exact same clock hierarchy.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
