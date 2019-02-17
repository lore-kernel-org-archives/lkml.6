Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF5EC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 10:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AE8F2192C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 10:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbfBQKPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 05:15:23 -0500
Received: from sauhun.de ([88.99.104.3]:50036 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbfBQKPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 05:15:23 -0500
Received: from localhost (unknown [195.52.228.164])
        by pokefinder.org (Postfix) with ESMTPSA id A69C52C08C3;
        Sun, 17 Feb 2019 11:15:20 +0100 (CET)
Date:   Sun, 17 Feb 2019 11:15:17 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PULL REQUEST] i2c for 5.0
Message-ID: <20190217101513.mmbztn2nopa4phif@ninjato>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="x4lbudek2j2la7in"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x4lbudek2j2la7in
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

I2C has two more driver bugfixes for you.

Please pull.

Thanks,

   Wolfram


The following changes since commit d13937116f1e82bf508a6325111b322c30c85eb9:

  Linux 5.0-rc6 (2019-02-10 14:42:20 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to f275a4659484716259cc46268d9043424e51cf0f:

  i2c: bcm2835: Clear current buffer pointers and counts after a transfer (2019-02-15 09:45:05 +0100)

----------------------------------------------------------------
Paul Kocialkowski (1):
      i2c: bcm2835: Clear current buffer pointers and counts after a transfer

Shubhrajyoti Datta (1):
      i2c: cadence: Fix the hold bit setting


with much appreciated quality assurance from
----------------------------------------------------------------
Kyle Roeschley (1):
      (Test) i2c: cadence: Fix the hold bit setting

 drivers/i2c/busses/i2c-bcm2835.c | 12 ++++++++++++
 drivers/i2c/busses/i2c-cadence.c |  9 +++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

--x4lbudek2j2la7in
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxpNCwACgkQFA3kzBSg
KbYYcg//eJMnU7nHE4uM843ahTp+WgduIAVmpNuBLU8RFadO7mNqdWCLlu2/rYDy
kH+c3KDjwur30Uk5YGQAXDWzaJr3gCvvwzJzJHZ8/19i4rZgHsfhx6NiQhY2OPSQ
foQExmLazsKy9TN+JGJp+BMxy6IuoRY8AFgrudAH/OQnodEL1JOdxtqqT/c7FZMc
f8X4rWrux4HUoamNiXvsjoDkEWEbWjSIOJ2Mz0rie7zpBiJ7sFDiG64NvrKZz0vq
TMF4cwl2fOqLObNOuCs5yYFi2mVBJ4e6UgBKb6TU3eOJ6yit7hEk6G2e3GbGQO2z
GqZAwhd+VnVlCa0Ryqkdy0yVHKs0TesMn3fL7LWcYGBk2VKJbakGyvjXoB4wjkRd
xOOOwko7yYABZJTMP41c5Q6XODVEeg5KzjKZhmEBpFrK+FIpl7PhR5bwI28JkWV9
FaLnYHeUWIEEQ9/xPx2waIycW7WbtHC1J/iT/71DyXBbqrLuzlSiy34AjeMoYS9G
16wxIefEXKfsr6Z0RMzaq9Sk4ES2+gxhefGdaqYsTMXWnWLMt6ABBdeiuGfFEigv
zz0VqEn67xbAeGYiFC0+PM9qCiG+Qhj4pg2xu6KqYmQSFY6UbbQkjEupbbralvwe
cXscXe6vxX91b2jfrZMaJd+kgRH2J+sOfz3WdpRQz+uAJNuXeFQ=
=iluI
-----END PGP SIGNATURE-----

--x4lbudek2j2la7in--
