Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752532AbeBSKmi convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 05:42:38 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:58604 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752377AbeBSKmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 05:42:37 -0500
Date: Mon, 19 Feb 2018 11:42:34 +0100
From: =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand@bootlin.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: wens@csie.org, linux@armlinux.org.uk, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clabbe.montjoie@gmail.com, thomas.petazzoni@bootlin.com,
        quentin.schulz@bootlin.com
Subject: Re: [PATCH v3 3/7] ARM: dts: sun8i: Add PRCM device node for the
 A83T dtsi
Message-ID: <20180219114234.0eeec1fc@dell-desktop.home>
In-Reply-To: <20180219084822.zudk3w55z75lx5gx@flea.lan>
References: <20180219081837.15482-1-mylene.josserand@bootlin.com>
        <20180219081837.15482-4-mylene.josserand@bootlin.com>
        <20180219084822.zudk3w55z75lx5gx@flea.lan>
Organization: Bootlin
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 19 Feb 2018 09:48:22 +0100
Maxime Ripard <maxime.ripard@bootlin.com> wrote:

> Hi,
> 
> On Mon, Feb 19, 2018 at 09:18:33AM +0100, Mylène Josserand wrote:
> > As we found in Sun9i-A80, PRCM is a collection of clock controls,
> > reset controls, and various power switches/gates.
> > It is used with CPUCFG for SMP bringup and CPU hotplugging.
> > 
> > Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
> > ---
> >  arch/arm/boot/dts/sun8i-a83t.dtsi | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
> > index e45bab836620..3e7317ec3e43 100644
> > --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
> > +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
> > @@ -699,6 +699,11 @@
> >  			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> >  		};
> >  
> > +		prcm@1f01400 {
> > +			compatible = "allwinner,sun8i-a83t-prcm";
> > +			reg = <0x1f01400 0x400>;
> > +		};
> > +
> >  		r_ccu: clock@1f01400 {
> >  			compatible = "allwinner,sun8i-a83t-r-ccu";
> >  			reg = <0x01f01400 0x400>;  
> 
> These two are exactly the same nodes.

Oh, yes, I did not pay attention to that.

Thanks,

Mylène

-- 
Mylène Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
