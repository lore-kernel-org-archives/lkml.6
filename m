Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751524AbeBWJXR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 04:23:17 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:44926 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750861AbeBWJXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 04:23:15 -0500
X-Google-Smtp-Source: AG47ELvIjc7cjaGWf+JPyI232gQglEQqEjn8Ag5fHLTqeUInsTS2mbuw6ir8STRuRSQO3EnsqLoUIm7HBAa5yIdsSBw=
MIME-Version: 1.0
In-Reply-To: <1519326370-15805-3-git-send-email-jacopo+renesas@jmondi.org>
References: <1519326370-15805-1-git-send-email-jacopo+renesas@jmondi.org> <1519326370-15805-3-git-send-email-jacopo+renesas@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 23 Feb 2018 10:23:13 +0100
X-Google-Sender-Auth: cez-F_ygcR5SLO_ECwZjQuzBtf0
Message-ID: <CAMuHMdXW2JZr1=XTqdxc1s9_woH=Sget8m3aM6FMXFF4JYoeeg@mail.gmail.com>
Subject: Re: [PATCH 2/6] arm64: dts: renesas: r8a77965: Add #address-cells and #size-cells
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 8:06 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> Add "#address-cells" and "#size-cells" properties to all place-holder nodes
> that have children nodes defined by salvator-x[s].dtsi device tree.
>
> This silences the following DTC compiler warnings:
> Warning (reg_format): "reg" property in /soc/.. has invalid length (4 bytes)
> (#address-cells == 2, #size-cells == 1)
> Warning (avoid_default_addr_size): Relying on default #address-cells
> value for /soc/...
> Warning (avoid_default_addr_size): Relying on default #size-cells value
> for /soc/...
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
