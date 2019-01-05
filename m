Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E55CC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 23:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0F0C222EE
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 23:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfAEXeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 18:34:36 -0500
Received: from wes1-so2-b.wedos.net ([46.28.106.45]:60160 "EHLO
        wes1-so2.wedos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726363AbfAEXeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 18:34:36 -0500
Received: from localhost (ip4-46-39-182-135.cust.nbox.cz [46.39.182.135])
        by wes1-so2.wedos.net (Postfix) with ESMTPSA id 43XJ094tVkzhq;
        Sun,  6 Jan 2019 00:34:33 +0100 (CET)
Date:   Sun, 6 Jan 2019 00:34:30 +0100
From:   Otto Sabart <ottosabart@seberm.com>
To:     David Miller <davem@davemloft.net>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] doc: networking: update references to files
 describing offloads
Message-ID: <20190105233430.GA29953@personal>
References: <cover.1546553515.git.ottosabart@seberm.com>
 <cce5f338791563e31c0b4702cedce35d66959fbc.1546553515.git.ottosabart@seberm.com>
 <20190105.141516.1525542484975135006.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <20190105.141516.1525542484975135006.davem@davemloft.net>
X-PGP-Key: http://seberm.com/pubkey.asc
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05. Jan (Saturday) v 14:15:16 -0800 2019, David Miller wrote:
> From: Otto Sabart <ottosabart@seberm.com>
> Date: Fri, 4 Jan 2019 11:42:29 +0100
>=20
> > Update reference to checksum-offloads.rst file which was converted into
> > RST.
> >=20
> > Whole kernel code was grepped for references using:
> > $ grep -r "\(segmentation\|checksum\)-offloads.txt" .
> >=20
> > There should be no other references
> > to {segmentation,checksum}-offloads.txt files.
> >=20
> > Signed-off-by: Otto Sabart <ottosabart@seberm.com>
>=20
> Probably this should be combined into patch #2.

Yes, this makes sense.

I have just sent you v2 of this series of patches where I combined
patches #2 and #3.

Thank you for your review!

Ota

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEb6VOpv2s03VHGoilgjuumfi+HjwFAlwxPwYACgkQgjuumfi+
Hjwg/hAAo7yDUE4jiss2r+wgrmlC8lM/YhOqmX3JHTKrGrhun2KlgHUeAGQ4YIwg
5bFY3R3QkiB4bn50o0jIonnptM/bycZGYZwO8J39ZV0eyezw68KjseZgXE8GdCik
WgEZNIRFSTmHvDhlsA6W7ofnIDhAqPEyl6eD/4EEXjWL5ByAvFKHG+PoHx0AOG//
FVpGPAN+thedj16vpyI80UHPbp5g2wIFSWmYDSgSccWHrKmosbSPSQtpu2deVWBF
8rglWcxpB4TzmMzZAtH5IvQg9g9dtzhH33ZljinJHlGUMUsvgIU0EQQZ2iMXH1WP
aQyYXclsKeXxVylKeyiepzX5VUEXZ8eok8LAgmcJOiTv/aExzPOL8gJbb5trHVWC
N+WejI/lD/IfNAqcqJto1L+lXj5Ujh8LiArhzfkxadC284vaxz+uuQpARiUukB0/
0UxG/JNihAFxtiu4GOYqPkbpZ5RZjbCwn1CEF0/2QrnGYEU3AIELuK/pGpJtQY/p
TGlL9DlTmhKJywLFIhWkIqciUyyTDdn6byKFxTORgXsrkr4CFCfpBrcHynbCHUdI
l7nDri0NkBsvbBPHzJCqJHJxlPWKc6Al/zAjig/+v648Ci0xuHdMJUt5gBX7hWAJ
oA8mx3UaUPG6HWyXJ2OXgy7flxMTl0bP7K4Zbh/JyP1Lectw8w4=
=ytIo
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
