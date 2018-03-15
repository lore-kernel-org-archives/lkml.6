Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751597AbeCOJOA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 05:14:00 -0400
Received: from ozlabs.org ([103.22.144.67]:52519 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751314AbeCOJN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 05:13:57 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 15 Mar 2018 20:13:26 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: linux-next: manual merge of the akpm-current tree with the
 asm-generic tree
Message-ID: <20180315201326.2b616bcd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/oO1S9L/5G0E=8zI9PMfy/Cg"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/oO1S9L/5G0E=8zI9PMfy/Cg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  arch/tile/mm/mmap.c

between commit:

  0373506fe580 ("arch: remove tile port")

from the asm-generic tree and commit:

  69ab63fcaa9b ("exec: pass stack rlimit into mm layout functions")

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

--Sig_/oO1S9L/5G0E=8zI9PMfy/Cg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqqOTYACgkQAVBC80lX
0GxcAAf9FZE6lAt6ZyJZO88DWyP+uQDjBSZpqfvVKdE96wx/9+8ecWFseK5ukM02
xxri1ykv+8ou3gyhvpSxY3bkKlDE4PWy/a9YO9XQa7hYcfIuo4HRSo4pdwfEB+MG
hqxxUDEXD6/T38zdbihaEV2LwnsZ8bR8D8k8RCN/hr9wu6Mdi8o/rn7m6grAM4Qc
tuaiNsvNfAbPlXfeZRdt1/ObvatpQ3R+kDKOD5OPi6SqSsBGkN5GgRAG2Ydb0G3G
8fF1CFFHxqDHaGQPv4llz2g09Yh0OIJkwHe8IeH2Ngq6TSWjXCdEeVTW1kAevFrX
6A54+kbim9G8nO1AB5xQdH02W7gcTA==
=q3pO
-----END PGP SIGNATURE-----

--Sig_/oO1S9L/5G0E=8zI9PMfy/Cg--
