Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751700AbeCOJGG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 05:06:06 -0400
Received: from ozlabs.org ([103.22.144.67]:47623 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751279AbeCOJGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 05:06:05 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 15 Mar 2018 20:05:33 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Huang Ying <ying.huang@intel.com>
Subject: linux-next: manual merge of the akpm-current tree with the
 asm-generic tree
Message-ID: <20180315200533.7a3c52a7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/jSOPd4VSlD+3M2DPGFTvOpu"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jSOPd4VSlD+3M2DPGFTvOpu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Today's linux-next merge of the akpm-current tree got a conflict in:

  arch/score/mm/cache.c

between commit:

  b8c9c8f0190f ("arch: remove score port")

from the asm-generic tree and commit:

  32a8c02959cd ("mm: fix races between swapoff and flush dcache")

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

--Sig_/jSOPd4VSlD+3M2DPGFTvOpu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqqN10ACgkQAVBC80lX
0GwRGwf+PXr/DnXjWN9JqVWkIxYtovhe4/Wrlm6JGbYAlGa9UYK71raazAQexTUJ
T5UegtYsKSL/Ii/Weo8H9RFTMHRtc/pP5pXrqToGqiX45TU510n2vIbuyMxjgube
chHIbF8wbwGSAAByVuo/pIVDp66wdeKqhoBJAjbITygclilHe8e1VGR6Y7TaY/lH
NGxZ9chagOI08SUrZKCJ91rIYns75mSf9uwGDoOYUHUkWkDnF/EHUBI4QhjFaeZZ
atVEeQgJOI22NzCsO/8AnhevsSd+bO1GWElfZsUY/GnXYMQ6RTaoBACJNMszRaLo
xSa7qu+qjoKjXQ/Qi+9aD29aiqHNyQ==
=6hsN
-----END PGP SIGNATURE-----

--Sig_/jSOPd4VSlD+3M2DPGFTvOpu--
