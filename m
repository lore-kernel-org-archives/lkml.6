Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA4EECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 10:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3020A2083E
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 10:40:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3020A2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbeJUSyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 14:54:01 -0400
Received: from sauhun.de ([88.99.104.3]:42570 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726842AbeJUSyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 14:54:01 -0400
Received: from localhost (p54B33A92.dip0.t-ipconnect.de [84.179.58.146])
        by pokefinder.org (Postfix) with ESMTPSA id 894592E35C1;
        Sun, 21 Oct 2018 12:40:06 +0200 (CEST)
Date:   Sun, 21 Oct 2018 12:40:06 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PULL REQUEST] i2c for 4.19
Message-ID: <20181021104002.GA2921@kunai>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greg,

please pull another driver bugfix and MAINTAINERS addition from I2C.

Thanks,

   Wolfram


The following changes since commit 35a7f35ad1b150ddf59a41dcac7b2fa32982be0e:

  Linux 4.19-rc8 (2018-10-15 07:20:24 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to 31d86033a0749a0463ea654130b2de5c163154f1:

  i2c: rcar: cleanup DMA for all kinds of failure (2018-10-20 15:25:59 +0200)

----------------------------------------------------------------
Kamal Dasu (1):
      MAINTAINERS: Add entry for Broadcom STB I2C controller

Wolfram Sang (1):
      i2c: rcar: cleanup DMA for all kinds of failure

 MAINTAINERS                   | 8 ++++++++
 drivers/i2c/busses/i2c-rcar.c | 6 +++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvMV30ACgkQFA3kzBSg
KbbFJw//e/o64XaEp1T+pNh4khVEAtQmh98yb+/Sph8xVPqFKZnOd0MxKnc6SZUt
gXJUKroRnqclp+0dCeeeVDVOKHlgVkbv1lECBOG/jaNIdpdxahQm8UHvLWDl2N4h
z7G2oB1urzA9i7ziDIGEVZLoTLmhQCk+4s8/Vc1EHj5hRzkwFaTC/9X245+LCtnv
7n8RAKDnP7VQN/ThMoMU/7qRlq3aFlZP9s6315qmvF4qnXyDRTc+RdRecI4Xfs6C
qnKL1mMuAwHCdk3IsTcL1kopbyIXMJM2a12sOWpioc/BD7qS8z4iZD5XAYm2rrza
0iMhIYGgZGtvgBt9DX876BgvAq4FwVa+FoXCVC4+Rbh11EwkCnC6YBtXhMfffacB
uNIwKbdd3bfoYXeZOzfsE27E+l0GBetOzq/XsJJ+M/UZP38yILMrHQihL/PEd8Bp
nxDnj6hkkmY+dPbmJyD3U8KdWIAD0incZ8cxXAvw5zeDQQPz0kg5Nr0Nr1Z/tjl+
fxqhkwOMcnuHsBsL885aVE+nXle4JdVdC5Yp7BO8cbeKI5yg+3wdEVbunXeobhrT
SF8cdHdEnMmPtNwBvbu+j5YFs/9VZrvtXyGyLO/43ceyWtwk9GPFwrNfDH6XiwPN
YGfJgePR6EtXpK4VikoFfGizCuZPa4l3eI8AbBrU+920hdkTg9s=
=8ka2
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
