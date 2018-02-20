Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752696AbeBTPqw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 10:46:52 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:46856 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752504AbeBTPqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 10:46:51 -0500
X-Google-Smtp-Source: AH8x226Df+7QJIYUBWDrZyiZpsiNUMOmtkhHTVTZQK8EV88NUF2twMZ3JGPNGWUl/MRkIocFUo9yOQ0FSUec9rn8wVM=
MIME-Version: 1.0
In-Reply-To: <1519139541-18783-13-git-send-email-jacopo+renesas@jmondi.org>
References: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org> <1519139541-18783-13-git-send-email-jacopo+renesas@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Feb 2018 16:46:49 +0100
X-Google-Sender-Auth: dPAzzR6_W4yRuubzS-yxmcf_UYY
Message-ID: <CAMuHMdVEEcG6HcnnS0W6gTW57aD-y5Gg5ojvEr6TDvUp_irUPw@mail.gmail.com>
Subject: Re: [PATCH v2 12/19] dt-bindings: serial: sh-sci: Add support for
 r8a77965 (H)SCIF
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

On Tue, Feb 20, 2018 at 4:12 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> Add documentation for r8a77965 compatible string to Renesas sci-serial
> device tree bindings documentation.
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
