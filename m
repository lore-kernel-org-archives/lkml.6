Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753025AbeDLQQF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 12:16:05 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60612 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752955AbeDLQQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 12:16:04 -0400
Date: Thu, 12 Apr 2018 17:16:01 +0100
From: Mark Brown <broonie@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 2/2] ASoC: tfa9879: switch to using .probe_new
Message-ID: <20180412161601.GI9929@sirena.org.uk>
References: <20180411124238.9385-1-peda@axentia.se>
 <20180411124238.9385-2-peda@axentia.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LYw3s/afESlflPpp"
Content-Disposition: inline
In-Reply-To: <20180411124238.9385-2-peda@axentia.se>
X-Cookie: The coast was clear.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LYw3s/afESlflPpp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 11, 2018 at 02:42:38PM +0200, Peter Rosin wrote:

> Use the new probe style for i2c drivers.

This doesn't apply against current code, please check and resend.

--LYw3s/afESlflPpp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrPhkAACgkQJNaLcl1U
h9DaCwf8CAIPB1AJZcLOV0maTOnMXhevFM6tDpBlCYSFHCWOA/tg3cZD3GbAD9Pv
l3dHQ9jVT/39ZI0UPfiRJVqyogQFdDr+WDlRVnIgVx1MoZFAJ93OdIIXCteJl54M
zSoGSPa9MroAdV1F1nWw8eceJK1/BK44WocxGJPULKThrTQHJDQ1EWeMdzPEGPsE
EXqbVM8R5RIOiCAuCtLOHDvcOPbxAbXHTTcsO3N1w+foN2kp2ByNSDKXbLm4SMET
+VYtWkLxROBnlj2ouKemWX79UqttjRsowQyXNwwZW2S5v42+GWDs14jtdbwFnRb4
+N1fHifYvPNhiodfkAZCd1d+Oxl97Q==
=7KdK
-----END PGP SIGNATURE-----

--LYw3s/afESlflPpp--
