Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751981AbeCNU2F (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 16:28:05 -0400
Received: from ozlabs.org ([103.22.144.67]:48259 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751456AbeCNU2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 16:28:03 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 15 Mar 2018 07:27:16 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the asm-generic
 tree
Message-ID: <20180315072716.7e9a8e25@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/qV_npyMjpF037/V/sjKVu9P"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qV_npyMjpF037/V/sjKVu9P
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

Commit

  77b0b77f7812 ("CRIS: Drop support for the CRIS port")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/qV_npyMjpF037/V/sjKVu9P
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqphaQACgkQAVBC80lX
0GyqQQf/dU8ltunsP3mxn21e9iZg5kbmBUB+gh7X00u/437HdNblQuVSuk9UzaRf
gwFsc7NUQOhHKvSzMwMAMu4SKQq2mCKRknpbgTJvU/2DR+sAVDhy65oWSE6fBQeM
cd12bDc3oL4fRvNNnI1LWRoYhczluAmSfTOcwtXQyLvDlOfeEIvuhStcH8RCP6MD
qUKSluaSLhvNzISockxBQDvtakWicgKiPLdG7Yk09i5UBU2Mjk9nC1I52aipgHPk
8GJrTB+zJBNALPoELtjn+ttuZDOhJZeGSNfk0ZW8vHHbo0PVIDCIW6FZTATBEIWX
0LGJowzN/dtWCy9ySQ1ZfvhfW1D9ZA==
=4iGt
-----END PGP SIGNATURE-----

--Sig_/qV_npyMjpF037/V/sjKVu9P--
