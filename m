Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932359AbeCMBQA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 21:16:00 -0400
Received: from ozlabs.org ([103.22.144.67]:39239 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932231AbeCMBP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 21:15:59 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 13 Mar 2018 12:15:28 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dave Airlie <airlied@linux.ie>, DRI <dri-devel@lists.freedesktop.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Huang <JinHuiEric.Huang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>, Rex Zhu <Rex.Zhu@amd.com>
Subject: linux-next: manual merge of the drm tree with Linus' tree
Message-ID: <20180313121528.36120e37@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/wrPZgJZxY4WI2A2sGLGYPP+"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wrPZgJZxY4WI2A2sGLGYPP+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c

between commit:

  a0aaa03062be ("drm/amd/powerplay: fix power over limit on Fiji")

from the Linus' and commit:

  a5278e511dce ("drm/amd/pp: Revert gfx/compute profile switch sysfs")

from the drm tree.

I fixed it up (I just used the latter version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/wrPZgJZxY4WI2A2sGLGYPP+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqnJjAACgkQAVBC80lX
0GzVYgf+PdWjze0sLpZoFAOIfJSZRRiYeI2e7jk+LnQErOnbJV89MK/8yGm+7Cr4
lx3KHXqsuSRVJUdFTUokAA5/bhOzWafs8D+3owWQfZ8AiI+MxaRbDqrDhoFfj3tb
dmMjmyEDu9oI670vKvmTdDzAEL5/eqqA2M/Uh948fE3Wy70B1gjTqS9A1xih0WAK
drfcblR94dm0RjqOPmCYtmGHzGLpxB99D/13mMiOdZfKCdjXe97BY3Ez5WZV1EfH
C7Qd3xhcaHkIBnHYHVCJs3WZw3A13ph9O6RNsvg5zlRhjrTuY1Deh88fFXNPQcbB
GJ5KHRGN542tf8q33G3JTTPKNG4QLQ==
=rwMR
-----END PGP SIGNATURE-----

--Sig_/wrPZgJZxY4WI2A2sGLGYPP+--
