Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755086AbeDCIPL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 04:15:11 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39579 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754946AbeDCIPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 04:15:10 -0400
Date: Tue, 3 Apr 2018 10:14:58 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Sergey Suloev <ssuloev@orpaltech.com>
Cc: Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] spi: sun4i: introduce register set/unset helpers
Message-ID: <20180403081458.lyilg3yu3n2e54fd@flea>
References: <20180329185907.27281-1-ssuloev@orpaltech.com>
 <20180329185907.27281-6-ssuloev@orpaltech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3kbhyrgcus3k2xfh"
Content-Disposition: inline
In-Reply-To: <20180329185907.27281-6-ssuloev@orpaltech.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3kbhyrgcus3k2xfh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 29, 2018 at 09:59:06PM +0300, Sergey Suloev wrote:
> Two helper functions were added in order to update
> registers easily.
>=20
> Signed-off-by: Sergey Suloev <ssuloev@orpaltech.com>

I'm not really sure what's easier about this one.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--3kbhyrgcus3k2xfh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrDOAEACgkQ0rTAlCFN
r3T5Aw/+Ly9fZE+IObifi+UtbtilyDAzeqNIxqp6yX4Q6FBkB0su35OqEy2Z/MxB
4o6SNjxk1XhczhvmwGT+y+9D607Df+QKGQFpM+KWGTqE8k6PXWFQEgruF2K7YLHD
4sekLSIkSn7YXZqy1LCbZZf6cp7JfF3RE74ilZDFNXsDo1QY0Yv9lI1zUBGFO97X
aQMNzxpTGnveFOLsFq8hhdqqLBP+6ikey6slSofNc6dS8VVdPZCgjmBdIxlgS/yC
FUzka0ZQMmJcaHXeHBwoOXB3NYUCNydRCBq7ChKwyy879Xt5AfSL3E3/51vWZbVt
6J0Ixy8uaFdFJazwuRLFHWGoCsjFdz3nkdadFhSJZagMFsrB2vuNdd78eJbHHkBT
7b2wUoVP3fgMI3NHsKF2vf9wLjk5heULW71N8lZGHexu/qytyTtZ6erqejJ85z9e
mw1CgSWTkfuxOhrSwxXE1pRKd44PRpljVOqG9ZeD6nqo8PS6oL2fEzkJ0zZaRxPz
a+/f/Gqms2b5654UGunxcu4MMhARLX/UrJydWo+4OzFEtlpbd6k+H4qVU2fZzFcj
rw3k9KXhWFXabLRyTcujDNTgEpT5/IdeHVkQ0pxUU+63x5oVD2N1BUQahXIhF075
w4B6npIjt4fPi3b5DBy+r1qljQQy364G0ZumLXystFXmKzSPtJg=
=wwT7
-----END PGP SIGNATURE-----

--3kbhyrgcus3k2xfh--
