Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751526AbeCNWmc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 18:42:32 -0400
Received: from ozlabs.org ([103.22.144.67]:35721 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750779AbeCNWmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 18:42:31 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 15 Mar 2018 09:42:01 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: linux-next: manual merge of the asm-generic tree with the kbuild
 tree
Message-ID: <20180315094201.1a70ed2a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/yWusftHlzQ1Kd=d9sgQ=vlB"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yWusftHlzQ1Kd=d9sgQ=vlB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

Today's linux-next merge of the asm-generic tree got a conflict in:

  arch/blackfin/kernel/bfin_ksyms.c

between commit:

  4d9c7a5907dd ("kbuild: rename built-in.o to built-in.a")

from the kbuild tree and commit:

  e7e57f690e38 ("arch: remove blackfin port")

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

--Sig_/yWusftHlzQ1Kd=d9sgQ=vlB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqppTkACgkQAVBC80lX
0GzP3Af/eLZ5SfFORjbIuD5Hu5AZMpl/t9IckpR+dbh4p7YFJeNNjIBGfkFzFDEH
/2ilMFU5JN/vIowAvrrZUqqrQM6acUqBJCT+GWaLmQpy/mJkr57ggVL0+Hot4c4m
0bCTnEPmojOZaiTEFYznWQeWlrbdRxj2tn14KHEoly/XgMGMbqiB2SM9PjUz/FOn
0RQ95hvAEw9Pi2/Lfz9ZNGmPKStSzp2yJ1dL0HYe+NCg5e/0h+oJsXFs+8Br51FN
x2H+vJO6tz/sSASn3pz0n3QaUBOzkv1z9gCSW+84Zd/qkdvlHPOB1vmb8FB4Bu01
vqsF6uJ3q2QJOZGRpAM7xf17vYQq2A==
=rEOL
-----END PGP SIGNATURE-----

--Sig_/yWusftHlzQ1Kd=d9sgQ=vlB--
