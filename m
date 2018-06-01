Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751042AbeFAIH7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 04:07:59 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:40466 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbeFAIHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 04:07:51 -0400
X-Google-Smtp-Source: ADUXVKITz5ylJ+v3qyEY8icbPbUS+YZn/H9/3hmI3fBt2FIx7w+n/ttW1dsRnjKKZUGHrajvHJNdOb8C4sAHv/EzwMY=
MIME-Version: 1.0
In-Reply-To: <1527171551-21979-6-git-send-email-gilad@benyossef.com>
References: <1527171551-21979-1-git-send-email-gilad@benyossef.com> <1527171551-21979-6-git-send-email-gilad@benyossef.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 1 Jun 2018 10:07:49 +0200
X-Google-Sender-Auth: V3IUWnqQ4-tMcX-bl1qAtuQKjSE
Message-ID: <CAMuHMdUCZN_4yBWAJvSM89d-Vp=cQ9ndzaKvkM9jYZnO1OEg4g@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] arm64: dts: renesas: r8a7795: add ccree binding
To: Gilad Ben-Yossef <gilad@benyossef.com>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ofir Drang <ofir.drang@arm.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gilad,

On Thu, May 24, 2018 at 4:19 PM, Gilad Ben-Yossef <gilad@benyossef.com> wrote:
> Add bindings for CryptoCell instance in the SoC.
>
> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>

Thanks for the update!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
