Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEDAC43612
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 17:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8F6218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 17:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfABRoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 12:44:10 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:48196 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726044AbfABRoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 12:44:10 -0500
Received: from office.codethink.co.uk ([148.252.241.226] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gekYp-0006TE-Eo; Wed, 02 Jan 2019 17:44:07 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gekYo-00062s-Qx; Wed, 02 Jan 2019 17:44:06 +0000
Message-ID: <d87d33d64801d1a397762aec911541216c4243b1.camel@decadent.org.uk>
Subject: Re: [PATCH 3.16 000/366] 3.16.61-rc1 review
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Johannes Pointner <h4nn35.work@gmail.com>
Cc:     linux@roeck-us.net, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org
Date:   Wed, 02 Jan 2019 17:44:01 +0000
In-Reply-To: <CAHvQdo3ysM2xcm_jC17pHiujCNTKSKo55Rnh9UrGAY+HTp8=Wg@mail.gmail.com>
References: <lsq.1541965744.387173642@decadent.org.uk>
         <20181113015707.GA5984@roeck-us.net>
         <CAHvQdo3ysM2xcm_jC17pHiujCNTKSKo55Rnh9UrGAY+HTp8=Wg@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-9y8fVNaneC0D0R9QtTuy"
User-Agent: Evolution 3.30.3-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9y8fVNaneC0D0R9QtTuy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-11-14 at 21:47 +0100, Johannes Pointner wrote:
> On Tue, Nov 13, 2018 at 2:58 AM Guenter Roeck <linux@roeck-us.net>
> wrote:
> > On Sun, Nov 11, 2018 at 07:49:04PM +0000, Ben Hutchings wrote:
> > > This is the start of the stable review cycle for the 3.16.61
> > > release.
> > > There are 366 patches in this series, which will be posted as
> > > responses
> > > to this one.  If anyone has any issues with these being applied,
> > > please
> > > let me know.
> > >=20
> > > Responses should be made by Fri Nov 16 18:00:00 UTC 2018.
> > > Anything received after that time might be too late.
> > >=20
> > Build results:
> >         total: 140 pass: 139 fail: 1
> > Failed builds:
> >         i386:tools/perf
> > Qemu test results:
> >         total: 217 pass: 217 fail: 0
> >=20
> > Details are available at https://kerneltests.org/builders/.
> >=20
> > Guenter
>=20
> Hello Ben,
>=20
> could you please include the following patch which makes it possible
> to build arm with gcc8
> a71ae0513c232c844009738af135a13e5d7e39c ARM: fix put_user() for gcc-8
> this is the version which landed in 3.18
> and also the following patch
> 430c3fdb11ec1f0af1eca28460c922b9c1eb2ac5 turn off -Wattribute-alias
> this also the version which landed in 3.18

I'm not sure how much point there is in using gcc 8 for Linux 3.16, but
these look harmless enough so I've queued them up for the next update.

Ben.

--=20
Ben Hutchings
Absolutum obsoletum. (If it works, it's out of date.) - Stafford Beer



--=-9y8fVNaneC0D0R9QtTuy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlws+GIACgkQ57/I7JWG
EQmquA/+Oh8C4W4VJlOP3x9GeHroy0XuN0PTFsf+LvWTKvzxzrjpRz6nn6Y0ahAZ
2WXd9SYLIuqLJqdy6hjOcX70uN6lATDGdzbbA2wQ2b/QpAxEksa1zNAnvIBnhss6
p1GLvpzjMT/yS+dMeGrqj8FXGGNgp74IsRTW5wB40iL/a5ZQxLqDY01gLawd1Jju
IMxpUQfVFBH0O6EnbiV1Ruz71LF/m5p87OVmwLKcnWm5SffSViLHwfI9BKKlmlid
u576Gtmy8L0nSKRjNIZqib2ry7AlNYL5wgFfBgumQmerveOpwF31LyN52E47gvUT
YMm8agWSGnKF1bqGM6xTC0wSHx0smIhBF51w/DtpNA37xdlZA3guEJq7aiBo/Nox
B8rVYifvsmelaJPmfL8+3/QOcsGDW03nO/6/CNXVTDxe+7MYZdm6Z0KHCt7Tv/Cb
iony0BLTaRCsOR4OqFCfy3cxDrfz/m85HMJLHruT6x+5Y+MshfRI2NSLz8QAlMMN
RX7joxQE3vCPKVChkIer1hgkTwwKuezEgssgpYE4lw1u3Fp78L4NM4jnZgZB3i1y
nlKYQMWSQgC1pwdTu4BRpD18NuEVdn6Dh7zl16FkGumVt04pioIJkvrRCvtZUnl+
9czdV7x39uKNG0ha7scCNXms3UwTsM/iGCm6G8in9obNILus3SU=
=9o2v
-----END PGP SIGNATURE-----

--=-9y8fVNaneC0D0R9QtTuy--
