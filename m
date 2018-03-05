Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932112AbeCEP7w (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 10:59:52 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50370 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751490AbeCEP7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 10:59:50 -0500
Date: Mon, 5 Mar 2018 15:59:38 +0000
From: Mark Brown <broonie@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: =?iso-8859-1?Q?Myl=E8ne?= Josserand
        <mylene.josserand@bootlin.com>,
        lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, michael@amarulasolutions.com
Subject: Re: [PATCH v2 1/2] ASoC: codecs: Add support for PCM1789
Message-ID: <20180305155938.GL8588@sirena.org.uk>
References: <20180305124817.7421-1-mylene.josserand@bootlin.com>
 <20180305124817.7421-2-mylene.josserand@bootlin.com>
 <20180305154910.GJ8588@sirena.org.uk>
 <20180305155715.GJ3035@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="j3olVFx0FsM75XyV"
Content-Disposition: inline
In-Reply-To: <20180305155715.GJ3035@piout.net>
X-Cookie: Do not write below this line.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--j3olVFx0FsM75XyV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 05, 2018 at 04:57:15PM +0100, Alexandre Belloni wrote:
> On 05/03/2018 at 15:49:10 +0000, Mark Brown wrote:

> > Please don't mix C and C++ style comments in a single comment like this
> > - it looks unintentional.  Just use the same style for the whole thing.
> > You also don't need to include all the boilerplate with the SPDX header.

> I think Linus made it clear that he wants the SPDX header to be a
> C++ comment, the documentation has:

Sure, so make the entire thing a C++ comment then.

--j3olVFx0FsM75XyV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqdaWkACgkQJNaLcl1U
h9CiUgf40Hp+gzXwR2TkhGpq5wjdnZSOKngsP8WUfonuZTnnEkE2ejOVjAMVgpOM
U0ljr1dg/Hg6tfbWNFRYflY31V+PPjfw+KnPuqNxjNFYj1t5GTL3sTrjrLf8RwSU
v1mgbevFejwxwk4vDhhdx869XZIiWUfnGk7vfAxJIQDi0BWfB6b31nBQmPv11sO0
pXi/l/ZBtmP29pfLoM1XxzKC3zwZ3dn9ESVkKMgKlnBUGGjsqHpNZTEmj+VB3KHL
Sg9nTyqmF5zwiNBNnddqriWee+2M+/7ZUBUWj+inCCfC7mLkbFZfB43BHVfl20cl
kY2El6N9CDLWgJHJUYA4Y8RQRhAe
=er+z
-----END PGP SIGNATURE-----

--j3olVFx0FsM75XyV--
