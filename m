Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751302AbeBTNpj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 08:45:39 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52998 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750866AbeBTNph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 08:45:37 -0500
Date: Tue, 20 Feb 2018 13:45:27 +0000
From: Mark Brown <broonie@kernel.org>
To: Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: Applied "ASoC: topology: Add missing clock gating parameter when
 parsing hw_configs" to the asoc tree
Message-ID: <20180220134527.GF6378@sirena.org.uk>
References: <20180219203636.3692-2-k.marinushkin@gmail.com>
 <E1eo6jW-00039l-Ts@debutante>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XIiC+We3v3zHqZ6Z"
Content-Disposition: inline
In-Reply-To: <E1eo6jW-00039l-Ts@debutante>
X-Cookie: Don't read everything you believe.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XIiC+We3v3zHqZ6Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2018 at 12:09:18PM +0000, Mark Brown wrote:
> The patch
>=20
>    ASoC: topology: Add missing clock gating parameter when parsing hw_con=
figs
>=20
> has been applied to the asoc tree at
>=20
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git=20

This broke the build so I dropped it.

--XIiC+We3v3zHqZ6Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqMJnYACgkQJNaLcl1U
h9Bxvgf+Nv7fdDYz7Rset2EHm/+CjK0HLbtGsrmrgxokwdjQrrz71yZr2CV5yHuu
PIqcRNCVc9Z/UPgkgBcEh+IZVunrVzPUYG9eVr+muo5GwHfXbCxceszxl8/KpEOg
wP1XrME4y1PIfzjDWmujAUnhfS94Th9mHYOQit9DUCzRECYNaN4/iIUW+CORDbAm
x6B2u57aHhKuYMcHi0vZoLXjsAYaGljvALDtunkaaTTHa7BLypVNdSKhOj7E36gw
ncLaY1MYmUoM0Zbk1K2cxh8Toq6Cwfmy17j3j02Bkwdf6AWDn1cjGgpq6LDVQ9C6
jS2kD5yPoo467LGlD5JtS/0OJSDDDA==
=Jg+6
-----END PGP SIGNATURE-----

--XIiC+We3v3zHqZ6Z--
