Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031260AbeEZDuL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 23:50:11 -0400
Received: from ozlabs.org ([203.11.71.1]:36749 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031109AbeEZDuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 23:50:09 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Sat, 26 May 2018 13:50:04 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jens Axboe <axboe@kernel.dk>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>
Subject: linux-next: Signed-off-by missing for commits in the block tree
Message-ID: <20180526135004.00b19986@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/YoPSMsOCfX6+Y.YCKhw5fLQ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YoPSMsOCfX6+Y.YCKhw5fLQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jens,

Commits

  287a63ebbe7c ("nvme: mark the result argument to nvme_complete_async_even=
t volatile")
  750dde4472e4 ("nvme-pci: simplify nvme_cqe_valid")
  d1f06f4ae041 ("nvme-pci: move ->cq_vector =3D=3D -1 check outside of ->q_=
lock")
  1ab0cd6966fc ("nvme-pci: split the nvme queue lock into submission and co=
mpletion locks")
  1eae349d18fc ("nvme-pci: drop IRQ disabling on submission queue lock")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/YoPSMsOCfX6+Y.YCKhw5fLQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsI2WwACgkQAVBC80lX
0GwAqgf/YcYEJ2gUYrjIpTsqpZUw7jg8qdrjaE3Lv0GeWAajNrKkPuJt9Nfr5w3z
vLfUGuldFn7yPAy8afpDPLpSnrpK4SKzrFBVUrDyvIel4QdBT0zaRrEyd14Tbaff
yTkI4Ahh9uSsoJ+etXuzaEvazhXYYblfPusdggv8+KZ629415PS0aBy08mD+ZcBB
ypg11OC87QE2KpADMEOyXYbsR8etnqniFWpr6zUQLSL0pRHPBI471d7WQ8iENr82
v/w1om4HIdKrCcIux1ycuK0Y6LdY77FDZCqRMA1SdY+YShRkEEys2j386LzDIZDU
maSu37Ybuz6HCyG9U9XyLUaDGpIArA==
=9me+
-----END PGP SIGNATURE-----

--Sig_/YoPSMsOCfX6+Y.YCKhw5fLQ--
