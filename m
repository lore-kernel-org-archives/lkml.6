Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751432AbeEBNOg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 09:14:36 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51158 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751076AbeEBNOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 09:14:33 -0400
Date: Wed, 2 May 2018 15:14:31 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: =?utf-8?Q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Cc: linux@armlinux.org.uk, wens@csie.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, robh+dt@kernel.org, horms@verge.net.au,
        geert@linux-m68k.org, magnus.damm@gmail.com,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 10/12] ARM: sun8i: smp: Add support for A83T
Message-ID: <20180502131431.j7jaz74ko5ueotwn@flea>
References: <20180501123131.7738-1-mylene.josserand@bootlin.com>
 <20180501123131.7738-11-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v3li36dd5jhn3acu"
Content-Disposition: inline
In-Reply-To: <20180501123131.7738-11-mylene.josserand@bootlin.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v3li36dd5jhn3acu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 01, 2018 at 02:31:29PM +0200, Myl=E8ne Josserand wrote:
> Add the support for A83T.
>=20
> A83T SoC has an additional register than A80 to handle CPU configurations:
> R_CPUS_CFG. Information about the register comes from Allwinner's BSP
> driver.
> An important difference is the Power Off Gating register for clusters
> which is BIT(4) in case of SUN9I-A80 and BIT(0) in case of SUN8I-A83T.
> There is also a bit swap between sun8i-a83t and sun9i-a80 that must be
> handled.
>=20
> Signed-off-by: Myl=E8ne Josserand <mylene.josserand@bootlin.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--v3li36dd5jhn3acu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrpubYACgkQ0rTAlCFN
r3Qqlg//YFe09MMg2NNFb3wlQITSJ7vYVeBfO9MheU8Nf4Zf0wit7OR9f9d1hPxr
iqlgfBIoXdj3nrdukW4pR+sHBYxhzpICIw79tcFvlhUv+1TzndVdWQf7TYtScvfF
9cpjv3+kJcytQH+is9+r+KhrQbYTjNNKf1oXOYZupXOEL9KJmeZeRqjyj+AffF+x
f6K9eQPedtSLrD4QCpoYhn+kLAP+8VN4aun3RymwwDgenKQiOVmME7AYNyeSlW0M
XqV3xeP4xCGDTYaWh/Q3En6fE28ss0Jwrekzl2e9JU8U88kF606p6i0D2yM8LcHR
vPIjGSmGdC850pZ3+87b1OlyP5gU4ehHCWO9YvUE5OTm83+Dlbd1aqWOuGcSqGx1
3goL7QTOEKunZgP/J3GiR88Wwqi4aXC4atlpg3TBewMN1fnR1CxXCjBO1qTYG1ZH
wfBuNpDs+01dhD5aMX2mgGBQfZz/vD/KNFBS6+ZQeEAl5wJHHk+M95UIGYpezY0L
PMyqfWhwQN1XSgXFK5d4SiyrRhGUya22C8a9QgZrOPnhVgPfOTHSmjdSiAtpxXyw
LP/Jh0FL+F8L4qQO3YusZzIBB5zCjcRdqF9oupQuK9GS/NuTmeIwzsxGMewuu2Ew
V6rwoCoj+H9ONd1e/2rhLJtmFq/AGS4CKyUfpnIZbtoRDdPBj2I=
=JGi0
-----END PGP SIGNATURE-----

--v3li36dd5jhn3acu--
