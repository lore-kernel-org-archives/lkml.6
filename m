Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FB6C6778F
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 06:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B79620897
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 06:55:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B79620897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbeG1IUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 04:20:52 -0400
Received: from sauhun.de ([88.99.104.3]:57624 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbeG1IUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 04:20:51 -0400
Received: from localhost (p5486CBB7.dip0.t-ipconnect.de [84.134.203.183])
        by pokefinder.org (Postfix) with ESMTPSA id 7554965057E;
        Sat, 28 Jul 2018 08:55:24 +0200 (CEST)
Date:   Sat, 28 Jul 2018 08:55:23 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PULL REQUEST] i2c for 4.18
Message-ID: <20180728065519.7fbb6omuknfko5ko@ninjato>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6vkeymc4ahygjzoo"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6vkeymc4ahygjzoo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Linus,

I2C has some driver bugfixes for you.

Please pull.

Thanks,

   Wolfram


The following changes since commit d72e90f33aa4709ebecc5005562f52335e106a60:

  Linux 4.18-rc6 (2018-07-22 14:12:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-curre=
nt

for you to fetch changes up to d2d0ad2aec4a8f3fd15e000ed903d6beddf39644:

  i2c: imx: use open drain for recovery GPIO (2018-07-24 14:59:12 +0200)

----------------------------------------------------------------
Alexander Sverdlin (1):
      i2c: davinci: Avoid zero value of CLKH

Esben Haabendal (1):
      i2c: imx: Fix reinit_completion() use

Wolfram Sang (2):
      i2c: rcar: handle RXDMA HW behaviour on Gen3
      i2c: imx: use open drain for recovery GPIO


with much appreciated quality assurance from
----------------------------------------------------------------
Geert Uytterhoeven (1):
      (Rev.) i2c: rcar: handle RXDMA HW behaviour on Gen3

Lucas Stach (1):
      (Rev.) i2c: imx: use open drain for recovery GPIO

Uwe Kleine-K=C3=B6nig (1):
      (Rev.) i2c: imx: Fix reinit_completion() use

 drivers/i2c/busses/i2c-davinci.c |  8 ++++--
 drivers/i2c/busses/i2c-imx.c     |  5 ++--
 drivers/i2c/busses/i2c-rcar.c    | 54 ++++++++++++++++++++++++++++++++++++=
+---
 3 files changed, 59 insertions(+), 8 deletions(-)

--6vkeymc4ahygjzoo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltcE1IACgkQFA3kzBSg
KbbsYxAAlria6ZA4HFyFI7FS2hTjjFl8iiN9BIo67wF21b7pPp36iDXgIueQf5lO
ApCn5TcY0ocjU8F+2+dKOQfNs7MaBSVdNEpjFUY+cuiq4DyPwSQMfpEq72to5kg0
pwED6qqf35Cb1pSB7EoNc2IAVlmLa8Dy4xjKnBVyU9clnpKChrlJ/xrQfUCC1kjV
cX/3t/l28Vbpx+PT7nlHJ6u3JBUJwKPBxkW3Bv0B/8BSUZRJ0IyQjMIjjRVY8cOj
+f29mkcg34y5MPiRXhaL1SmgMh1AkMCCdXHQMxcpiiZRk9nHBxsRvYSFlFtNadDZ
ygm1/4+ZhzD7u6KI/JhsJ2pJtsEJ/pjGB8mhs2oWFzPJNikpu2oopZ0h3XFgkkZz
5bCBqvY+hQjLLyIDron4se3B8OIxkaM9t8RV+l7SUKGGTxmITBYdl4RTntE36R+V
umVyHj5eAN2NLTLhIGFswurT2VmqZNz8LvxH8sH6m352MVU+W1FS5GrleDNI7tZn
ZDFHFiIlcF7VmUrXejC6Ip/MBdgHSO8KWeRIOaxXIkvvztEY5qRze2O6XzDM10X1
Mtc6WCnIKbwFrZWMO7eNdiyTsm5jqusdVwZtHRWO3Romfz2i/eQ7bszckbQtb4/H
megNdIhcGCRnDi3EOcEk/AASvQTy2pWWujXV1OIaF47i8LzUe8A=
=6Nx6
-----END PGP SIGNATURE-----

--6vkeymc4ahygjzoo--
