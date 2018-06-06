Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="mR5WQ4Do"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 553E4606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932446AbeFFJMK (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 05:12:10 -0400
Received: from ozlabs.org ([203.11.71.1]:60957 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932265AbeFFJMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 05:12:09 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 6 Jun 2018 19:12:05 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: linux-next: manual merge of the staging tree with Linus' tree
Message-ID: <20180606191205.27b1290c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/iFQ.1rWNs5=/+=W2qkGkVed"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iFQ.1rWNs5=/+=W2qkGkVed
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Today's linux-next merge of the staging tree got conflicts in:

  drivers/staging/ipx/af_ipx.c
  drivers/staging/ipx/ipx_proc.c

between commits:

  fddda2b7b521 ("proc: introduce proc_create_seq{,_data}")
  db5051ead64a ("net: convert datagram_poll users tp ->poll_mask")

from Linus' tree and commit:

  7a2e838d28cf ("staging: ipx: delete it from the tree")

from the staging tree.

I fixed it up (I just removed the files) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/iFQ.1rWNs5=/+=W2qkGkVed
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsXpWYACgkQAVBC80lX
0GzvRgf/TO6TaePIKoELxpjLffGFUM4wXdZOq3SaAnMaDxRygg9bT4XP6hyVRhOh
664iQ/qsxi0/Q8ZFMSvLuEXaHtC4y9pwOuiiBuoZw5wwuDU5RtAh+wJkqtlqVQGW
P2HAg4QbEN/6DJ5EeiGAYbIuJ6A/QZ7TaNEWe1kbA5csmkXSO0/76UL3E/Mdp9rr
igu9NDfiFXxlXj8iH8zCuGxNMU/wdoPo4zninT7hizdCCMN292z2hpIvG4JEIsSu
l2YGJsbHIb9EAIBmwYHwgxMMrm7uQpR80wUoE92oktP2H46/8zZZeEag25e/XJrJ
000LvlulBbObEcuUJ+Cf2i6MaIvksw==
=oYXW
-----END PGP SIGNATURE-----

--Sig_/iFQ.1rWNs5=/+=W2qkGkVed--
