Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751972AbeFENXd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:23:33 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:41027 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751820AbeFENX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:23:27 -0400
X-Google-Smtp-Source: ADUXVKJ3JW3HKCK6f2jo4zRP56ONuvESPrG9Nrt+W6Wkj1ogGRYGW2det8pVioA8v1b9MjFp3ZzZouHNNxrhNiZXYl8=
MIME-Version: 1.0
In-Reply-To: <1528198148-23308-2-git-send-email-michel.pollet@bp.renesas.com>
References: <1528198148-23308-1-git-send-email-michel.pollet@bp.renesas.com> <1528198148-23308-2-git-send-email-michel.pollet@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 5 Jun 2018 15:23:25 +0200
X-Google-Sender-Auth: DbK4EkkLTjXSdutozejaQObNMKU
Message-ID: <CAMuHMdX3kmvYfGxXmcCT34rqfXm36cuQXb0ncy4kNrbAAX0oKw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: cpu: Add Renesas R9A06G032 SMP enable method.
To: Michel Pollet <michel.pollet@bp.renesas.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Michel Pollet <buserror+upstream@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Douglas Anderson <dianders@chromium.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>, Carlo Caione <carlo@endlessm.com>,
        Frank Rowand <frank.rowand@sony.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 1:28 PM, Michel Pollet
<michel.pollet@bp.renesas.com> wrote:
> Add a special enable method for second CA7 of the R9A06G032
>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
