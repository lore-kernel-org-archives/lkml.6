Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752505AbeDKXKP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 19:10:15 -0400
Received: from 220.107.128.77.rev.sfr.net ([77.128.107.220]:43144 "EHLO
        gagarine.paulk.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750785AbeDKXKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 19:10:13 -0400
Message-ID: <588060914d3b6899f6812daa4969f61bf750c91b.camel@paulk.fr>
Subject: Re: [linux-sunxi] Re: [PATCH 2/3] ARM: dts: sun7i: Add RGB666 pins
 definition
From: Paul Kocialkowski <contact@paulk.fr>
To: giulio.benetti@micronovasrl.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com
Cc: Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Russell King <linux@armlinux.org.uk>, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Date: Thu, 12 Apr 2018 01:09:59 +0200
In-Reply-To: <e7f68882-c333-12ac-c122-20b0d7b65666@micronovasrl.com>
References: <20180410213129.24049-1-contact@paulk.fr>
         <20180410213129.24049-2-contact@paulk.fr>
         <e7f68882-c333-12ac-c122-20b0d7b65666@micronovasrl.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-/aaeYYd/6fpGElp81Fhz"
X-Mailer: Evolution 3.28.1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/aaeYYd/6fpGElp81Fhz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le jeudi 12 avril 2018 =C3=A0 00:22 +0200, Giulio Benetti a =C3=A9crit :
> Hi,
>=20
> Il 10/04/2018 23:31, Paul Kocialkowski ha scritto:
> > This adds the pins definition for RGB666 LCD panels on the A20. It
> > was
> > imported from the A33 definition, that concernes the same set of
> > pins.
> >=20
> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > ---
> >   arch/arm/boot/dts/sun7i-a20.dtsi | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> >=20
> > diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi
> > b/arch/arm/boot/dts/sun7i-a20.dtsi
> > index e529e4ff2174..f46af8675cfa 100644
> > --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> > +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> > @@ -781,6 +781,14 @@
> >   				function =3D "ir1";
> >   			};
> >  =20
> > +			lcd_rgb666_pins: lcd_rgb666@0 {
>=20
> I point you to this Thread and back:
> https://lists.freedesktop.org/archives/dri-devel/2018-March/170688.htm
> l
>=20
> I did the same for rgb888, so good part is discussed.
>=20
> IMHO I would:
> - call lcd0_rgb666_pins, since this is for LCD0 interface
> - same as above, call lcd0-rgb666, take care about using "-" instad
> of=20
> "_" that can cause DTC warnings.
> - remove @0 since only this set can achieve LCD0 RGB666, and I
>    don't think there will be other combinations.

I even responded to that discussion but overlooked these aspects when
crafting this patch. Thanks for the summary :)

> Kind regards
>=20
> --=20
> Giulio Benetti
> CTO
>=20
> MICRONOVA SRL
> Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
> Tel. 049/8931563 - Fax 049/8931346
> Cod.Fiscale - P.IVA 02663420285
> Capitale Sociale =E2=82=AC 26.000 i.v.
> Iscritta al Reg. Imprese di Padova N. 02663420285
> Numero R.E.A. 258642
>=20
>=20
> > +				pins =3D "PD2", "PD3", "PD4", "PD5",
> > "PD6", "PD7",
> > +				       "PD10", "PD11", "PD12",
> > "PD13", "PD14", "PD15",
> > +				       "PD18", "PD19", "PD20",
> > "PD21", "PD22", "PD23",
> > +				       "PD24", "PD25", "PD26",
> > "PD27";
> > +				function =3D "lcd0";
> > +			};
> > +
> >   			mmc0_pins_a: mmc0@0 {
> >   				pins =3D "PF0", "PF1", "PF2",
> >   				       "PF3", "PF4", "PF5";
> >=20
>=20
>=20
--=20
Paul Kocialkowski,

developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
--=-/aaeYYd/6fpGElp81Fhz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAlrOlccACgkQhP3B6o/u
lQxQtw/+L30M/sriICp40At1qyaGQdhI1oi8jnsHw0gI32lzg01N6aaB4PL8oF1S
wxFmwSSKAQtB6Xo9vdMdBol4jnYgtufef+NElP1j2+JDIZUI6MANVr+39sRiZ0NX
fpL+VPMc6141+CgSY6lBFKnYt0HoQGSCfaMeeTpZ0dymseFNQYvRcrAVwiOQl8aB
VGbVgnDxt4YnK6bxrOnxf12OU9d1dyQWqieosT/LxgLor2mT7qHJV+UlznITxVpO
mscPxhOyWHy/V7xZdygmmEZsPqFQpP8wbkQE/F1Bl05/XdIswquYAY+kMxeMXgDx
Iv7UJUmHmx6vUH0Mw2Lqxo+rZX8kPEYHtVeLZOPjfihoMGW8n9yWD9QSCNIhYHAA
PnLSbQ78liOcED16uLK/byErKMf90nmaLgA/XeoQqsJXpm+3enaDJMeL881BXg0G
qNaOsVo14HMDPsVltuQygh6+AFJxSUym0KcKvgFe8xHXhpVC7AELctM6jJ0+ZW1G
7lM7nU141JhV2elYQWaMBBVtfDFo+E2YGTgZL32c71g0ebY0GpJeRkM0ZguXk3FJ
1qifF9QFKhiwvaXe4Bwzy36OyAMrurccsWI/IFZOGi4I4leaHIp3SxbnnA0VJIpU
SVFs64K+tgGuMNMaTd3LneovAcQhZg8MuiZLG7pOCh1a2gdLcUs=
=IRoy
-----END PGP SIGNATURE-----

--=-/aaeYYd/6fpGElp81Fhz--
