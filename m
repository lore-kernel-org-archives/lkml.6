Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751909AbeCOJML (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 05:12:11 -0400
Received: from ozlabs.org ([103.22.144.67]:32807 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751556AbeCOJLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 05:11:24 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 15 Mar 2018 20:10:53 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: linux-next: manual merge of the akpm-current tree with the
 asm-generic tree
Message-ID: <20180315201053.2467aa92@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/vk2wWtnm42fhUSnn/JFLMG6"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vk2wWtnm42fhUSnn/JFLMG6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  arch/tile/kernel/pci_gx.c

between commit:

  0373506fe580 ("arch: remove tile port")

from the asm-generic tree and commit:

  4b36a05ab086 ("arch/tile/kernel/pci_gx.c: make setup_pcie_rc_delay() __in=
it")

from the akpm-current tree.

I fixed it up (I just removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/vk2wWtnm42fhUSnn/JFLMG6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqqOJ0ACgkQAVBC80lX
0GzQ6Qf+MleyLWDD0B2BpyF55M6l9CRJPQ/MMRDkNXVOxxMtdROZrA0mBK0qQgwU
BVwCze8xI2T06qiPiI9BnK9WxEGyYcs8IvxIFeA+/rwaoDd10ofeXS7J8QF6VBkv
1bbIZ9Ku9YmDUWnagvlimE26wHJAl1gVyISuLpU9ZR/tHEzYCtveewt/lkJJpCvO
xZXI7A5XrzTJDvWrCwUooq1B1qubxwv211XJ4u5agaaBHDT+vi8EsukxCPFPivFX
Osun1uCUoN5n+CD6pHqO8aSid3+Z/ccetxdtvGyXcKAeS09FDaLRUJBFiue6J4KA
ZXc9/7pYJVBHTEba7X215Y9MHKTldg==
=2ff+
-----END PGP SIGNATURE-----

--Sig_/vk2wWtnm42fhUSnn/JFLMG6--
