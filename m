Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752128AbeC3RHV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 13:07:21 -0400
Received: from sauhun.de ([88.99.104.3]:35196 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751256AbeC3RHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 13:07:20 -0400
Date: Fri, 30 Mar 2018 19:07:13 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PULL REQUEST] i2c for 4.16
Message-ID: <20180330170707.6nmjytx4e2s7azrz@tetsubishi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gqjwnvvepfxmhigw"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gqjwnvvepfxmhigw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

here is a simple but worthwhile I2C driver fix for 4.16.

Please pull.

Thanks,

   Wolfram


The following changes since commit c698ca5278934c0ae32297a8725ced2e27585d7f:

  Linux 4.16-rc6 (2018-03-18 17:48:42 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to 771b7bf05339081019d22452ebcab6929372e13e:

  i2c: i2c-stm32f7: fix no check on returned setup (2018-03-24 13:37:41 +0100)

----------------------------------------------------------------
Pierre-Yves MORDRET (1):
      i2c: i2c-stm32f7: fix no check on returned setup

 drivers/i2c/busses/i2c-stm32f7.c | 5 +++++
 1 file changed, 5 insertions(+)

--gqjwnvvepfxmhigw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlq+brQACgkQFA3kzBSg
KbalyxAAqQBlQfQZvL03T7q0iF/3UJ8d+d2ixlDZGKwxS7C24VhaB+hWBU0tBPhe
FMNCFEmqTdC0UvBgiaQQxfe173KuJFmt94d0Hpm+7lvkHBB1wkGsm8Jy7yAwpbQ3
pn96leWsp44SdTanZZ2S/746MyX1Fvjhltry/vWa6H35FJk3XwOcEePun1bv1ptR
Frnr3aYpId+hH/NlpTsKVLNC2Znlbb9BE6FBoarGGiVUU8+75VP2weDKUavEc/pM
r3DyCQjigr1s/PODPqtZqrGYLltmlzqT9DYlGUPtDK14O7IfXTNDveZ7C1RlOPiz
iJlMnY10sKcdyRD/i0Q30yWt1mYQ1YHEDKMAvQOtc0fjIxHVTtyZdU/lse8lXJJj
tgx2Y4Ojcfl1gL4IJoT4K5cCmNko8L/gw0HK0rwKQVpU7twvPwq6JCc1+v0F0FYr
dku7gjbNcyjb8fx/Iwb5HGN1dia77TmXJTrzMeLeYXyhUb2+V0IAuDnCO1PxlrgP
5lcTbzm5/R6cfdgglIaLFKn71wYWoPQeUKwxswr0inMlh5xt5A281/4iz0ezrTDe
r90O8dhW4ES/UUGkBiCMqcBIansLPZZLLDw529yhYaOf5nXHdwbblY7xyOQk++Tr
HI54mEq8IX6O5Y2SEa+iWQF1sL6SGITbZNLM29cbI8RnBv6su5g=
=B/6q
-----END PGP SIGNATURE-----

--gqjwnvvepfxmhigw--
