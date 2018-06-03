Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751015AbeFCBlw (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 21:41:52 -0400
Received: from ozlabs.org ([203.11.71.1]:53847 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750871AbeFCBlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 21:41:51 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Sun, 3 Jun 2018 11:41:33 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Subject: linux-next: Signed-off-by missing for commits in the pci tree
Message-ID: <20180603114133.64a2cc77@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ES9rkGbWIDm.KHmg4dKtuHd"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ES9rkGbWIDm.KHmg4dKtuHd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

Commits

  aeddc65a043f ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP driver DT =
bindings")
  c1efa236b42b ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP driver")
  18eb4158c840 ("PCI: mobiveil: Add MSI support")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/ES9rkGbWIDm.KHmg4dKtuHd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsTR00ACgkQAVBC80lX
0GwZPwf+Lc49n0GofSsHYpfyBjT0+A6XrBWH0u2x35FIAvZmoWiyB3hTCf43X/kq
W15g5NiXPwEer16vEWqc7veFyb4+xN8isK3LDQReEHh18VbamNYy39f/T+oqcdp7
ikOC5YC8uoCEedrreWNmEXwInuiEA9t6Dxg/gmgCh5SGbWZiEJvS/b4aZkAwZvGP
/dKN3h5SIY5S2d7Rx630qU5o8fQf42Pr83QRVhS2dN3aQ2vC/HOx5n9n1douBx1z
kR9IwYtL95NJBP8Hj+VSXiP2kO376HVRvp76ZOXmiLh2fYiCF+NfZmmMEvrJBEdT
CUcEbBv28xNPGO7xJp8DunoQTyPIyQ==
=ZSvb
-----END PGP SIGNATURE-----

--Sig_/ES9rkGbWIDm.KHmg4dKtuHd--
