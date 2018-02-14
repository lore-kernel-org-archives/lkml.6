Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030404AbeBNOKc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:10:32 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:36663 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030256AbeBNOK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:10:29 -0500
X-Google-Smtp-Source: AH8x2275OYdp63rDhdKgZe1KLY3D54KdlxgC/LyiyZ/R5BVF/uZpKWqN1rZVIYqdmcz6/nEmHfSVaYlvWRsVRXJE7PQ=
MIME-Version: 1.0
In-Reply-To: <1518515162-23663-13-git-send-email-jacopo+renesas@jmondi.org>
References: <1518515162-23663-1-git-send-email-jacopo+renesas@jmondi.org> <1518515162-23663-13-git-send-email-jacopo+renesas@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 Feb 2018 15:10:27 +0100
X-Google-Sender-Auth: mgyqnHpydO8VmKeEbRw8My0OQu4
Message-ID: <CAMuHMdWptGc4hG4yufgbjnfu-4vyD8Hag-01FhWW_ubojXNHiQ@mail.gmail.com>
Subject: Re: [PATCH 12/15] ARM64: dts: r8a77965: Add GPIO nodes
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 10:45 AM, Jacopo Mondi
<jacopo+renesas@jmondi.org> wrote:
> Add GPIO nodes to r8a77965 SoC device tree file.
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> @@ -201,38 +201,6 @@
>                         #power-domain-cells = <1>;
>                 };
>
> -               gpio0: gpio@e6050000 {
> -                       /* placeholder */
> -               };
> -
> -               gpio1: gpio@e6051000 {
> -                       /* placeholder */
> -               };
> -
> -               gpio2: gpio@e6052000 {
> -                       /* placeholder */
> -               };
> -
> -               gpio3: gpio@e6053000 {
> -                       /* placeholder */
> -               };
> -
> -               gpio4: gpio@e6054000 {
> -                       /* placeholder */
> -               };
> -
> -               gpio5: gpio@e6055000 {
> -                       /* placeholder */
> -               };
> -
> -               gpio6: gpio@e6055400 {
> -                       /* placeholder */
> -               };
> -
> -               gpio7: gpio@e6055800 {
> -                       /* placeholder */
> -               };
> -
>                 intc_ex: interrupt-controller@e61c0000 {
>                         /* placeholder */
>                 };
> @@ -339,6 +307,126 @@
>                         dma-channels = <16>;
>                 };
>
> +               gpio0: gpio@e6050000 {

Why have you moved them?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
