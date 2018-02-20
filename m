Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751977AbeBTMF0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 07:05:26 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54104 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751879AbeBTMFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 07:05:24 -0500
Date: Tue, 20 Feb 2018 12:05:21 +0000
From: Mark Brown <broonie@kernel.org>
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ASoC: max9759: Add Amplifier Driver
Message-ID: <20180220120521.GC6378@sirena.org.uk>
References: <1519047958-22583-1-git-send-email-narmstrong@baylibre.com>
 <1519047958-22583-3-git-send-email-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Fig2xvG2VGoz8o/s"
Content-Disposition: inline
In-Reply-To: <1519047958-22583-3-git-send-email-narmstrong@baylibre.com>
X-Cookie: Don't read everything you believe.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Fig2xvG2VGoz8o/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 19, 2018 at 02:45:58PM +0100, Neil Armstrong wrote:

> +++ b/sound/soc/codecs/max9759.c
> @@ -0,0 +1,207 @@
> +// SPDX-Licence-Identifier: GPL-2.0
> +/*
> + * MAX9759 Amplifier Driver
> + *

Please don't mix C and C++ style comments like this, make it all a C++
comment - it looks more intentional.  Otherwise this looks good so I'll
apply, please send an incremental fixup.

--Fig2xvG2VGoz8o/s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqMDwEACgkQJNaLcl1U
h9BKqQf+I8r9vpHpGAJfRSiXdFwKEDA9HVOxBRLQVV4FOhfaThFShCf1TPJMbMS7
oGAbl6/DuKNlpabrrkCv7jWipyVCDOWPN/YvvpWph6RbIHwUhBZEF4BucOclXGhD
kgKEEQBsSCpjZfALXqRKfdCWTe8gFnX+pAi/eP3cDChfvmDdQSlEx1siEh6ffTDW
wKoGAl/DlYmygtOKzBe4I8/KHgbV2Dmd9/WvPqdTPCiGD0LpFJV3RmYM6TlQjQxA
DAYRtPQ9+DU0ZvDV4lKKa7Pso18edxsVyk1L7mBp+HOqOTxkByHRq/R+ZOJKuDkg
GfODTxFqESv8pyFbXA54t4Q6Dv25dA==
=1WAN
-----END PGP SIGNATURE-----

--Fig2xvG2VGoz8o/s--
