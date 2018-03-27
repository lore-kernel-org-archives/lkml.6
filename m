Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752572AbeC0JWv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 05:22:51 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39122 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752310AbeC0JWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 05:22:49 -0400
Message-ID: <1522142479.1110.45.camel@bootlin.com>
Subject: Re: [PATCH 02/10] drm/sun4i: Disable YUV channel when using the
 frontend and set interlace
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>
Date: Tue, 27 Mar 2018 11:21:19 +0200
In-Reply-To: <20180327091823.sbmvvo4jsh3x7p4i@flea>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
         <20180321152904.22411-3-paul.kocialkowski@bootlin.com>
         <20180323095529.5nptn5achjt3esog@flea>
         <1522137643.1110.4.camel@bootlin.com>
         <20180327081731.he3lhnvqffuimsi5@flea>
         <1522140259.1110.43.camel@bootlin.com>
         <20180327091823.sbmvvo4jsh3x7p4i@flea>
Organization: Bootlin
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-4rq/EnQv7E9pd6g5SrXT"
X-Mailer: Evolution 3.26.5 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4rq/EnQv7E9pd6g5SrXT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2018-03-27 at 11:18 +0200, Maxime Ripard wrote:
> On Tue, Mar 27, 2018 at 10:44:19AM +0200, Paul Kocialkowski wrote:
> > > > Also, is interlacing actually used on any of the video outputs
> > > > we
> > > > support? Perhaps RGB?
> > >=20
> > > Composite would be a better guess :)
> >=20
> > Oh and I was wondering what CVBS was about. Now I know!
> > It seems that we don't support it for now apparently, anyway.
>=20
> What do you mean? We do support it.

Sorry, I think I was remembering the status for A10/A20 only. Glad to
see that it works on A13!

--=20
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
--=-4rq/EnQv7E9pd6g5SrXT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAlq6DRAACgkQ3cLmz3+f
v9EX3gf+LPb1jMDjup0+f/gysXkeqkLtR6RRVC3t0uNBL6aRKvU05De3avZsugke
Ng4BN9cAVcFeHMWK7zXshpcA5S903o1UA295r4F3shwMl1k41emtOW1pxA9PeIPb
8q55Ew7pn5ja58xDrqpY+rgJiFAS7yNovBxeka0as391BWA/ODss5O+fba4foanV
MLduuIniVy+w0dLO3xUoFz2+oJE0BTEQlwVvifMg8lBnql4LbrC4k98Q2zLwYfE7
d8+qn9biVjprCvxYR/XgEIMbnvlork9uTX7vPHVhl+MXAtaZ+kVX4d/wtN46P99X
NR2HR+yo5ul+yCtH9K5BU51kHRzAaw==
=B2Vu
-----END PGP SIGNATURE-----

--=-4rq/EnQv7E9pd6g5SrXT--
