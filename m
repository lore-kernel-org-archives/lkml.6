Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D830AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E5C21924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732550AbfBOPi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:38:29 -0500
Received: from sauhun.de ([88.99.104.3]:34556 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfBOPi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:38:28 -0500
Received: from localhost (unknown [195.52.228.164])
        by pokefinder.org (Postfix) with ESMTPSA id 6E7C42E3551;
        Fri, 15 Feb 2019 16:38:26 +0100 (CET)
Date:   Fri, 15 Feb 2019 16:38:22 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-i2c@vger.kernel.org, linux-tegra@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] i2c: tegra: change phrasing, "fallbacking" to
 "falling back"
Message-ID: <20190215153822.oszldcxoxk2mssli@ninjato>
References: <20190215153126.18575-1-colin.king@canonical.com>
 <20190215153245.GA7374@ulmo>
 <da6cdd39-b021-7834-f3a4-46feceeb66c4@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6pztjuawutxj44df"
Content-Disposition: inline
In-Reply-To: <da6cdd39-b021-7834-f3a4-46feceeb66c4@canonical.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6pztjuawutxj44df
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 03:33:58PM +0000, Colin Ian King wrote:
> On 15/02/2019 15:32, Thierry Reding wrote:
> > On Fri, Feb 15, 2019 at 03:31:26PM +0000, Colin King wrote:
> >> From: Colin Ian King <colin.king@canonical.com>
> >>
> >> The phrasing in two dev_err messages is using fallbacking which
> >> os less understandable than "falling back", so fix this up.
> >=20
> > os -> is, otherwise:
>=20
> Oops, can that be fixed up when it's applied.

Yes.


--6pztjuawutxj44df
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxm3OoACgkQFA3kzBSg
KbZ2+A//V8yxCnyJ34e2GPkX+XQ9xnbos8BNwpHpU4ilnMujqO5Kxd5oJRX15PR7
L7EniEzKHnXpHXO6Sfwl7Rr4K2fOmcobkjsHSISVZhMFcjkoAHkgldsbx2R0PUz2
LcZcujSMXimHZktW+ypDwDS505WKsUm0fUkmW0+MCiEVCAPs+o4OutipbpQOz2jm
e0SrlGjeeSWkb0/Sf3aXOKngCkAakRBW3uVZT1ddt2JNZK2+OsSrhxXd/BU8uCzq
jB33DcO5aR+scdHoC8wB4dec8i96HD9D8yL9X9PDa/U8vhCNGe54dJKdLyDA8vVr
MAdnZt/AGnYJ0PsINE9QG8NFafWul5Ovi4YOAR6hDP7Gbt1fGJs2QtUYPfsrnkPY
nlvZUuPsjiwNGTkY52zqHG8wCKG+QMV8NhMlGLBOusGHD0N9Fmt3V0KcarYH9Pxd
g7Ln1vwQqu8mM6gPPC+tWOEcGnyPD4oHeOIayzLWs3N2tJ4WFxc0OYZeFLABXFST
TexeX/9BYxX4Z1U+WE/dgAslbAS+mhctaGTGOdifaQBHsxN92b7Nqbet1qoB60cT
t952/VlgIx0jz2OKNFVHCK+2kUGfkAoXX9RASOhoi/6RFnO+qaSBxC2hZiq+lAkk
OvZcuA5fLKDODePqq54W9Wzr4CF9iqIA5MpCGfgim2BRzKbRvFo=
=+6Od
-----END PGP SIGNATURE-----

--6pztjuawutxj44df--
