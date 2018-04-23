Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932463AbeDWVeB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 17:34:01 -0400
Received: from ozlabs.org ([203.11.71.1]:49561 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932185AbeDWVdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 17:33:55 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 24 Apr 2018 07:32:28 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Simon Horman <horms@verge.net.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the renesas tree
Message-ID: <20180424073228.22a9f64d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/P9.KeanxRn6oH=nkNvcubPD"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/P9.KeanxRn6oH=nkNvcubPD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Simon,

Commit

  341d83147b6a ("arm64: dts: renesas: r8a77970: sort subnodes of the soc no=
de")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/P9.KeanxRn6oH=nkNvcubPD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlreUO0ACgkQAVBC80lX
0GxlUAf2LWd/RIC1viPYTYV49YerAPk2kFi1JYMiKM7wdgkU1dgetCcbpfcDZZQ3
bv1qq5+Uo51nnFwh4JGZl1xNZiB6LXcjOpOpzDN4hr0VBYzbFCsBKM9y/WMdSFj0
3qDxKznqV/k2WkyCKTmTs/v/3oc0lb4FVRgeq6r53j9Z+AdHZn87g4UIl9vfQTI+
MHORgigrbA1/tZdsNu5iKyqCIBY/KkitJwdDGwDTlvVGYJrer2kXmtVF7aXPJf5e
sgi0JUR7RDVx/k+zXhufOFEHntOFZQ0db5zZabebtmccSBlbCPAi64X158AKPhiV
YFiPaJbiOvoOtF6YtcxjbPgY6w2O
=SwpT
-----END PGP SIGNATURE-----

--Sig_/P9.KeanxRn6oH=nkNvcubPD--
