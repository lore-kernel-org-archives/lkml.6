Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751881AbeEOXOW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 19:14:22 -0400
Received: from ozlabs.org ([203.11.71.1]:38553 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750748AbeEOXOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 19:14:20 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 16 May 2018 09:14:10 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: linux-next: manual merge of the mips-james tree with the mips-fixes
 tree
Message-ID: <20180516091347.1763527b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/f_LJFff4UvJtT+9lDtoCXul"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/f_LJFff4UvJtT+9lDtoCXul
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mips-james tree got a conflict in:

  arch/mips/boot/dts/xilfpga/Makefile

between commit:

  a5a92abbce56 ("MIPS: xilfpga: Stop generating useless dtb.o")

from the mips-fixes tree and commit:

  fca3aa166422 ("MIPS: dts: Avoid unneeded built-in.a in DTS dirs")

from the mips-james tree.

I fixed it up (I just used the former update to this file) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/f_LJFff4UvJtT+9lDtoCXul
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr7acIACgkQAVBC80lX
0GzEDQgAntxZgneNss2yQaUpsnj+wOitXNULB+jF3JAKcy80x4c8KJxBd9LGlMCU
9+GZoat+1Hg8VAHL+VU5ZXjaxbEMs6X7JZBgTU70uExv3SXRbV4Jv/Hag/f1vTEl
ZBqQl6IxtstlHdWBh8JdoWXRT+/v0BLb7sWmzZdmq6D8Wn48N4SyQobc7olUxs5R
q+4Sh8UJNjumg2ESKCp0GOXaA+dct+GCSlfBJAhZPqCB/+l0XHfeBGaQMw08NPBP
tX6hJx8XBxfYYn18aKavTs5wzk5PByHvezv7SadyPnmpkshOZr4S18gruuq/2EtG
WN4NaNkAl0++6gAd6p+neyiijTCOqQ==
=j8bZ
-----END PGP SIGNATURE-----

--Sig_/f_LJFff4UvJtT+9lDtoCXul--
