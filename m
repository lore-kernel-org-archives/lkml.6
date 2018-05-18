Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751860AbeERSsq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 14:48:46 -0400
Received: from sauhun.de ([88.99.104.3]:59218 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751197AbeERSso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 14:48:44 -0400
Date: Fri, 18 May 2018 20:48:41 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PULL REQUEST] i2c for 4.17
Message-ID: <20180518184837.47b4z776tt4ychhy@ninjato>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="me3vpn5vwgzjf5vd"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--me3vpn5vwgzjf5vd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

I2C has a bunch of driver bugfixes and a MAINTAINERS addition.

Please pull.

Thanks,

   Wolfram


The following changes since commit 75bc37fefc4471e718ba8e651aa74673d4e0a9eb:

  Linux 4.17-rc4 (2018-05-06 16:57:38 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current-fixed

for you to fetch changes up to 22aac3eb0c465dd9ea7f06ee1ed8ad933890f2a3:

  MAINTAINERS: add entry for STM32 I2C driver (2018-05-17 16:02:19 +0200)

----------------------------------------------------------------
Alexander Monakov (1):
      i2c: designware: fix poll-after-enable regression

Bartosz Golaszewski (1):
      eeprom: at24: fix retrieving the at24_chip_data structure

Hans de Goede (2):
      i2c: core: ACPI: Improve OpRegion read errors
      i2c: core: ACPI: Log device not acking errors at dbg loglevel

Peter Rosin (3):
      i2c: pmcmsp: return message count on master_xfer success
      i2c: pmcmsp: fix error return from master_xfer
      i2c: viperboard: return message count on master_xfer success

Pierre-Yves MORDRET (1):
      MAINTAINERS: add entry for STM32 I2C driver

Wolfram Sang (1):
      Merge tag 'at24-4.17-rc5-fixes-for-wolfram' of git://git.kernel.org/.../brgl/linux into i2c/for-current


with much appreciated quality assurance from
----------------------------------------------------------------
Ben Gardner (1):
      (Test) i2c: designware: fix poll-after-enable regression

Mika Westerberg (2):
      (Rev.) i2c: core: ACPI: Log device not acking errors at dbg loglevel
      (Rev.) i2c: core: ACPI: Improve OpRegion read errors

 MAINTAINERS                                |  6 ++++++
 drivers/i2c/busses/i2c-designware-master.c |  5 ++++-
 drivers/i2c/busses/i2c-pmcmsp.c            |  4 ++--
 drivers/i2c/busses/i2c-viperboard.c        |  2 +-
 drivers/i2c/i2c-core-acpi.c                | 13 ++++++++++---
 drivers/misc/eeprom/at24.c                 |  2 +-
 6 files changed, 24 insertions(+), 8 deletions(-)

--me3vpn5vwgzjf5vd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlr/IAEACgkQFA3kzBSg
KbaEbxAAl2j99CHjbtj17MTTRgxeIRHAp/wGSsQp5L+2RU9y0u0DnIxTOCN/g02e
1KogAffOhZ1y+fC5YSpWxjDvxnVse3+UYKuybfuzQmespRea5I0aCG7TgF3pBPSJ
ErN37OImAUyN4Vnhi0xhOn5EbzNmh7C+ilTpqiTr3zULwuAB/7t/il+H14Q+26BJ
/COqrXQhs2/1fCsRz+7HpZrucMmK1pbqTJ5Evk21aPE9tqBQhovugpJKd1m4MUu9
eCtWMvt2xqs9AbCtYN7ZWADVn/e2E1pybvksiN3YwWkgFB1OKDK9sZYeZ9KcuRwS
hRYCXXQUuv9HqcgxBFtpWFqtrcQy2PeVefgtedTDn42m6niDbwq9Hgh5XE21jtAU
6cYzqbYrAaEIDQTqw5dh6KrZrjCjt+AzvZjIo39QENWw5Ld7yoc7OmD2c9j5ExXM
NFbtgCnapW8uZ1Tj9mWpJjF63J7jLlKUx+H3TDl9s1Yc7AAYYWi2GaiN7cTZpzQU
Vzm/lUQRvIZHub6l9QZ2tYJrscSZDSBmYI/RKSIbj0lYNUL6AjDi1fcLewI67F+X
saOmua61LS217nt40kmH9fxODJ8gE/zS1vodJjMRVVGiaIRjQgk/DOMr+1K/MLv9
ykQ/8c5BpDB1TV6pksWG0fTKEU/g5ML8Xm6sG1OMUc7AxocDZ+U=
=lEd0
-----END PGP SIGNATURE-----

--me3vpn5vwgzjf5vd--
