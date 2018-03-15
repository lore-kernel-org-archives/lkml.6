Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751470AbeCOBil (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 21:38:41 -0400
Received: from ozlabs.org ([103.22.144.67]:39771 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750950AbeCOBik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 21:38:40 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 15 Mar 2018 12:38:09 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        David Howells <dhowells@redhat.com>
Subject: linux-next: manual merge of the fbdev tree with the asm-generic
 tree
Message-ID: <20180315123809.5b21870f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/34N=.QHMpCY20TfMz9jm1YN"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/34N=.QHMpCY20TfMz9jm1YN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Bartlomiej,

Today's linux-next merge of the fbdev tree got a conflict in:

  drivers/video/console/Kconfig

between commits:

  739d875dd698 ("mn10300: Remove the architecture")
  588020dcb92a ("treewide: simplify Kconfig dependencies for removed archs")

from the asm-generic tree and commit:

  f06a51a08f9d ("video: console: kconfig: Remove AVR32 dep. from VGA_CONSOL=
E")

from the fbdev tree.

I fixed it up (the latter is a subset of the former) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/34N=.QHMpCY20TfMz9jm1YN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqpzoEACgkQAVBC80lX
0Gzmzwf/ZuWBKjr57qquiHIgs7eSEMDSgFuNjUce1tbC6Z1LsZ5UX9Ov1uQjS/x9
s5PH4Ov7sQjgOUbPYY9wbh6ox1GLfshxldBYCcfnOvJeW6XldxLEoijN7RA/Yrgh
og1ded+zVbbbPJFWP8q86yIsYOe6ZSN+OleLSkrhpm2xrVthr6bWu19/feU+Wn1r
J6mmXE//hGbBo+SGiULxJUjUs4DW14PLsIcoNrHnwD6/R1IQjLgo4hHxqFPdSaTE
9b7IEOfzydZ6etuzYc3P3jIdpsuVYss5lVDraMCWQkLtQFBdJNxAe/0d8rK0PP1Z
xxCfBxPZsHvJTSuik2/m829I/ZMS3A==
=/pgU
-----END PGP SIGNATURE-----

--Sig_/34N=.QHMpCY20TfMz9jm1YN--
