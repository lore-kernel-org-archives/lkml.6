Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031734AbeBPNkP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 08:40:15 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:33912 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031458AbeBPNkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 08:40:13 -0500
Date: Fri, 16 Feb 2018 14:40:08 +0100
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 06/15] Documentation: devicetree: dma: Add r8a77965 dmac
Message-ID: <20180216134007.vkkhb3ybose3tlrp@verge.net.au>
References: <1518515162-23663-1-git-send-email-jacopo+renesas@jmondi.org>
 <1518515162-23663-7-git-send-email-jacopo+renesas@jmondi.org>
 <20180215153948.puwztivx3zwtqxet@verge.net.au>
 <20180215155638.kh6hxxo4tmit3jj4@verge.net.au>
 <CAMuHMdUPLPABkeefDE8+V4Bbs1GK9fBY0hzWU1_zAQ0o-3hTsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUPLPABkeefDE8+V4Bbs1GK9fBY0hzWU1_zAQ0o-3hTsg@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 10:01:33AM +0100, Geert Uytterhoeven wrote:
> On Thu, Feb 15, 2018 at 4:56 PM, Simon Horman <horms@verge.net.au> wrote:
> > On Thu, Feb 15, 2018 at 04:39:49PM +0100, Simon Horman wrote:
> >> On Tue, Feb 13, 2018 at 10:45:53AM +0100, Jacopo Mondi wrote:
> >> > Add documentation for r8a77965 compatible string to rcar-dmac device
> >> > tree bindings documentation.
> >> >
> >> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> >>
> >> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> >
> > Sorry for not noticing this the first time around.
> >
> > I think a better subject would be:
> >
> > dt-bindings: dmaengine: rcar-dmac: document R8A77964 support
> 
> s/64/65/ ;-)

These kind of errors allow you to verify that the email really came from me :)
