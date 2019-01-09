Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B5CC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 198F92177B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbfAIT5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:57:41 -0500
Received: from wes1-so1-b.wedos.net ([46.28.106.43]:32778 "EHLO
        wes1-so1.wedos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728395AbfAIT5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 14:57:39 -0500
Received: from localhost (ip4-46-39-182-135.cust.nbox.cz [46.39.182.135])
        by wes1-so1.wedos.net (Postfix) with ESMTPSA id 43Zg011dh7z5nJ;
        Wed,  9 Jan 2019 20:57:37 +0100 (CET)
Date:   Wed, 9 Jan 2019 20:57:33 +0100
From:   Otto Sabart <ottosabart@seberm.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 2/3] doc: networking: convert scaling doc into RST
Message-ID: <ac9c5722a66e9ede3d8694cf97364226e9b8fa4f.1547063330.git.ottosabart@seberm.com>
References: <cover.1547063330.git.ottosabart@seberm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <cover.1547063330.git.ottosabart@seberm.com>
X-PGP-Key: http://seberm.com/pubkey.asc
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Just rename the scaling file to be found by Sphinx.

There are no references to "scaling.txt" file. Whole kernel tree was
checked using:
$ grep -r "scaling\.txt"

Signed-off-by: Otto Sabart <ottosabart@seberm.com>
---
 Documentation/networking/{scaling.txt =3D> scaling.rst} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/networking/{scaling.txt =3D> scaling.rst} (100%)

diff --git a/Documentation/networking/scaling.txt b/Documentation/networkin=
g/scaling.rst
similarity index 100%
rename from Documentation/networking/scaling.txt
rename to Documentation/networking/scaling.rst
--=20
2.17.2


--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEb6VOpv2s03VHGoilgjuumfi+HjwFAlw2Ui0ACgkQgjuumfi+
HjyaxQ//aNbUzZBevJCbgK4Bakpy93YGio9yKzC4NOX4d9TkXp7AubPGwxLZf+i6
hIuhpdmsL5d0uflgKl5cB5tUbaG37Dn+/+5bDMBLS/XCmlIPFiefTypPxKkOPZI6
f/YdgPhSvH7/8lorcYP+acJcg6u/AZBAKYq/z1Xly8D88Cem1AKDD7AWkgM5ml2x
lZVkusPvUES0B4iAL/WS34XX3I2Cr2XBacbKmRRJrmr0NBPid+kwfhWVyESbLIBo
B83o+eC8f37F5lpqFdr8N+YjxiCjCauGMPjWUiiFcaXiJ+7zUhqWOJY6TRgwbMyB
B7nXDFIJLCgm6RbPP7E1MbQoHeSL3ou1rPuJ1M1JMlOVlOkWpco68JTGupz0ncFN
aaWsZ2KhSVZtY7k9tXVxvnwmxWCVWtDR8fzy31SYZWxH1x9f7GTU0ryGgVBEd62a
nlP5IB1aemc7lTykesJn260gpXxlelpC78K16bPqbbi2Z3FptXMsKFtyuWekRGXQ
FbXII6u7nUEoiW+3RP9HYOuM2t7BDwun6Ui5gf4FDvgEfGbn/NK7W7CWAChBHFE2
TtfwtQ9TJ+NnVXDCED5S+pD0XUx2dN5PYjr+x8xCG1C7Qyb+LLZnTTAUlAKekpVS
cP2WuDetujHu+XDHr/qOCZimqoJPbfwSt7/7q3F+53zGCTLGkHg=
=Pm0W
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
