Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754222AbeB0Py5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 10:54:57 -0500
Received: from mail.bootlin.com ([62.4.15.54]:59068 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753548AbeB0Py4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 10:54:56 -0500
Date: Tue, 27 Feb 2018 16:54:44 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/8] MIPS: mscc: add ocelot PCB123 device tree
Message-ID: <20180227155444.GB15333@piout.net>
References: <20180116101240.5393-1-alexandre.belloni@free-electrons.com>
 <20180116101240.5393-7-alexandre.belloni@free-electrons.com>
 <20180214170042.GE3986@saruman>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180214170042.GE3986@saruman>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2018 at 17:00:42 +0000, James Hogan wrote:
> On Tue, Jan 16, 2018 at 11:12:38AM +0100, Alexandre Belloni wrote:
> > Add a device tree for the Microsemi Ocelot PCB123 evaluation board.
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> Please Cc DT folk.
> 

I can do but again, I don't think they care.

> > diff --git a/arch/mips/boot/dts/mscc/ocelot_pcb123.dts b/arch/mips/boot/dts/mscc/ocelot_pcb123.dts
> > new file mode 100644
> > index 000000000000..42bd404471f6
> > --- /dev/null
> > +++ b/arch/mips/boot/dts/mscc/ocelot_pcb123.dts
> > @@ -0,0 +1,27 @@
> > +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> > +/* Copyright (c) 2017 Microsemi Corporation */
> > +
> > +/dts-v1/;
> > +
> > +#include "ocelot.dtsi"
> > +
> > +/ {
> > +	compatible = "mscc,ocelot-pcb123", "mscc,ocelot";
> 
> Should mscc,ocelot-pcb123 be added to the mscc DT binding documentation
> in the other patch?
> 

On ARM at least, we don't document the board compatibles because this
will be a huge list without much benefit as they are mostly unused.
Still, it is nice to have in case something specific needs to be done
for a particular board (and hopefully this never happens).

also, I don't think any other MIPS boards are documented bu if you
insist, I can either add it in
Documentation/devicetree/bindings/mips/mscc.txt or create a new file to
list all the mips board compatibles.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
