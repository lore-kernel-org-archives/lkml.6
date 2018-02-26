Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751844AbeBZSW2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 13:22:28 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:37907 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751165AbeBZSW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 13:22:26 -0500
X-Google-Smtp-Source: AG47ELs02ZwaJm/TyJRtvw71FxS91AK6cKB6abJDlRotG58yuWLB7/bDLQJfZacr4cCHbgKil5C7tXbgx1tBQyptdvs=
MIME-Version: 1.0
In-Reply-To: <1519667836-31330-9-git-send-email-jacopo+renesas@jmondi.org>
References: <1519667836-31330-1-git-send-email-jacopo+renesas@jmondi.org> <1519667836-31330-9-git-send-email-jacopo+renesas@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Feb 2018 19:22:24 +0100
X-Google-Sender-Auth: CUBweAqeAnlER0ztv6oviidXKWQ
Message-ID: <CAMuHMdUXRVwgvN0aZLFGUpFuvrcgcdYqjj-OsBb6vsVH9okq8g@mail.gmail.com>
Subject: Re: [PATCH 8/8] arm64: dts: renesas: r8a77965: Add EtherAVB device node
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Simon Horman <horms@verge.net.au>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        iommu@lists.linux-foundation.org, netdev <netdev@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On Mon, Feb 26, 2018 at 6:57 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> Populate the ethernet@e6800000 device node to enable Ethernet interface
> for R-Car M3-N (R8A77965) SoC.
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> ---
> v1 -> v2:
> - Replace ALWAYS_ON power area identifier with numeric constant

And you added the iommus property, which I wouldn't bother doing at this
early stage.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
