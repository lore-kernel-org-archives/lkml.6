Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752883AbeEQQpF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 12:45:05 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59198 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752865AbeEQQpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 12:45:02 -0400
Date: Thu, 17 May 2018 16:03:07 +0900
From: Mark Brown <broonie@kernel.org>
To: Sergey Suloev <ssuloev@orpaltech.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] spi: sun6i: coding style/readability improvements
Message-ID: <20180517070307.GP20254@sirena.org.uk>
References: <20180330125047.13936-1-ssuloev@orpaltech.com>
 <20180330125047.13936-2-ssuloev@orpaltech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y6PvmTFIYclVmRST"
Content-Disposition: inline
In-Reply-To: <20180330125047.13936-2-ssuloev@orpaltech.com>
X-Cookie: Are you a turtle?
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y6PvmTFIYclVmRST
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 30, 2018 at 03:50:42PM +0300, Sergey Suloev wrote:
> Minor changes to fulfill the coding style and improve
> the readability of the code.
>=20
> Changes in v2:
> 1) Fixed issue with misplacing a piece of code that requires access
> to the transfer structure into sun6i_spi_prepare_message() function
> where the transfer structure is not available.

Place inter-version changelogs after the --- as covered in
SubmittingPatches.

>=20
> Signed-off-by: Sergey Suloev <ssuloev@orpaltech.com>
>=20
> ---
>  drivers/spi/spi-sun6i.c | 97 +++++++++++++++++++++++++++++--------------=
------

This is a *very* large change doing a whole bunch of different things,
including some fairly substantial changes like moving things into
different functions but the changelog doesn't provide any details at all
on what the changes are supposed to be.  This makes it difficult to
review, it should be split into separate patches each doing one clerly
described thing (I'm guessing this might be part of why the AllWinner
maintainers haven't reviewed the series).

--y6PvmTFIYclVmRST
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlr9KSsACgkQJNaLcl1U
h9DTpwf+Or1rhzX6sEKI26zIJJVbHhxmT/MggpXRWWbFdOJ8S+BvwJGKPgj1b5oH
Pdkitz5rl00ocJxbl98Uq9ucY2EFN73YT0AtughW4Ms7NL4SKjZbdze9EZRelBAD
KTl9WCdWXakch33U2csOimkwIUu6gxpMqjNX3QFjECVuVJw6UzmGKChqV/dDTozQ
bK80ZzW5yEh0QqEn1/YYDvvhA1n7K6OPohel9GbpVPAwpl5mby6y3x88Z+nAcTxG
5tcFPtwV/XJXdcfOwBKa26s0FTBxmpHxrFeTKyFqLkSTszNXYeOYrCGqX5BAQTWH
ZLL5ID1MXLuI3SLmz3cEqeQT+7g+lw==
=OO25
-----END PGP SIGNATURE-----

--y6PvmTFIYclVmRST--
