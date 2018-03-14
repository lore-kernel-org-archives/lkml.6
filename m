Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751512AbeCNWpD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 18:45:03 -0400
Received: from ozlabs.org ([103.22.144.67]:46795 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751131AbeCNWpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 18:45:02 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 15 Mar 2018 09:44:30 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arnd Bergmann <arnd@arndb.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jesper Nilsson <jesper@jni.nu>
Subject: linux-next: manual merge of the asm-generic tree with the syscalls
 tree
Message-ID: <20180315094430.5d6f3e3e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/m5491f2i1Dk+uN.5ZT6YgZb"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/m5491f2i1Dk+uN.5ZT6YgZb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

Today's linux-next merge of the asm-generic tree got a conflict in:

  arch/cris/kernel/sys_cris.c

between commit:

  17b923b234ed ("mm: add ksys_mmap_pgoff() helper; remove in-kernel calls t=
o sys_mmap_pgoff()")

from the syscalls tree and commit:

  77b0b77f7812 ("CRIS: Drop support for the CRIS port")

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

--Sig_/m5491f2i1Dk+uN.5ZT6YgZb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqppc4ACgkQAVBC80lX
0GyjmQf+IdK/yKZI9TfHUudjvNJNZIBpXe4chtB80BP0ey6hpdF8e8usYC4cwlV1
ulnZp6EWjGRi0N0je1p0DcYWiDImJcAPOvJLoqXckck08jdgQ5mj1shwoPpA/hri
5wvohUFiiWWIVyLxbThPM2gfEPTidR0iw5ce2+BAcJm4vWNPDLq5Sv3rGXhq0MDf
HVd+aH+fcKTYqlzjsjr7z1O6noUECJbltuLJY3JvA0qyUrEICmc0XD1AfyrkK+XJ
IOiiPmoNg/2690vcDqE1F449XfP95GbBzmXqXqF3u/VI67Pe8NcRQZzNJ2Prxxxn
lneK1pEekR8Uvy2hCvEEvqpddZf6tA==
=mUBa
-----END PGP SIGNATURE-----

--Sig_/m5491f2i1Dk+uN.5ZT6YgZb--
