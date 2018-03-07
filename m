Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754690AbeCGPEg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:04:36 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48176 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754582AbeCGPEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:04:33 -0500
Date: Wed, 7 Mar 2018 15:04:31 +0000
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Liam Girwdood <lgirdwood@gmail.com>
Subject: [GIT PULL] regulator fixes for v4.16
Message-ID: <20180307150431.GI7290@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qVyHzDF4yf4A8jkR"
Content-Disposition: inline
X-Cookie: If you can read this, you're too close.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qVyHzDF4yf4A8jkR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 661e50bc853209e41a5c14a290ca4decc43cbfd1:

  Linux 4.16-rc4 (2018-03-04 14:54:11 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v4.16-rc4

for you to fetch changes up to 82a917c59f0e077817c833f537c71b8fd40cbfe1:

  Merge remote-tracking branches 'regulator/fix/resume' and 'regulator/fix/stm32-vfrefbuf' into regulator-linus (2018-03-07 14:39:07 +0000)

----------------------------------------------------------------
regulator: Fixes for v4.16

A couple of fixes here:

 - Another half of the supend to idle fix from Geert that went in
   earlier, both he and I are confused as to why he didn't notice that
   this was missing when his earlier fix was merged.
 - A simple fix for a test done the wrong way round in the stm32-vrefbuf
   driver.

----------------------------------------------------------------
Fabrice Gasnier (1):
      regulator: stm32-vrefbuf: fix check on ready flag

Geert Uytterhoeven (1):
      regulator: Fix resume from suspend to idle

Mark Brown (1):
      Merge remote-tracking branches 'regulator/fix/resume' and 'regulator/fix/stm32-vfrefbuf' into regulator-linus

 drivers/regulator/core.c          | 2 +-
 drivers/regulator/stm32-vrefbuf.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--qVyHzDF4yf4A8jkR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqf/34ACgkQJNaLcl1U
h9CdFQf+LGL11p3juUhP7hTDNUmP5X6wju1tX8I6HZCkdi94UVcLv53gtHKTdjoi
jiZmlObI61jUKFIsjFB0ajGMJ8GnT70YHgvXTLcB5PR2sXZy6o2mFZq5bk1fg2WO
Vhf5Wv50q3K8YSeCYG700TB8lWcux/FL1Xn4Epz8mZC79qJ+TfHKAffxo/EWkTHZ
+JPZWd+JtruKPnjwReu8N+Id5n2onTyXGbC/ofTb7Sv9W+QMFAQHVs8vY9WNrgkM
6beXPRhae748AbP+xUgkhwWiurpjNiESex9nt9GdhZhaduX7UtGpW+xpJV5hZjG2
BlQTi/NzZrjhyHFmYyPYiibpeFX5XQ==
=1aQZ
-----END PGP SIGNATURE-----

--qVyHzDF4yf4A8jkR--
