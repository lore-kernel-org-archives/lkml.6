Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752502AbeC3BJg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 21:09:36 -0400
Received: from ozlabs.org ([103.22.144.67]:55617 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751209AbeC3BJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 21:09:35 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 30 Mar 2018 12:08:41 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vivek Goyal <vgoyal@redhat.com>
Subject: linux-next: Signed-off-by missing for commit in the overlayfs tree
Message-ID: <20180330120411.035c9242@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/f=c=UwaqEtExsu1h4zD9SfY"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/f=c=UwaqEtExsu1h4zD9SfY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Miklos,

Commit

  cbf293becfa4 ("ovl: cleanup setting OVL_INDEX")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/f=c=UwaqEtExsu1h4zD9SfY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlq9jhkACgkQAVBC80lX
0GzXYAf/Y6A+dVzRuB5zwHgqGPbqlpkqhGyiUBO7WnMjykebe16dZ0+pOrhGCDUO
1MVw+yz2YHFTvzFldtnXLJ/0IJ04vCP6x2DwGSaOUmNJeZmflExiODdo30NcBlm0
4chLCkq4KJwjpC2Pm9BAdwn6llPNZBIEDx1D9xiDq9dcwSy53a5n03HJ5MJRJL2S
vtwekKpl1YYqJwpC+EOiFS7S/L0fuNpBTz3SDtHL1uaEpCSJuGbwifsAkyHfF5Pi
cMZ4Gy+ZIEN0anwUb6Kaq6f/EBCIBaR9pXsVy3ggRbaPPvbO+7e1HU02AOJA3Jkc
nAkPRk4JGZgOLh/oeE22h5ACWO26Yg==
=OOV+
-----END PGP SIGNATURE-----

--Sig_/f=c=UwaqEtExsu1h4zD9SfY--
