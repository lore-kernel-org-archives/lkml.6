Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752530AbeDRQXX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 12:23:23 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59702 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750981AbeDRQXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 12:23:21 -0400
Date: Wed, 18 Apr 2018 17:23:15 +0100
From: Mark Brown <broonie@kernel.org>
To: Colin King <colin.king@canonical.com>
Cc: Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] spi: pxa2xx: make function pxa2xx_spi_transfer_one
 static
Message-ID: <20180418162315.GF10061@sirena.org.uk>
References: <20180418161842.19846-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QXO0/MSS4VvK6f+D"
Content-Disposition: inline
In-Reply-To: <20180418161842.19846-1-colin.king@canonical.com>
X-Cookie: Sank heaven for leetle curls.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QXO0/MSS4VvK6f+D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 18, 2018 at 05:18:42PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> The function pxa2xx_spi_transfer_one is local to the source and
> do not need to be in global scope, so make it static.

Someone already sent a patch for this which I applied earlier today.

--QXO0/MSS4VvK6f+D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrXcPIACgkQJNaLcl1U
h9CCIAf/eF+L52UsAb/zYblEOaMrc+d+LbuwcYm8vq8Z6QXi/ASvHx/Yi/mkbc2g
zFmKpjzK+a3cm2eUBSGOqOxyF2SqUmoZYMZjHs5V4eJtK379G9B/Ok+tksj2R6Ir
TsYnt6xbUoGwnTGozSQ7kyb/Girjqpd9uq/tx7bNF7dg6BVCyk9fCbvsYGFJlyLE
rPvfl/avZTlByWLmGYKIxbJtV0h206PtJHvI5I9klxMx3dAfSmxwHd5d+k9qeb10
BzI16/pCmih6dewa+p0sfhiBB+Y0qPbjOzdmZYJ/qk1YZ+kyJ3LnhQEf21GuuaCt
5DHAFxRc1x1Z+2ZFO2FvvTvOCcgsNw==
=Mul6
-----END PGP SIGNATURE-----

--QXO0/MSS4VvK6f+D--
