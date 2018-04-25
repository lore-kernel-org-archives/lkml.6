Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753487AbeDYVer (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 17:34:47 -0400
Received: from ozlabs.org ([203.11.71.1]:56887 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753255AbeDYVeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 17:34:46 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 26 Apr 2018 07:33:09 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andy Gross <agross@codeaurora.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yossi Mansharoff <yossim@codeaurora.org>,
        Stephen Boyd <stephen.boyd@linaro.org>
Subject: linux-next: Signed-off-by missing for commit in the qcom tree
Message-ID: <20180426073309.6fbb313f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Tv+54_n9hPPUyRk4i/CYTNl"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Tv+54_n9hPPUyRk4i/CYTNl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andy,

Commit

  6c3189330321 ("arm64: dts: qcom: Collapse usb support into one node")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/Tv+54_n9hPPUyRk4i/CYTNl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrg9BUACgkQAVBC80lX
0GxdKQf8D4mi/a3IZB8h1HWAA3uuefO6vWo+SlVUOz8AoHI08MCBVqoprRp7Js5V
/tTVFLgV51TwRJ7Yov1MzikbF5Hwx2WmyVKpmCALYBDUDJPgKdrSHo3Ya99uzNxJ
GKrv2gRU39fmfRIYVN75dmko2KIe1GNzVx4jfGSsod9+L9eOhoWH9cddZC77rg9H
NB1I+if2qspa0UEXd4laLXG5BRsrUmrdAQeN+MShKLP9AtghsBW8V2NEo1xHf1rg
a59GNXpWLTeF41NtLMvxvJhaUwqcaW3f7haot0v7IJ/0K0Ovg1JwDP3IWa8im1k2
qwt9/Bi0UzUF/zpISkzU7dorxLlRpA==
=8amW
-----END PGP SIGNATURE-----

--Sig_/Tv+54_n9hPPUyRk4i/CYTNl--
