Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165010AbeCBEwl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 23:52:41 -0500
Received: from ozlabs.org ([103.22.144.67]:39617 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164429AbeCBEwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 23:52:39 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 2 Mar 2018 15:52:15 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the net-next tree
Message-ID: <20180302155215.7653987d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/o_XjIvKMJhbRFFIt+hmhf_R"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/o_XjIvKMJhbRFFIt+hmhf_R
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  568477045f80 (" phy: marvell10g: Utilize gen10g_no_soft_reset()")
  0adfdb667ab5 (" phy: cortina: Utilize generic functions")
  aebc78a40b88 (" phy: teranetics: Utilize generic functions")
  e8a714e086e4 (" phy: Export gen10g_* functions")
  6ed33d3a06e6 (" phy: aquantia: Utilize genphy_c45_aneg_done()")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/o_XjIvKMJhbRFFIt+hmhf_R
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqY2H8ACgkQAVBC80lX
0GxCAQf/StJ7Z4Hq6ZrMaHRrjcJtn7A+UJrIaRUtjt2SabZgKrCkQrw5sfMAsH1d
ezb2ZMoewHmJnOkbmwd314HKOzslRQ6QNS4krX8rC8xVbTl1Dw3KIaHOaBaCzqQ1
zrSF85CmTDV7auRWuy9+VU8bp59iVD6AagS/L6loKeqXFonakwJ9k+slnP5Hifmj
ixTaTuoao3duXvJSP9ciWhaIwkRGM8NDTE8pyJtEajQCo246kRz+rWXuLoyNWBbT
nfMRfmNlaIl/PVmTi/aL1h/bpGzsyba+jC6YNUVb3gtfpDCFjLrNVqU7oSVlcupc
VxlqtAGDa38oksStGtwV8kR3ECgUgQ==
=IdR8
-----END PGP SIGNATURE-----

--Sig_/o_XjIvKMJhbRFFIt+hmhf_R--
