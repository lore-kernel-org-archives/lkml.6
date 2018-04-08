Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752654AbeDHSoN (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 14:44:13 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41720 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752076AbeDHSoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 14:44:12 -0400
X-Google-Smtp-Source: AIpwx49jlGV6HPW0DdnHnWAD9w7iXvlHJ2HA1yftcEZ1QrhCM6Vi6/j5oMqibJjIOcI7NdBtXjqrXA==
Date: Sun, 8 Apr 2018 11:44:09 -0700
From: Matt Turner <mattst88@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sinan Kaya <okaya@codeaurora.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Michael Cree <mcree@orcon.net.nz>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PULL] alpha.git
Message-ID: <20180408184409.GA27396@ivybridge.mattst88.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull a few small changes for alpha.

Thanks,
Matt


The following changes since commit bf6879dcc483f0aa087afe27d103285daf435951:

  Merge branch 'misc.compat' of git://git.kernel.org/pub/scm/linux/kernel/g=
it/viro/vfs (2018-04-07 14:38:01 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha.git=20

for you to fetch changes up to cd0e00c106722eca40b38ebf11cf134c01901086:

  alpha: io: reorder barriers to guarantee writeX() and iowriteX() ordering=
 (2018-04-07 15:04:15 -0700)

----------------------------------------------------------------
Alexandre Belloni (2):
      alpha: rtc: remove unused set_mmss ops
      alpha: rtc: stop validating rtc_time in .read_time

Michael Cree (1):
      alpha: Implement CPU vulnerabilities sysfs functions.

Sinan Kaya (1):
      alpha: io: reorder barriers to guarantee writeX() and iowriteX() orde=
ring

 arch/alpha/Kconfig          |   1 +
 arch/alpha/include/asm/io.h |  14 +++---
 arch/alpha/kernel/Makefile  |   2 +-
 arch/alpha/kernel/bugs.c    |  45 ++++++++++++++++++++
 arch/alpha/kernel/rtc.c     | 101 +---------------------------------------=
----
 5 files changed, 55 insertions(+), 108 deletions(-)
 create mode 100644 arch/alpha/kernel/bugs.c

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEO7Y55W+GH6LoZQVpD91oLZdMpyoFAlrKYvIACgkQD91oLZdM
pyrAZg//R+9VhRxjNCt1SuQ6gP04fvQURGdwPgqueRdr5cW8pv2UgCeKxu3yAd92
EbhEsq7p0di7sXunzQBwKSM7ifAhVtXBKsFVrtvFrEc/1/pGbwckReQ1Hd5t4lwB
zXrmjJRGvxupyh3yqsY81vWR5t5kxfLZ1QdFvuCSdQq6LefVE+S0uBZzhhFoSOgb
z7VpCZyo9ca70or5NeysIAXYZtmLar3GyHKb1427c9zAJhmgFEhiO+WNKPpOm8wT
36rT1GF4Ot9PC/TgYQIGK3Vnds9NaRmi08iMXgiu975h0aMHQliFCSjm5r9Bhsse
GuMPMRp4HUTLHfvMsLKwBp7wYe2sq5dzbDqFbughkduHa3Dro72SzfWcrovy/PPe
lFnFxGuS024Ihp23JDDmd0kPju3y1hQxoKqj+n3Wui4HTsnvlPfKdTrTg2N0THZH
RfAsQOaApAUv1bpEcLCOyyJGIMm5IpMZhdL4ieVndGibgBDiT/HY5dXUNKpdb7we
LvN52Dh1Tc8xXdsi8iA6burQA82OGRS6sqT3G0U2rz86tAJIRQc+6knYcrBzL3Eq
Z2QBTljnw1X6n7o0GNbvUcU4RDyIIwu4Z8pyrKD55xpHGnkqUbzHgWcZck3cXgXH
DrI/MFButts4dNzDKER8iCcETds7XgL4ssXuV7ow8vWiidVLvic=
=e8Jg
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
