Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161642AbeCAUh6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 15:37:58 -0500
Received: from ozlabs.org ([103.22.144.67]:51131 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033189AbeCAUh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 15:37:57 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 2 Mar 2018 07:37:33 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Sterba <dsterba@suse.cz>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Subject: linux-next: Signed-off-by missing for commit in the btrfs-kdave
 tree
Message-ID: <20180302073733.789343f2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/b6Nj45Y_C2Bb3jGEnwyuaAj"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/b6Nj45Y_C2Bb3jGEnwyuaAj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi David,

Commit

  001cafe3c03c ("Btrfs: fix unexpected -EEXIST when creating new inode")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/b6Nj45Y_C2Bb3jGEnwyuaAj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqYZI0ACgkQAVBC80lX
0Gz4pQf/Y1bnNPOKnG/bDGKIH+6WkQ4WSNOihPow/92RIeEfd3bQuYxbY5VT9g/t
VsMxPxWXU1x+1R3Q3Z+6Oudn1+SVJbPnF7toWWTHIgWcHFUVkusWZIKFdMQ6Uy/n
M0G8+dB9z5gfEX0Hj/DpQdeZG/wpcw52hRE2AA4rFKkXtBVXhMYspBr2HmfCP70b
uROKfUxYaOS2H2QDCU2Crpt88/EnyLOVaoKDqszg0ez80i1VMbPHt+YL/VUPhj1s
+Ojfrxv+q1B/cyhfkcwJgd363j11BaxUlMWW1yp4ZhQw1C2nBcPso9nqVo1BGoos
woXbDNMh5/AX7+rAYb3arcBYQAx4pg==
=X9v6
-----END PGP SIGNATURE-----

--Sig_/b6Nj45Y_C2Bb3jGEnwyuaAj--
