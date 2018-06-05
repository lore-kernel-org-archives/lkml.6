Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752635AbeFEOul (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 10:50:41 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49022 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752445AbeFEOuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 10:50:40 -0400
Date: Tue, 5 Jun 2018 16:50:38 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Bob Ham <rah@settrans.net>
Cc: Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm: sun4i: Add support for Pengpod 1000 tablet
Message-ID: <20180605145038.qptdlcphdbnw6jyg@flea>
References: <20180602160313.26763-1-rah@settrans.net>
 <20180604081302.hcn7j36gt6xeyquq@flea>
 <313a74ea-0be6-cff1-6b2f-06a4b0b7ba8d@settrans.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zazi7f7zkd74w65t"
Content-Disposition: inline
In-Reply-To: <313a74ea-0be6-cff1-6b2f-06a4b0b7ba8d@settrans.net>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zazi7f7zkd74w65t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 04, 2018 at 06:33:02PM +0100, Bob Ham wrote:
> On 04/06/18 09:13, Maxime Ripard wrote:
> > On Sat, Jun 02, 2018 at 05:03:13PM +0100, Bob Ham wrote:
>=20
> >> + * This file is dual-licensed: you can use it either under the terms
> >> + * of the GPL or the X11 license, at your option. Note that this dual
> >> + * licensing only applies to this file, and not this project as a
> >> + * whole.
>=20
> >> + *     The above copyright notice and this permission notice shall be
> >> + *     included in all copies or substantial portions of the Software.
>=20
> > And this is redundant with the SPDX header.
>=20
> The X11 license notice states explicitly that the notice has to be
> included in the file.  Wouldn't removing it be a violation of the license?

The SPDX header is explicitly here to remove the license text and
create a tag that is in a indirect reference to the license text in
LICENSES. It's not going away.

> >> +		brightness-levels =3D <0 10 20 30 40 50 60 70 80 90 100>;
> >=20
> > Each step should increase the perceived brightness by roughly 1/Nth, N
> > being the number of steps. Usually PWM backlights don't work like that.
>=20
> FYI, this was copied from another .dts file.  All of the other
> brightness-levels settings in sun{4,5,7}i .dts files follow similar
> patterns:
>=20
> sun4i-a10-dserve-dsrv9703c.dts:               brightness-levels =3D <0 10
> 20 30 40 50 60 70 80 90 100>;
> sun4i-a10-inet1.dts:          brightness-levels =3D <0 10 20 30 40 50 60
> 70 80 90 100>;
> sun4i-a10-pov-protab2-ips9.dts:               brightness-levels =3D <0 10
> 20 30 40 50 60 70 80 90 100>;
> sun5i-a13-empire-electronix-d709.dts:         brightness-levels =3D <0 10
> 20 30 40 50 60 70 80 90 100>;
> sun5i-a13-utoo-p66.dts:       brightness-levels =3D <0 30 40 50 60 70 80
> 90 100>;
> sun5i-gr8-evb.dts:            brightness-levels =3D <0 10 20 30 40 50 60
> 70 80 90 100>;
> sun7i-a20-wexler-tab7200.dts:         brightness-levels =3D <0 10 20 30 40
> 50 60 70 80 90 100>;

I never said we were perfect reviewers. Feel free to help in the process.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--zazi7f7zkd74w65t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsWoz0ACgkQ0rTAlCFN
r3SBxxAAk+5xBNAj0WH0RlFM8/lJC/r//zqIeqZcEgmMimHLbJ6Dvjo6kyGCuFov
LBkTy+TAFSK2a8H6G2l1HddTAqGKo9wY3W+fmXxElZ/9sD7sZn6R3dmD1rVFJ2nR
lLix71GEyQnLWy1Qp9kAR1j75A/yi7ubspNDiHVatXt+i4anLz0xHl6nywPFQH1Y
HeX6jWd2l9k5Z+okYppgc92a1pmocCo+mhreR46RxRac7ZI2CrrV5bVwizV2w7jK
M5ZLgVOLo0pEixzUylITPbWlC+H0vtzXZFDdA7ZRjEVVGS7WuUAtWUVM2ldK5x37
3k2H5/rwQ6B20eTIpwzH9HbaqwK+WgkgEELvZFP+SEgWvs+i2IzUp6/QsxL+3bGC
KanK8hHd7NQClP/PHWDx5jXwrXOxv6QyHfgt8hFDHKqLBc3isMIatltHa9/YoJdj
resI7vs+OZsgfACDCvFzxR1aQl8AD/USaeqo3bMGojovASHDPQfmQmRo4yP+Xd2/
jsiHpGVW1+/RnUfT0acKiykpx2u66vBTsPROrqOtvy0dNX6EDGblI2nU0F5m8ax4
9GDUVtuvBFbIvbSe70lrPTL999qW/zrf1qkOh5yYXzMGq9tGBinlt7hZg6nIWNfT
ejrvg14s7/LVVfQiBbUHysJ6DUawLoMqvy+GOijmhyij97X/3DE=
=/Kki
-----END PGP SIGNATURE-----

--zazi7f7zkd74w65t--
