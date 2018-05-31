Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932587AbeEaAmZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 20:42:25 -0400
Received: from ozlabs.org ([203.11.71.1]:47577 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932451AbeEaAmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 20:42:24 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 31 May 2018 10:42:21 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Trond Myklebust <trondmy@gmail.com>
Cc: List Linux Next Mailing <linux-next@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Neil Brown <neilb@suse.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the nfs tree
Message-ID: <20180531104221.2a899269@canb.auug.org.au>
In-Reply-To: <CAABAsM5W+LsPD_+Fxi_3FePoCBThFjhx15seGA=iZFi-v0XtTA@mail.gmail.com>
References: <20180531072629.6e19241b@canb.auug.org.au>
        <CAABAsM7VZcJvtSnbebOAWEAZ7oTkV6JXJF=GxOj=zLYgjSGQ_Q@mail.gmail.com>
        <CAABAsM5W+LsPD_+Fxi_3FePoCBThFjhx15seGA=iZFi-v0XtTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/dY4Y5hJZIY0pcXzbwrlAYQT"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/dY4Y5hJZIY0pcXzbwrlAYQT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Trond,

On Wed, 30 May 2018 18:26:34 -0400 Trond Myklebust <trondmy@gmail.com> wrot=
e:
>
> Note that there is another known problem with that linux-next branch
> with the patch "NFSv4: Fix sillyrename to return the delegation when
> appropriate". You might therefore just want to drop that branch for
> today. It will be fixed up later tonight.

I used the version of the nfs tree from yesterday (which was empty).
Thanks for letting me know.

--=20
Cheers,
Stephen Rothwell

--Sig_/dY4Y5hJZIY0pcXzbwrlAYQT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsPRO0ACgkQAVBC80lX
0GxQKAf/Y5tfL+U/LLsUgRFZz/x5ZZJuuaLWjuLTZYjq174dGGu1Nh4SEOCU/TeT
+foc2yd1gYoiD1o85JStZWisModGB/Kq3VgYKtEpV/fbW+Jl9cbgrN1nmP0s2+2K
zsHAFqWI7NNd6r7NolHPBe2Zpf3GdIH3tD7qpQU9Lx5fg+Qrkjxp0EikAykk/4hz
kg6q63HI8Ra6HDOs2YLYCfMSlViKASE4pche/MWTbeXYs7oYPBE3JJY+Zrazr9Y/
wQs+oZvsLt8WXDvdhrxi/+rR4F10GuM9hMY4KyNGRnkulZs3orxhUcm8PPDM6jz4
T9w6ffxk+jhUefiGxGHanSv/b4PItg==
=2cfF
-----END PGP SIGNATURE-----

--Sig_/dY4Y5hJZIY0pcXzbwrlAYQT--
