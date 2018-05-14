Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752045AbeENUds (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 16:33:48 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:33847 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751865AbeENUdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 16:33:46 -0400
X-Google-Smtp-Source: AB8JxZqjBB6/krZneC+KOG5NpVrxHWOuBpa3w+1JBXj5c8EqXBXDOJnBjK6CiyugC92cX1AZayVJa8qkQYnup+04E+M=
MIME-Version: 1.0
In-Reply-To: <1526032802-14376-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1526032802-14376-1-git-send-email-jacopo+renesas@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 14 May 2018 22:33:44 +0200
X-Google-Sender-Auth: ogf1LNZWLDT96M4A8yBEvp1i3Ws
Message-ID: <CAMuHMdXdDZdbrpLTogyR=djwtQYMf1dgAA_z+8HaFZBG6R+e6g@mail.gmail.com>
Subject: Re: [PATCH 0/3] arm64: dts: Draak: Enable HDMI input and VIN4
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On Fri, May 11, 2018 at 11:59 AM, Jacopo Mondi
<jacopo+renesas@jmondi.org> wrote:
>    this series enables HDMI input and VIN4 on R-Car D3 Draak board.
>
> The Draak board has an HDMI input connected to an HDMI decoder that feeds
> the VIN capture interface through its parallel video interface.
>
> The series requires the just sent:
> [PATCH 0/5] rcar-vin: Add support for digital input on Gen3
>
> and enables image capture operations on D3 Draak board.
>
> The series has been developed on top of media-master tree but applies cleanly
> on top of latest renesas-driver.
>
> Geert: would you like a topic branch for this series to be included in
> renesas-drivers?

It seems patch 2 has been applied by Simon already, but there is some
discussion pending on patch 3?

> Patches for testing are available at:
> git://jmondi.org/linux d3/media-master/driver
> git://jmondi.org/linux d3/media-master/dts
> git://jmondi.org/linux d3/media-master/test
> git://jmondi.org/vin-tests d3
>
> Thanks
>     j
>
> Jacopo Mondi (3):
>   dt-bindings: media: rcar-vin: Add R8A77995 support
>   arm64: dts: renesas: r8a77995: Add VIN4
>   arm64: dts: renesas: draak: Describe HDMI input
>
>  .../devicetree/bindings/media/rcar_vin.txt         |  1 +
>  arch/arm64/boot/dts/renesas/r8a77995-draak.dts     | 68 ++++++++++++++++++++++
>  arch/arm64/boot/dts/renesas/r8a77995.dtsi          | 11 ++++
>  3 files changed, 80 insertions(+)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
