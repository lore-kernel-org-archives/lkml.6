Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752603AbeFDKrP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 06:47:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56462 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752177AbeFDKqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 06:46:52 -0400
Date: Mon, 4 Jun 2018 11:46:42 +0100
From: Mark Brown <broonie@kernel.org>
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Liam Girdwood <lgirdwood@gmail.com>, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: linux-next: manual merge of the regulator tree with the arm-soc
 tree
Message-ID: <20180604104642.GC7536@sirena.org.uk>
References: <20180530150711.2c7c1fe9@canb.auug.org.au>
 <CACRpkdaotBXbA4pPFHRH0S1SF7-XX_T6yAOwZcbsR3RBcj+-=Q@mail.gmail.com>
 <2564792.sYBGPVz9u3@z50>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vOmOzSkFvhd7u8Ms"
Content-Disposition: inline
In-Reply-To: <2564792.sYBGPVz9u3@z50>
X-Cookie: One Bell System - it works.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vOmOzSkFvhd7u8Ms
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 01, 2018 at 12:49:53AM +0200, Janusz Krzysztofik wrote:

> I confirm the fix by Stephen works for me, however, the conflicting patch=
 by=20
> Linus breaks things a bit.

> Lookup tables added to board files use function name "enable" while the=
=20
> regulator uses NULL. As a result, GPIO descriptor is not matched and not=
=20
> assigned to the regulator which ends up running with no control over GPIO=
 pin.

> Either the regulator driver should use the function name "enable" or that=
 name=20
> should be removed from lookup tables.

I'll revert this one as well :(

--vOmOzSkFvhd7u8Ms
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsVGJIACgkQJNaLcl1U
h9Cw9Af/fZiF09ZPYuhqNpNAeRnPGyhQl+kvwFebr6N9QUHECbSzww9gsFCbuBIs
jiy0Je3YXSgA3vbsxG6AXw5f2ahno/RqrQbd4m9gk9trKhCSHuRM4Y5Ux0ul7VSJ
I3oOfcfHeZnJC3alSyBwc5LqUGSNuUMzeEwbrMm2cnBfn/2MSE13QoKGNMGs0fho
iCG83nfXKp07niQkqxktluJfQ3C0Q13ZdOFdUzCaGEgSkIUVustMup+WdG7nBNCe
GWMBtBO1iKwbTCcFevpF4ouAOz471op7XmRnqqW5G7/aSbR/UJInir41B+ElHFok
IyCq5GX+krL9cqamXN7W25zXCxnwng==
=Hz4K
-----END PGP SIGNATURE-----

--vOmOzSkFvhd7u8Ms--
