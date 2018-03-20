Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751521AbeCTUxx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 16:53:53 -0400
Received: from ozlabs.org ([103.22.144.67]:54779 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751186AbeCTUxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 16:53:50 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 21 Mar 2018 07:52:51 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michal Simek <monstr@monstr.eu>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-bys missing for commit in the microblaze
 tree
Message-ID: <20180321075251.49f3c1a3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/28FJYb+O/=ncxtGW+1aCB0/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/28FJYb+O/=ncxtGW+1aCB0/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Michal,

Commit

  39a21eefea04 ("MICROBLAZE")

is missing any Signed-off-bys.  In fact, it is a very strange commit
message.

--=20
Cheers,
Stephen Rothwell

--Sig_/28FJYb+O/=ncxtGW+1aCB0/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqxdKMACgkQAVBC80lX
0GySbwf/Y/2V6/Tyh7gO1zeo0Biknc4/0YZz5RHsjrm/WQ9u5NBkF0RV+rRnr5dQ
PcttnYRDI0Gz+IVVTd08fIFkPGhVSH7jU9FwQPn3Xkh/QPUcaQFj/wMdQVlv/XKq
SiDcMz9y7rE9DQWgJhyvpAWO5xzSoUUuUQRJ1p2PELPoQePkVbU1kC3zZUC7EDDD
4FkOuFuNPmXA+3ghevW/wha+fOMBLwCeLw/J4dF3ghN5ybnN/XVvQjDlJtchPDx7
fCPhiICT71y+ZW4Ut88tJB/5LhL2g83jSFHf5Ni9GqgBEDURyzdZIMVwJAROqg7t
Emo/GCM/dCCLLD6RfeuNUibIY4sHTA==
=I8Va
-----END PGP SIGNATURE-----

--Sig_/28FJYb+O/=ncxtGW+1aCB0/--
