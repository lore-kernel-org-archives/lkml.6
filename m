Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752059AbeERICY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 04:02:24 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50515 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751880AbeERICU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 04:02:20 -0400
Date: Fri, 18 May 2018 10:02:08 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Stefan Mavrodiev <stefan@olimex.com>
Cc: Stefan Wahren <stefan.wahren@i2se.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 1/1] ARM:dts:sunxi: Add Olimex A20-SOM-EVB-eMMC board
Message-ID: <20180518080208.mr7jit2pajgalti3@flea>
References: <1526470689-6275-1-git-send-email-stefan@olimex.com>
 <96201051.35560.1526541952287@email.1und1.de>
 <7ad11904-be61-a459-f2be-ff37fcd02402@olimex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="765wp2q25h6ttz4g"
Content-Disposition: inline
In-Reply-To: <7ad11904-be61-a459-f2be-ff37fcd02402@olimex.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--765wp2q25h6ttz4g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 17, 2018 at 10:34:06AM +0300, Stefan Mavrodiev wrote:
> On 05/17/2018 10:25 AM, Stefan Wahren wrote:
> > Hi Stefan,
> >=20
> > > Stefan Mavrodiev <stefan@olimex.com> hat am 16. Mai 2018 um 13:38 ges=
chrieben:
> > >=20
> > >=20
> > > With the new rev.E of A20-SOM-EVB, there is option for 16GB eMMC.
> > > Currently used card is KLMAG2GEND, wired to MMC2 slot.
> > >=20
> > > Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
> > > ---
> > >   arch/arm/boot/dts/Makefile                         |  1 +
> > >   .../arm/boot/dts/sun7i-a20-olimex-som-evb-emmc.dts | 37 +++++++++++=
+++++++++++
> > >   2 files changed, 38 insertions(+)
> > >   create mode 100644 arch/arm/boot/dts/sun7i-a20-olimex-som-evb-emmc.=
dts
> > >=20
> > > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > > index 1db91ec..7f1ee65 100644
> > > --- a/arch/arm/boot/dts/Makefile
> > > +++ b/arch/arm/boot/dts/Makefile
> > > @@ -959,6 +959,7 @@ dtb-$(CONFIG_MACH_SUN7I) +=3D \
> > >   	sun7i-a20-m3.dtb \
> > >   	sun7i-a20-mk808c.dtb \
> > >   	sun7i-a20-olimex-som-evb.dtb \
> > > +	sun7i-a20-olimex-som-evb-emmc.dtb \
> > >   	sun7i-a20-olimex-som204-evb.dtb \
> > >   	sun7i-a20-olimex-som204-evb-emmc.dtb \
> > >   	sun7i-a20-olinuxino-lime.dtb \
> > > diff --git a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb-emmc.dts b/ar=
ch/arm/boot/dts/sun7i-a20-olimex-som-evb-emmc.dts
> > > new file mode 100644
> > > index 0000000..81ebc97
> > > --- /dev/null
> > > +++ b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb-emmc.dts
> > > @@ -0,0 +1,37 @@
> > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > +/*
> > > + * Device Tree Source for A20-Olimex-SOM-EVB-eMMC Board
> > > + *
> > > + * Copyright (C) 2018 Olimex Ltd.
> > > + *   Author: Stefan Mavrodiev <stefan@olimex.com>
> > > + */
> > > +
> > > +/dts-v1/;
> > > +#include "sun7i-a20-olimex-som-evb.dts"
> > > +
> > > +/ {
> > > +
> > > +	model =3D "Olimex A20-Olimex-SOM-EVB-eMMC";
> > > +	compatible =3D "olimex,a20-olimex-som-evb-emmc", "allwinner,sun7i-a=
20";
> > the file Documentation/devicetree/bindings/arm/olimex.txt seems to be o=
ut of date. I cannot find any recent board compatible.
> >=20
> > Didn't checkpatch complain about it?
>
> Yes it did. I didn't get is seriously because neither Olimex A20 based bo=
ard
> is documented in the binding.

I guess we should fix that as well, but that can come in a subsequent
patch.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--765wp2q25h6ttz4g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlr+iH8ACgkQ0rTAlCFN
r3TDhg//RF09crnIwihM86T+0nFWOmLeUTWmJCdbpcfxQRMBYNPCUlHPG+a6dn36
XjmdgulRyYcM0Ymdi8tWpz85cQ2bawbTifWNjv8/ls2R6vszViP6mv5DP8JR83pb
9L4c/sZN4kUDSXzm720IKZsAz4zkNmmgQUsKuc/TPLSY4ggPMu3rHW6JF5X7fHC+
uuEXJ7w9eB9OPuwoXPfnjQraeqw600TqKbUeIa1tXQxAwtUnty/DjLAkri0EOqCL
O/rssjgyj4XSEJpsBxwy8so1jDyQkj+wdA5GlpnUqP3jVuoIncPdvco36tPHqZTV
iDxD62oD8ThHU+278iHecQu7jl1/5MbGeJNpYRmNEBNsf+nkh+KArDIbBw9X97/V
dt3x3KR2TUU4Eh7u33Owc7jxtiLjnbQDizdnSIzx/GD+urX76Szr8dQGArXi8A6q
0BuuDfuRfW++X41XnF+ijVN6iTpIEFduvTJJAnI6VyCixWa+fGu0qYDNHosyTS/D
x416vtT6IxaraOFGzOZesfc+1zlmd2h54i/Cq7cq/m3uf4wuMg1xilgwB6Y0vXCh
szB6wSlANkbnw0xHGx2MwiAOEVah4ymcvTnZ0e1widRXHUPUVJr9Ti4FdLTsMq/5
UoqfvS/Zw5q7JfQ+VPH1ygRTeonAWg93CAAuIAs5CxKFdZOE+uE=
=QNZt
-----END PGP SIGNATURE-----

--765wp2q25h6ttz4g--
