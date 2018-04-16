Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755002AbeDPLMJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 07:12:09 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:37930 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752795AbeDPLMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 07:12:07 -0400
X-Google-Smtp-Source: AIpwx49wClKs5aBbZ5FHv7fwg8JOZ1K5exBvqN6ZW4HQU1Qruy0u1x69E8F2pDN+GxLWRuntDXhnYONII+dmN3Jzjvc=
MIME-Version: 1.0
In-Reply-To: <1519139541-18783-16-git-send-email-jacopo+renesas@jmondi.org>
References: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org> <1519139541-18783-16-git-send-email-jacopo+renesas@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 16 Apr 2018 13:12:06 +0200
X-Google-Sender-Auth: xgKyv6pJIs4BlUxkwRBKGeu9p50
Message-ID: <CAMuHMdW4k+GROdy6kKT-3jd7YYGVbKvieyCSEWXGXJyvZg7NGQ@mail.gmail.com>
Subject: Re: [PATCH v2 15/19] dt-bindings: gpio: Add support for r8a77965
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On Tue, Feb 20, 2018 at 4:12 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> Add compatible string for R-Car M3-N (r8a77965) in gpio-rcar.
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Can you please resend to the GPIO maintainer?
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
