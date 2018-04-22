Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753404AbeDVRWZ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 13:22:25 -0400
Received: from vpn-0-22.aquilenet.fr ([185.233.101.22]:42832 "EHLO
        leonov.paulk.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751296AbeDVRWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 13:22:24 -0400
Message-ID: <8012696a7bf0132dd2361a896bf0abfbe8a3084e.camel@paulk.fr>
Subject: Re: [PATCH] ARM: dts: imx6qdl-cubox-i: Move card-detect GPIO to 1.5
 SOM devices only
From: Paul Kocialkowski <contact@paulk.fr>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Date: Sun, 22 Apr 2018 19:22:14 +0200
In-Reply-To: <20180422143911.GB16141@n2100.armlinux.org.uk>
References: <20180422142151.17910-1-contact@paulk.fr>
         <20180422143911.GB16141@n2100.armlinux.org.uk>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-cv3H+KZnNuNMpz0d3X7i"
X-Mailer: Evolution 3.28.1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-cv3H+KZnNuNMpz0d3X7i
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le dimanche 22 avril 2018 =C3=A0 15:39 +0100, Russell King - ARM Linux a
=C3=A9crit :
> On Sun, Apr 22, 2018 at 04:21:51PM +0200, Paul Kocialkowski wrote:
> > The Solid-Run CuBox-i lower board used in the first generation of
> > CuBox-i devices feature a hinged micro SD card slot, that does not
> > have
> > card-detect capability. Since the card-detect GPIO was specified in
> > the
> > common cubox-i dtsi, it is moved to each device using the 1.5 SOM
> > and is
> > thus removed from the imx6q-cubox-i dts.
>=20
> This seems incorrect.
>=20
> The 1.5 SOM is a relatively recent thing, and I have one of the first
> Cubox-i's that were produced which is not hinged, and does not have a
> 1.5 SOM.  There is _no_ correlation between the 1.5 SOM and the SD
> card slot.
>=20
> Talking to folk at SolidRun, we're all confused about your assertions.

It appears that I was also confused about the different models in the
CuBox-i line. I had assumed that the models had been updated to a new
revision (carrying that 1.5 SOM) since the time I bought mine (which was
thus some sort of first generation). With this scenario in mind, it made
sense to me that a CD GPIO required only for the second generation would
have been applied by mistake to all the cubox-i devices by having it in
the common dtsi.

I checked on the leaflet inside the box and models did not change, only
the 4x4 model was added in the meantime.=20

> We're also confused about "hinged micro SD card slot" - Cubox-i's
> come with either a push-push slot or a static (push-in, pull-out)
> slot.
> (Prototypes were the latter.)

The one I have definitely does not have a spring-loaded mechanism, so I
would call it a push/pull static slot. I mentioned a hinged slot because
that's the term used to describe the layout in the CuBox-i-Lower
schematics, SD/MMC Connector part: "U3 is an internal hinged micro SD".
Looking at pictures of what hinged slots look like, that's definitely
not what I have here.

Are all CuBox-i units that have ever been sold supposed to have a
connector with a CD line? I find it hard to believe that it's broken
specifically on mine.

If that's really needed, I could open up the device, check whether the
R8 pull is in place and check the voltage there.

Cheers,

--=20
Paul Kocialkowski,

developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
--=-cv3H+KZnNuNMpz0d3X7i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAlrcxMYACgkQhP3B6o/u
lQxfog//Qc0HFoAUIFHU4DV6ZaHUTPKCpiYB44sqt7VQp0GXLKBa73lOGH6zipqR
guG2Ytsjn9+/Tx7jHSOlpKP7RodtXPGk1DAH1i+BP4mKsIDLGd+bPnoI4Zz0Si7J
EW5Hhz5zb3GfPpbj30oy1bQ/G2bq9N/gubtNMNMHSZzlBXXnLPGcqZYm1maNnDkj
rg/AnRTQJpr4Ko2f0wDuaYzZMVqWNzO4mqsMVgAAsmeAPHj3Rdew588efQ6TE7Ck
Qywx5+ZuDKdhXNHpyhiICW+FitHJyreZ7VLlOmk4g8vCP+ZgW2P9Yc8M4Z5f1Cm7
InrTQ6p6ldTL5Nc23Ky+XY+JJ+C5geXLlFg/vsMGZf6pwMyt8fO99wvcOjcbWSm5
LSrKbTwJ9x+c3sKklSu/ZnLa9KesNgcdUpUsvuxj11UM5SfhMl8E34PN5hF9HhxO
h56m4XS3WjnXALYq6sH9dMAwwsqa91xYxR4Cacu/DdOEnv5VcYYdGexsD5clVG4C
YzJsMhKGM0akfbhqqDtYk9IWharhQKQcBya+p4wwuLt90M3ezeFRdzMbVidHoHDg
RJDL8eMhdPt9eXjgtglC1/X9UNZuaPsmaAfu+g+bGFCgPNqpadTftfZwarTdOKbR
EGkFH4KsHmZ5rnASRnqzw5jd6BI1KL88zKiMFFlYccrCsblOums=
=3oIn
-----END PGP SIGNATURE-----

--=-cv3H+KZnNuNMpz0d3X7i--
