Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753418AbeCNIDV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 04:03:21 -0400
Received: from ozlabs.org ([103.22.144.67]:43469 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753190AbeCNIDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 04:03:18 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 14 Mar 2018 19:01:37 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: please clean up the clockevents tree
Message-ID: <20180314190137.3704602b@canb.auug.org.au>
In-Reply-To: <ce514c90-f9ec-fc9e-e205-cd822cd766b2@linaro.org>
References: <20180314100213.61168207@canb.auug.org.au>
        <ce514c90-f9ec-fc9e-e205-cd822cd766b2@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/uJA0QYGPf4LPxYtqkojBPTO"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uJA0QYGPf4LPxYtqkojBPTO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Wed, 14 Mar 2018 07:56:00 +0100 Daniel Lezcano <daniel.lezcano@linaro.or=
g> wrote:
>
> On 14/03/2018 00:02, Stephen Rothwell wrote:
> > Hi Daniel,
> >=20
> > The clockevents tree appears to only contain an old version of patches
> > that have been committed upstream.  As such, it is only causing conflic=
ts.
> > Please resync with your upstream tree. =20
>=20
> Done.

Excellent, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/uJA0QYGPf4LPxYtqkojBPTO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqo1uEACgkQAVBC80lX
0Gxmlgf+NM3gNSxo75j2JdE+0da8nmZo+VyjTXVtE7PtWe/P+yqdBiJiZbIPeMR9
8NyUHQHJNCq1Bz0bY7ZyrrfC8a+4BURzWqb+jUSwrzTUbcrfWpQgYvPdG8Kq/ODf
+AQ9+kjvhiPixYmo5UVSlt/RAgdNPIIC2W9qFHHT7FyY8IfG/x7wmIQe1AxJbsh8
S4MRk8R7uwLK+tffPSVOA2uqyxw5TKJgKasZaFlPcugE8UCNDuA8e1VtLJtLW2pf
7GERkxEKeERCJR7M1n1OmsmLoJ+d/Wzd0IfZnQab/uzOHIwl0m+WXDQ1wSiDtPwI
Bmv3ni7447ayLcaNUqBXm5F0jfKRkQ==
=ETQm
-----END PGP SIGNATURE-----

--Sig_/uJA0QYGPf4LPxYtqkojBPTO--
