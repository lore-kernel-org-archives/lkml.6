Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752632AbeFDLIQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 07:08:16 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35920 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752027AbeFDLIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 07:08:15 -0400
Date: Mon, 4 Jun 2018 12:08:13 +0100
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] regmap updates for v4.18
Message-ID: <20180604110813.GF7536@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hUH5gZbnpyIv7Mn4"
Content-Disposition: inline
X-Cookie: One Bell System - it works.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hUH5gZbnpyIv7Mn4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit e241e3f2bf975788a1b70dff2eb5180ca395b28e:

  Merge tag 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost (2018-04-11 18:58:27 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v4.18

for you to fetch changes up to 869619e627287606d4d36a72a6e2127230f95507:

  Merge branch 'regmap-4.17' into regmap-4.18 for the merge window (2018-06-04 12:03:03 +0100)

----------------------------------------------------------------
regmap: Updates for v4.18

This is another quiet release for regmap, there's one minor feature
improvement for the recently added slimbus support and a few minor fixes
and cleanups.

----------------------------------------------------------------
James Kelly (1):
      regmap: Skip clk_put for attached clocks when freeing context

Mark Brown (1):
      Merge branch 'regmap-4.17' into regmap-4.18 for the merge window

Sean Wang (1):
      regmap: include <linux/ktime.h> from include/linux/regmap.h

Srinivas Kandagatla (2):
      regmap: add missing prototype for devm_init_slimbus
      regmap: slimbus: allow register offsets up to 16 bits

 drivers/base/regmap/regmap-mmio.c    |  3 ++-
 drivers/base/regmap/regmap-slimbus.c |  2 +-
 include/linux/regmap.h               | 19 ++++++++++++++++++-
 3 files changed, 21 insertions(+), 3 deletions(-)

--hUH5gZbnpyIv7Mn4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsVHZ0ACgkQJNaLcl1U
h9DBzAf/XtV3T29ObTd/OcLcqlo0JGSMbRfqwpNJnk/Ntms+JKp4A40eGeNoSLjQ
zHBdTaa9m7gc7lElYEjbxZUbMhhMSk5jIWV1JAN/ji/vcQnsL4yp6gTa2MFYRt8M
ixdONY+9p45qpO9wEvoqpjBt4+22inFjcTv6Il76ljmTsAxyIb2nFHWSqeebtBKQ
L+YU65aRX0EFtMJj405fj/PVuh7MJIHhdwGnTqYgii7f87od1hzgu2vjudI6k2Zn
bfC/S2AZTa4eGM5Ilja58AVdVQqtk7S+aXmdGx1Ba8QoMxtpLmLKR7vYmxooJqGT
qHvY1cAg7ZF9eSQ0cEZA7ZTrWl++AQ==
=n6nK
-----END PGP SIGNATURE-----

--hUH5gZbnpyIv7Mn4--
