Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752427AbeCVHIm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 03:08:42 -0400
Received: from ozlabs.org ([103.22.144.67]:46597 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752333AbeCVHIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 03:08:39 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 22 Mar 2018 18:07:56 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build warning after merge of the nvdimm tree
Message-ID: <20180322180756.3978942f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/5Uq.KlDv7KJbIjjSjvthpz9"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5Uq.KlDv7KJbIjjSjvthpz9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dan,

After merging the nvdimm tree, today's linux-next build (powerpc
ppc64_defconfig) produced this warning:

fs/xfs/xfs_file.c: In function 'xfs_break_layouts':
fs/xfs/xfs_file.c:759:20: warning: unused variable 'ip' [-Wunused-variable]
  struct xfs_inode *ip =3D XFS_I(inode);
                    ^~

Introduced by commit

  6ea4108852e9 ("xfs: prepare xfs_break_layouts() for another layout type")

--=20
Cheers,
Stephen Rothwell

--Sig_/5Uq.KlDv7KJbIjjSjvthpz9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqzVkwACgkQAVBC80lX
0GwieQf+LKZJUZXobAhHD13R2rkoSKLUntzDycI9khOXunhkKNiIQkMh5E+VW+DB
b2RtuxawkCaG6d4HtDx/ZRtLotnIFvJugaEw09sd/IzgistZNQlbSkIpc+pVVY7i
Ih89FT3t8++fPBG2/lciaXskOdYzuq825nhC3PfC3E8HLNXbO1nqs7vFFHsnPrm6
tLMmGwJwqZ9x2MWPlMovnPcj3e3hHwu9s5SHpkn02zwmGrlqppPKSToxz0YICXtp
uHaap/pcCjb+TmM9vLfZ892xRHdsx0uVax+4Q3YAXnlsihl1zQcBAG7/2LLdX2rm
Q7j69Uk2IJWreXXdTOsUtHbijwpMvw==
=FdHn
-----END PGP SIGNATURE-----

--Sig_/5Uq.KlDv7KJbIjjSjvthpz9--
