Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4B4C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 16:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011C920833
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 16:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 011C920833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbeI3XdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 19:33:22 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55818 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728192AbeI3XdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 19:33:21 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6f48-0002qw-SB; Sun, 30 Sep 2018 17:59:32 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6f43-0005wH-L1; Sun, 30 Sep 2018 17:59:27 +0100
Message-ID: <577a4c24a53ec779cf8f6b02b3fe3bd3641ac4ac.camel@decadent.org.uk>
Subject: Re: [PATCH 3.16 000/131] 3.16.59-rc1 review
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org
Date:   Sun, 30 Sep 2018 17:59:16 +0100
In-Reply-To: <c10b2127-8db4-4d52-d03c-3139dca51f43@roeck-us.net>
References: <lsq.1538257386.330095874@decadent.org.uk>
         <c10b2127-8db4-4d52-d03c-3139dca51f43@roeck-us.net>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-18aRA91jf9FJOmf1h9TW"
User-Agent: Evolution 3.29.92-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-18aRA91jf9FJOmf1h9TW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2018-09-30 at 07:06 -0700, Guenter Roeck wrote:
> On 09/29/2018 02:43 PM, Ben Hutchings wrote:
> > This is the start of the stable review cycle for the 3.16.59 release.
> > There are 131 patches in this series, which will be posted as responses
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >=20
> > Responses should be made by Mon Oct 01 21:43:06 UTC 2018.
> > Anything received after that time might be too late.
> >=20
>=20
> Build results:
> 	total: 139 pass: 139 fail: 0
> Qemu test results:
> 	total: 217 pass: 217 fail: 0
>=20
> Details are available at https://kerneltests.org/builders/.

Thanks for checking.

Ben.

--=20
Ben Hutchings
Who are all these weirdos? - David Bowie, on joining IRC



--=-18aRA91jf9FJOmf1h9TW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAluxAOQACgkQ57/I7JWG
EQn7kBAAlz30vhavZ/fFd8tLpKeqGE4f08wYbV9XTei5lxJg9APl5pVF5RSo0uta
rzqCN2GAxrAZR7NbrssUXvFzrBhOtQNuM7OVgL28OVvft/n7q82TCIskjQsHmogP
Mv+n0hQRL99rCqrYjh5EiU4+GHIvvchUByQGAuvpu2Nu8eKwYaocRXhQtBukhvbV
Ib5g+sSkbN01zq3t0Vv/ijgU/7qhpqX5Q2gBRHhHRfBhvIbUaqeSJzj3TSdQjdXu
10EfkEyYQ08xE5f/6vgMo7BsbvgYnLnsKqhSG375hQgUCVA/zZ21p9+E9JtQiyZ0
TPxI+OqOwWmyskzBWMMkrA9bfnyd/8+h7DWoYrwei+7c8nkjiiY+9q1l3R36cM9r
JsZcXib7JkFLyTUENstYkHRjJDWLa+T2YzpXs/ZeLeD5N/r9oLdKYXdIol5GVKe2
5UiaVRfjTtmOfnkvfWZbQReTr9ILoufLZyxhfln7KuKuergXFKyXgzXghhfiJVVF
1YaTLe3+pxnbpnuHCbe3CmIGNIb7ZELYLwex1lPrBocEUB8W3pO/7ntzUGIfg0PA
++HVUBm4KTIUr5Jxs/Py5D/o56q2abwyk+KrMJGQzllOYs3Gk9GmL/ZKmDqJTzDS
ql988hhvx69zaUzOWNRwUNrgoobZ4ASOitn5D/sNK9eiK9SegmE=
=5k1I
-----END PGP SIGNATURE-----

--=-18aRA91jf9FJOmf1h9TW--
