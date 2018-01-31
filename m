Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932075AbeAaPZs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 10:25:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:50710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752497AbeAaPZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 10:25:45 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D4DA20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sre@kernel.org
Date: Wed, 31 Jan 2018 16:25:41 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] hsi changes for hsi-4.16
Message-ID: <20180131152541.hsxsa7yay2fwswn3@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tndktocghdlklk2u"
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tndktocghdlklk2u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Just one simple patch this time for the HSI subsystem.

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-4.16

for you to fetch changes up to b6dc80dbe6cdf4effd5a07bcd37f34cbf25eb07a:

  HSI: cmt_speech: use timespec64 instead of timespec (2017-12-01 16:31:47 +0100)

----------------------------------------------------------------
HSI changes for the v4.16 series

* Y2038 fix for cmt-speech

----------------------------------------------------------------
Arnd Bergmann (1):
      HSI: cmt_speech: use timespec64 instead of timespec

 drivers/hsi/clients/cmt_speech.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--tndktocghdlklk2u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlpx3/IACgkQ2O7X88g7
+pq9WxAAkE9F8FNeaQ4jw2+cmHl0ty4m49wQUQk1YrjAniwtb5YOLOP877KUICW9
xqJKl+hUt+YjWmRHM+mnabe9HpYJ7WnPelTGFKciFKGzvB2RDW2K5e/xCZjTYDM7
caC6Qg6yQI5JW+KpWxF5jC0LxyNontrC7F/j2rAGdBo9m3IGKQY67Iz4HTBL0lPA
xGwjSVCyMxgvriz081PlE69xZ9qHV7TyhqBx45XeNb1Y3hSYGKDydts63ya1qcvY
tDJDo8L1+uhBtP97zHcpWeu61WEytCVBwqI/tangyUiUKQOWg3frgEI9WZzh4DwZ
36ll+3oQRsSzD9DPWH2D169KD4C4F/2cWinqNnNI6looHbL7uXfncAw4EYQGabVl
JiRFiI+9lDR7wQ3m/G9h2BSt8etqJ3EBe7NcN0LW4gJtaoNwT4G5xQKYXXwjLcTx
PPTY8D3CABtTj1lN9dJHUX+viJkta+VoxkNnS/Fa4PDl1A1sQgCwlXSw1iKPymFo
2I/JWIdpupk20A3y/fFJ8EmDkJsL95QRQftjh+Ft9pLpNHLfRzIUnyv45ZkgfUhY
dhAxYMTsIIPWnK+RgBjnb7cwnYHO4HG2grvQF/rDvv3LqOJXoZpP83a964PRQK/2
Y/Ika4cfXB+QamZuSX+my+tlX5AIDbh6NofryAENwtmRmjWmGj0=
=KYmZ
-----END PGP SIGNATURE-----

--tndktocghdlklk2u--
