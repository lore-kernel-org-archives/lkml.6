Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752302AbeCVGiF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 02:38:05 -0400
Received: from ozlabs.org ([103.22.144.67]:49111 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752024AbeCVGiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 02:38:03 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 22 Mar 2018 17:37:22 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dave Airlie <airlied@linux.ie>, DRI <dri-devel@lists.freedesktop.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the drm tree with Linus' tree
Message-ID: <20180322173722.78d012c5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Z9KNElp.WKMlbYCpqfQ=Q8u"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Z9KNElp.WKMlbYCpqfQ=Q8u
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got conflicts in several amdgpu
files because there are a set of (mostly identical) patches that appear
Linus' tree and the drm tree.  In each case I just used the version fo
the file from the drm tree.

You should do a test merge between your tree and Linus' tree and see what
you want to do about the resolution (either do the back merge (I think
with v4.16-rc6), or provide Linus with branch that has the merge done).
Its a bit of a mess :-(

--=20
Cheers,
Stephen Rothwell

--Sig_/Z9KNElp.WKMlbYCpqfQ=Q8u
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqzTyIACgkQAVBC80lX
0GwVgggApZvAvAblCkES91oKgvH7ZydJaoAG8ice8wQdAPJD2lbtzwUwVp1geMGd
jwds66ii74Znr3LbUhxZ+tipoDGsAk8HgabMm4OuRjXmwWjFvGutZt2q9/vCpHbq
tS4RJx2XLmzxEzfVEMnQ3GMEVlwwjCyluhL2Of8VGY6f1e7WJesKl2/B8DyhnITw
vd8dj7cRYRydlyLHB/KV3ahjYpV75hLNAjZ0u366rslJ04pQADLCdIAiJY/hr0bv
PhGmoo5+SHVlXDXKbrfwR6+ApGe1vyBATAP3weanagOubEgVW9RoUG33HAcaNt9e
gCOOJhDQxFrdFDYWbHUClRSESqXeYA==
=isrG
-----END PGP SIGNATURE-----

--Sig_/Z9KNElp.WKMlbYCpqfQ=Q8u--
