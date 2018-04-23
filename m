Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754666AbeDWKDe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 06:03:34 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40556 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754466AbeDWKDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 06:03:32 -0400
Date: Mon, 23 Apr 2018 11:03:18 +0100
From: Mark Brown <broonie@kernel.org>
To: sean.wang@mediatek.com
Cc: matthias.bgg@gmail.com, rjw@rjwysocki.net, khilman@baylibre.com,
        ulf.hansson@linaro.org, linux-mediatek@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] regmap: include <linux/ktime.h> from
 include/linux/regmap.h
Message-ID: <20180423100318.GA19834@sirena.org.uk>
References: <ccea364eeb830b2092987d271c8308b97fe59d8f.1524465345.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <ccea364eeb830b2092987d271c8308b97fe59d8f.1524465345.git.sean.wang@mediatek.com>
X-Cookie: I think, therefore I am... I think.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 23, 2018 at 02:42:44PM +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
>=20
> Similar to the readx_poll_timeout() macro calling ktime_* and using
> ktime_t type, which is declared in <linux/ktime.h>. So, make

I'm missing patch 2 here - what's the story, are there any
dependencies?

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrdr2IACgkQJNaLcl1U
h9BVuwf/VtE8pK33MXz12kl0OpPTVWose3BdVvLrb9ZnKlqo4+Bp2g/HS0i7JWi/
q0DYrM0EA08fDlJbNSIhvjkm71YmV01v76YSYEtIakh27tRgR733F1QhznS/nPkU
3K2Cw9MCDVdhXQj0XNH+Aw8bRIT+E1yS5tvG+1VG4vAS8G2QGsS0Wsxgj4BV+NhL
Zvozs296ty9HUwHUbAdnYD+ezRWzPieUpIckk7l7Z/J0zJsindjHs7scB7SPMliI
hovcNmkcU2cOlPA0GR5Qu0YXHw75ILNgyIiNYR/QDEHo7j3Y31Gu8719/SxZvSF0
AoXA932DOuTHbSdAS72nSs47D0rkZQ==
=nJUn
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
