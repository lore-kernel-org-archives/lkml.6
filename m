Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751726AbeFALGr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 07:06:47 -0400
Received: from sauhun.de ([88.99.104.3]:48100 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751342AbeFALGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 07:06:34 -0400
Date: Fri, 1 Jun 2018 13:06:32 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PULL REQUEST] i2c for 4.17
Message-ID: <20180601110628.n3sofix7uyqm6grj@ninjato>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lo6spks4ncf7lp5u"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lo6spks4ncf7lp5u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

I2C has a documentation bugfix and a MAINTAINERS addition for you. It
would be great to have that in 4.17 proper already.

Please pull.

Thanks,

   Wolfram


The following changes since commit 771c577c23bac90597c685971d7297ea00f99d11:

  Linux 4.17-rc6 (2018-05-20 15:31:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to a0ccb6b54bdde16885ac99f49ee8031cf1c71abe:

  i2c: ocores: update HDL sources URL (2018-05-29 20:14:32 +0200)

----------------------------------------------------------------
Federico Vaga (1):
      i2c: ocores: update HDL sources URL

George Cherian (1):
      i2c: xlp9xx: Add MAINTAINERS entry

 Documentation/i2c/busses/i2c-ocores | 2 +-
 MAINTAINERS                         | 8 ++++++++
 drivers/i2c/busses/i2c-ocores.c     | 2 +-
 3 files changed, 10 insertions(+), 2 deletions(-)

--lo6spks4ncf7lp5u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlsRKLAACgkQFA3kzBSg
KbY/PQ//Y87k/cw7bgFgIQJrcELiSuUnzLrSPtftOPePkGmn5llp8bzVqQqqJmrk
rIxqAsFK9VXlDQwUPNcSTTGzsUeOwim2/IVv68+mEQm03+XM03RgZ1wpNdIXDrzK
kxUTUqmanufCJJcrWomkdnrlwOzHfZIuJ7XiZBYz1rBJ0nqnf+bosQlyPDnBrPZb
o8sNLA6Zj8K9iBFt1AOMn81MbHbMEGW5adjhNgHp6gmToH5Dgwn0lR2YVl/jqVGq
YlPQqPAR9O3q6FAzf+mCMqOZbVOhrZiw/CP8qm6unl1QTlbNWLcBv+FL295CZrg6
QCE8HLuE7snM9VZDdg1NG8yKJtCz9xW0lXVu9XQjMgyz4/XcVpKamMGG+w9S2ydK
mi8KOMrBANd3k+GQ8TpIDUtaA5hTzVBvWVChSF+cG1ssfSo95NZj2In6NaVq4s0X
xfpidmaoQ20puUrS4f6JdPKwu4HYTMbWJ3lrmgOBj/4asmmVQ2fWV+s0yH35qhzT
qJGoyD6QE7seqBmDZM7k27o40mdIc8VmMJXwE5dnrxEvO30HYw3PiUlxbCsrqE47
CqnWcuH3fhJawPwuBvPrni/DKKKh0R+q89OgcjmCfknbyo2Yv7ivBeE17R04qySa
9S94mW1xRZ4fuAIL87AFQsHt5/+YpHRnT83YWeyEDk/7JSxOc8w=
=HPz+
-----END PGP SIGNATURE-----

--lo6spks4ncf7lp5u--
