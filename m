Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751568AbeFAKZf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 06:25:35 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55574 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750852AbeFAKZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 06:25:34 -0400
Date: Fri, 1 Jun 2018 11:25:06 +0100
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Chintan Patel <chintan.m.patel@intel.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v2 1/3] ASoC: topology: Improve backwards compatibility
 with v4 topology files
Message-ID: <20180601102506.GB8677@sirena.org.uk>
References: <1527191363-21021-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline
In-Reply-To: <1527191363-21021-1-git-send-email-linux@roeck-us.net>
X-Cookie: OS/2 must die!
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 24, 2018 at 12:49:21PM -0700, Guenter Roeck wrote:
> From: Guenter Roeck <groeck@chromium.org>
>=20
> Commit dc31e741db49 ("ASoC: topology: ABI - Add the types for BE
> DAI") introduced sound topology files version 5. Initially, this
> change made the topology code incompatible with v4 topology files.

No review on these from anyone at Intel?

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsRHwEACgkQJNaLcl1U
h9DI1QgAgaKFW5DKIHLNWriVAG2tJQsBwzOuzf5pMkVO/ae2hZuz2tf/+dF74f8G
4Zs/u+9xzVlxPGoisNVkgMUyLg6lQdmu7nRR5s475vN/3M0nIxaNCJF9rM1v3bXT
IUjcDS3F14lKt4f6Tz9Q6EWo/RESoFmUalCOlpKR0tLu+zcemumfV08jDHhQMP44
c4auS5T++wQdHzwSff2vhmfhzOkcERP9V2JGXOfazo/j3HO4ANBicnnPAL92SS4I
VXJs5MsLzIsC+nfLgdLzpZ7QqqhY1SJ/h/cpOcu2XNTp3HISevTH3KSGuLU2tJBB
dwcvyjwSAQEKYKjNzEnHM3wHKRhhYA==
=1ZMc
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
