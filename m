Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754208AbeE1JPj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:15:39 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:56388 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753984AbeE1JPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:15:35 -0400
Date: Mon, 28 May 2018 11:15:30 +0200
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michel Pollet <michel.pollet@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Michel Pollet <buserror+upstream@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 3/5] ARM: dts: Renesas R9A06G032 base device tree file
Message-ID: <20180528091529.xno3o4nt7k7cenmy@verge.net.au>
References: <1527154169-32380-1-git-send-email-michel.pollet@bp.renesas.com>
 <1527154169-32380-4-git-send-email-michel.pollet@bp.renesas.com>
 <CAMuHMdW5VvZ-wbO7TuZC2z+KFPLq_PhBGe3WbAeES-nezb7tmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdW5VvZ-wbO7TuZC2z+KFPLq_PhBGe3WbAeES-nezb7tmQ@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 11:27:46AM +0200, Geert Uytterhoeven wrote:
> Hi Michel,
> 
> On Thu, May 24, 2018 at 11:28 AM, Michel Pollet
> <michel.pollet@bp.renesas.com> wrote:
> > This adds the Renesas R9A06G032 bare bone support.
> >
> > This currently only handles generic parts (gic, architected timer)
> > and a UART.
> >
> > Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> 
> Thanks for your patch!
> 
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/r9a06g032.dtsi
> 
> > +       soc {
> > +               compatible = "simple-bus";
> > +               #address-cells = <1>;
> > +               #size-cells = <1>;
> > +               interrupt-parent = <&gic>;
> > +               ranges;
> > +
> > +               sysctrl: sysctrl@4000c000 {
> 
> system-controller@
> 
> > +                       compatible = "renesas,r9a06g032-sysctrl";
> > +                       reg = <0x4000c000 0x1000>;
> > +                       status = "okay";
> > +                       #clock-cells = <1>;
> > +               };
> 
> With the minor nit above resolved, and pending acceptance of the
> sysctrl bindings:
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks. I have marked this patch, and the following one, as deferred
pending acceptance of those bindings. Please repost or otherwise ping me
once that has happened.
