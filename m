Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F60ECDE43
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 20:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A0A208E7
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 20:37:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A0A208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbeJGDm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 23:42:28 -0400
Received: from sauhun.de ([88.99.104.3]:49002 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbeJGDm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 23:42:27 -0400
Received: from localhost (p54B333F2.dip0.t-ipconnect.de [84.179.51.242])
        by pokefinder.org (Postfix) with ESMTPSA id 8008B2C015D;
        Sat,  6 Oct 2018 22:37:42 +0200 (CEST)
Date:   Sat, 6 Oct 2018 22:37:38 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PULL REQUEST] i2c for 4.19
Message-ID: <20181006203728.ijfuod6p3ocwy3sk@ninjato>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="exehsgcp3xa2xsl4"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--exehsgcp3xa2xsl4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greg,

I2C has three driver bugfixes and a fix for a typo for you.

Please pull.

Thanks,

   Wolfram


The following changes since commit 6bf4ca7fbc85d80446ac01c0d1d77db4d91a6d84:

  Linux 4.19-rc5 (2018-09-23 19:15:18 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to 9ce7610e6d201e3923c0b2f454f2e1d54f5da49e:

  i2c: designware: Call i2c_dw_clk_rate() only when calculating timings (2018-10-05 13:40:05 +0200)

----------------------------------------------------------------
Colin Ian King (1):
      i2c: i2c-isch: fix spelling mistake "unitialized" -> "uninitialized"

Edgar Cherkasov (1):
      i2c: i2c-scmi: fix for i2c_smbus_write_block_data

Jarkko Nikula (1):
      i2c: designware: Call i2c_dw_clk_rate() only when calculating timings

Stephen Boyd (1):
      i2c: i2c-qcom-geni: Properly handle DMA safe buffers


with much appreciated quality assurance from
----------------------------------------------------------------
Ard Biesheuvel (1):
      (Test) i2c: designware: Call i2c_dw_clk_rate() only when calculating timings

Douglas Anderson (1):
      (Rev.) i2c: i2c-qcom-geni: Properly handle DMA safe buffers

Jean Delvare (1):
      (Rev.) i2c: i2c-isch: fix spelling mistake "unitialized" -> "uninitialized"

 drivers/i2c/busses/i2c-designware-master.c |  4 +++-
 drivers/i2c/busses/i2c-isch.c              |  2 +-
 drivers/i2c/busses/i2c-qcom-geni.c         | 22 ++++++++++++++++++----
 drivers/i2c/busses/i2c-scmi.c              |  1 +
 4 files changed, 23 insertions(+), 6 deletions(-)

--exehsgcp3xa2xsl4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlu5HQQACgkQFA3kzBSg
KbYNPQ/+LfftRiDvXuXJBNgSUWTZbQ8ppO7qCBq9rCbw5pBm+gRodWpLrQBkrf+S
oRhVIbIiEhP4oNqfw30fhHEKK4LO4jfpNl3mtu6RkrOJ476DK2BTwP2WzO7pzrjO
CdpiNqX0QbJY+IH8G437YcS3BjNdyF0H48u6rWO/YvlOErpAv+pBoSVyZHS/Ht8Q
skG3xlVzHNXv+V9aJ1GJz5b3jV2hWkiVeZnA3PUoie21IVhdo+0e63SH9IEW0OAB
3pUDO5fp8ZaP+AUTwf/MWu/zFfrxOFBg1aiNz1c37aY18Ok5whvlQMgbnJFNmR3D
8ykifqbbuwxxxp3OhxUCoiQjdngA1um6FGjg6ogwZ/QpdZe7nvHnLPjXf32Z9hB9
1YH4IJ3adTUKNnl+JiQTdcUBEDtRfOSf4ilRnKisTAKHbPhOcTFacbS7ZY2DWTrF
SrwJmcnGav/jXQ6jcyn9aDVWKBBuaTn9xnhK2M1vA+aikBq7zRbNaHuZLPrgO9eg
XH8FTMHhb+UGVBuKHd/5fE8AppiuR0XaoRYACqBWPdpcLSGpizR1IkZjDt+r/ZQi
NRQzfIGT5l3yyuNzEe5IzFR5Xn5zWtEam9eDA3MFMrpd0b9ExJ4I1P6JRU4NwUsc
O2xYKMV2WFimMrL8XSdVNDZwKyKwcyIjRzHqh3AMMFEpjUplH30=
=9h/P
-----END PGP SIGNATURE-----

--exehsgcp3xa2xsl4--
