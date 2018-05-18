Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751437AbeEROaI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 10:30:08 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50800 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750882AbeEROaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 10:30:06 -0400
Date: Fri, 18 May 2018 16:29:55 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Sergey Suloev <ssuloev@orpaltech.com>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] spi: sun6i: coding style/readability improvements
Message-ID: <20180518142955.lmeb5bkeo4wyv2ue@flea>
References: <20180330125047.13936-1-ssuloev@orpaltech.com>
 <20180330125047.13936-2-ssuloev@orpaltech.com>
 <20180517070307.GP20254@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d7i6mknxxllhrk7r"
Content-Disposition: inline
In-Reply-To: <20180517070307.GP20254@sirena.org.uk>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d7i6mknxxllhrk7r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 17, 2018 at 04:03:07PM +0900, Mark Brown wrote:
> On Fri, Mar 30, 2018 at 03:50:42PM +0300, Sergey Suloev wrote:
> > Minor changes to fulfill the coding style and improve
> > the readability of the code.
> >=20
> > Changes in v2:
> > 1) Fixed issue with misplacing a piece of code that requires access
> > to the transfer structure into sun6i_spi_prepare_message() function
> > where the transfer structure is not available.
>=20
> Place inter-version changelogs after the --- as covered in
> SubmittingPatches.
>=20
> >=20
> > Signed-off-by: Sergey Suloev <ssuloev@orpaltech.com>
> >=20
> > ---
> >  drivers/spi/spi-sun6i.c | 97 +++++++++++++++++++++++++++++------------=
--------
>=20
> This is a *very* large change doing a whole bunch of different things,
> including some fairly substantial changes like moving things into
> different functions but the changelog doesn't provide any details at all
> on what the changes are supposed to be.  This makes it difficult to
> review, it should be split into separate patches each doing one clerly
> described thing (I'm guessing this might be part of why the AllWinner
> maintainers haven't reviewed the series).

We didn't really review them because most of the changes done here
were also applicable to the sun4i series that was sent pretty much at
the same time:
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-April/570056.html

We should have made that clearer, sorry.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--d7i6mknxxllhrk7r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlr+42IACgkQ0rTAlCFN
r3TStA//QhbjWN3incX1RsA/jvrsdgXH/vFz1CJ6t3WlRRt9/GLqs+tB6Az6iC26
IDFepxUlNf2538we2rhpEtpZtTY7AwQu2/Gd++dIlxpn19O8CHHCGhqVLlgcrQXC
V97e9PzWSZw5PR2b+7QizHR4VqiXL/1OQdkefnTLZzyruiElSI2U6I5Xb8tInUsL
hqA7HGPohelAvI/q/adUceUehPzvDvAXA79GQLbMyPqaREljimbALYhyKyl/pxGx
790zvuW4Kg30In5/sdS4B8Ubo81k1q08qkLmip383gVaBzRv4gVO40Gwy8gptRNY
rUkZz0JKV3GxFAP6YVb9SsZ+qYH2VE6iVqHQ+RjNRdkNTxj3phvV4ikvAn0aM6ZX
i7Vjnn/Q5tDvOYdCi9xig7HFxgJfl0KrLJf4KMh8L5v/NnFiwmO+yqWYzHiht0uL
JYSdQB0pXbLd6yY1/RQJDsXrqCJRgQMPr3A8rhmD5X9q+lAOnNuSeiYSMgd/SRBh
ubO/MjCZSJO60YAsPggYHOC6vlRhyaYNyxjc30YADVdd0qkqoGJ++H3ueQyCie9c
pobyl2XXFHS9Lcq26Y34HRW/KTdyA+rkcgmaG3cBgXZ47Pf40PFYewz30zH0DI5c
UR9mZZ6ANbOvOpSM32YMcc/EHV2xjHv9hI5x/c8AVYAOBm7SXrA=
=9mEz
-----END PGP SIGNATURE-----

--d7i6mknxxllhrk7r--
