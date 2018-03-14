Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751729AbeCNWqs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 18:46:48 -0400
Received: from ozlabs.org ([103.22.144.67]:45757 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751131AbeCNWqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 18:46:46 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 15 Mar 2018 09:46:17 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arnd Bergmann <arnd@arndb.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the asm-generic tree with the syscalls
 tree
Message-ID: <20180315094617.7c2a11b0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/qkJ0JBwy.utBj.8=7wiOemP"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qkJ0JBwy.utBj.8=7wiOemP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

Today's linux-next merge of the asm-generic tree got a conflict in:

  arch/frv/kernel/sys_frv.c

between commit:

  17b923b234ed ("mm: add ksys_mmap_pgoff() helper; remove in-kernel calls t=
o sys_mmap_pgoff()")

from the syscalls tree and commit:

  fd8773f9f544 ("arch: remove frv port")

from the asm-generic tree.

I fixed it up (I just removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/qkJ0JBwy.utBj.8=7wiOemP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqppjkACgkQAVBC80lX
0GzjIgf8CMMBhePpFl+ZxK0uvdLwIw+jCaHJS6+h2n3SzM5JZTyIcCbWnbe/4ACj
SgGN7wxMoo8sM7BPv8m+bafXaWFXA+7hngL0YnF8/U74l80Zy5hc0A9cJV+qiqBA
82fc36cilOmE+J2ZOnhZovEGqOak7dmb9xWOoW1JLmwDg2oqHMx4JYRbvDUF5x3u
Jm2mPOBFcDU9wg8bfsjoRrqlLAHzBF+Qx71VbzXn/Gju/Iw5G5qdmXHbKBJLAQrU
tQarxqqF7PAemMGV2sS7WnlN2cVi7EaV7CieSNwZtywFUMZhSbuO0vvyf7z+wLAS
PETqPJ2oREW5mEZRPz+vMpfWRyQB7g==
=nylQ
-----END PGP SIGNATURE-----

--Sig_/qkJ0JBwy.utBj.8=7wiOemP--
