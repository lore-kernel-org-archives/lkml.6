Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DB9C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 00:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 908B020989
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 00:09:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 908B020989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbeKKJz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 04:55:56 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:42348 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725896AbeKKJzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 04:55:55 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLdJM-0005e9-06; Sun, 11 Nov 2018 00:09:08 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLdJL-0003dn-Rn; Sun, 11 Nov 2018 00:09:07 +0000
Message-ID: <bf66aa7e856d4c2c83dc78dca95eee76437a1513.camel@decadent.org.uk>
Subject: Re: [PATCH 3.16 000/410] 3.16.57-rc1 review
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org
Date:   Sun, 11 Nov 2018 00:09:03 +0000
In-Reply-To: <945ce3bb1ecd9c70249e79d2cb5572f9475c9786.camel@decadent.org.uk>
References: <lsq.1528380320.647747352@decadent.org.uk>
         <20180608141426.GA5242@roeck-us.net>
         <945ce3bb1ecd9c70249e79d2cb5572f9475c9786.camel@decadent.org.uk>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-bV4Ouag1LamKcT2DGWqJ"
User-Agent: Evolution 3.30.1-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-bV4Ouag1LamKcT2DGWqJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2018-06-16 at 22:18 +0100, Ben Hutchings wrote:
> On Fri, 2018-06-08 at 07:14 -0700, Guenter Roeck wrote:
> > On Thu, Jun 07, 2018 at 03:05:20PM +0100, Ben Hutchings wrote:
> > > This is the start of the stable review cycle for the 3.16.57 release.
> > > There are 410 patches in this series, which will be posted as respons=
es
> > > to this one.  If anyone has any issues with these being applied, plea=
se
> > > let me know.
> > >=20
> > > Responses should be made by Thu Jun 14 18:00:00 UTC 2018.
> > > Anything received after that time might be too late.
> > >=20
> >=20
> > Build results:
> > 	total: 138 pass: 136 fail: 2
> > Failed builds:=20
> > 	i386:tools/perf=20
> > 	x86_64:tools/perf=20
> > Qemu test results:
> > 	total: 116 pass: 116 fail: 0
> >=20
> > tools/perf builds are new, so it is probably not entirely surprising
> > that they fail.
> >=20
> > Deetails are available at http://kerneltests.org/builders/.
>=20
> Thanks for testing.  I see you've now made the tools/perf builds work
> for 3.16, so thanks for that as well.

I looked again and for the current patch queue I see:

    Building i386:tools/perf ... failed (script) - skipping

    Building x86_64:tools/perf ... failed (script) - skipping

I can still build it here in a Debian jessie environment though.

Ben.

--=20
Ben Hutchings
Kids!  Bringing about Armageddon can be dangerous.  Do not attempt it
in your own home. - Terry Pratchett and Neil Gaiman, `Good Omens'


--=-bV4Ouag1LamKcT2DGWqJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlvncx8ACgkQ57/I7JWG
EQm3dRAAstmwybgq51DIXXqUnretYBViT6gfagvlIBfozlI3c78pTj2sJhtym5Ei
pHguvudos7I0SKja8ZlHoOH4UrJUgGWfcgVFMTMtvgMVF80qJKgm8H5h5zXUiPPA
e6ACF7IhB+SvkPvMrAFP5ZCyFdB/X3dfVmor5/B+bR5cdA15swHdbGJaeqwMtw6z
2qSUyBMaG1oJIjAsR9/EHWlw50A5uwXDwOnYL7G3DJSZdOqytarswQDLS1Ic7a2N
0rtdhuqOXyNsYVucvL4CoDvvSEkXMsgu/1z8qlX8J2SjDQrKE1c+ZxRcWW1wbS6o
/kcIvmRbaxoH/eo0nZ2TWemxbIlVoJpGbQfefRT+81z15bQwuR2lrB3XXLX876rT
0HARP1XFw2DrfCpC1cWVp2tSPbDfP6T0HIs1P0/eo7kjYc6PhzB9zwu2WV5RVafZ
CeG3/iVWR7dpS+7Etv8QTZo38ROQvoFVhq3nqeOXtNW1p0bD1+HJe+pAO5kNqx81
8YGXvZhZsCn77jLfW7S/bGNp/SFYTv5KQvTzHf1O/5imLpRUq7dD6G+hKWuY85bR
S5flnCqpxFQfB6CopdFzRpp1mNpkTXside/Ic+fLwLIgEjYfi3XRwjFJCj2x0Fff
4gUKs5b3quR0i0OZOdj/GiWI7abtPDLi/wEWilvsxUmG+yh/3hg=
=VtKg
-----END PGP SIGNATURE-----

--=-bV4Ouag1LamKcT2DGWqJ--
