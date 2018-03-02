Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423311AbeCBIxS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 03:53:18 -0500
Received: from mail-it0-f51.google.com ([209.85.214.51]:37940 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423223AbeCBIv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 03:51:57 -0500
X-Google-Smtp-Source: AG47ELsLFW+hDeRWe2ApX0rMfCkv6mO8ywogR0jGR3E8YO1kQmpv8oK+Y34DjbWNwiRKtrba20HLBNZHYUw3Xesn50Q=
MIME-Version: 1.0
In-Reply-To: <20180223122552.58049-1-icenowy@aosc.io>
References: <20180223122552.58049-1-icenowy@aosc.io>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 2 Mar 2018 09:51:56 +0100
Message-ID: <CACRpkdYtTLV1R+LpPp8J8uGX9f7sFXOkPuH8du0zz_v=FZHMBw@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Initial Allwinner H6 support
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
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

On Fri, Feb 23, 2018 at 1:25 PM, Icenowy Zheng <icenowy@aosc.io> wrote:

> This patchset adds initial support for the Allwinner H6 SoC.
>
> It's quite different from earlier Allwinner SoCs. For example, the
> memory map is refactored, and the CCU is rearranged. It's also the first
> Allwinner SoC with PCI Express interface, and the second one with USB
> 3.0 (the first one is A80).
>
> This patchset adds the most basical support for it, including the main pin
> controller, the main CCU and the basical device tree.

It seems the pin control part is more or less finished, I will
apply it after v4 if Maxime provides ACKs for it.

Is it fine to merge the pinctrl drivers/* portions in isolation from the
rest?

Yours,
Linus Walleij
