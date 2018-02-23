Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbeBWKbK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 05:31:10 -0500
Received: from sauhun.de ([88.99.104.3]:52846 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751334AbeBWKbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 05:31:08 -0500
Date: Fri, 23 Feb 2018 11:31:06 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PULL REQUEST] i2c for 4.16
Message-ID: <20180223103103.hnjqvkmsz2xwlylu@ninjato>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s4rpk42xg7mr65zi"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s4rpk42xg7mr65zi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

I2C has for you: two bugfixes, one v4.16 regression fix, and two
documentation bugfixes.

Please pull.

Thanks,

   Wolfram


The following changes since commit 91ab883eb21325ad80f3473633f794c78ac87f51:

  Linux 4.16-rc2 (2018-02-18 17:29:42 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to d1fa74520dcdbeae891b30035e6c51aafa35306d:

  i2c: designware: Consider SCL GPIO optional (2018-02-22 12:15:35 +0100)

----------------------------------------------------------------
Andy Shevchenko (1):
      i2c: designware: Consider SCL GPIO optional

Ben Gardner (1):
      i2c: designware: must wait for enable

Eric Anholt (1):
      i2c: bcm2835: Set up the rising/falling edge delays

Jarkko Nikula (1):
      i2c: i801: Add missing documentation entries for Braswell and Kaby Lake

Patryk Kocielnik (1):
      i2c: busses: i2c-sirf: Fix spelling: "formular" -> "formula".


with much appreciated quality assurance from
----------------------------------------------------------------
Dominik Brodowski (1):
      (Test) i2c: designware: Consider SCL GPIO optional

Jos?? Roberto de Souza (1):
      (Rev.) i2c: designware: must wait for enable

 Documentation/i2c/busses/i2c-i801          |  2 ++
 drivers/i2c/busses/Kconfig                 |  2 ++
 drivers/i2c/busses/i2c-bcm2835.c           | 21 ++++++++++++++++++++-
 drivers/i2c/busses/i2c-designware-master.c |  4 ++--
 drivers/i2c/busses/i2c-i801.c              |  1 +
 drivers/i2c/busses/i2c-sirf.c              |  4 ++--
 6 files changed, 29 insertions(+), 5 deletions(-)

--s4rpk42xg7mr65zi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqP7WIACgkQFA3kzBSg
Kbab/w/+LErXF6wYNbKcEk7+wdY7iHnRUAZAtL2otbqcympNKsdC93rCJdKSqVVs
QVvd+dMuSEEfEWnJXRaHP9gGnwkUt9gdyKP+o3qCDa88F+2zoNn89qhyga+HVg64
Hy7SeHfMT95yBnpD3v6EPKXSrDYp+aLBuwvsw6WmYOkQFkFluwsRqie6S9gzu4ry
TlnxGZJBaCbx/dWNd7WJ6gsqMz76qKEDSZ5AkvYCliBJaQML2XdvNWxZl3cS7Fl/
yDjQz8M0NsgG0cUy/Cy9OT2V26/67UaqjOtNiZyQDKC3rROg7FPF0tZdKpEIKNSk
jF0P691CqBU1zA2PVnIED+IarUqLGRvknsJ6v9+J8/p0xudCTUShOzxlmqZKdEGM
t2k/RuovHpCgwYDVFgwla89682bOtFzNpvRQuUDArX7qRGglyui0+A3IH4mEMXFj
vSv85zx5c2G/x+1nNUznbru7F9ov8LAvra/NBLInwCWSD5CkLpi7ExPsoUsK5igu
B3BNo6lrUXqYxPcKVbgHZzcjCrw2t374Cucr+mvpQYeHgn43i8Ku5Qp7Dmt2r9Mg
VtRYdLA6V8GRH1oSY0O0wG3ZjUCTyFspeHd6/R6ARXmJ5trVGoDLsS7oeYIieL0p
fCkq02AT/DMtlG/QmODXKWB2YFAgJYhRi4mRF3IL2T7VPK/JxqU=
=XVZb
-----END PGP SIGNATURE-----

--s4rpk42xg7mr65zi--
