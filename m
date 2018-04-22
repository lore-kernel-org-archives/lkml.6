Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753506AbeDVRXy (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 13:23:54 -0400
Received: from vpn-0-22.aquilenet.fr ([185.233.101.22]:42904 "EHLO
        leonov.paulk.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753355AbeDVRXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 13:23:50 -0400
Message-ID: <12bc46186bb643203601165b7b0136d96e0613c9.camel@paulk.fr>
Subject: Re: [PATCH] ARM: dts: imx6qdl-cubox-i: Move card-detect GPIO to 1.5
 SOM devices only
From: Paul Kocialkowski <contact@paulk.fr>
To: Jon Nettleton <jon@solid-run.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Date: Sun, 22 Apr 2018 19:23:42 +0200
In-Reply-To: <CABdtJHuE05ea1EPSR916vSEz6gtCirLF77c_PW2N2ofGnzN-bw@mail.gmail.com>
References: <20180422142151.17910-1-contact@paulk.fr>
         <20180422143911.GB16141@n2100.armlinux.org.uk>
         <CABdtJHuE05ea1EPSR916vSEz6gtCirLF77c_PW2N2ofGnzN-bw@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-X06kYKnvUfRarPRWXKkU"
X-Mailer: Evolution 3.28.1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-X06kYKnvUfRarPRWXKkU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le dimanche 22 avril 2018 =C3=A0 15:02 +0000, Jon Nettleton a =C3=A9crit :
> On Sun, Apr 22, 2018 at 4:39 PM Russell King - ARM Linux <linux@armlin
> ux.org.uk> wrote:
> > On Sun, Apr 22, 2018 at 04:21:51PM +0200, Paul Kocialkowski wrote:
> > > The Solid-Run CuBox-i lower board used in the first generation of
> > > CuBox-i devices feature a hinged micro SD card slot, that does not
> > have
> > > card-detect capability. Since the card-detect GPIO was specified
> > in the
> > > common cubox-i dtsi, it is moved to each device using the 1.5 SOM
> > and is
> > > thus removed from the imx6q-cubox-i dts.
> >=20
> > This seems incorrect.
> >=20
> > The 1.5 SOM is a relatively recent thing, and I have one of the
> > first
> > Cubox-i's that were produced which is not hinged, and does not have
> > a
> > 1.5 SOM.  There is _no_ correlation between the 1.5 SOM and the SD
> > card slot.
> >=20
> > Talking to folk at SolidRun, we're all confused about your
> > assertions.
> >=20
> > We're also confused about "hinged micro SD card slot" - Cubox-i's
> > come with either a push-push slot or a static (push-in, pull-out)
> > slot.
> > (Prototypes were the latter.)
> >=20
> > Maybe someone's modified yours?
> >=20
> Regardless of the physical mechanics of the device, the CD-GPIO is a
> mechanism of the carrier and not the SOM. I have one of the few Cubox-
> i's that have been physically modified to work with the rev 1.5 som
> and have no issues (the heat spreader needs additional cutouts).

There was some confusion about the relationship with the 1.5 SOM. It is
now clear that the issue is not linked to it at all.

> Now if you are still using the old 2013 u-boot then there is possibly
> confusion between the eMMC and SDHC slots which can cause
> strangeness.  Please use the 2018.01 branch on our github and that
> will handle this properly.

I'm using U-Boot 2018.03, so I think I'm safe on that side.

Cheers,

--=20
Paul Kocialkowski,

developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
--=-X06kYKnvUfRarPRWXKkU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAlrcxR4ACgkQhP3B6o/u
lQw6gRAAmHn9wjxHcrvGN6Cp9E9IdLTCk4PGWlIzPXk9MVWpV4jp+A1Q9MUJCse+
Ur6dWqZM0sbW9+rdG9JT3qFQIrHdrMvPeDGeQxShKWqk9VF9s5tnsUHKhNFz2Tq0
1q09V3zqqS1dKrkx5zwANosETlkgbh3nZlqlMvuftZxJTk2KZy6GyrzVY5RTNHw7
hjij1JNdFojflPn6KOQRYzPdpwy3ReWz11gYKls93rYQcj6cCnklYaDRnf7OfPEV
jtkS4bFxGJ+FFqtn3H9fi+HHcCfJ+zx+LCn/ycGxqsITESbDRFT/sE6JVccn5mTH
euW+CgNTF0DgjiFWEimzVu7smAnNqaHv2/ZUS5yFlZRrZhZsq86FW4CV4XskcP5G
uZX5rALAFbrdMMgQ8n1QfsaJ1uGlC5QwlCiBkD5BD2u+v0WAgf4L6XFlCkhAEJhu
JRLKvGOKhrG1KpaBrQ4MIOXWV7DPks3CykVZAbx1latPlrH1moBu3WJgMVgDjEM9
C4VBkI+SmoGgqSM4vbutDTfNFtm2OQ0YqF5yMKVIIn2w1P/R6MxG4OwgCvfmujTl
r4ji883QciqFfxHO7tzTdIO75pH+CbXOfp5HYdIDDZmJXQfsvFfLlB9Ik25wmpte
SCndOLeHaY1BSe7Ftp4zeQz7Ro+spjp+Ep1Rq3IFUkpioSpjLZ0=
=J2Dh
-----END PGP SIGNATURE-----

--=-X06kYKnvUfRarPRWXKkU--
