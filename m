Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B6FC1B0F7
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750672087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbfARUiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 15:38:15 -0500
Received: from wes1-so1.wedos.net ([46.28.106.15]:38219 "EHLO
        wes1-so1.wedos.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729422AbfARUiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 15:38:14 -0500
Received: from localhost (ip4-46-39-182-135.cust.nbox.cz [46.39.182.135])
        by wes1-so1.wedos.net (Postfix) with ESMTPSA id 43hCSh0wMcz4JX;
        Fri, 18 Jan 2019 21:38:11 +0100 (CET)
Date:   Fri, 18 Jan 2019 21:38:09 +0100
From:   Otto Sabart <ottosabart@seberm.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 0/1] doc: networking: integrate scaling document into doc
 tree
Message-ID: <cover.1547843156.git.ottosabart@seberm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
X-PGP-Key: http://seberm.com/pubkey.asc
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Changes in v2:
* Changed formatting of sections according to kernel documentation
  conventions [0].
* All commits from this series were squashed into one.

[0] https://www.kernel.org/doc/html/latest/doc-guide/sphinx.html

Otto Sabart (1):
  doc: networking: integrate scaling document into doc tree

 Documentation/networking/index.rst            |   1 +
 .../networking/{scaling.txt =3D> scaling.rst}   | 131 ++++++++++++------
 2 files changed, 86 insertions(+), 46 deletions(-)
 rename Documentation/networking/{scaling.txt =3D> scaling.rst} (92%)

--=20
2.17.2


--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEb6VOpv2s03VHGoilgjuumfi+HjwFAlxCOS4ACgkQgjuumfi+
Hjzdkg/+JoeKOw97YxCqC/u1F690I/utEtBPK4diT8UexcUg5vn07d7htyMhIaQH
77LgK9h+kCgc0IuL3gDl01TInMid/H6sdHzBqDTcKg3xytwBeoUQGchDORfQRhqv
5TJ9VGQY9UjxO0b/4p544sTMToGSyuHnIFXVy9Xn9+pTyAYkZ8LfG3af5pCEE64Z
qUb71Z67kXVoCXX+aux1ll41FUjepvlA3fN80gnk4qWNPp5mMtQQnqD1aYyNjfBe
RAIu1WzHCW6x9fRIbeKsZpTTvXf5nW5sGgTEguPWy+b3dwQhaNbc469VXlhRmMfo
cmzTAHToEcB0InOBbM4e6MlxrIkge/+Dyrk0nb9p6InD7kQd2e+eoj2gyqZJ6xJH
9vvtBJLn2jYcAEbM3tR6+kwtsNBOX7oKNh17dbZUL8eWvk5zMEKutf15xjjK6Rqm
ZeHba26MP9qGKCG0skAEbcLPyCi5Ef0izFPgwrgT+ksfV+n1gdfWJreUWMBPl2ne
t+yjq8/7pFpqjkD8AmKSSvpHw/xXBW3BYA+WMr4Kd5oINLlgUVAW4+WLpVKI9or4
aoRY3emdy75NAHpqaRue4udWnLB1A3UjeSJDhEJFPZSDKCDfgueLJrChsX3P4bVw
kilN8d2SrGITZQQVUAb7A5AEJLfJ8BLqI7WLvMfErJWjS9esbro=
=96Qn
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
