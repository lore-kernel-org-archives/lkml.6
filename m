Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752828AbeC1COk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 22:14:40 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38626 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752258AbeC1COj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 22:14:39 -0400
Date: Wed, 28 Mar 2018 10:14:16 +0800
From: Mark Brown <broonie@kernel.org>
To: sean.wang@mediatek.com
Cc: matthias.bgg@gmail.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: mediatek: remove redundant MODULE_ALIAS entries
Message-ID: <20180328021416.GK29239@sirena.org.uk>
References: <58fc8553bdc3cbad8d107a905947b7e4d9c12b92.1522054975.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SdaPbLtAangIkrMZ"
Content-Disposition: inline
In-Reply-To: <58fc8553bdc3cbad8d107a905947b7e4d9c12b92.1522054975.git.sean.wang@mediatek.com>
X-Cookie: Serenity through viciousness.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SdaPbLtAangIkrMZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 26, 2018 at 06:04:18PM +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
>=20
> MODULE_ALIAS exports information to allow the module to be auto-loaded at
> boot for the drivers registered using legacy platform registration.
>=20
> However, currently the driver is always used by DT-only platform,
> MODULE_ALIAS is redundant and should be removed properly.

There is no meaningful cost to having the alias there, why remove it?

--SdaPbLtAangIkrMZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlq6+ngACgkQJNaLcl1U
h9DH+Qf9EtxwWsTohTFZLq84M56CM8LV9zkR8RXwk1z1y8iuiUjwqlLSfeAltGNU
XHcFWDc3Q9+hsx/nhq3YsVGJ8b7ligzUs+jfsZ4a9G+/KG+89ojAMzn24zTZoQWy
0FjMU6KfdlhcM07f3g7GH/Rj/OiriBGOs1hfYtHZA0fOshGgT5yLPMSwb5GTbjgD
flCk4qclIug/P8+WDGYMABV0+zypuZK1xtK+fmoFZwTLKg8BnQU7pyZIsainqjIj
MjhGdolULgvMBtVbqwS84epAWq88wxTd9FZGyeEgCbc8L4hrrXuuMH3Xj/lqHBEf
mQQkcN8gROFJYdGdIakuHP69k7Il9g==
=HD40
-----END PGP SIGNATURE-----

--SdaPbLtAangIkrMZ--
