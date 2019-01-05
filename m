Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8356CC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 12:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B2F32070D
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 12:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfAEMbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 07:31:50 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52251 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfAEMbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 07:31:50 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id D8BD78076B; Sat,  5 Jan 2019 13:31:42 +0100 (CET)
Date:   Sat, 5 Jan 2019 13:31:46 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Vesa =?iso-8859-1?B?SuTkc2tlbORpbmVu?= <dachaac@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH 2/2] leds: lp5024: Add the LP5024/18 RGB LED driver
Message-ID: <20190105123146.GA16354@amd>
References: <cd90f179-6c16-823f-496f-27f141e9c322@ti.com>
 <a72c11c0-949b-bdbc-df2c-4490e04a1065@gmail.com>
 <986b5105-2fdb-bd25-7c8a-ca8fd1ade821@gmail.com>
 <7f205102-e854-f1cb-cc03-1307d1cddc87@gmail.com>
 <c9f8965a-90f4-b456-8225-c70694c9f071@gmail.com>
 <cf6c0025-36e7-197b-b27a-1f31fb45cc38@gmail.com>
 <20190104201256.GA2931@amd>
 <a4e3a782-de76-ba91-3727-4db69cf27c3a@gmail.com>
 <20190104220726.GA12395@amd>
 <4cf79414-578e-eea7-4f46-fc8789206988@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <4cf79414-578e-eea7-4f46-fc8789206988@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> >We will need to solve RGB leds somehow, hopefully this is solved with
> >it.
>=20
> When? With this attitude we will procrastinate it forever.
> It's been almost 3 years since first HSV patches.
>=20
> I proposed rough design of LED RGB class interface in [0].
> If you find it totally flawed, then please spot the problems.
> If not, let's improve it and implement.

That is fatally flawed, and inferior to the HSV patches, sorry...

Grab yourself an RGB LED and play with it; you'll see what the
problems are. It is hard to explain colors over email...

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwwo7IACgkQMOfwapXb+vKHNwCfXSjYskqmRYzSUngUV79UyvWJ
lgcAnRSNc7ISOocGNdyrWZ/TAtf2XXK6
=4/oy
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
