Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756088AbeEIIFw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 04:05:52 -0400
Received: from ozlabs.org ([203.11.71.1]:57409 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753176AbeEIIFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 04:05:49 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 9 May 2018 18:05:39 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dan Williams <dan.j.williams@intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: linux-next: manual merge of the nvdimm tree with the jc_docs tree
Message-ID: <20180509180539.57a360e7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/CFTcfMTfJTvKN5E_E/+YXpl"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CFTcfMTfJTvKN5E_E/+YXpl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dan,

Today's linux-next merge of the nvdimm tree got a conflict in:

  mm/hmm.c

between commit:

  ad56b738c5dd ("docs/vm: rename documentation files to .rst")

from the jc_docs tree and commit:

  737b47a6db70 ("mm, dev_pagemap: introduce CONFIG_DEV_PAGEMAP_OPS")

from the nvdimm tree.

I fixed it up (the latter removed the comment modified by the former,
so I just did that) and can carry the fix as necessary. This is now
fixed as far as linux-next is concerned, but any non trivial conflicts
should be mentioned to your upstream maintainer when your tree is
submitted for merging. You may also want to consider cooperating with
the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/CFTcfMTfJTvKN5E_E/+YXpl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlryq9MACgkQAVBC80lX
0GzqBAgAmIQuKqmX3EhZvCh7xwT4qmOnxSQcpkqfx4MmaJ/eOF01+lomAkQ159I1
qJx9VQyQJ5rV5vj/VDVBM4SDSqWrR/GH3Vy2Jh3PZGtVqh6mogDMFlAv32O8yMZr
RDnFw3q27v5zCl0vLtJ9Us+cD5it7D9jqnkR3a0nSDsXCNOnOrpDDgShlmmEUCwI
K3HJuakwhoW3is2w9nqGylulkTB9XG3y2amx2M3uSZ3vG7q4SScH0vNA/LRuRxj1
rNmui0+UzG5nC6oU6h5YStilneWEmcOSp5gPaTbCA3MTNKDI+bPZFQLiz739atFw
8RnHAn8R8HlMPVRhTCwvl7hV6Pfaqw==
=SJX8
-----END PGP SIGNATURE-----

--Sig_/CFTcfMTfJTvKN5E_E/+YXpl--
