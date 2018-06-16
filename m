Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F01C5CFC0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 21:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C29620891
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 21:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C29620891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933444AbeFPVSc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 17:18:32 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49065 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933331AbeFPVSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 17:18:31 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fUIab-0002JV-UF; Sat, 16 Jun 2018 22:18:30 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fUIaV-0003pU-Ub; Sat, 16 Jun 2018 22:18:23 +0100
Message-ID: <945ce3bb1ecd9c70249e79d2cb5572f9475c9786.camel@decadent.org.uk>
Subject: Re: [PATCH 3.16 000/410] 3.16.57-rc1 review
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org
Date:   Sat, 16 Jun 2018 22:18:19 +0100
In-Reply-To: <20180608141426.GA5242@roeck-us.net>
References: <lsq.1528380320.647747352@decadent.org.uk>
         <20180608141426.GA5242@roeck-us.net>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-YuJ04BwlFxvudu+pyt2/"
X-Mailer: Evolution 3.28.2-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YuJ04BwlFxvudu+pyt2/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-06-08 at 07:14 -0700, Guenter Roeck wrote:
> On Thu, Jun 07, 2018 at 03:05:20PM +0100, Ben Hutchings wrote:
> > This is the start of the stable review cycle for the 3.16.57 release.
> > There are 410 patches in this series, which will be posted as responses
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >=20
> > Responses should be made by Thu Jun 14 18:00:00 UTC 2018.
> > Anything received after that time might be too late.
> >=20
>=20
> Build results:
> 	total: 138 pass: 136 fail: 2
> Failed builds:=20
> 	i386:tools/perf=20
> 	x86_64:tools/perf=20
> Qemu test results:
> 	total: 116 pass: 116 fail: 0
>=20
> tools/perf builds are new, so it is probably not entirely surprising
> that they fail.
>=20
> Deetails are available at http://kerneltests.org/builders/.

Thanks for testing.  I see you've now made the tools/perf builds work
for 3.16, so thanks for that as well.

Ben.

--=20
Ben Hutchings
The generation of random numbers is too important to be left to chance.
                                                       - Robert Coveyou


--=-YuJ04BwlFxvudu+pyt2/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlslfpsACgkQ57/I7JWG
EQmmjxAAqS7RcpzXOU4iN8kuD4K+cVaC7jUMLs7enNcE+lGyBtpN5tWnSCtXwKJ5
exJ9cJhQ9KhK7cPhfhOpFdpfG7kA3C3rymnTAhkiGO5MTRDOGVfmCmV2Totf31WL
7ONKGhgvBM5zX/OfhvuDL//v1Es7Z9dJeup55sg4MWCCUiIN9vnPQZesOkZB08gX
pJmfLIXT5vtMdfexJWGOjx2T0a4bDbbdhg5wlWsFs+0laR2GfU5ZGrOZSmXoxRGX
O9ADjrW9Qs+vUlYQCf87NruAH12QM1xKmCgxkLMNnxbuc0P7LJ7/GwqPbpzjxEFI
BGYWtggnNxdYKlQYqZxVvpOgWpLUqceDD3PjrnIJnzrBUiUyc4ufJDeLOlZcfYnU
sRokwqAfsLY4BWIst55zWasJgbwfUh6Ny2+l9lIEQGYiglPGSsOaRObPSIC4tAoj
JIK9ayfl9r8Vj8kUVK75sjIiV0kmPpzttouSbP49ZRZCnVD8lLheCYIEsvBEqiXa
yqaQ1vEs7TmgL6UOZdD58kY61ZFej2jLaFWBV+GTvRuNQ6Y03t4XyiXeddHn58J9
RPK2rPbNMEotLvzIkObHk7Yz8Tj7mXJgui1CxcztMK+bEemr7i3TJqMm5Mcc1ipF
+2NPNsGk+R+mlH63QEpuu6xFBMFjg8MtVEx0sKwOar7RwzTwNLo=
=FXku
-----END PGP SIGNATURE-----

--=-YuJ04BwlFxvudu+pyt2/--
