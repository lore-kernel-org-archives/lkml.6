Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751578AbeDGNha (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 09:37:30 -0400
Received: from ozlabs.org ([103.22.144.67]:43595 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751468AbeDGNh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 09:37:29 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Sat, 7 Apr 2018 23:36:24 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Stafford Horne <shorne@gmail.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the openrisc tree
Message-ID: <20180407233624.18bdb1d8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/njSbMCObApmg+VX/oiJ_C2u"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/njSbMCObApmg+VX/oiJ_C2u
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Stafford,

Commit

  bf118b74c385 ("openrisc: remove unused __ARCH_HAVE_MMU define")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/njSbMCObApmg+VX/oiJ_C2u
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrIyVgACgkQAVBC80lX
0GzG2ggAmbfF6tAtaPTezUfRZgOeWo+GzwSqMkzAJC6SQ3ftHXQuFfpuelPqN1lJ
rJHGRJiEOHSG5DZrY2kWSfgP+ZA31QCSOxWynjh66gvyVWXjSsBDtyvHcZWeSFZ3
oOMDjQKF+rhHmaHO5/s89nGOPh64x6TohFPPtJaiM0toMLbU8jRtuWo8t5jpR9mj
2mODe/2dnOMcE+e+OWhi5KhkEI7RUoT886xGL8v6Q2cvs+AO6o8Sw5B0seY4wbbi
A+iklTebmzBg5VPBv1fAQ4zZBnzu/jleOTpAwql536dAOtPpKMWHdjZZJK4kOM5J
IkkmTVCIFzntk2P32TGhfgLbwluzXQ==
=eu5v
-----END PGP SIGNATURE-----

--Sig_/njSbMCObApmg+VX/oiJ_C2u--
