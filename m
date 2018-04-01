Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753276AbeDABml (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 21:42:41 -0400
Received: from ozlabs.org ([103.22.144.67]:57193 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752824AbeDABmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 21:42:38 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Sun, 1 Apr 2018 11:41:43 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the pci tree
Message-ID: <20180401114143.77a9b4a5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/eMl.xZoI.=snyHa1.w3EunB"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eMl.xZoI.=snyHa1.w3EunB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

Commit

  0d852407c377 ("HISI LPC: Support the LPC host on Hip06/Hip07 with DT bind=
ings")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/eMl.xZoI.=snyHa1.w3EunB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrAONcACgkQAVBC80lX
0GwztAf/exKVwr6VIuvuikK278H2a3nKTlnOP+rcNBQNJdUNZMHePLXhiletW+R3
HwSXtaAacSRXKs8F52tjT+3AsUDLPgdCCzAwEo2La9uNEIQTEzPHP3tpOVyiTyuL
GR6gQi7Jf3wduPwUn2YuZEJa+RWChALeW7KOJ1+AuiVBvrDbvbmGUIv5ItVKykLo
+P3P5GpdGS1aluyJ3oDjZqiaLBrd1TfWge2QwI3XouGAYuYVY719QkQvOeioQDq8
bhzv50ezrY964mTWm1TpTBgHvdcm7sauKYSrRSZdzFBmgygMthGEcUsG96uHMMCu
e8U3qiV1HxGyVGJTfLLlip+e1DJs6g==
=vyNv
-----END PGP SIGNATURE-----

--Sig_/eMl.xZoI.=snyHa1.w3EunB--
