Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934343AbeEIKZk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 06:25:40 -0400
Received: from ozlabs.org ([203.11.71.1]:47879 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933715AbeEIKZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 06:25:39 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 9 May 2018 20:25:26 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: linux-next: manual merge of the akpm-current tree with the jc_docs
 tree
Message-ID: <20180509202508.15c3435a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/PPonJBaV+v5qJfsODEkaV1x"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PPonJBaV+v5qJfsODEkaV1x
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  Documentation/features/vm/pte_special/arch-support.txt

between commit:

  2bef69a385b4 ("Documentation/features/vm: Remove arch support status file=
 for 'pte_special'")

from the jc_docs tree and commit:

  1099dc900e93 ("mm: introduce ARCH_HAS_PTE_SPECIAL")

from the akpm-current tree.

I fixed it up (the former removed the file, so I did that) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

BTW, it would be nice if the the question "Why was this file removed?" was
answered by that jc_docs commit message ...  I actually wonder if this
file needs to return (I have no way of knowing).

--=20
Cheers,
Stephen Rothwell

--Sig_/PPonJBaV+v5qJfsODEkaV1x
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlryzJYACgkQAVBC80lX
0Gz8hAf/TvC+bD7KgL4r1DkOQ5BmooBBuiPQMu1l1KpEecKp1zEQJZWHW+2edYI8
mtxMQXOjmPtwpJkpdMzcXT0BMfwIV3D43Tn6RDQH+aEawyx8JohfrDFzA0eVgf4P
SlQ02Q1b4fg7KV0riTEJeUCnbE6HCEQlJrAQQFzDzikRrOpTQrl72hLdXRGBje62
AC63sWvHAUFSVX389QijDjsitHW+cxCbwHYOpAwiTgUcysOckjSZPyBXoTZL/XoP
86Y0QkLiVVgnPp6covr7kBPATGyHP2DIAFestLEKf0xsaoijzG3ELmhywFS8aFFK
HIeZSBz8OrqCHFYpxbze9LxMmXZDVg==
=Zrib
-----END PGP SIGNATURE-----

--Sig_/PPonJBaV+v5qJfsODEkaV1x--
