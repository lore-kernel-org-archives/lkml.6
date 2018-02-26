Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751704AbeBZSRa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 13:17:30 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44372 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751472AbeBZSR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 13:17:28 -0500
X-Google-Smtp-Source: AG47ELthzCIXeC0JMWMv8XutbU6V5flAH9vCzLqA0rkWyQISzFlXJs+61l/glUxVPn1vU8JqepbfY05328Uf+BNuDqE=
MIME-Version: 1.0
In-Reply-To: <1519667836-31330-3-git-send-email-jacopo+renesas@jmondi.org>
References: <1519667836-31330-1-git-send-email-jacopo+renesas@jmondi.org> <1519667836-31330-3-git-send-email-jacopo+renesas@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Feb 2018 19:17:27 +0100
X-Google-Sender-Auth: Zi7UQL86KwCOpLqOheiBr9aLGOk
Message-ID: <CAMuHMdVnS3_f6ZsaJ3=SqZwAdKv+mWqJ1_q2VpKD+VMvsqZEnw@mail.gmail.com>
Subject: Re: [PATCH 2/8] arm64: dts: renesas: r8a7796: Set EtherAVB phy mode
 to "rgmii"
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

On Mon, Feb 26, 2018 at 6:57 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> Set the "phy-mode" property of EtherAVB device to "rgmii" and let board
> files override it if the installed PHY layer provides delays for the
> RX/TX channels.
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

But you need a patch to update ulcb.dtsi first.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
