Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751116AbeDMT0j (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 15:26:39 -0400
Received: from sauhun.de ([88.99.104.3]:50082 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750864AbeDMT0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 15:26:37 -0400
Date: Fri, 13 Apr 2018 21:26:36 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PULL REQUEST] i2c for 4.17
Message-ID: <20180413192632.owle2s622ypntnno@ninjato>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4efsk27glukewz52"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4efsk27glukewz52
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

the second pull request from I2C contains:

- hot bugfix for i801 to make laptops with strange BIOS reboot again
  when using SMBUS Host notify

- change to MAINTAINERS creating a specific fallback entry for I2C host
  drivers and settings its status to "Odd fixes"

- a long overdue param checking for the I2C core

Please pull.

Thanks,

   Wolfram


The following changes since commit 8837c70d531a1788f975c366c254a5cb973a5291:

  Merge branch 'akpm' (patches from Andrew) (2018-04-11 10:51:26 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to 1eace8344c02c625ee99cc3ffa50187ded2c87b5:

  i2c: add param sanity check to i2c_transfer() (2018-04-11 23:33:46 +0200)

----------------------------------------------------------------
Ard Biesheuvel (1):
      i2c: add param sanity check to i2c_transfer()

Jean Delvare (2):
      i2c: i801: Save register SMBSLVCMD value only once
      i2c: i801: Restore configuration at shutdown

Wolfram Sang (2):
      MAINTAINERS: remove me as maintainer for I2C host drivers
      MAINTAINERS: add maintainer for Renesas I2C related drivers


with much appreciated quality assurance from
----------------------------------------------------------------
Benjamin Tissoires (1):
      (Rev.) i2c: i801: Save register SMBSLVCMD value only once

Jason Andryuk (2):
      (Test) i2c: i801: Restore configuration at shutdown
      (Test) i2c: i801: Save register SMBSLVCMD value only once

Simon Horman (2):
      (Rev.) MAINTAINERS: add maintainer for Renesas I2C related drivers
      (Rev.) MAINTAINERS: remove me as maintainer for I2C host drivers

 MAINTAINERS                   | 34 ++++++++++++++++++++++++++++++----
 drivers/i2c/busses/i2c-i801.c | 16 ++++++++++++++--
 drivers/i2c/i2c-core-base.c   |  3 +++
 3 files changed, 47 insertions(+), 6 deletions(-)

--4efsk27glukewz52
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrRBGQACgkQFA3kzBSg
KbbtlBAAkya3QTV4A9Dx4/mp9ji7AHvLIgNCTgRlmnMgG5RzQWWB9PK7geLs8Ue9
ptq0bQfiBmnZVZY5hVP2Uao1BmlUAGsVVF0xM1eICfyL/uS4R/rA5cT+GfYc+CaH
6YQGLfbt5yvzN5vZ1U6CqtrHJx0o3MdNmRlkhOnIFIcWzkrQkqjxzgBPVJZxOFPq
Nzs6KwpOTbg2d5ImTY88kYXCQjv1uhsLvTiny5Uh7WEaEZHHPdHkzXJQxSEiF49G
gZJcGHLiZrTJtyQ4JzXxREmFK1hHLTiejS/yKwZRS6livQLzr4d+OwCzqlFtCatI
hgDIEPH/L9k0Za26Mwff8/PkiSfHQaKU/zfk1TDBrejGTqgNLqWm/ZJdBtOwUFJ+
FW2NLqhAentXNyFMBWqFVqj2fZkQzhXHs/WFPEWhuzygukUpPG43wD4Gnk4uF35R
WXxgOcDeo1114oo2vK7KvQY2S8yN1D9SLqSR/cuJz97ZL0TgOurhXXCsRgG9RTd6
gD0qvSvnPYjRoQGq9GejATSzf3KghCV35zAJfNA7+4+Bh1+WwtwxAByfn01t5rqV
ioMnIsE9q04aTTclu9R5VFu5ej+yiWyghFtx82x5+sjFEUfyYXUf4/SIRaTk327a
TzMIu/NiojnQVmuWWVsWE7z/YC37BRIQqkWBqP+asiJ7hgsMzR4=
=h+2t
-----END PGP SIGNATURE-----

--4efsk27glukewz52--
