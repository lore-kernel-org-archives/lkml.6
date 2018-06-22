Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03101C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA9A524606
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA9A524606
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934573AbeFVQr0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:47:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:47847 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933354AbeFVQrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:47:24 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2018 09:47:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,257,1526367600"; 
   d="asc'?scan'208";a="49777093"
Received: from jtkirshe-nuc.jf.intel.com ([134.134.177.59])
  by fmsmga008.fm.intel.com with ESMTP; 22 Jun 2018 09:47:23 -0700
Message-ID: <8ee37afa1023e8a9212ca98bc15311711993d531.camel@intel.com>
Subject: Re: [PATCH 4/4] Documentation: e1000: Fix docs build error
From:   Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Reply-To: jeffrey.t.kirsher@intel.com
To:     "Tobin C. Harding" <me@tobin.cc>, Jonathan Corbet <corbet@lwn.net>
Cc:     "David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 22 Jun 2018 09:47:22 -0700
In-Reply-To: <20180622003708.31848-5-me@tobin.cc>
References: <20180622003708.31848-1-me@tobin.cc>
         <20180622003708.31848-5-me@tobin.cc>
Organization: Intel
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-d3VEJ9yXn7cfpOZaT7Nf"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-d3VEJ9yXn7cfpOZaT7Nf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-06-22 at 10:37 +1000, Tobin C. Harding wrote:
> Recent patch updated e1000 docs to rst format.  Docs build (`make
> htmldocs`) is currently failing due to this file with error:
>=20
>         (SEVERE/4) Unexpected section title.
>=20
> This is because a section of the file is indented 2 spaces.  Build
> error
> can be cleared by aligning the text with column 0.  While we are
> changing
> these lines we can make sure line length does not exceed 72, that
> newlines following headings are uniform, and that full stops are
> followed by two spaces.
>=20
> Align text with column 0, limit line length to 72, ensure two spaces
> follow all full stops, ensure uniform use of newlines after heading.
>=20
> Fixes commit (228046e76189 Documentation: e1000: Update kernel
> documentation)
>=20
> CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Signed-off-by: Tobin C. Harding <me@tobin.cc>

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
--=-d3VEJ9yXn7cfpOZaT7Nf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiTyZWz+nnTrOJ1LZ5W/vlVpL7c4FAlstKBoACgkQ5W/vlVpL
7c5zvQ//VYHxNZxmpRHAHI4jncP9stSpoA0JxpgGA1O5EpqQG6Hr6jfRSuXwF4nI
amuFhmwI3+j13Teh7Ta6XlJL5F0umB4EhurxboQG16K07TBYmnelsO0n4EZ/HMcP
6XUnivTReOo4otoVQvFjLEaUzwUVRXcRE6KpcHBklXakq+uALF7rdxTGBlUudQhU
p+a1wur3qxqnVg3sy+SloRIbIvlJj3ieCNA2Jaz2q53z3Plydf9P2F5QUP/mgply
T/eirpK/mS1UZJfIoxs0Hb95uLp46X5kjfueXUTX+/MBGUPONJ3kLE01Nd6NN2bb
ac5A8BF0XuuO/D5jEiMSWpX6DxOTP1cMIIt+1AhQOHU/0ngBUK78B9LzHNeRM6t2
2Mps6FvzhnKKDodjHMEF2II0gXXiWcR0mtG/1wi7FKgEnPiateEelNQF5CJVEM44
Jdbd19vLicS8ytQ0YHeiYJCaGr/pBBRj0xlgkDqMVDxsKcuXQ+Ik+8n6lnVyqQgq
MdLPVDq83cVhT8EdHfBwqOxzhJMexbAKFm+9YZo4zobKh97yq51RJtQc/Dd0bpzB
ZvsjpYVeHWYXgDfIVUi5Xg+BNzu3rq9b7Z/1IBpF9E5WTLlw0bHpBlO+aVrL0ck4
abOwf5V3xRhMQTkeuIYunKdBc1EFRUUr9UkboDLYjkmB8dDzdHk=
=v/ru
-----END PGP SIGNATURE-----

--=-d3VEJ9yXn7cfpOZaT7Nf--

