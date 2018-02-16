Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750836AbeBPUSW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 15:18:22 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:33109 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750727AbeBPUSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 15:18:20 -0500
Date: Fri, 16 Feb 2018 21:18:18 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sun4i: fix HSYNC and VSYNC polarity
Message-ID: <20180216201818.j5gunpkkebq35b4n@flea.lan>
References: <1518717288-123578-1-git-send-email-giulio.benetti@micronovasrl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kxyinf54766plvzj"
Content-Disposition: inline
In-Reply-To: <1518717288-123578-1-git-send-email-giulio.benetti@micronovasrl.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kxyinf54766plvzj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2018 at 06:54:48PM +0100, Giulio Benetti wrote:
> Differently from other Lcd signals, HSYNC and VSYNC signals
> result inverted if their bits are cleared to 0.
>=20
> Invert their settings of IO_POL register.
>=20
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

--kxyinf54766plvzj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqHPIkACgkQ0rTAlCFN
r3QMQg/+OV3q9HrUT8zsozxJwMsVMGHmzlW3T2oS5k8dUWgaXRgeCqSMUotbiV4M
SMRvY1HEr6gwQIDQBblzEi81k/ztXHIxyD2hT6RRgNoeE4jMf9g8Yg22xkBaG52Q
8/YVBAeI84p+R+oE07K234p9PJJxG+FzaiUmJaDGJ4I8/tfubEBt21Ht52ER6Lc/
CrnC8Y8W1k2SPWEP/8dwRu//0ZhWe54p6fCi4b4iT9SNvYjIYTags+nJvkWbhmMR
Rlpal3DQVl4wu6y0zK8ccitw0niXYKv27NqOm9/WlZd/CtprZ0xdsdx4orfskFH3
Y5wd+2+q3meQEcwtmXxZNEHfKrAYKnYFAOACCKnaddlFQ2cXMzH5Y6T/z1fclDqL
9QCwcuNdF2i3fNodP/CmPdq+6PVu+YTqs+cPGr8sQ5ytDg+fzfo7avUHHjCBMTsD
T/NvTV8VzKqK241BifBbNY3VLbIPhXl+UY42RdyTQGF3+Kv6MMQSjOkNM8QPbhjB
EeTcmQndH7v9GiXTuErMafKoGcdS7FzqTcPfD0ZPe59HWQac7+4W7vzyBVONQXxU
KckuQQ9U6wCwvzpyT4MWcbCiWrbo8mvxEYNsMLFHE0BWQqlhliueQFwDu+B6jRNq
BkBiRwEuTXlu/kPHF3/UDzFO0utQKuSrM92ajPZxw+IbAPTD8ek=
=oied
-----END PGP SIGNATURE-----

--kxyinf54766plvzj--
