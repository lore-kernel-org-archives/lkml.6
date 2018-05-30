Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753422AbeE3OQk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 10:16:40 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42632 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752108AbeE3OQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 10:16:39 -0400
Date: Wed, 30 May 2018 15:16:36 +0100
From: Mark Brown <broonie@kernel.org>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 10/19 v3] regulator: s2mps11: Pass descriptor instead of
 GPIO number
Message-ID: <20180530141636.GL6920@sirena.org.uk>
References: <20180514080640.12515-1-linus.walleij@linaro.org>
 <CACRpkdZFrFuNnP=uJyREckr8EXW6L2ku+=QwVA7Tva3CpfrpCQ@mail.gmail.com>
 <2026891.KGZ2uNuXyI@amdc3058>
 <CGME20180530134408eucas1p14c6d7fe692e2ed91ef833c8a1ead8ce7@eucas1p1.samsung.com>
 <1722883.ZQ0ZDYoSn5@amdc3058>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m0XfRaZG5aslkcJX"
Content-Disposition: inline
In-Reply-To: <1722883.ZQ0ZDYoSn5@amdc3058>
X-Cookie: Don't get mad, get interest.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m0XfRaZG5aslkcJX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 30, 2018 at 03:44:08PM +0200, Bartlomiej Zolnierkiewicz wrote:

> The similar issue with shared GPIOs seems to be present in commit
> c89c00e2b8f0 ("regulator: max77686: Pass descriptor instead of GPIO
> number") and Midas board (arch/arm/boot/dts/exynos4412-midas.dtsi).
> I don't have the board itself to test it but from the code audit it
> seems that commit c89c00e2b8f0 should also be reverted.

> Marek has also discovered separate problem on Trats2 board with
> commit 3c6b38d45fa5 ("regulator: wm8994: Pass descriptor instead of
> GPIO number"):

I've reverted both.

--m0XfRaZG5aslkcJX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsOskMACgkQJNaLcl1U
h9BSfQf/bQSiUgekplmGNTV7rXf90ilA/9t0SV/wnXPwgXt5rflobY+07s3gRNo+
759/nHDmDMcMMt95B4REuLxdcPQBcS3lzzabwU8ukXuAnPcypmp2kzogSBd36mX+
7JuslOQdD5l42oQipxpFJP80v15h2UxYUWPXOIpcWodBDQ82RYR5/4+4O+gN/6hr
SHlV+WHkD7zOo/4zJijvq9YG+BPpPV6621SzDb3hf1xSz592fPQp2saxkZRL2aO7
K6hHlXO/cmAOBydnraKgvKzVvGoQOyyySs6Fn3dcHk78/l2UpHoY2w07Ns0kFMWU
+1EXJOUHjuhYS93K55iuKpBy6z/NTg==
=yn3N
-----END PGP SIGNATURE-----

--m0XfRaZG5aslkcJX--
