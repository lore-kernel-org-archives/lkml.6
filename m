Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63161C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 154C420846
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:13:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 154C420846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936449AbeF2PN6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 11:13:58 -0400
Received: from sauhun.de ([88.99.104.3]:48456 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934498AbeF2PN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 11:13:57 -0400
Received: from localhost (p54B335EC.dip0.t-ipconnect.de [84.179.53.236])
        by pokefinder.org (Postfix) with ESMTPSA id 905C15601C5;
        Fri, 29 Jun 2018 17:13:55 +0200 (CEST)
Date:   Fri, 29 Jun 2018 17:13:55 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PULL REQUEST] i2c for 4.18
Message-ID: <20180629151351.i3ogf77awxzuw4sl@ninjato>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uo7xj3nczsno75al"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uo7xj3nczsno75al
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

this pull request contains:

* a revert because of bugzilla #200045 (and some documentation about it)
* another regression fix in the i2c-gpio driver
* a leak fix for the i2c core

Please pull.

Thanks,

   Wolfram


The following changes since commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:

  Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current-fixed

for you to fetch changes up to 12b731dd46d9ee646318e6e9dc587314a3908a46:

  i2c: gpio: initialize SCL to HIGH again (2018-06-29 08:23:12 +0200)

----------------------------------------------------------------
Peter Rosin (1):
      i2c: smbus: kill memory leak on emulated and failed DMA SMBus xfers

Wolfram Sang (3):
      Revert "i2c: algo-bit: init the bus to a known state"
      i2c: algos: bit: mention our experience about initial states
      i2c: gpio: initialize SCL to HIGH again


with much appreciated quality assurance from
----------------------------------------------------------------
Geert Uytterhoeven (1):
      (Test) i2c: gpio: initialize SCL to HIGH again

Linus Walleij (1):
      (Rev.) i2c: gpio: initialize SCL to HIGH again

Sergey Larin (1):
      (Test) Revert "i2c: algo-bit: init the bus to a known state"

 drivers/i2c/algos/i2c-algo-bit.c |  8 ++++----
 drivers/i2c/busses/i2c-gpio.c    |  4 ++--
 drivers/i2c/i2c-core-smbus.c     | 14 +++++++++-----
 3 files changed, 15 insertions(+), 11 deletions(-)

--uo7xj3nczsno75al
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAls2TKsACgkQFA3kzBSg
KbYR+BAAsG76e3uN3kSy7IeRbnVRM7Uly7K+DrWLVmDQxigYg2InPgPDq3sj70iU
phsL3dMPJwP/ww4vtsOpv8/9/1c9jiqGYQcSqCv7UZrLGwmEkvTJ8BGkN0jkVO5m
qxENbo890nLwvh+il8Zid5JYzP0ceZ5H329pMyLItcBEG7mUHWU6YM6WyumxHxeZ
TEyWf2FRfTIcwWgCuz1NuIuW+sm0HBbzQkKP/XIpPgG+JgNQaa6j57Q1tfb35V19
VRy/41mHWEfyh6npSLTWRE5uoclg3N6nRee6HGPEeqoKLYKvMdcSy7RDYSfLiQ/O
4GuXeq2OPCcdSIl9NIO+Wy0NaFBvz2iDU2/qbSZopsuyPLdifcMd1rJO/VuApJxU
P0HRB/sHnmZUmb8ic+YZMRnz8G5shtqPc5pudVfNVGvBVrA4s1DpVNfzR1k1NwBa
xJsgZqIC61IwlTO+pNsCqpO+jQ7lge6cjCWZ2mo+JdLYk1TL1vzakDQ4S2apPeGl
p2hWVIIwetuU3R5TxVrb8hj9h9USYzHZ2PG0/OMkqsUEJVMaX8GVp1CLdf5SmzTr
+55hMBGj+fWoIhD6deywUnT0kqdMAzKnXaR1v9i3GIBNXgQImoAnRvRJmSMLIzMC
fZTwB+6b5UtdPugrAHVWiZbe//4Q/dESq6i4yeryrMqDFriY8CE=
=JMu1
-----END PGP SIGNATURE-----

--uo7xj3nczsno75al--
