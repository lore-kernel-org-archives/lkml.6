Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751775AbeFAMIi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 08:08:38 -0400
Received: from ozlabs.org ([203.11.71.1]:51687 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750790AbeFAMIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 08:08:35 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 1 Jun 2018 22:08:32 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Darren Hart <dvhart@infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Haruka Kawajiri <yukx00@gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the drivers-x86
 tree
Message-ID: <20180601220832.73ad5b84@canb.auug.org.au>
In-Reply-To: <CAHp75VeULdbi3_V8JPffYCocmGtjC3QPdE-yPz5eDrkpONeE-A@mail.gmail.com>
References: <20180601213639.74f49e51@canb.auug.org.au>
        <CAHp75VeULdbi3_V8JPffYCocmGtjC3QPdE-yPz5eDrkpONeE-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Jfq7zUrBopZb_3+mTsQdqW3"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Jfq7zUrBopZb_3+mTsQdqW3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Fri, 1 Jun 2018 14:40:35 +0300 Andy Shevchenko <andy.shevchenko@gmail.co=
m> wrote:
>
> Oops. What is the proposed fix for that? It seems we can't rebase
> published branches.

It's unfixable without a rebase, so you could instead consider it an
opportunity to improve your processes for the future. :-)

--=20
Cheers,
Stephen Rothwell

--Sig_/Jfq7zUrBopZb_3+mTsQdqW3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsRN0AACgkQAVBC80lX
0GwNoAgApc25YyXlEl+7CQTIbj6lj+MwSryOhctcuN0Fxvuq5iWFdmzTfIQVAt48
2bnWqD5qBdzC0b+1fjOeD7ouR+fypTQXStdCNuVFdkcc+guORsb9dxFVM8PXMmLD
25t99YGcHfc+t6ca5kwLWXqfZl/PQn8PwNdR4TZD4QuEEnmgjueRnitLzkLYwkFK
gv7eXkaSbB87pptuDxs0cbwPqxjS3rTxod3tlIZTx+akwap1cda/lA6IpWlt2DTO
nZmZ1/3lTz3kOFZYcFLK9KKzgP1WI/1pOAEtGHrOuOGsJPb5R68avIlNdGpqGj8w
+32IOBTyYPG7Sq+wEWXmahI0AdOT3A==
=Ik39
-----END PGP SIGNATURE-----

--Sig_/Jfq7zUrBopZb_3+mTsQdqW3--
