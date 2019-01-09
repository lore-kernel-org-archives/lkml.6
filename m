Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDF6C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3C432075C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbfAIT5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:57:07 -0500
Received: from wes1-so1-b.wedos.net ([46.28.106.43]:35227 "EHLO
        wes1-so1.wedos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727123AbfAIT5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 14:57:07 -0500
Received: from localhost (ip4-46-39-182-135.cust.nbox.cz [46.39.182.135])
        by wes1-so1.wedos.net (Postfix) with ESMTPSA id 43ZfzP174Gz4gD;
        Wed,  9 Jan 2019 20:57:05 +0100 (CET)
Date:   Wed, 9 Jan 2019 20:57:01 +0100
From:   Otto Sabart <ottosabart@seberm.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 0/3] doc: networking: integrate scaling document into doc tree
Message-ID: <cover.1547063330.git.ottosabart@seberm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
X-PGP-Key: http://seberm.com/pubkey.asc
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

These patches integrate scaling document into documentation tree.

There are no semantic changes.

Otto Sabart (3):
  doc: networking: prepare scaling document for conversion into RST
  doc: networking: convert scaling doc into RST
  doc: networking: add scaling doc into index file

 Documentation/networking/index.rst            |   1 +
 .../networking/{scaling.txt =3D> scaling.rst}   | 131 ++++++++++++------
 2 files changed, 86 insertions(+), 46 deletions(-)
 rename Documentation/networking/{scaling.txt =3D> scaling.rst} (92%)

--=20
2.17.2


--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEb6VOpv2s03VHGoilgjuumfi+HjwFAlw2UgsACgkQgjuumfi+
HjyL7xAApK3awdC5eWoqeoB05kl/DU5JamDMDug2JzzMacKG1KipWM76xYahkoQc
dyi82ZeR96BcScyrF6eVygCzvn5ufvmEB2pFkHHWR3tDTIeQNBvTvlVuRTTTH9zA
DUMEtPBE21ICkeOEorprHBr5KAfrmsFEI54jDpKFhNl64qy6M9a4/zPckj1uMouh
/Dh2/WbOqosRWuNpXZg5gUd2392I/JRPY/34zaZNI5ieOBpdv59jlzdtx3wb+vxB
rMh0f2bzMnxbS744RuTJ+986CMXDTtTgbYBaMLrRCA4Qs/yDPmac65xbkex3myCs
iR1lkF77FhGHlqmer/Zg8dXhtouC1fy2tOWH7fOc1mMX7bhPotjbhc6VeJdZD/vf
9+7C48bZpxyuYib4VgetcNXE/oVOAnIg7gcKoA70Hgz2FIIeQzwIXR9/WIWASB+p
R4d26+Iwn0GDePUFTC19szwm96ot8zbF1wT19844hOMeM1XmpaTSjJx2038xUL5J
p3f0eCTbVoC4OjNkjE12g9RojVjYC3S2xzGeEZRkzQyXESPT8FL3kAfreq6YTbos
mhZYrgpwgEwJBZY3660/5VnfiYDV/uaF3NrouB22X/4TMuFjrkfh1GCLXFXVWTbE
BbGexGDIHMfsrU84rqRuNzlrENolLi9OXGc0h/Lh7rS1F1Znfrs=
=3ebX
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
