Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752250AbeBZJ1A (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 04:27:00 -0500
Received: from mail.bootlin.com ([62.4.15.54]:41661 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751563AbeBZJ05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 04:26:57 -0500
Date: Mon, 26 Feb 2018 10:26:45 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 6/7] arm64: allwinner: h6: add the basical Allwinner
 H6 DTSI file
Message-ID: <20180226092645.xghkmfowenzlbm42@flea.lan>
References: <20180223123555.64009-6-icenowy@aosc.io>
 <20180223123555.64009-7-icenowy@aosc.io>
 <20180223152038.2bflylwa6vj4gzfj@flea.lan>
 <81D53DC5-7622-430E-A530-ED0DE5397DC3@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="z6o7m63bqzv2zod7"
Content-Disposition: inline
In-Reply-To: <81D53DC5-7622-430E-A530-ED0DE5397DC3@aosc.io>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z6o7m63bqzv2zod7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2018 at 11:22:06PM +0800, Icenowy Zheng wrote:
> >> +	psci {
> >> +		compatible =3D "arm,psci-0.2";
> >> +		method =3D "smc";
> >> +	};
> >
> >Is it needed? The bootloader should fill it with whatever version it
> >has, shouldn't it?
>=20
> But we now use ATF rather than U-Boot PSCI. U-Boot will not fill ATF
> info.
>=20
> See A64/H5 device trees.

So if the PSCI version implemented in ATF ever changes, we would have
to update all the DT everywhere, but only if you're running the new
version?

Sigh.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--z6o7m63bqzv2zod7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqT0tQACgkQ0rTAlCFN
r3TLwg/+Nz8rd3gYDqm5pcrYPGIJN0H61KEsqx/iB8F9FplnrLVH79Y2LXuehDAD
OFNpmoWWZMXoRePjL/rpoA6/EfXeBddtks+IyMgAHQgBWqDjHgAvq0IV7NUAQ0hb
AfcIVhDAposY/s8e0BmANAdxLZESlQkZE2kqZEgQ8nr1yDVHam4iALk0gp4DTwef
U0aDUttzBlHmGZmcEVRuxh2CoPualNFBmav4+GLR/8UdzK/yu64bJHaVan19M9R7
mGQ8JcU5GJgdFzWFrECgOCsgT5scQqEnve9PxA0w7NYqvP6yCPqTLQ0B58xPl92p
CEgJqbogmdhE5a9/Mv+G1NXnJlUHFtJkQ030tMRAj6sA247wPnowW5uFnPYi35xc
CfFrlG+IzcFYDdPy3wfhyHPfGn7o9yxZMNchlseLywyM4uBwf8wjds3nKNeP0Y0m
NH8ZJK8PKQ+LXfj7Ihu4VSpmH64zkYSQwqMbjFFvuJXGsnBPqqS/Ok+ZzXKjgh1r
/8grCvGLfKL/r/9/VCYFx0/oGh23oicUBkYLFAsYcDb3lOA0TO+03pqtdXARshaO
QTbdqBi9Iz90Y3lxOfbpRMG90RvonBeUh9GpeRXKfxL5mD4M5vGh7lD3a2Jojek4
mj2++whGyo3wLYsFirdAqeA4b0oGSJffC3vpSjzz1OW7U9MhJXA=
=8ds1
-----END PGP SIGNATURE-----

--z6o7m63bqzv2zod7--
