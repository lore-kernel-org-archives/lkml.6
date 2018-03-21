Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752029AbeCUJ1v (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 05:27:51 -0400
Received: from ozlabs.org ([103.22.144.67]:45037 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751459AbeCUJ1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 05:27:48 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 21 Mar 2018 20:27:05 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dave Airlie <airlied@linux.ie>, DRI <dri-devel@lists.freedesktop.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: linux-next: Signed-off-by missing for commits in the drm tree
Message-ID: <20180321202705.708b8f1a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/0PzI5IxV48yZTTKF_l+Pzu9"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0PzI5IxV48yZTTKF_l+Pzu9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

A series of commits

  a82f034765fa ("drm: omapdrm: Split init and cleanup from probe and remove=
 functions")
to
  663ac57b285d ("drm: omapdrm: venc: Allocate the venc private data structu=
re dynamically")

are missing a Signed-off-by from their commiter.

--=20
Cheers,
Stephen Rothwell

--Sig_/0PzI5IxV48yZTTKF_l+Pzu9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqyJWkACgkQAVBC80lX
0GwpDwf9ES4nSmHFMF00KBRiNt6EaPxwL63ejhWocNkFpLZWnBdwiGewROdV9RK9
G8Xpp+ZahWqyPLYoyvP83EzHmdKvXsn34PtyryMullyNAin/kC1dXcvebEc/TPUP
lCRFIg8TUHIuZ6VGBJpuD+miKgXN0LjqHRHEj9+4mIbq98yX53rip31/OrWakIaH
VEOmWgXZ0Rq2xLsA7fTv3fGNVA4C38SF+7UNFIPDjuyotdrebClkISZVfQ8lwxeD
zWay/tY3vdV28RwmUMkjAPO9j6bvDAL929Zf+Xe7Kt3R3klH/RQm35FjvEDqRXtU
j6AJGvONLpjEG7Z5HxvyPbJhe9dLQw==
=ReOe
-----END PGP SIGNATURE-----

--Sig_/0PzI5IxV48yZTTKF_l+Pzu9--
