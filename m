Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751868AbeCZI6A (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 04:58:00 -0400
Received: from ozlabs.org ([103.22.144.67]:54475 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751042AbeCZI55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 04:57:57 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 26 Mar 2018 19:56:53 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: linux-next: manual merge of the akpm tree with Linus' tree
Message-ID: <20180326195653.03f3e089@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/XYFIgnyBgIktwGfQkVuOKmX"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XYFIgnyBgIktwGfQkVuOKmX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Today's linux-next merge of the akpm tree got a conflict in:

  ipc/mqueue.c

between commit:

  cfb2f6f6e0ba ("Revert "mqueue: switch to on-demand creation of internal m=
ount"")

from Linus' tree and patch:

  "ipc/mqueue: add missing error code in init_mqueue_fs()"

from the akpm tree.

I fixed it up (I dropped the akpm tree patch) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/XYFIgnyBgIktwGfQkVuOKmX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlq4tdUACgkQAVBC80lX
0GyWpAgAgXvks2BRABEbbD/WiipAKZjXuAqiVOMYKovX8G9vjLBYA5jgo75/vHjA
/lslusZZ+GibpFTsIML68kcgxkxxKYSeaVpaJSI6iSGILsXfOpX5Ixx2NYrrs8jR
1v81fTGACKcJ15I4q2fwAQ7rl4V+xoG2auun0p6/sWIJQnunKSi+6KodntwJx0a1
Hacch8pMN7vqvv7W8FhFmStXnZ1GR+5v4Is/BBdCqlJp3maQKWGYNEXDxL9bh5tl
ZEf0xc5/1qizRexQLIg7nhWEXdjh03fBUj4Z3r2dcpy8YEKVfkjDzF7BcrzsWLDI
xJeOxCG3GduVUxA7kLfTacKkqh2Pyg==
=TF02
-----END PGP SIGNATURE-----

--Sig_/XYFIgnyBgIktwGfQkVuOKmX--
