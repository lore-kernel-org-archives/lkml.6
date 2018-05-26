Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031101AbeEZDb2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 23:31:28 -0400
Received: from ozlabs.org ([203.11.71.1]:56459 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031031AbeEZDb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 23:31:27 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Sat, 26 May 2018 13:31:12 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@mellanox.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the rdma tree
Message-ID: <20180526132829.0cbb8826@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/1dZX0jbVyoDaE/35gobvpOl"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1dZX0jbVyoDaE/35gobvpOl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  116aeb887371 ("iw_cxgb4: provide detailed provider-specific CM_ID informa=
tion")
to
  0252f73334f9 ("IB/qib: Fix DMA api warning with debug kernel")

are missing a Signed-off-by from their committer.  I presume they have
been rebased?

--=20
Cheers,
Stephen Rothwell

--Sig_/1dZX0jbVyoDaE/35gobvpOl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsI1QAACgkQAVBC80lX
0GybhQgAg3N/9/DTlAdDSRfpxZuVnMUpQF3hEIp0OnjNXx6+mAWykey/c4dhd7gE
HRNqyi8xRXp/QUBOfld9jUVN3vTtNpg25rXUZWC7Ht3sfo7XrSCleVQzccPvWDcs
FLGbWOPUvJH/wrVFm/C/usL4VsnK1vN8qvuMac9odEnyr/Gz8aebmk395wWE1Xvl
xKrgbzZdfeAZQzO113yJnbq14oAxTrrtpGE4avsb4/eeMvrxc0z0KMODCV9vuuXz
H1OPyo99fyq5a6+7wLGxhvellXnKzefNX1H0fB8p/pLF0/wttIRJSNRk7jOQ0tGi
6knuJz0TPA/XW88S7GHS8pkmGpsoJg==
=RSAu
-----END PGP SIGNATURE-----

--Sig_/1dZX0jbVyoDaE/35gobvpOl--
