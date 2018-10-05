Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FE7C65BAA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBAB9208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:31:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBAB9208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbeJEWaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 18:30:18 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49841 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbeJEWaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 18:30:18 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id DD8E52074F; Fri,  5 Oct 2018 17:31:03 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id AF60520734;
        Fri,  5 Oct 2018 17:31:03 +0200 (CEST)
Date:   Fri, 5 Oct 2018 17:31:04 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH 12/12] arm64: dts: allwinner: bananapi-m64: Bananapi
 S070WV20-CT16 DSI panel
Message-ID: <20181005153104.xxv5vxinvawz3hic@flea>
References: <20180927114850.24565-1-jagan@amarulasolutions.com>
 <20180927114850.24565-13-jagan@amarulasolutions.com>
 <20180927171747.wqdt5eiwktyyoefz@flea>
 <CAMty3ZBb25EBF85oGYZFMGkW1F8DwojfwWp=UKhoTrJZmQkjZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xdzysu2lcfowgjtf"
Content-Disposition: inline
In-Reply-To: <CAMty3ZBb25EBF85oGYZFMGkW1F8DwojfwWp=UKhoTrJZmQkjZQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xdzysu2lcfowgjtf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 04, 2018 at 09:33:59PM +0530, Jagan Teki wrote:
> On Thu, Sep 27, 2018 at 10:47 PM Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> >
> > On Thu, Sep 27, 2018 at 05:18:50PM +0530, Jagan Teki wrote:
> > > This patch add support for Bananapi S070WV20-CT16 DSI panel to
> > > BPI-M64 board.
> > >
> > > DSI panel connected via board DSI port with,
> > > - DC1SW as AVDD supply
> > > - DCDC1 as DVDD supply
> > > - PD6 gpio for reset pin
> > > - PD5 gpio for backlight enable pin
> > > - PD7 gpio for backlight vdd supply
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > >  .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 42 +++++++++++++++++=
++
> > >  1 file changed, 42 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dt=
s b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> > > index ef1c90401bb2..c0be949be68d 100644
> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> > > @@ -45,6 +45,7 @@
> > >  #include "sun50i-a64.dtsi"
> > >
> > >  #include <dt-bindings/gpio/gpio.h>
> > > +#include <dt-bindings/pwm/pwm.h>
> > >
> > >  / {
> > >       model =3D "BananaPi-M64";
> > > @@ -56,6 +57,24 @@
> > >               serial1 =3D &uart1;
> > >       };
> > >
> > > +     vdd_bl: regulator@0 {
> > > +             compatible =3D "regulator-fixed";
> > > +             regulator-name =3D "bl-3v3";
> > > +             regulator-min-microvolt =3D <3300000>;
> > > +             regulator-max-microvolt =3D <3300000>;
> > > +             gpio =3D <&pio 3 7 GPIO_ACTIVE_HIGH>; /* PD7 */
> > > +             enable-active-high;
> > > +     };
> > > +
> > > +     backlight_dsi: backlight-dsi {
> > > +             compatible =3D "pwm-backlight";
> > > +             pwms =3D <&r_pwm 0 50000 PWM_POLARITY_INVERTED>;
> > > +             brightness-levels =3D <0 10 20 30 40 50 60 70 80 90 100=
>;
> >
> > The brightness levels should be increasing linearly from a user point
> > of view. Usually, with a PWM backlight, a quadratic rule works much
> > better.
>=20
> Does that mean, 0 40 80 ...

No, that means 1 2 4 8 16 32 etc..

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--xdzysu2lcfowgjtf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlu3g7cACgkQ0rTAlCFN
r3Sw9g/+J1ltTpyEpyVxRuutEOOe7lCdxJS7qNYR35GQw7Q66wh+mzC+eaY5D5qK
BsBIzsSGMR9cGqQroY/SxahVJlk3dgzsVRQYvekaWIyoiVeMAHEGOtCJ1JH7X10K
/y3FfD9Gruj+yuTdbEF1or3tEN8wvFMBNVCUO6Pa6r83jo6J1LKF7cYp3Jt+tbmo
mbKwWxpZ1mKfFRxJ44kw6Uz6h96ljeEIscfsiopEjmCPlg94vMAuGRwcYHnvZrqy
5Ig0OSlrdPMVz0PS27dF/JTVTJu+f+FbOP0ZWbXcZylswVWCKCxQjNhmGpYz5xLB
lodS+b++sx/hCBVZCWmFJwfJfocMcdRU16bpPgCsMoDSg/3AJIdys9gWob/T0klR
LMHTQkCUj9ZpvkIv+Vf211u5KsFlQzay1FnItm5RwfVW8jF7KIF/+PHj99QR3UFu
qOx93gUDIrUWQv96/wnPyEmEnqjRH8sw5EIk0XzcZTyRQ9nUW9npv99Rn8dOeoXc
cwsNNlIitQqjIIT0URmiOnRbz98hEggqxzIusMUj3w37IzHqdTGHdJlhWkK+UCHO
j/Htn8yUs914Y+/y6W5NLH/3cW3epsblGwQxn8B0/TjLWSIEfxB1n0KH6phKRmgg
3Dm1x2T6MkSEGEDfv+J4/K1YuDLkguI8ICSQ+le3PbI+XtikdmA=
=lZdS
-----END PGP SIGNATURE-----

--xdzysu2lcfowgjtf--
