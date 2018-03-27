Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752647AbeC0NIn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 09:08:43 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:53281 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752289AbeC0NIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 09:08:40 -0400
X-Google-Smtp-Source: AG47ELvpkjrgI0G5+ljrdMTbSq5RX7zVg64RQfuUiJaDnUOW6w/wwjbpDXpw5X1xN/xK0xNTaCfr1udS5M//OHIZAyw=
MIME-Version: 1.0
In-Reply-To: <20180316140215.28663-4-icenowy@aosc.io>
References: <20180316140215.28663-1-icenowy@aosc.io> <20180316140215.28663-4-icenowy@aosc.io>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 27 Mar 2018 15:08:39 +0200
Message-ID: <CACRpkdaq6RYNdk5H4bFEJxfCErg0veqxY563uPr3W8d3cA9vZg@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] pinctrl: sunxi: change irq_bank_base to irq_bank_map
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

> The Allwinner H6 SoC have its pin controllers with the first IRQ-capable
> GPIO bank at IRQ bank 1 and the second bank at IRQ bank 5.
>
> Change the current code that uses IRQ bank base to a IRQ bank map, in
> order to support the case that holes exist among IRQ banks.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Extracted in v4.

Patch applied with Maxime's ACK.

Yours,
Linus Walleij
