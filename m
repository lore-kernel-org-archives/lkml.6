Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755032AbeCSBYD (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 21:24:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55678 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754708AbeCSBYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 21:24:02 -0400
Date: Mon, 19 Mar 2018 09:23:35 +0800
From: Mark Brown <broonie@kernel.org>
To: kbuild test robot <lkp@intel.com>
Cc: =?iso-8859-1?Q?Myl=E8ne?= Josserand
        <mylene.josserand@bootlin.com>,
        kbuild-all@01.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexandre.belloni@bootlin.com,
        thomas.petazzoni@bootlin.com, michael@amarulasolutions.com
Subject: Re: [PATCH v3 1/2] ASoC: codecs: Add support for PCM1789
Message-ID: <20180319012335.GA2186@sirena.org.uk>
References: <20180315161825.5524-2-mylene.josserand@bootlin.com>
 <201803171907.vbmkB7Z8%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rmZDAlAp7pllCg/D"
Content-Disposition: inline
In-Reply-To: <201803171907.vbmkB7Z8%fengguang.wu@intel.com>
X-Cookie: Am I SHOPLIFTING?
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rmZDAlAp7pllCg/D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 17, 2018 at 07:19:51PM +0800, kbuild test robot wrote:

> >> sound/soc/codecs/pcm1789.c:265:1-3: ERROR: test of a variable/field address

>  > 265		if (&priv->work)
>    266			flush_work(&priv->work);

This is a legit warning but otherwise this looks good so I'll apply,
please send a followup patch fixing this.

--rmZDAlAp7pllCg/D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqvERcACgkQJNaLcl1U
h9Bz6Af+Obo5cUDzueqjNID4s8PqyHekx1WLIbfKMpBrMnZT9yunB+tKct+xQ2Zf
s9OQ5zNuYVo1SdY4KFKGtqHWQm7UPwLr/aISpEZFov/gRYRVkXibf/LjdhVEx9Du
GNSSnsE6ZYDQ8U5LJB03wofldsHH7HD5ZRJ9+/gAc/uX2qwtF0GTX9RF8q3Z+AQw
r+VtleDfLSr2Ca/83qka4o7IBrbjl3nWgyczY4wRs6I3kUlRfnp0EK6IIHxHnmyQ
Pdwcxi14w9rRHmw3j0IGgiR/9BLUTYlyh+ik9DKm89UslcEYW3LX8jrzxird10i0
csg2pQT3CBA9Eyeq8XXkaGkuva/3dA==
=kJ15
-----END PGP SIGNATURE-----

--rmZDAlAp7pllCg/D--
