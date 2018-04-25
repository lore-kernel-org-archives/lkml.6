Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753068AbeDYV7C (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 17:59:02 -0400
Received: from ozlabs.org ([203.11.71.1]:39579 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751369AbeDYV7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 17:59:00 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 26 Apr 2018 07:57:35 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: unable to fetch the kbuild-current tree
Message-ID: <20180426075735.2f72e7fd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/46JHX1Y09xwyrxoq64TuW_T"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/46JHX1Y09xwyrxoq64TuW_T
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Masahiro,

Fetching the kbuild-current tree produces this error:

fatal: Couldn't find remote ref refs/heads/fixes

--=20
Cheers,
Stephen Rothwell

--Sig_/46JHX1Y09xwyrxoq64TuW_T
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrg+c8ACgkQAVBC80lX
0Gx9Zgf/bBdssqTgtQcuD5TMIv2Fat0Rb92Vi57Kyj0bJQ+gndtCLYgo4rAgqakk
G0kNLzKUbgdOSO2vHYlMLP54BwNy6+4Q590CiRHJFxhvlDKmcTVDslmPsEnMBsfO
WOCjV729F0MtAlvxM1/LTCjxoH2Nj/h7iwBbEewKXXCLMf+lKEUu8DxU4NGQbI3f
ndYtG4HHZqDeJMraNhwrJiJ6BbAZkGcl9C4WGFHKWNFpDTFQFKDIfVRo+WPByOov
ypz6McWhZqcaifwsrOr0mUXNYmf658UDQn/i0OML0Ut4Kz+3oiNpcaEsKTDD7e77
VNbwHeGeLKEo941hMCQ3IiPI7D8h7Q==
=E1lV
-----END PGP SIGNATURE-----

--Sig_/46JHX1Y09xwyrxoq64TuW_T--
