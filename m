Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934000AbeCGQFB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 11:05:01 -0500
Received: from mail.bootlin.com ([62.4.15.54]:42699 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933502AbeCGQFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 11:05:00 -0500
Date: Wed, 7 Mar 2018 17:04:48 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/5] MIPS: mscc: add ocelot dtsi
Message-ID: <20180307160448.GN3035@piout.net>
References: <20180306121607.1567-1-alexandre.belloni@bootlin.com>
 <20180306121607.1567-3-alexandre.belloni@bootlin.com>
 <20180307151753.GQ4197@saruman>
 <20180307152751.GM3035@piout.net>
 <20180307155605.GS4197@saruman>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307155605.GS4197@saruman>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2018 at 15:56:07 +0000, James Hogan wrote:
> On Wed, Mar 07, 2018 at 04:27:51PM +0100, Alexandre Belloni wrote:
> > On 07/03/2018 at 15:17:56 +0000, James Hogan wrote:
> > > On Tue, Mar 06, 2018 at 01:16:04PM +0100, Alexandre Belloni wrote:
> > > > diff --git a/arch/mips/boot/dts/mscc/ocelot.dtsi b/arch/mips/boot/dts/mscc/ocelot.dtsi
> > > > new file mode 100644
> > > > index 000000000000..8c3210577410
> > > > --- /dev/null
> > > > +++ b/arch/mips/boot/dts/mscc/ocelot.dtsi
> > > > @@ -0,0 +1,117 @@
> > > > +//SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > > 
> > > Niggle: there should be a space after // for consistency with other
> > > files. Same in patch 3.
> > > 
> > 
> > Ah, yes...
> > 
> > If that is the only thing left, I can resend right away
> 
> There are a couple of irqchip patches from v2 which have gone from the
> latest versions:
> https://patchwork.linux-mips.org/project/linux-mips/list/?series=568
> 

I'll get those through the irqchip tree.

> and the vendor prefix too from v4:
> https://patchwork.linux-mips.org/project/linux-mips/list/?series=856
> 

My mistake, I prepared my series from that patch, excluded instead of
from that patch, included.

> I presume they're all still relevant. Were you expecting the irqchip
> ones to go through MIPS too? We'd need an ack from the irqchip folk if
> so.
> 
> Cheers
> James



-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
