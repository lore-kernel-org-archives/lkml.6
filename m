Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751949AbeBYWvK (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 17:51:10 -0500
Received: from ozlabs.org ([103.22.144.67]:42139 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751738AbeBYWvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 17:51:08 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 26 Feb 2018 09:50:31 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build warning after merge of the v4l-dvb-fixes tree
Message-ID: <20180226095031.74f46e71@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/kLnQLeJoDsenAWekz+/8sDx"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kLnQLeJoDsenAWekz+/8sDx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mauro,

After merging the v4l-dvb-fixes tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

WARNING: modpost: missing MODULE_LICENSE() in drivers/media/common/videobuf=
2/vb2-trace.o
see include/linux/module.h for more information

Exposed by commit

  e77c31ed60d1 ("media: videobuf2: fix build issues with vb2-trace")

--=20
Cheers,
Stephen Rothwell

--Sig_/kLnQLeJoDsenAWekz+/8sDx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqTPbcACgkQAVBC80lX
0GzgWAf/bLpHttIwBEkhY3WzbVDzC9d6E2QFPBJupnBuLk8mHXl0iNTppXyG5Iq/
EvTb+xNbQRDKvwMFhHZbKpku8ew96QK40mFYLfIXQBY8eHs+jOnrK+dRjae/MJeQ
hrcejHitaT5y0RiLjo2CFnuFspXR2jD4/5IafVpkSe5zXxNV79WsUOdmrX2mcZkU
VNGTK2cIyUuqVfCpC1E51oVeCQ1vUsEtc6RtM4we5PIuhI0/dPWDWZyoBLIQHDJY
4aomOWy1ltSiyljJM9X2Ko3v+4I8TTeJTSPSpuKwxt10HbRKS9p3W7minbwl/aXC
E3kYnSqRsDqhkXccFAbC85bFWvlKlw==
=bfBj
-----END PGP SIGNATURE-----

--Sig_/kLnQLeJoDsenAWekz+/8sDx--
