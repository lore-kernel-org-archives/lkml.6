Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751559AbeCNWuL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 18:50:11 -0400
Received: from ozlabs.org ([103.22.144.67]:37183 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750950AbeCNWuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 18:50:10 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 15 Mar 2018 09:49:40 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arnd Bergmann <arnd@arndb.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the asm-generic tree with the syscalls
 tree
Message-ID: <20180315094940.12690ce1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/v09z2RdGDI=xQsfV_mTIdpI"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/v09z2RdGDI=xQsfV_mTIdpI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

Today's linux-next merge of the asm-generic tree got a conflict in:

  arch/score/kernel/sys_score.c

between commit:

  17b923b234ed ("mm: add ksys_mmap_pgoff() helper; remove in-kernel calls t=
o sys_mmap_pgoff()")

from the syscalls tree and commit:

  b8c9c8f0190f ("arch: remove score port")

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

--Sig_/v09z2RdGDI=xQsfV_mTIdpI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqppwQACgkQAVBC80lX
0Gwrkwf+PJjQxNEEeH8gOABhGNsmUjN5X3ZjIoyis2qMTXNZjH21Z0GJqjQ/2z4c
lULotduA05wUJr7nRLzQe1/1oQp0MKN6Ef4SbjkluXwGqjF1d+tcKgLIElgbalUq
KTKtdOs73TNSjMfnqF08+9dizBh1fZHDP1qW1hR8ckeriiAljDYuPJCLUdCl4+8n
oi6Ba6VgBW05VeAcVNZXESRyJAOEIHlBp2xh04X/kx/n71x7HYp45w6jrUjlbUqv
ymZcLTHPonT13AonQ4w/SAYcSvFsxkzAhSNtK8msqeCV8Pu55PhG7rQluqSC2ft/
QJGwrcSSTGIUcy8xQKGJ+w+cTglTHA==
=zHDs
-----END PGP SIGNATURE-----

--Sig_/v09z2RdGDI=xQsfV_mTIdpI--
