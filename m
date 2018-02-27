Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932198AbeB0PsH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 10:48:07 -0500
Received: from mail.bootlin.com ([62.4.15.54]:58940 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932177AbeB0PsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 10:48:05 -0500
Date: Tue, 27 Feb 2018 16:47:54 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/8] MIPS: mscc: add ocelot dtsi
Message-ID: <20180227154754.GA15333@piout.net>
References: <20180116101240.5393-1-alexandre.belloni@free-electrons.com>
 <20180116101240.5393-6-alexandre.belloni@free-electrons.com>
 <20180214165743.GD3986@saruman>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180214165743.GD3986@saruman>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2018 at 16:57:43 +0000, James Hogan wrote:
> On Tue, Jan 16, 2018 at 11:12:37AM +0100, Alexandre Belloni wrote:
> > Add a device tree include file for the Microsemi Ocelot SoC.
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> May I suggest Cc'ing the DT folk on this patch.
> 

I can do that but I think that while they care about the bindings
themselves, they usually don't review the device trees.

So I wouldn't expect any review from Rob on such a patch, especially
since he reviewed the bndings.

> > diff --git a/arch/mips/boot/dts/mscc/Makefile b/arch/mips/boot/dts/mscc/Makefile
> > new file mode 100644
> > index 000000000000..f0a155a74e02
> > --- /dev/null
> > +++ b/arch/mips/boot/dts/mscc/Makefile
> > @@ -0,0 +1,4 @@
> > +obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
> > +
> > +# Force kbuild to make empty built-in.o if necessary
> > +obj-				+= dummy.o
> 
> I don't think you need this since f7adc3124da0 ("kbuild: create
> built-in.o automatically if parent directory wants it"). It was removed
> from other places in bf070bb0e6c6 ("kbuild: remove all dummy assignments
> to obj-").
> 
> Cheers
> James



-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
