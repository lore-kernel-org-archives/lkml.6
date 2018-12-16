Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4180C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 21:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 722AD206A2
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 21:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730868AbeLPVga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 16:36:30 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39234 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727256AbeLPVga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 16:36:30 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gYe5L-0000Gz-QM; Sun, 16 Dec 2018 21:36:27 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gYe5L-0004k5-Ls; Sun, 16 Dec 2018 21:36:27 +0000
Message-ID: <8ef0b3270592b15424cea895d6517cfec2d71b1f.camel@decadent.org.uk>
Subject: Re: [PATCH 3.16 000/328] 3.16.62-rc1 review
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org
Date:   Sun, 16 Dec 2018 21:36:16 +0000
In-Reply-To: <20181210203611.GA15708@roeck-us.net>
References: <lsq.1544392232.713909046@decadent.org.uk>
         <20181210165414.GA25566@roeck-us.net>
         <d17c45bcaf44c02fa716c2dc862119278e0262ca.camel@decadent.org.uk>
         <20181210203611.GA15708@roeck-us.net>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-bEbjTC2GwaCFwx/gkiYP"
User-Agent: Evolution 3.30.2-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-bEbjTC2GwaCFwx/gkiYP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-12-10 at 12:36 -0800, Guenter Roeck wrote:
> On Mon, Dec 10, 2018 at 07:06:41PM +0000, Ben Hutchings wrote:
> > On Mon, 2018-12-10 at 08:54 -0800, Guenter Roeck wrote:
> > > On Sun, Dec 09, 2018 at 09:50:32PM +0000, Ben Hutchings wrote:
> > > > This is the start of the stable review cycle for the 3.16.62 releas=
e.
> > > > There are 328 patches in this series, which will be posted as respo=
nses
> > > > to this one.  If anyone has any issues with these being applied, pl=
ease
> > > > let me know.
> > > >=20
> > > > Responses should be made by Fri Dec 14 18:00:00 UTC 2018.
> > > > Anything received after that time might be too late.
> > > >=20
> > >=20
> > > Build results:
> > > 	total: 136 pass: 135 fail: 1
> >=20
> > This is the i386 perf build which never succeeded yet, right?
> >=20
>=20
> Correct. Should I disable the test ?

I'll try to fix it, but not in this cycle.

Ben.

> > > Failed builds:=20
> > > 	i386:tools/perf=20
> > > Qemu test results:
> > > 	total: 219 pass: 219 fail: 0
> > >=20
> > > Details are available at https://kerneltests.org/builders/.
> >=20
> > Thanks for checking.
> >=20
> My pleasure.
>=20
> Thanks,
> Guenter
--=20
Ben Hutchings
If you seem to know what you are doing, you'll be given more to do.



--=-bEbjTC2GwaCFwx/gkiYP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlwWxVEACgkQ57/I7JWG
EQlSaBAAgW54eGgszPbcuslx+QjAaVn5wJrJKWV1J86Qj1uEELgyscsOjp2D8M2L
r7MvLHCPPFM2OAsrwNLQbxsSEQOzsEdkhneK0r6TjEmsSyn9wlnzxc8PMGbPdXFC
oIknXIflu4P39zbnb09FYzTh7HaQBG/VL+v6RGSEDUQtuogRHWcdh0ijCJc+rZyP
Y/dZ02B5XGYAwQ9/RzjSA7fsNUBmPEZk13nROl0BQ7LR56ZB0ELaaWxzXWEUqF1s
+ECuJ5gL5QJ133QOsTJxJgrodwgvPDfXv1CmFPzLfPh9PguQ5pFu/IbQe6C2Ww85
1gRjxN95Eda0rsjUkteqvWlIzfCsFQ/H7nHgTPq9iwHyc2GiGbHyxmM3vTfv/56h
Lhx1OLwsMtJ8MqaLVkbzMTzz+iuh5kVJvTKqk0aRFNL1A0q2Ybo2l6c10B8MAaqG
i6UjaIbKnc9CvT01b9Ubv81QjlLkw9NWwtKtHncIwDI0aQL97I2AIkaoHN/HX38o
GH0Itj0hHh8YKMlebUikMVkxLeu+/BAhVh2J7RLICJvimLBfnRw5H62UrOiQW2Pq
WmD9oFHVkSZ9+iS6dmmdjTv4HrjDGV1Q5VNBuQQoiF3CmdOFP6poluqzZbK6nrbG
NzRdeNXl3EivqLwYLw3q7gLW3rG5+8G7Wnj2GCnnyETTkPrd1QM=
=VGNW
-----END PGP SIGNATURE-----

--=-bEbjTC2GwaCFwx/gkiYP--
