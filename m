Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752792AbeDQPt3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 11:49:29 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:33097 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751863AbeDQPt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 11:49:27 -0400
X-Google-Smtp-Source: AIpwx4/4uI3l9gsmk6wxDgzYp+ZkYCxzLtUHVXhN73YeE1132pRq6clvs3303eYBeVH1ENtJODTZUxrmMFQ7Qhw+O9M=
MIME-Version: 1.0
In-Reply-To: <1523963101-56725-4-git-send-email-michel.pollet@bp.renesas.com>
References: <1523963101-56725-1-git-send-email-michel.pollet@bp.renesas.com> <1523963101-56725-4-git-send-email-michel.pollet@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 17 Apr 2018 17:49:25 +0200
X-Google-Sender-Auth: WH-zOjlBvnCti7FljDztxO4S5aI
Message-ID: <CAMuHMdU4upXcYZ_yD2a_=J5VAUE28fni7_NotmchjpYUqCxV=A@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] dt-bindings: arm: Document the RZN1D-DB board
To: Michel Pollet <michel.pollet@bp.renesas.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Michel Pollet <buserror+upstream@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
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

On Tue, Apr 17, 2018 at 1:04 PM, Michel Pollet
<michel.pollet@bp.renesas.com> wrote:
> This documents the RZ/N1 bindings for the RZN1D-DB board.
>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/arm/shmobile.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
> index 61b486f..6efb3f1 100644
> --- a/Documentation/devicetree/bindings/arm/shmobile.txt
> +++ b/Documentation/devicetree/bindings/arm/shmobile.txt
> @@ -51,7 +51,8 @@ SoCs:
>      compatible = "renesas,r8a77990"
>    - R-Car D3 (R8A77995)
>      compatible = "renesas,r8a77995"
> -
> +  - RZ/N1D (R9A06G032)
> +    compatible = "renesas,r9a06g032", "renesas,rzn1"

Why do you need a family-specific compatible value ("renesas,rzn1",
which is a marketing name)?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
