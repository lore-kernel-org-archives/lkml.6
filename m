Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932477AbeE3V0t (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 17:26:49 -0400
Received: from ozlabs.org ([203.11.71.1]:47467 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932254AbeE3V0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 17:26:47 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 31 May 2018 07:26:29 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Trond Myklebust <trondmy@gmail.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NeilBrown <neilb@suse.com>
Subject: linux-next: Signed-off-by missing for commit in the nfs tree
Message-ID: <20180531072629.6e19241b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Fgdwgc49L6q4AR1fWPyS.X8"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Fgdwgc49L6q4AR1fWPyS.X8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Trond,

Commit

  f217ebf24480 ("NFS: slight optimization for walking list for delegations")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/Fgdwgc49L6q4AR1fWPyS.X8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsPFwUACgkQAVBC80lX
0GzoKwgAmBeLnqN0e5750QYsIbHnUm++RSU8SXzDmjmmbBMsOdjkZy+Slfy0AjlZ
hQxZmHM91a4JLBgHMejH6EtACBuzfOkCzlSwYlqDGzBMQv7T++e6YJ0U/JKonZVn
vwsGBxHBw/Av9v3Rr1+ISl3+OTsF6OKSVy4qzoBx/Iz+BIBhdFpVX8VsCB6htxwC
lcuo1FYb4Wlg5Vg5xLLLWNRdeMYPDn+xWvw8Khg4+7JDW0LQPMYC6uid6R2DzwI4
BSMvlr218JuDlGXr+mndgOKPL0Zt47VW04qSzKcEvUlQjqozHvYxxbxtSPly1UaD
5Lgw4ex2mwZtUaxIv9BQL2C1kl62nQ==
=yXJL
-----END PGP SIGNATURE-----

--Sig_/Fgdwgc49L6q4AR1fWPyS.X8--
