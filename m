Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751477AbeFBHV4 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 03:21:56 -0400
Received: from ozlabs.org ([203.11.71.1]:40503 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751031AbeFBHVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 03:21:55 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Sat, 2 Jun 2018 17:21:51 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the vfs-fixes tree
Message-ID: <20180602172151.300a536e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/2bCycCLUdPYNZr_2Owstkyi"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2bCycCLUdPYNZr_2Owstkyi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Al,

Commit

  9b8a76714b3d ("Revert "fs: fold open_check_o_direct into do_dentry_open"")

is missing a Signed-off-by from its author and committer.

Reverts are commits as well ;-)

--=20
Cheers,
Stephen Rothwell

--Sig_/2bCycCLUdPYNZr_2Owstkyi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsSRY8ACgkQAVBC80lX
0GzSnwf/Y45gAf1BPhYkEtMGeTzQ73ucOuELuddbkF/87Dzbglrb/bd3vP5xLj2K
OgRQTrq3gemeT36f0nCyiNRgmZuUAQdOEBBfdoMB0bEoCjojBXtsZ2A1cxaQjI1c
cTHLkMDMvCJY6kR8G9y/qc4Iqr8jqdTYLubfLKSlvevM7CsZxpR1xHy5q5sI0DmQ
WaXySFSxtuULJ+qF6HpL7czBsllmtcMPkxU8OWm+KO6XkwSfDg8fQlD6lbZ2P4ls
3crm6R8tSuslVX4JeS/6onIyzGZXaDxbMqZLdEh4MKKIdrjK1AHdQZQzxlP4hghv
KP93GXGN1XlvR3YmIk+pc91RfUBBWQ==
=DjaX
-----END PGP SIGNATURE-----

--Sig_/2bCycCLUdPYNZr_2Owstkyi--
