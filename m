Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933946AbeCCWdE (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 17:33:04 -0500
Received: from sauhun.de ([88.99.104.3]:59748 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933915AbeCCWdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 17:33:00 -0500
Date: Sat, 3 Mar 2018 23:32:57 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PULL REQUEST] i2c for 4.16
Message-ID: <20180303223240.q3xmnxasstin4tfh@ninjato>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="477lwxfjb7h2czfk"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--477lwxfjb7h2czfk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

here is a driver fix and a documentation fix (which makes dependency
handling for the next cycle easier) from I2C.

Please pull.

Thanks,

   Wolfram


The following changes since commit 4a3928c6f8a53fa1aed28ccba227742486e8ddcb:

  Linux 4.16-rc3 (2018-02-25 18:50:41 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current-fixed

for you to fetch changes up to 7c4246797b84e55e2dfaaf8a18033de9df7c18c1:

  i2c: octeon: Prevent error message on bus error (2018-03-02 11:11:15 +0100)

----------------------------------------------------------------
Jan Glauber (1):
      i2c: octeon: Prevent error message on bus error

Peter Rosin (1):
      dt-bindings: at24: sort manufacturers alphabetically

Wolfram Sang (1):
      Merge tag 'at24-4.16-rc4-for-wolfram' of git://git.kernel.org/.../brgl/linux into i2c/for-current

 Documentation/devicetree/bindings/eeprom/at24.txt | 2 +-
 drivers/i2c/busses/i2c-octeon-core.c              | 1 +
 drivers/i2c/busses/i2c-octeon-core.h              | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

--477lwxfjb7h2czfk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqbIoQACgkQFA3kzBSg
KbYBPhAAnZ0oENmfbmSKS3NZO4Cpvqsn2nlvW1IXj+oJhYfOa2VsMj4FApJs/g5S
Tc+1/O1IkgYce3Rc/zhJqwM2ZoANkPNK609BPu28opkj4YVyZW5Nyuk8AyIMIt73
kFizFz9KcNniHpOXnD3VhOmHBiqSnDepRqeQBTNBniFL6pKCVji99MllRx0OJHF7
mFdONhU+2wEr2+RGVRpXiFw4qEW4xx2K35BluvKLDcmrGUMlPFj27kpPLeVbc2Rn
HkFp5+TQh3jfw3yQeeOk9QeVEq8aUQ8FcngB84iHD7FQHGkp9G/5zzrMvHybzRsq
Ej/ZK7X44b9n3szqI7EKNH02uRJnwV8aeSnR5GFOimOWpgnBSOX0kYa7Z4c0ubEk
222KQyse/VVwj5RVDsHlFKhgv7yUwLPEb85ZBOR7dmwv+0Q+Dn4Gtp+dupIJ/vZx
pKgoAu2/MForu9TEkIpLobMtB+eD59KP0ne8KHS5HZhvH3EaVs7ckB7K3E5qyZSg
4jB2BhNMMdIZAdvlQsL6xozFnt43d/U/ag/QM6dE9loWmyXS1cy+5D5C4D6pVoTy
crOv/Km11F9DpMTMqi1QZQ9gKBW55zRDcrBJtzbsn5qMCamGlURlkkoEvQOhCRyQ
6mLxeVCEOnsBeQj+IwObLhhptUuXqKi4FIveTa3P6xbKUe1BROQ=
=Bk5S
-----END PGP SIGNATURE-----

--477lwxfjb7h2czfk--
