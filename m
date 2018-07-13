Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E111ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CBDE2075B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CBDE2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732199AbeGMUui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 16:50:38 -0400
Received: from www.zeus03.de ([194.117.254.33]:38406 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731542AbeGMUui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 16:50:38 -0400
Received: (qmail 28557 invoked from network); 13 Jul 2018 22:34:23 +0200
Received: by mail.zeus03.de with ESMTPSA (ECDHE-RSA-AES256-GCM-SHA384 encrypted, authenticated); 13 Jul 2018 22:34:23 +0200
X-UD-Smtp-Session: l3s3148p1@QBq4Z+dwHuUgAwDPW8bBAAId4P/+oMhl
Date:   Fri, 13 Jul 2018 22:34:23 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PULL REQUEST] i2c for 4.18
Message-ID: <20180713203419.ty2boi6zj6qvzyoh@katana>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mwcxmur3ww62ikxn"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mwcxmur3ww62ikxn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

I2C has for you:

- one I2C core bugfix regarding bus recovery
- one driver bugfix for the tegra driver
- one typo correction

Please pull.

Thanks,

   Wolfram


The following changes since commit 021c91791a5e7e85c567452f1be3e4c2c6cb6063:

  Linux 4.18-rc3 (2018-07-01 16:04:53 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to abe41184abac487264a4904bfcff2d5500dccce6:

  i2c: recovery: if possible send STOP with recovery pulses (2018-07-12 23:38:18 +0200)

----------------------------------------------------------------
Jon Hunter (1):
      i2c: tegra: Fix NACK error handling

Thadeu Lima de Souza Cascardo (1):
      i2c: stu300: use non-archaic spelling of failes

Wolfram Sang (1):
      i2c: recovery: if possible send STOP with recovery pulses

 drivers/i2c/busses/i2c-stu300.c |  2 +-
 drivers/i2c/busses/i2c-tegra.c  | 17 ++++++++---------
 drivers/i2c/i2c-core-base.c     | 11 ++++++++++-
 3 files changed, 19 insertions(+), 11 deletions(-)

--mwcxmur3ww62ikxn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltJDMsACgkQFA3kzBSg
Kbbt4A//Y6aUUG/9P1ZuycD+2HRdTU4p2Ma+ogx5O6bX93blLwWtlAG1XJPorUUy
fldw0NuHQDd0N2CgeJH0OGdTlDpwO1cyGkOEUXVjVMEZc6sySa4utY+kRNEqhiUF
TXmqW3NNqEwDskxS89XwIGQn45dQ856PW5n4C580u4KUCu1KXXp3OjPUFnX+lDDl
nzcnW3fn4AtEPXSAkHDuZyw7algIbkkrTorhejNfPIEP5R3b93QGpjaIZto6gDXT
xc5/odzR9Ag2GcP2IWpdkk6kc1qJ1mT0GqwJKi5+IybLWZddrg3oarravbRvdfL5
2WmVWYq/DktfJIwZu8IFt+eCycNHtylT6VS0PhAHNh9G5P02TSrUi8ywm+EZBI6s
PYeqrTXWCjKYiPjxjusfkDkag/MgYMguuJB28G7yrvBXLLKh1QxDRyUpqPteDDY1
KH8drR8NUQ+qxfWArgMQGQjg/iJrrQRXK6DOre+AnBCK91dB/N+ATg6/PY/vPONN
/QqjHoMN14449VYrJ5LxYnh2qC8p0pAuywpgMfUQSetao7p+7GqC+4FHfuX85SDh
o0xt/J+d36oOUNt8/XXpegClXxEc/52Y2A+OnjmgBcbmTUWtsqLTkZhUj/GidLfg
HTtMFxCau3L6iESjKQjZ338mkPLsKWLt/cWWMapiWqmIJMOa1Fc=
=aVKt
-----END PGP SIGNATURE-----

--mwcxmur3ww62ikxn--
