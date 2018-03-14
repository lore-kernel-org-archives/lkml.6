Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751459AbeCNWxG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 18:53:06 -0400
Received: from ozlabs.org ([103.22.144.67]:39587 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750779AbeCNWxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 18:53:05 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 15 Mar 2018 09:52:35 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arnd Bergmann <arnd@arndb.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the asm-generic tree with the syscalls
 tree
Message-ID: <20180315095235.607d85d5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/bRUesZIPxM0FsDunIyWBVD3"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bRUesZIPxM0FsDunIyWBVD3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

Today's linux-next merge of the asm-generic tree got conflicts in:

  arch/tile/kernel/compat.c
  arch/tile/kernel/sys.c

between several commits from the syscalls tree and commit:

  0373506fe580 ("arch: remove tile port")

from the asm-generic tree.

I fixed it up (I just removed the files) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/bRUesZIPxM0FsDunIyWBVD3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqpp7MACgkQAVBC80lX
0GyvGwgAkrh1sHwPtVdAy8oc3igloaH54Y5KZUD2rs7yBjSnUNSJsexNFVVYGZth
dFJeM+vOmDrSzXzK8IBDs2NPTr4Y3C92yCh5ggEVXH6aXN8jFVgVsS/VGIZFTQcW
Fo9Gjq7HKVk2C2VGGlKplZwiKmsQlE1urzTOz6lokRrYcHUBRKqy1c9GAgjRQU5z
Xbxs1d51Mzc7f8rcCZP96QQjA4vvqWVb48a5jjPNWmmQS8bPZ6eh072RKgq/qJA2
hzMx40c/HpHuI57SS7lOQuZrM+U4SErF+6lwuAWd4h4FHlOhYrJaDzo6CK0vCJLD
pndw+hyx5jmA7S7jjJsUMJSD9e0dMQ==
=6X6P
-----END PGP SIGNATURE-----

--Sig_/bRUesZIPxM0FsDunIyWBVD3--
