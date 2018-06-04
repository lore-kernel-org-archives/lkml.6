Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751855AbeFDAbX (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 20:31:23 -0400
Received: from ozlabs.org ([203.11.71.1]:53601 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751780AbeFDAbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 20:31:21 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 4 Jun 2018 10:31:04 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: linux-next: manual merge of the overlayfs tree with Linus' tree
Message-ID: <20180604103042.43fe18fe@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ObuA55/wXhkXoZl=D3CUkEq"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ObuA55/wXhkXoZl=D3CUkEq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Miklos,

Today's linux-next merge of the overlayfs tree got a conflict in:

  fs/open.c

between commit:

  af04fadcaa93 ("Revert "fs: fold open_check_o_direct into do_dentry_open"")

from Linus' tree and commit:

  e0e3f7de6435 ("vfs: simplify dentry_open()")

from the overlayfs tree.

I have no idea how to fix this up ... so I just used the overlayfs
version for now.  I assume that this will need more work before being
merged into Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/ObuA55/wXhkXoZl=D3CUkEq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsUiEgACgkQAVBC80lX
0Gx/eAf+MVEZvCWUex0LVL9GBbwVQBVfNghccQM4gMc1VMQ5T8TXYpcdn2muQmRP
8LIH5lB86d52AbtM6EfOiH/g2+0yz1rFehjd5tgM1kZMPR0JB/DsWUlcPAyEHPUQ
jJlO2cdXVxz5knCTbXLKATQRurPxBsq68xHzDMr0mH1LFS/LspWgDr81spG+3k3T
w/tCIkXkxL1Sk75nx9GChTCAaVngWcC6yqvw3/uKcJ+zvjTrIVZUcLXqpgrLvar3
LX81nN6G3xXqbuFDaRlXOz9SNcVnmy8/Xn26R1PqNoSMvOKwSJ97DQ6Wx+HQ/aOm
cNCZCmmU+bIbGyhqHFOqIoznkiUl/w==
=XTWb
-----END PGP SIGNATURE-----

--Sig_/ObuA55/wXhkXoZl=D3CUkEq--
