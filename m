Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ecV5oyRO"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8D30F606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932418AbeFFJJW (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 05:09:22 -0400
Received: from ozlabs.org ([203.11.71.1]:51747 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932323AbeFFJJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 05:09:09 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 6 Jun 2018 19:08:58 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: linux-next: manual merge of the staging tree with Linus' tree
Message-ID: <20180606190858.7d4c27ac@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/qUPQreRBfUw7dMPULvPzkiS"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qUPQreRBfUw7dMPULvPzkiS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Today's linux-next merge of the staging tree got a conflict in:

  drivers/staging/ncpfs/dir.c

between commit:

  1c5fedbb508f ("ncp_lookup(): use d_splice_alias()")

from Linus' tree and commit:

  bd32895c750b ("staging: ncpfs: delete it")

from the staging tree.

I fixed it up (the latter removed the file, so I did that) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/qUPQreRBfUw7dMPULvPzkiS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsXpKoACgkQAVBC80lX
0Gz7WggAgGGB18HKT5IFllrnkrt4dQfrot5xWUH4J7v7hLUbZEKBjFZxfBwBYE0h
7ATl9uLCExWy5QABQ+5Lr/4qFBdNnssR4dmN2OSu8MtOC3JTo0efiCvLB1NRNDl/
8RE0GC0KxDUlypZGTtFLibPIzF1zFpm0XOhKi4IpvOD1FxFSFhwqaYbz5rLelJ1Z
BHiyh00SyNPhIT0RaxiJDU5p2oH1kJN7Dd5Z8k7drCSIwGVVx8+IZIncdhXWTSGL
j2lJRyHJCcHXRXVIoGbhSD82YkEw6Uupl0dlM3T0xL0p+hO7n2YlXXBwGX5rf4/p
+d7CxGMZ5lg+Lj5RoStGtNEG0f681g==
=C8xb
-----END PGP SIGNATURE-----

--Sig_/qUPQreRBfUw7dMPULvPzkiS--
