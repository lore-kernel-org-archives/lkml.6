Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751408AbeBTUvf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 15:51:35 -0500
Received: from ozlabs.org ([103.22.144.67]:53515 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750799AbeBTUve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 15:51:34 -0500
Date: Wed, 21 Feb 2018 07:51:05 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the kvms390 tree
Message-ID: <20180221074734.6cd689ec@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Vpdl2taO1gAfdCYTDiV9OWD"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Vpdl2taO1gAfdCYTDiV9OWD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  6558ff10e614 ("Kconfig : Remove HAS_IOMEM dependency for Graphics support=
")
  60da5bfd79f7 ("s390/char : Rename EBCDIC keymap variables")
  74113cf840c7 ("s390/setup : enable display support for KVM guest")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/Vpdl2taO1gAfdCYTDiV9OWD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqMijkACgkQAVBC80lX
0Gy6iwf/YNySU8LYmp0vLmTYNdAwgnlKqkTCSKtiGg7A5eSdQtE77kHNWhsQknLp
dQ3q4KNYjnzDiRQ/wfzycoCQbg8f5QCbzyFtgHtAqKu+xNBvijSn4mWNqpRnZ7c9
ZMHvg4ynHh7L/NDoYCug9/GO4k+0NtDJdiSAiAvSadghY5bNcgMl69Lvr6ZxqlGK
S1iNZ9Y0ib6wJP0rq7W1HBMMSwSTTw2l9/2ZV80TiVlhC5yzDez8gQpvZq5Pse1D
ELnrgrRXbgzPQk9QC0Ccu+UCMOD5aYjp2H4WxeII/LCDhzWqGXcaEkEOI3pmtHNk
H+z3yDfO9NwxPkVHaiO21dhWgfcyUA==
=bwb9
-----END PGP SIGNATURE-----

--Sig_/Vpdl2taO1gAfdCYTDiV9OWD--
