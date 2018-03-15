Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751946AbeCOB3x (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 21:29:53 -0400
Received: from ozlabs.org ([103.22.144.67]:41453 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751791AbeCOB3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 21:29:52 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 15 Mar 2018 12:29:21 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>
Subject: linux-next: manual merge of the v4l-dvb tree with the asm-generic
 tree
Message-ID: <20180315122921.24520368@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/OpVT54UC0mC/0FnZdgv8kIG"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OpVT54UC0mC/0FnZdgv8kIG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mauro,

Today's linux-next merge of the v4l-dvb tree got a conflict in:

  drivers/media/platform/blackfin/bfin_capture.c

between commit:

  b9ec40bf7d29 ("media: platform: remove blackfin capture driver")

from the asm-generic tree and commit:

  4471109e3894 ("media: convert g/s_parm to g/s_frame_interval in subdevs")

from the v4l-dvb tree.

I fixed it up (I just removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/OpVT54UC0mC/0FnZdgv8kIG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqpzHEACgkQAVBC80lX
0GwRpQf7ByGYurhqxsE4eIlLeHoDwqvl5y1Aac4bX4NAJ7xJA6DmSwxq1iYaDWg4
qy42Uz6MhINz81+sG4H+hOpNwlR0fSF+loAfGMYSrOD6dcIw4Lp5R1olz5tfvVgr
31pgvQ8CTfLgPTSwk8yxnjgZrbKYmFKUcDBnkw2zuACQJo0kYvY8q3Gq5T4OW7Mg
NMDQv+SNs4e7oLoF2kbvkQ8GKWamT7xG39W0M/vMF3dVGVNJMYW7JsouIR3FWk+e
oyecOG6i8i2xlfVFPL/bfBHl+JTjoZwME3e+sHEpbalOKNvXPKLabTm5tuGEwVD1
wIfocQM5CdBI0jsJ6MosDJq5h+SiGg==
=P+0I
-----END PGP SIGNATURE-----

--Sig_/OpVT54UC0mC/0FnZdgv8kIG--
