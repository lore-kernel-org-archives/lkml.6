Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752547AbeENVeA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 17:34:00 -0400
Received: from ozlabs.org ([203.11.71.1]:47709 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752363AbeENVd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 17:33:57 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 15 May 2018 07:33:49 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zhi Wang <zhi.a.wang@intel.com>, Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: linux-next: Signed-off-by missing for commits in the drm-intel tree
Message-ID: <20180515073349.6efabb21@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/_TI0gA6aNcqaWj2eNPbpFU1"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_TI0gA6aNcqaWj2eNPbpFU1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  cb8ba171ae6c ("drm/i915/gvt: let force_to_nonpriv cmd handler only valid =
for LRI cmd")
  0438a1059877 ("drm/i915/gvt: do not return error on handling force_to_non=
priv registers")
  3d8b9e258b9d ("drm/i915/gvt: let NOPID be the default value of force_to_n=
onpriv registers")
  b99f514f5dfa ("drm/i915/gvt: Remove disable_warn_untrack and print untrac=
ked mmio with debug level")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/_TI0gA6aNcqaWj2eNPbpFU1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr6AL0ACgkQAVBC80lX
0Gw5Jgf/TBz3S1c+Sk4txq2RsY/Z6VFvLoaFCQDs2FLG+aPhLcHIh5K1+gzhnJGy
bo9Aw0T7llGqQ0W3jthluG/qVVciSZZTc4ISXhazUNsJqTuLLucC6TvfGnbjcYM6
KMI7wwCfOf4OKne/HU58H02fe1g1cpfG+ilNODp/EcfuNaC/iqQMiu9f5+eqmdac
miJ2Ilu2CBY+br6hb+lFPHmCggD1+UDw/ZvFv/Iu0gglRAi5rbrAMRpx07A4wi45
AMq59dcVkdsgpDPVcS3jJi4FdDEORjezhLd+8fDF/I5i4j8HxfuUKrUkZveM+cA4
uYNA2BnEJjcVTXl+DVEpZAWkHt/HAw==
=V/Ve
-----END PGP SIGNATURE-----

--Sig_/_TI0gA6aNcqaWj2eNPbpFU1--
