Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752658AbeC0NMY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 09:12:24 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:38389 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752619AbeC0NMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 09:12:21 -0400
X-Google-Smtp-Source: AG47ELv0rmGvFtG6RRxNrORPE4LfJT51U0aiETeVtOD38ledaS/GmGxdI4N2WAuNZ9dLJuKrKvKhDbnjDbjjNliec6M=
MIME-Version: 1.0
In-Reply-To: <20180316140215.28663-1-icenowy@aosc.io>
References: <20180316140215.28663-1-icenowy@aosc.io>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 27 Mar 2018 15:12:20 +0200
Message-ID: <CACRpkdYW4N-zuPGGz+=GHUX69xBTS3w=EYhiP7dDvr+DZNUJUw@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] Initial Allwinner H6 support
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 3:02 PM, Icenowy Zheng <icenowy@aosc.io> wrote:

> This patchset adds initial support for the Allwinner H6 SoC.
>
> It's quite different from earlier Allwinner SoCs. For example, the
> memory map is refactored, and the CCU is rearranged. It's also the first
> Allwinner SoC with PCI Express interface (although the implementation
> of the PCI Express controller is broken), and the second one with USB
> 3.0 (the first one is A80).
>
> This patchset adds the most basical support for it, including the main pin
> controller, the main CCU and the basical device tree.
>
> Icenowy Zheng (9):
>   pinctrl: sunxi: refactor irq related register function to have desc
>   pinctrl: sunxi: introduce IRQ bank conversion function
>   pinctrl: sunxi: change irq_bank_base to irq_bank_map
>   pinctrl: sunxi: add support for the Allwinner H6 main pin controller

I applied these pinctrl patches for v4.17 so anything dependent on that
can now be merged.

Yours,
Linus Walleij
