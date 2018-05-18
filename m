Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752342AbeERIEC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 04:04:02 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50611 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751957AbeERID5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 04:03:57 -0400
Date: Fri, 18 May 2018 10:03:55 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Stefan Mavrodiev <stefan@olimex.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support"
        <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 1/1] ARM:dts:sunxi: Add Olimex A20-SOM-EVB-eMMC board
Message-ID: <20180518080355.fhaav52fn7afu2ys@flea>
References: <1526470689-6275-1-git-send-email-stefan@olimex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hr3re55muyziju6j"
Content-Disposition: inline
In-Reply-To: <1526470689-6275-1-git-send-email-stefan@olimex.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hr3re55muyziju6j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 16, 2018 at 02:38:08PM +0300, Stefan Mavrodiev wrote:
> With the new rev.E of A20-SOM-EVB, there is option for 16GB eMMC.
> Currently used card is KLMAG2GEND, wired to MMC2 slot.
>=20
> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>

Applied, thanks!

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--hr3re55muyziju6j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlr+iOoACgkQ0rTAlCFN
r3SoaQ//ZbcFpXYaVlnVo2mEq67gpHpPKlkE101llQ6udifOom2pT0eJ4zGFBHr0
8AKptIJmpTmGFmdxv+BvmJzRHfGATE8V9LDb51EifRruA5HVKkvf41ftdExhk6YL
0l1Na8mXPtDFAjtINg3zMHLjZGK55RPLmcY3cCXnnQq/lBr4AbLUa7p1TTBVNViC
pv49Sbm89nA9qI7uemwD7Ug55MfTvj/VflgtpF4dydc5knoJj7KhDWxhsAZxz1GX
O7Rf/U0kvrEKATNszMEuMXsuY+b1clGcMtoig3sVcJN6pw4oyErUIGLdFou+RJ72
0tCjrScJ5NbU2ew4XthXkW2/4xzN106r+alR3nMYD27IU/WxZV7LLcmVFHZ3IjEq
tyWoz2z2/3nxDdvQdenEaAbZ23r+AGWSyehlla9+8pl9cLkz/ktVhGW1+DIjdJXI
eilyI/DmMy1N9/Gdf88N+Dns22u4DPVqlEiIuewg8oN1539rhbf6MeAeSfWO5eSn
ZAKuWtpzVNs5dvgUYHsfhPPIuS0eJsnsA3kAs5Dwi/cUkzodG/3zRd9N8TE4L+dB
MMg/ijhJKlWZpEIN/3aIQf/JGTWULUdkykORQHcf3udmyWXyt7Qw++UZm8OW0OPM
hIkFPGhdo5Z54DpsELAyfgLLuMIYcta+QKwATkVlxmFn3694/5w=
=RIqw
-----END PGP SIGNATURE-----

--hr3re55muyziju6j--
