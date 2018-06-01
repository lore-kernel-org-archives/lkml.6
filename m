Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753406AbeFARNI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 13:13:08 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60686 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752262AbeFARMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 13:12:24 -0400
Date: Fri, 1 Jun 2018 18:11:57 +0100
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
Message-ID: <20180601171157.GD8677@sirena.org.uk>
References: <1527191363-21021-1-git-send-email-linux@roeck-us.net>
 <20180601102506.GB8677@sirena.org.uk>
 <0015aace-fe32-9707-d3c9-0dea6f5fc48c@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IMjqdzrDRly81ofr"
Content-Disposition: inline
In-Reply-To: <0015aace-fe32-9707-d3c9-0dea6f5fc48c@roeck-us.net>
X-Cookie: OS/2 must die!
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IMjqdzrDRly81ofr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 01, 2018 at 06:17:05AM -0700, Guenter Roeck wrote:

> Other than that, there was a question if this is a Linux issue or
> a Chromebook issue (it appears that only Chromebooks shipped with
> v4 configuration files). I took that as rhetorical since upstream
> kernels (at least v4.4 and v4.5) support topology v4 configuration
> files, and it should not matter which products shipped using those.

Yes, that's definitely completely irrelevant here - one of the great
things about Chromebooks is their upstream support and this code was
definitely no exception!

--IMjqdzrDRly81ofr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsRfl0ACgkQJNaLcl1U
h9AcgAf+M5/KOrs2V584NuGmUEoErJ27oGBQabujIUbxMFFHIVMLimpDmH4qlTW1
Iu5i/H+E7r2yr0JL/DqfO61PGsCMaBT1ZYHOfD2xPZTUp6x4lDv9cP8Sun0jkoDE
WJx7E8NyY0lF+MsJmaKc0cq2tSjOyqBKS16P7VKFBB+qtwgbXfSwSFejG/t3ZHwk
lqjJYVf3bYR2KDBCdswCEsboGrxLBw9MK5/Pmm7vezPjD/I+UGXKcH+Hag1Ryv6s
4o+BTYJFd4WTvWqGO04r0ByUps+enn5mdPbvyrnGAll1yD3febZI7P6Sz9lFbiTx
E9Op5K3sKMFkB+cD+omM/MiPUs6KLw==
=+Ejj
-----END PGP SIGNATURE-----

--IMjqdzrDRly81ofr--
