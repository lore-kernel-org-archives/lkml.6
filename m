Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754416AbeBGPn2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 10:43:28 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49366 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754150AbeBGPn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 10:43:27 -0500
Date: Wed, 7 Feb 2018 15:43:25 +0000
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: [GIT PULL] regulator fix for v4.16
Message-ID: <20180207154325.GF6003@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oPmsXEqKQNHCSXW7"
Content-Disposition: inline
X-Cookie: 15% gratuity added for parties over 8.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oPmsXEqKQNHCSXW7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 4e79f3f1c832fc9eabf5435d73ba0279e58f9b9d:

  Merge remote-tracking branch 'regulator/topic/tps65218' into regulator-next (2018-01-26 17:57:05 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v4.16-suspend

for you to fetch changes up to 57a0dd187956ea04870f4bbbf25a63c425ee7cad:

  regulator: Fix suspend to idle (2018-01-30 12:25:59 +0000)

----------------------------------------------------------------
regulator: Fix suspend to idle

Testing on mainline after the initial regulator pull request went in
identified a regression for suspend to idle due to it calling the
suspend operations with states that it wasn't realized could happen,
this patch fixes the problem.

----------------------------------------------------------------
Mark Brown (1):
      regulator: Fix suspend to idle

 drivers/regulator/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--oPmsXEqKQNHCSXW7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlp7HpwACgkQJNaLcl1U
h9BOXQf/ZpzZFncqEizRlQzopGlkVTOrqDnC2ZrhUfyEUi9m1G0KQpwug6A2HoYz
cNXkk5/NYyHOSVTD9MmWNPkQKAS2Kce9NLab52OCP+hfio5ZaDChU5Ou5JEyF6I/
O29OsT0qFjxpfOqt9+PaK497oye/6FpmxTulXB31E3ia6X4YAbws1zUBOu/C1pCF
UugjDo1nfB+jAeUPVCA7uOtYMLh/biK8H+T8gP9fnf63X3cg5DPq4FDAMCo/HLV/
ZHAijBUHWNwwR3L6xxNw9b4izTIgWbzijXPsXvPNpS0DtCKJxmfM8XuvPyRGWEXV
wCyt7906kgvOBaBACt0DVmGM8gVIrA==
=MQ6p
-----END PGP SIGNATURE-----

--oPmsXEqKQNHCSXW7--
