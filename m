Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751517AbeCNXvf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 19:51:35 -0400
Received: from ozlabs.org ([103.22.144.67]:55993 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751348AbeCNXve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 19:51:34 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 15 Mar 2018 10:51:03 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greentime Hu <green.hu@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jesper Nilsson <jesper@jni.nu>
Subject: linux-next: manual merge of the nds32 tree with the asm-generic
 tree
Message-ID: <20180315105103.421ba79c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/jWXUg2yC_59pO.EJnzcQN_Y"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jWXUg2yC_59pO.EJnzcQN_Y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greentime,

Today's linux-next merge of the nds32 tree got a conflict in:

  arch/cris/include/asm/io.h

between commit:

  77b0b77f7812 ("CRIS: Drop support for the CRIS port")

from the asm-generic tree and commit:

  c25a4f41b284 ("cris: add ioremap_nocache declaration before include asm-g=
eneric/io.h.")

from the nds32 tree.

I fixed it up (I just removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/jWXUg2yC_59pO.EJnzcQN_Y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqptWcACgkQAVBC80lX
0GzzOAf+Mk07lWURI6Co99GBerkcSEfQ0impK1PhYxucQ5N4UJymvgZzO1MEKZat
G73Qil4/Hmojp+osK+9pvs7RBj39g7Mhnql9x+8TPvJP1liSnpANz3/oL0/YnPMA
2Cf8IEGVRcwCDMk4nHTkq+8SMsRkJoQ+q67iUzY38NoLJ2+XRKdgqzp+JgVPCjxq
WXm9pT+SVhPLxfp1Z9zZsw7akXTAeQHc4JKJE/5xNd0ggcNiDNLAS5VlBH45QrYq
QVMCxOaDOXHhTLLAQt5SEEvyoSUqSAN+SB+ZALhpzbh8swj3PvE50QY0+/yYHD/e
wyMUoTqnKbfhbZq1CHnSu5BJAGfO/Q==
=KWVE
-----END PGP SIGNATURE-----

--Sig_/jWXUg2yC_59pO.EJnzcQN_Y--
