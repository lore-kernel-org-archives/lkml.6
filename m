Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbeCOApc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 20:45:32 -0400
Received: from ozlabs.org ([103.22.144.67]:45261 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750779AbeCOApa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 20:45:30 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 15 Mar 2018 11:45:00 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Petr Mladek <pmladek@suse.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: linux-next: manual merge of the printk tree with the asm-generic
 tree
Message-ID: <20180315114500.65daa865@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/OtxR5x.c6h9/3nOL=632dUT"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OtxR5x.c6h9/3nOL=632dUT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Petr,

Today's linux-next merge of the printk tree got a conflict in:

  arch/blackfin/kernel/dumpstack.c

between commit:

  e7e57f690e38 ("arch: remove blackfin port")

from the asm-generic tree and commit:

  33251b634b4a ("dump_stack: convert generic dump_stack into a weak symbol")

from the printk tree.

I fixed it up (I just removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/OtxR5x.c6h9/3nOL=632dUT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqpwgwACgkQAVBC80lX
0Gymrwf/YqRsZ12whBM9rYfSWM92psUDAjRSoJKNtTjPCpHTGTvw67Knaq4oOqYl
b/MDfi2l6Dr+C3DNcztU8Vot3AE9U3p9MuJBlE93iVj7LC9Te5V8gi35aClvLo8e
z5OBDfNF8OA8GXdJ069WrS4Kp15ZvTT8Z18Cdg6S98knDL0QuoW/EnSlpkVx5yMX
nJhQ0+cW8z2ujhnvrCVHggzuzgwBFECSA6K7hdBCdBjfRP/RFqHHYo+n+I/f1/Kp
lGOEgvYHy9xxprpC9bOitvSHCvYN6NARqwP6RgQ37XqPquIPkEKznp43EaJnvI4G
LWgVcSzBaYjex31YUwos0q9Habab4A==
=p6ov
-----END PGP SIGNATURE-----

--Sig_/OtxR5x.c6h9/3nOL=632dUT--
