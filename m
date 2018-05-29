Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964793AbeE2Ord (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:47:33 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49112 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935764AbeE2OrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:47:24 -0400
Date: Tue, 29 May 2018 15:47:20 +0100
From: Mark Brown <broonie@kernel.org>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 10/19 v3] regulator: s2mps11: Pass descriptor instead of
 GPIO number
Message-ID: <20180529144720.GI23509@sirena.org.uk>
References: <20180514080640.12515-1-linus.walleij@linaro.org>
 <20180526100243.GA1564@sirena.org.uk>
 <CACRpkdZFrFuNnP=uJyREckr8EXW6L2ku+=QwVA7Tva3CpfrpCQ@mail.gmail.com>
 <CGME20180528112908eucas1p2946a9b6385fcaf6c19921c9767420405@eucas1p2.samsung.com>
 <2026891.KGZ2uNuXyI@amdc3058>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nO3oAMapP4dBpMZi"
Content-Disposition: inline
In-Reply-To: <2026891.KGZ2uNuXyI@amdc3058>
X-Cookie: Variables don't
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nO3oAMapP4dBpMZi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 28, 2018 at 01:29:07PM +0200, Bartlomiej Zolnierkiewicz wrote:

> I've also tested the new code (with fixup) on Artik5 board (which
> actually uses GPIO properties) and discovered the other problem,
> the GPIO core code doesn't handle shared GPIOs which are used by
> many platforms.

If the GPIO code is moved to use the regulator API GPIO support that
should hopefully deal with it (or we have a lot more boards with
problems).

--nO3oAMapP4dBpMZi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsNZ/cACgkQJNaLcl1U
h9CQvAf+JXWL9Rylcy3kh40Nn6bBLR+zqVNyElRktkpAmSbklSnL77rwpjbPUhYV
xAu6vdjDp/RfrSeENiE6VdB8eMSHc5h3dLMObS4GXTrpIFDRmqE7Gjpw+52KS1dI
R6gCTO+hSKC/WfNdwe5L8c3QXG2DbVqOgZI/c9ni/M0RltXPne2lORrPcCD1w+nm
gHN4DsxaXszPMU06gsYwdC6M0m8ISXPknluHmVI37Z/VM2xHTsiW1oOIwssU0rCG
ZspLKpNWRF151HBAlEEbI3it1h7VehRcSN5t+5kIYfX18li8s3BzqNb5zDUtAfmg
8R5clcPS9QdkLYzkHfejWxt5SixL9Q==
=KJk3
-----END PGP SIGNATURE-----

--nO3oAMapP4dBpMZi--
