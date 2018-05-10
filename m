Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756349AbeEJBif (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 21:38:35 -0400
Received: from ozlabs.org ([203.11.71.1]:52047 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755415AbeEJBid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 21:38:33 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 10 May 2018 11:38:29 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: linux-next: manual merge of the jc_docs tree with the dma-mapping
 tree
Message-ID: <20180510113829.513b3db9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/gir9HIap0zOjnlhomcPczrz"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gir9HIap0zOjnlhomcPczrz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

Today's linux-next merge of the jc_docs tree got a conflict in:

  Documentation/features/io/dma-api-debug/arch-support.txt

between commit:

  6e88628d03dd ("dma-debug: remove CONFIG_HAVE_DMA_API_DEBUG")

from the dma-mapping tree and commit:

  7156fc292850 ("Documentation/features: Refresh the arch support status fi=
les in place")

from the jc_docs tree.

I fixed it up (I just remobved the file like the former commit did) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/gir9HIap0zOjnlhomcPczrz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrzopUACgkQAVBC80lX
0GwvDAf/T6gbsaJeu9y8m42wPF3AJD2D7lr1MjWq9O8r1eQgunUCpVRQKiZakOyp
WPHH1zc4Xuy7F0wkUcb20bsqSgzpdMnw6gF1syBgXJpZSa28d0e4h0oAfoGeBdTE
YN0dWEJ0pKTWtrw5Lu39pXgnLmWm50BB/LaOxiAdwY6jBCrzpvcEQOTSGmr35DWo
8bnalSDolQIgM9xd0zNTtcCFgq4P9FZ/YiuIsUJu8fzMT+BsDAAQ/+JG8nPy+QrR
v+548ZS5W5yQP/GR4/0QKnDAvhLQKT0ysPPf5u5AJeE0gO9ZkECteOp10b3wlDGi
0ysmHM831SCm5SK6Ef4BxxCLfziKcQ==
=Kbq2
-----END PGP SIGNATURE-----

--Sig_/gir9HIap0zOjnlhomcPczrz--
