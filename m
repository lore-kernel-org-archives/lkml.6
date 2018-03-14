Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751478AbeCNWsm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 18:48:42 -0400
Received: from ozlabs.org ([103.22.144.67]:57171 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750779AbeCNWsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 18:48:41 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 15 Mar 2018 09:48:10 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arnd Bergmann <arnd@arndb.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: linux-next: manual merge of the asm-generic tree with the syscalls
 tree
Message-ID: <20180315094810.799c7388@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/4._gFti0+ajKbk_/kW0s=/D"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4._gFti0+ajKbk_/kW0s=/D
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

Today's linux-next merge of the asm-generic tree got a conflict in:

  arch/mn10300/kernel/sys_mn10300.c

between commit:

  17b923b234ed ("mm: add ksys_mmap_pgoff() helper; remove in-kernel calls t=
o sys_mmap_pgoff()")

from the syscalls tree and commit:

  739d875dd698 ("mn10300: Remove the architecture")

from the asm-generic tree.

I fixed it up (I just removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/4._gFti0+ajKbk_/kW0s=/D
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqppqoACgkQAVBC80lX
0GxReQgAhe0b1Oj2PpQg7fKRFHXA5C7GtImwCPqkOngHRCiH1Gg3MMu5jJjOBNvS
l3zvACgbHMaroJ3MOM8lYK9VkIhyHds/2882iR6gUaMOGVU5RKVpU5M16OKes04+
X0HDZbphfvq0PNdJNTlAlOgpy9IzJAUuzP085EauX/JSFmI3ZAwwOFCCeLzVBhEa
o9SrqNUQVhZ3QAco16xx3pYmsizAeTeHqtRZM7g5AzAksFs/07oT6tQsp25SZSeU
d2W5sAITS+HiMmas0ogtwqpAqyTNhKToQ8CRvlvR5//dugj/fpEzbry6TTipQNtu
AERzYw+nk0KPBHr4xdBl/RJEwQ9Wpg==
=LvVB
-----END PGP SIGNATURE-----

--Sig_/4._gFti0+ajKbk_/kW0s=/D--
