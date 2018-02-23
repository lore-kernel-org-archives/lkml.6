Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751789AbeBWO4y (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 09:56:54 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:52267 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751651AbeBWO4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 09:56:52 -0500
Date: Fri, 23 Feb 2018 15:56:50 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@bootlin.com>
Cc: linux@armlinux.org.uk, wens@csie.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clabbe.montjoie@gmail.com, thomas.petazzoni@bootlin.com,
        quentin.schulz@bootlin.com
Subject: Re: [PATCH v4 02/10] ARM: sun9i: smp: Rename clusters's power-off
 register
Message-ID: <20180223145650.dzhdhh2cprqioq5m@flea.lan>
References: <20180223133742.26044-1-mylene.josserand@bootlin.com>
 <20180223133742.26044-3-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rlbwter55etjdv6l"
Content-Disposition: inline
In-Reply-To: <20180223133742.26044-3-mylene.josserand@bootlin.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rlbwter55etjdv6l
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2018 at 02:37:34PM +0100, Myl=E8ne Josserand wrote:
> To prepare the support for sun8i-a83t, rename the variable name
> that handles the power-off of clusters because it is different from
> sun9i-a80 to sun8i-a83t.
>
> The power off register for clusters are different from SUN9I and SUN8I

This is just a nitpick, and I see you use them everywhere, but sun8i
and sun9i are the family of SoCs, and A80 and A83t the name of SoCs
within their respective families.

So in your commit log, you want to support the A83t because it's
different than the A80, and the sun9i and sun8i mentionned in your
last sentence is not really meaningful.

> Signed-off-by: Myl=E8ne Josserand <mylene.josserand@bootlin.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--rlbwter55etjdv6l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqQK7EACgkQ0rTAlCFN
r3SedQ/8D/fQ6K6yNdLNiOEl7BJjjgQP43h0kTjahkMUBK8mzGhNpoebnPmxDHos
m74jDNqGoML0F+1Q2FCnV3Pune872+rEGJGofwEigHcCcBlwLjxpOvaSlIhXp1iD
ZkzI8PCTuEDDx4PsHvpra872My33D1bp6U4JGPZ07+EiTla10rFWA/QSRgOFw3hu
vuO2W9xFOfQ9m2eATh+PKOKRML/J4jRjKGRwAKwzetmPNrA3W+1JLtenD2xJS5Xb
4PGBuFKjpoO2YNHMIe8RariHKnw+Kj73bYPJQYUCdUHrA4mWauHDo1llEmT8rx+H
KxNsPdnhqS9z8BsnX9TP56bh5tNOhksce/o/glY11qC8V6RDFENTePhD2Qovgxa0
uAidOZT/+jMt2D7TiSmqfuW3HhsNYvlB1ZzreNWEZBdlYqthdrbeN6GpjfPX4v36
xSkt2UM2wVPhb9+ANMoXCleL/oX2johhecRuTSX62A4UyUDZpIETRWJ3SJa7ir9l
oOF+7wh/NznzpfZsrZh6Icfc/g+hod+IR+qnGz36kfXluf+VxtAfdZ3kx5ldknEb
RUwV9Bl48yd+QaIKH8BTftB3qJaOSaB4uTGPEbvujawd0+XROVdR5RzCy9VpgoP5
18qYSZloGPd4quOmzooGxCDZNWjl1nAyka8qQP20Ddp29sKqcuA=
=y9Oz
-----END PGP SIGNATURE-----

--rlbwter55etjdv6l--
