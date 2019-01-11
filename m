Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50A8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7BE421848
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732559AbfAKS4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:56:55 -0500
Received: from sauhun.de ([88.99.104.3]:60488 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731352AbfAKS4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 13:56:54 -0500
Received: from localhost (p54B338E8.dip0.t-ipconnect.de [84.179.56.232])
        by pokefinder.org (Postfix) with ESMTPSA id A524F3E4153;
        Fri, 11 Jan 2019 19:56:52 +0100 (CET)
Date:   Fri, 11 Jan 2019 19:56:52 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PULL REQUEST] i2c for 5.0
Message-ID: <20190111185648.GA9214@kunai>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

I2C has one core and one driver bugfix for you.

Please pull.

Thanks,

   Wolfram


The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to b67d4530cdade7ebfafa2c6b46f2a0dad3e41bcb:

  i2c: tegra: Fix Maximum transfer size (2019-01-11 00:15:04 +0100)

----------------------------------------------------------------
Sowjanya Komatineni (1):
      i2c: tegra: Fix Maximum transfer size

Yi Zeng (1):
      i2c: dev: prevent adapter retries and timeout being set as minus value

 drivers/i2c/busses/i2c-tegra.c | 15 ++++++++++++++-
 drivers/i2c/i2c-dev.c          |  6 ++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlw45uwACgkQFA3kzBSg
Kba4DRAAjy05eXY5qK9AN9D0cF8sT8HKvs1//4FUOA3y1rBcODTNvKBxrZITmlmf
xppJnYqsjdEgRB00I8oGhUOARRLXoveDm6fWTgwWVRQ1gNE82/YI9+/JMSjtm6/F
4jDknVZGl5jDr02GbLgvU5eZnxQy6orrtlbC5uDyYY030JXkT0qtdyM6tww5IVdO
xE+Nqe1H5AnPuttYOK+LEfiDCecj+nhJBSlPzgUzgeED8dfnNvn2c/GAvdB6bZ/L
clum/giJiN8i+jFiORwncx7Yynt2fKYPwFI4T/Z2lSk4gq1riPToNOxLBrFTv9t1
n3GC4V1gdAgtxMcZcgrXbG8+41+JmwSUcHIiUoRL36vqu7mF04bBTRlEproD4lAG
PczM35UhI6xQ+f4Ccclu7WPatelVHy/Mof9BNQqIsE+hMuClegAUPTDVdpwCjAb4
rKN116bTpFbGIhLbVyGlW1TZbyAPz7279DPf1aDYPqA6hUH/eG4WLjCzk2Es0+c6
wz0YiEeFuuJQO9RKxiY9muOCVp0Ff/GXg2sYJFOAd7RSxecKGIVv0/7tJDC46UZ0
um1Opa/P5fkb4HOPGhVNm+Z7MZ849XWHzQ7LEnRdWs5kSb0sZr6UUHAFZhj5AzPO
dSDa+iEqSBfNnICDkoTib8ZeoELfzmcsrW6AHJjNC5Hl/m3cQN8=
=y5FR
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
