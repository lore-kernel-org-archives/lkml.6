Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030437AbeBNNxU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 08:53:20 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:57997 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030418AbeBNNxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 08:53:18 -0500
Date: Wed, 14 Feb 2018 14:53:06 +0100
From: jacopo mondi <jacopo@jmondi.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/15] pinctrl: sh-pfc: Initial R-Car M3-N support
Message-ID: <20180214135306.GA23932@w540>
References: <1518515162-23663-1-git-send-email-jacopo+renesas@jmondi.org>
 <1518515162-23663-5-git-send-email-jacopo+renesas@jmondi.org>
 <CAMuHMdUpEjnNa4kru7mUnvhTu2YoofoopuCvUp=AGdRJqfaNEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdUpEjnNa4kru7mUnvhTu2YoofoopuCvUp=AGdRJqfaNEw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,
   thanks for review

On Wed, Feb 14, 2018 at 02:37:08PM +0100, Geert Uytterhoeven wrote:
> Hi Jacopo,
>
> On Tue, Feb 13, 2018 at 10:45 AM, Jacopo Mondi
> <jacopo+renesas@jmondi.org> wrote:
> > Add initial PFC support for R-Car M3-N (r8a77965) SoC.
> > No groups or functions defined, just pin and registers enumeration.
> >
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
>
> Thanks for your patch!
>
> Looks mostly OK to me.
> You do want to compare with pfc-r8a7796.c: all differences not related to
> SATA_DEVSL, FSCLK, DU_DOTCLKIN2/3, and PRESET are issues that were fixed
> recently in pfc-r8a7796.c, and should apply to pfc-r8a77965.c, too.
>

I have used the M3-W tables with the exception of the pins/groups you
mentioned, that are clearly marked as different in the datasheet. At
least, this was my intention :)

I used v4.15 M3-W PFC tables, should I look in v4.16-rc1 or in
renesas-drivers for updates?

> That leaves us with very few differences only, but it won't be trivial to have
> a combined M3-W/N PFC driver, I'm afraid.
>

Takes a certain degree of grep-foo to clearly highlight differences
between the two version. Do you have any script/tools you use to
compare PFC tables a bit more easily?

Thanks
  j

> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
