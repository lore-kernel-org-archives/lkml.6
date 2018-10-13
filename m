Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACBEC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 16:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F7520659
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 16:21:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F7520659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbeJMX6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 19:58:54 -0400
Received: from sauhun.de ([88.99.104.3]:57046 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726798AbeJMX6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 19:58:54 -0400
Received: from localhost (i577A647D.versanet.de [87.122.100.125])
        by pokefinder.org (Postfix) with ESMTPSA id A65772C7D2D;
        Sat, 13 Oct 2018 18:21:05 +0200 (CEST)
Date:   Sat, 13 Oct 2018 18:21:05 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PULL REQUEST] i2c for 4.19
Message-ID: <20181013162101.GA1321@kunai>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greg,

I2C has one documentation bugfix for something we changed during the
v4.19 cycle.

Please pull.

Thanks,

   Wolfram


The following changes since commit 0238df646e6224016a45505d2c111a24669ebe21:

  Linux 4.19-rc7 (2018-10-07 17:26:02 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to 34d1b82cd198379545ca634119e296fce06252aa:

  i2c: Fix kerneldoc for renamed i2c dma put function (2018-10-11 22:59:57 +0200)

----------------------------------------------------------------
Stephen Boyd (1):
      i2c: Fix kerneldoc for renamed i2c dma put function

 drivers/i2c/i2c-core-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvCG2kACgkQFA3kzBSg
KbbsDBAAiESQTk2qjhz/gE/JI5zIgpJl9oyu35+lf6W1pdMHTtw98XsgYcFtjing
j36PHO3xPga62UHrhxsmlHbFUYzwAJXOAHFmYDNfTlAuKexsbuY75nV/Oj7Hqm8Q
Q+ClsWbp7a8efwmwdeyrLsQmx3vQsed4WmE7WZktQZlg1IVOhft0suZcj3O0SyNn
XYLA4xb1uwXqHzTQzUSbPHZvt5KqPCsvlVJuwKJ/LicpxMVsEv8gSCeAd4BgNB38
2QKTEHiSK8X+onbXAMRUUQTQbXrahy65OB7O+sChnliFXfMhGArXC3uAmXMzwBhu
O5s9iV2rwm+D+XaRMr+WBQaWusWlOCO8xCDMZSGRmK0U0LCN4s6t8ZVJnPKtSWKK
W0iBrwsffVKZgWoGABIRHmeC4IL5Eq9SEb8L+GqtCmlCqU+QTEuOBFNL0C0Z2svP
ZTnzW36p5QhP01gKtOV5Y3yCQW+t0sn8WKdoYV2Iw5JCqFgB2debUSEJ/hDmfZgr
+f1nJIVduoj1Vx/clMdd+SwkS5KRb+56i4umP7JTcbfuQzXkxB7fVg3DhS3krtfW
P0L/E6doc9GyP39jHiotVdtq8bCVPbNpzRI6jCxTdNdmWPicLraC4hawZrN/mCNo
1EGIWcaduF+vIcqoZKtu5RJmteQcDT9u0ayiVFzNWPBGfKGrevo=
=jgCq
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
