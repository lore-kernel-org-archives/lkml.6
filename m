Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751571AbeBTSfw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 13:35:52 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:37014 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751131AbeBTSfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 13:35:50 -0500
X-Google-Smtp-Source: AH8x227shF8ktFgw5Bew+4bLNWyedTjaQlAIAhQtrylDaH0FCMn6jamdz/EzEN2MrqkcHx3si2y3vkfN5eIQuZFSDfI=
MIME-Version: 1.0
In-Reply-To: <1519139541-18783-6-git-send-email-jacopo+renesas@jmondi.org>
References: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org> <1519139541-18783-6-git-send-email-jacopo+renesas@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Feb 2018 19:35:49 +0100
X-Google-Sender-Auth: u5_cB9bWad18j-dHDw4RkmUHF6c
Message-ID: <CAMuHMdUo+q2V-jpvguW75dbSxoGvihR1yxZSb3AUPrQ22L2xBQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/19] pinctrl: sh-pfc: Initial R-Car M3-N support
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

Hi Jacopo,

On Tue, Feb 20, 2018 at 4:12 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> Add initial PFC support for R-Car M3-N (r8a77965) SoC.
> No groups or functions defined, just pin and registers enumeration.
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
>
> ---
> v1 -> v2:
>
> Applied the following patches for r8a7796 on r8a77965:
>
> commit 0f4713d71f22d3b0ec3de6ae4a126cceecdea82b
> Author: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Date:   Thu Nov 16 23:59:21 2017 +0900
> pinctrl: sh-pfc: r8a7796: Rename RTS{0,1,3,4}# pin function definitions
>
> commit fbd81e345c9393b96e8ad252eef390f8c6f9cf60
> Author: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Date:   Thu Nov 16 12:17:18 2017 +0900
> pinctrl: sh-pfc: r8a7796: Fix to delete A20..A25 pins function definitions

Thanks for the update!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
and queueing in sh-pfc-for-v4.17, with the following recent fixes for
r8a7796 that are also applicable to r8a77965 folded in:

    pinctrl: sh-pfc: r8a7796: Fix IPSR and MOD_SEL register pin
assignment for NDFC pins group
    pinctrl: sh-pfc: r8a7796: Fix MOD_SEL register pin assignment for
SSI pins group

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
