Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753180AbeDCTwH convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 15:52:07 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58804 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752420AbeDCTwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 15:52:05 -0400
Date: Tue, 3 Apr 2018 21:52:02 +0200
From: =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Russell King <linux@armlinux.org.uk>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        LABBE Corentin <clabbe.montjoie@gmail.com>, quentin.schulz@bootlin.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 05/13] ARM: dts: sun8i: Add R_CPUCFG device node for
 the A83T dtsi
Message-ID: <20180403215202.2892baae@dell-desktop.home>
In-Reply-To: <CAGb2v66w3349h0b+xRD8seHhqMNoue8AzAFr-UPKvzZAtvoV5g@mail.gmail.com>
References: <20180403061836.3926-1-mylene.josserand@bootlin.com>
        <20180403061836.3926-6-mylene.josserand@bootlin.com>
        <CAGb2v66w3349h0b+xRD8seHhqMNoue8AzAFr-UPKvzZAtvoV5g@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, 3 Apr 2018 17:07:06 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

> On Tue, Apr 3, 2018 at 2:18 PM, Mylène Josserand
> <mylene.josserand@bootlin.com> wrote:
> > The R_CPUCFG is a collection of registers needed for SMP bringup
> > on clusters and cluster's reset.
> > For the moment, documentation about this register is found in
> > Allwinner's code only.
> >
> > Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
> > ---
> >  arch/arm/boot/dts/sun8i-a83t.dtsi | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
> > index 32992afa0b12..85f14f4ebeed 100644
> > --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
> > +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
> > @@ -933,6 +933,11 @@
> >                         #reset-cells = <1>;
> >                 };
> >
> > +               r_cpucfg@1f01c00 {
> > +                       compatible = "allwinner,sun8i-a83t-r-cpucfg";
> > +                       reg = <0x1f01c00 0x100>;  
> 
> The memory map says that its size is 0x400.
> 
> ChenYu

True, thank you for the correction.

Best regards,

-- 
Mylène Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
