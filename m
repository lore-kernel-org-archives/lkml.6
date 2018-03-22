Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754692AbeCVMhP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 08:37:15 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:44452 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753177AbeCVMhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 08:37:09 -0400
X-Google-Smtp-Source: AG47ELsk6Nup4+0w3VOe+zdo7qsk73xCyifgVuACK4AHNSduOSZD8wJIcrFAKTLdmupMk5eb3J272TBxR7G+O8Ifk1U=
MIME-Version: 1.0
In-Reply-To: <1521719091-25157-4-git-send-email-michel.pollet@bp.renesas.com>
References: <1521719091-25157-1-git-send-email-michel.pollet@bp.renesas.com> <1521719091-25157-4-git-send-email-michel.pollet@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 Mar 2018 13:37:07 +0100
X-Google-Sender-Auth: JOH1J4eDUY9m59Tw-8XCEAhZA_M
Message-ID: <CAMuHMdXaRarxors3E-Jv7TLjka-p9XGYCTKyF7jM3p+UemgO+w@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] DT: arm: renesas,r9a06g032: add the RZ/N1 bindings
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
> This documents the RZ/N1 bindings for both the RZ/N1 and the RZN1D400-DB
> board.
>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/arm/shmobile.txt
> +++ b/Documentation/devicetree/bindings/arm/shmobile.txt
> @@ -47,7 +47,8 @@ SoCs:
>      compatible = "renesas,r8a77980"
>    - R-Car D3 (R8A77995)
>      compatible = "renesas,r8a77995"
> -
> +  - RZ/N1D (R9A06G032)
> +    compatible = "renesas,r9a06g032"
>
>  Boards:
>
> @@ -104,6 +105,8 @@ Boards:
>      compatible = "renesas,porter", "renesas,r8a7791"
>    - RSKRZA1 (YR0K77210C000BE)
>      compatible = "renesas,rskrza1", "renesas,r7s72100"
> +  - RZN1D-DB (RZ/N1D Demo Board for the RZ/N1D 400 pins package)

The official board part number (between parentheses) should be
YCONNECT-IT-RZN1D?

> +    compatible = "renesas,rzn1d400-db", "renesas,r9a06g032"
>    - Salvator-X (RTP0RC7795SIPB0010S)
>      compatible = "renesas,salvator-x", "renesas,r8a7795"
>    - Salvator-X (RTP0RC7796SIPB0011S)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
