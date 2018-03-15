Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751824AbeCOHeo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 03:34:44 -0400
Received: from ozlabs.org ([103.22.144.67]:47555 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751653AbeCOHem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 03:34:42 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 15 Mar 2018 18:34:12 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Martin K. Petersen" <martin.petersen@oracle.com>,
        David Howells <dhowells@redhat.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the scsi-mkp tree with the
 efi-lock-down tree
Message-ID: <20180315183412.01412755@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/nX3i2UYX.tvbaVBnXGnMu4I"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nX3i2UYX.tvbaVBnXGnMu4I
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the scsi-mkp tree got a conflict in:

  drivers/scsi/eata.c

between commit:

  5b76b160badb ("scsi: Lock down the eata driver")

from the efi-lock-down tree and commit:

  6b1745caa14a ("scsi: eata: eata-pio: Deprecate legacy EATA drivers")

from the scsi-mkp tree.

I fixed it up (I just removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/nX3i2UYX.tvbaVBnXGnMu4I
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqqIfQACgkQAVBC80lX
0GxG4Qf/exik1BbI+H5UsC6pUY+XAUhZoipRtgOvgvt8Xv/TnZPIXgVvbk03AnnA
9SKucaC29+2OSVbt5cP92VYkNipjni+madhSPT80M94bQk9p/ZPOUfyfvxQg64P5
cI8PufREK7h3yKBP8x7+90tXPwtKOIjtpzwy56WYznBTBMYvHVaKzJ/w0XXvps+n
n+U55S3N4CNjHqUG0xLutxPOfTGRxZnnhRguvo34Y/cnoXL138j8T6L/7II2T1mF
jzheHxNl6fufa40DR9ulovMbZE8CHkQEk1fV6NRXrB5SvMqDGnocHlPwtfRWU7JB
1H+lQMoAT94gsH8X+5L9+ojHjWI/Mw==
=8UoR
-----END PGP SIGNATURE-----

--Sig_/nX3i2UYX.tvbaVBnXGnMu4I--
