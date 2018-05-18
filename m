Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752279AbeERKCh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 06:02:37 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45100 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751442AbeERKCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 06:02:36 -0400
Date: Fri, 18 May 2018 11:02:34 +0100
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] spi fixes for v4.17
Message-ID: <20180518100234.GF24209@sirena.org.uk>
References: <20180518100107.GE24209@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o0ZfoUVt4BxPQnbU"
Content-Disposition: inline
In-Reply-To: <20180518100107.GE24209@sirena.org.uk>
X-Cookie: The best things in life are for a fee.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o0ZfoUVt4BxPQnbU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 18, 2018 at 11:01:07AM +0100, Mark Brown wrote:

> are available in the Git repository at:

>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git spi-fix=
-v4.17-rc5
>=20
> for you to fetch changes up to bc519d9574618e47a0c788000fb78da95e18d953:
>=20
>   spi: bcm2835aux: ensure interrupts are enabled for shared handler (2018=
-05-04 08:09:02 +0900)

This is actually a signed tag, sorry:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-=
fix-v4.17-rc5

Managed to not notice being slightly fast with generating the pull
request.

--o0ZfoUVt4BxPQnbU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlr+pLkACgkQJNaLcl1U
h9AlKgf7BaX4Vl0vIwhT9RtuWlFUZJrRZ85QNaW/gfEYpBMlPkOZ6I2MM6gxtDtQ
7sOwaVaeNRF08qGvr0tmUiHbcPhDykXFTLXNSCzqoMaN2RaJz9jSVzgLvNXvzBx6
GG9Htup8NGoyDUnwErgmRSRY/FF1ksPHdeWTCo3zrqB2lqdtyBSCaKeiodnXeNoQ
r0wBpPAh2nJllLZYDgFmjCoiNG1/1NOgedqLPQ2KPlq/LGa5tUFrkgyDPj0+jyB/
tKDThuz37TtKwYfQJI18o//9+qpZCDC6MryA3f1swVtSzmB3KINadu+E0TAgtvol
uMTeRjfh8l/nFzVTbit7jHY9rtvAqQ==
=mlXK
-----END PGP SIGNATURE-----

--o0ZfoUVt4BxPQnbU--
