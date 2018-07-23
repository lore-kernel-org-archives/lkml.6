Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12E0ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 752FB20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 752FB20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388179AbeGWWIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:08:32 -0400
Received: from www.zeus03.de ([194.117.254.33]:47096 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388077AbeGWWIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:08:32 -0400
Received: (qmail 26598 invoked from network); 23 Jul 2018 23:05:29 +0200
Received: by mail.zeus03.de with ESMTPSA (ECDHE-RSA-AES256-GCM-SHA384 encrypted, authenticated); 23 Jul 2018 23:05:29 +0200
X-UD-Smtp-Session: l3s3148p1@owhfAbFxxLggAwDPW8bjAAId4P/+oMhl
Date:   Mon, 23 Jul 2018 23:05:29 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] i2c: quirks: add zero length checks
Message-ID: <20180723210529.kvuu57jpdgmsipop@katana>
References: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
 <20180723202617.15230-2-wsa+renesas@sang-engineering.com>
 <20180723204418.GG1432@bigcity.dyn.berto.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zb5d6xp3oo53hkux"
Content-Disposition: inline
In-Reply-To: <20180723204418.GG1432@bigcity.dyn.berto.se>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zb5d6xp3oo53hkux
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Only build tested.
>=20
> Was this not tested when you also tested i2c-rcar and i2c-sh_mobile=20
> drivers? In any case I think this change make much sens.
>=20
> Reviewed-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>

You are right, of course. This text was added by a script and I forgot to
remove it :( This code was tested!

Thanks for the review!


--zb5d6xp3oo53hkux
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltWQxQACgkQFA3kzBSg
KbY2pQ//W7Fm+XWKAoXavMi9JC9SiqwNUN4+PF9X9wJfYWTWgXKuMim98ZInORhf
07EOEePR6CT+4gj07FVsaWckwK6JVVaoHi4xU0aFQf9eqh0kwkZmNUglPxPDshgi
yaBTdj7ILWGleVHYs0cxrs+dSJAFiaQiKgjxU153uDRQrp/3kGoB+9pgShlKDpNZ
tmIlugqwgfWB2kkSfBj5tYqk1YpzRMK7EsBhxZY2bCbIXGvgZKZKX84KcAKmkYMT
aMT+TQHMQ7FmIv+aiCrJ0bY8gsuBJRXxduzSMm0OO8llhtj3co/0Zuvy4YhGnK/5
P6/z2JTdwJOhno8mIjcK/NazvrZGEDYMDh1UZwaBJSjcoQJp6CJ8se8tqYgfmSf6
gHjsdZHEhZjuGkFFDYDMGRnapTohNQT+oY5cUM33RHO6G+ujNRSiNQgw9xaVpkWj
fzeeGOdycp+ju3LTG9aS//TtvYmgLv4LYhVJUlyOFqDbHhPoHULuQZj91cn+Il8f
iKkRK99w0BS5vsR3o+TENAFrRJYDPaFmbvp7uWNr1d7OHKS46PpEde+ZFqNws9W7
M9ife5K+rQBw2OWY3k7Di2skevsAr1fSikUygpwBTbeB1M33cAQur/L1tWIgNxK+
3oKUsb+h8nQnVDoDyCV7ML2dqrh8eKu/ILi2tD7BPv1HU3br/yw=
=WBf1
-----END PGP SIGNATURE-----

--zb5d6xp3oo53hkux--
