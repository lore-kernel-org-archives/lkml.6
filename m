Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752028AbeFENYX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:24:23 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:39053 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751832AbeFENYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:24:21 -0400
X-Google-Smtp-Source: ADUXVKJU03MCo9FzkTYWAQ6POFjefT+DgdLgLpshBpgQeKa0hMGXRkP92nFiXwdffngrXjhIznW+fIveh5u1q0VznRk=
MIME-Version: 1.0
In-Reply-To: <1528198148-23308-4-git-send-email-michel.pollet@bp.renesas.com>
References: <1528198148-23308-1-git-send-email-michel.pollet@bp.renesas.com> <1528198148-23308-4-git-send-email-michel.pollet@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 5 Jun 2018 15:24:20 +0200
X-Google-Sender-Auth: ObtUcBj1i42Aa0yK1XASZLFvaHI
Message-ID: <CAMuHMdVPfE=0EynQg1syOiPCMbvtK9ooWo+_hvtY=VEMKMPXHw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] ARM: dts: Renesas R9A06G032 SMP enable method
To: Michel Pollet <michel.pollet@bp.renesas.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Michel Pollet <buserror+upstream@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Carlo Caione <carlo@endlessm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Frank Rowand <frank.rowand@sony.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
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
> Add a special enable method for the second CA7 of the R9A06G032
> as well as the default value for the "cpu-release-addr" property.
>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
