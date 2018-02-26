Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751569AbeBZSQn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 13:16:43 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:45355 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750762AbeBZSQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 13:16:41 -0500
X-Google-Smtp-Source: AG47ELv5t/g3pQFuDih6ov66a/cUWbF9J+iJvCkCRqooeHFn8tVKC+NTRdVrDx6+O5XgCW38ssnPUH+On6eFJufKzpA=
MIME-Version: 1.0
In-Reply-To: <1519667836-31330-2-git-send-email-jacopo+renesas@jmondi.org>
References: <1519667836-31330-1-git-send-email-jacopo+renesas@jmondi.org> <1519667836-31330-2-git-send-email-jacopo+renesas@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Feb 2018 19:16:38 +0100
X-Google-Sender-Auth: VN6a_bQJ1_X0mH2naCfnnhcOHkQ
Message-ID: <CAMuHMdWM4-pisr+Yg4FABf0RnY_=2hnCvsmKYdUVe+FwM0T+rQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] arm64: dts: renesas: salvator-common: Override
 EtherAVB phy-mode
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
> As the PHY interface installed on the Salvator-X[S] board, provides TX
> channel delay, make the "phy-mode" property a board-specific one, meant
> to override the one specified in the SoC DTSI.
>
> Follow up patches will reset the SoC DTSI to use "rgmii" mode and let
> the board file override that.
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
