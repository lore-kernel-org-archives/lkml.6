Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B55C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E932082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1E932082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbeLJTGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:06:55 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:46080 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726324AbeLJTGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:06:55 -0500
Received: from office.codethink.co.uk ([148.252.241.226] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gWQtI-0000OK-Su; Mon, 10 Dec 2018 19:06:52 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gWQtI-0005pJ-2N; Mon, 10 Dec 2018 19:06:52 +0000
Message-ID: <d17c45bcaf44c02fa716c2dc862119278e0262ca.camel@decadent.org.uk>
Subject: Re: [PATCH 3.16 000/328] 3.16.62-rc1 review
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org
Date:   Mon, 10 Dec 2018 19:06:41 +0000
In-Reply-To: <20181210165414.GA25566@roeck-us.net>
References: <lsq.1544392232.713909046@decadent.org.uk>
         <20181210165414.GA25566@roeck-us.net>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-Y9wkW1Lv/DjJAH21shRQ"
User-Agent: Evolution 3.30.2-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Y9wkW1Lv/DjJAH21shRQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-12-10 at 08:54 -0800, Guenter Roeck wrote:
> On Sun, Dec 09, 2018 at 09:50:32PM +0000, Ben Hutchings wrote:
> > This is the start of the stable review cycle for the 3.16.62 release.
> > There are 328 patches in this series, which will be posted as responses
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >=20
> > Responses should be made by Fri Dec 14 18:00:00 UTC 2018.
> > Anything received after that time might be too late.
> >=20
>=20
> Build results:
> 	total: 136 pass: 135 fail: 1

This is the i386 perf build which never succeeded yet, right?

> Failed builds:=20
> 	i386:tools/perf=20
> Qemu test results:
> 	total: 219 pass: 219 fail: 0
>=20
> Details are available at https://kerneltests.org/builders/.

Thanks for checking.

Ben.

--=20
Ben Hutchings
Beware of bugs in the above code;
I have only proved it correct, not tried it. - Donald Knuth



--=-Y9wkW1Lv/DjJAH21shRQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlwOuUIACgkQ57/I7JWG
EQkOkBAAxY+M5gGvl5rVOXxIbeYPkNsSIGE7zrnXVMD/aKyQsAGvRQ+FO5oA/5g5
WUxKX+BuopbHj5XytWLQheQhM/M0PEEZT4o+a1UhWacXMEobZ33o9KZAqhlAt6NF
jhjfPMMu3Oa/+NKfajzX0gPthmrr2Y4VRUK9ooWUzDQlRdYEpV05eSRxBW16HSbZ
iDzUyA6BKP+KrDKUAas97nZJWLAGUdBu/OzIPvXa1N5pOL4q6LRzrmbgKJEHp/6h
BdDpERqggEmveAwesasA+7gGjPYnoEMMvSW/Xojs/ybf7hzyeCtMsgIRb6msmLM0
0c11vweyp61RtEoRwmDqqkCBD7bPjenvLO7sAqxWFbhvyv/90uq86hDKpruEpHKv
5doOEiJd39zmSGvnB3aSTmNzvTZYvfr7IEDM76yasCVm4O7jCVPbwaMjEM9k1UX6
mLXbwHNMfn74r4LPdNeGtQAY6qb9g3Ui0bJCODbDw806u+Kl/PXRoyFQZIqK9dsi
J4q8FC0uuJoM6CTIebGgDK7hBMskDMKiSImBGstmk/gtoKCnuQ4hPVp7R1Wvt/qm
kNSH0ROC5QuPWcvF5gAC8Dbzt5XkbpETdbNnur7LwdOwn/LO1+2WhiHiBNjc363P
UxUPYnLgxotepWqTMjpL+JykAQaSzHKhkbUj/D0jitbmzJX78A4=
=xWtx
-----END PGP SIGNATURE-----

--=-Y9wkW1Lv/DjJAH21shRQ--
