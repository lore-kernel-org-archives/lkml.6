Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752029AbeEMVbm (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 17:31:42 -0400
Received: from ozlabs.org ([203.11.71.1]:59367 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751210AbeEMVbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 17:31:41 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 14 May 2018 07:31:39 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christoph Hellwig <hch@lst.de>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the
 dma-mapping-fixes tree
Message-ID: <20180514073139.38ded4cd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/BV+FHuqD7/iIFNLJ.71SaBl"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BV+FHuqD7/iIFNLJ.71SaBl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

Commit

  05e13bb57e6f ("swiotlb: silent unwanted warning "buffer is full"")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/BV+FHuqD7/iIFNLJ.71SaBl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr4rrsACgkQAVBC80lX
0Gwobgf+LDITrGIT8b8k3RQm6R1/XETI/bU+PjgQvMfu0uvzlptd/Jcn8Ofy4KZZ
sIryeS/OzVIor/0CA8cH2Kan+a1ZlgN5UirxJ10o31T9t2NNMydbNcFElMl84zIn
lOtfeWkTwbxUe11SgUhukcSVrDLaw6bcd4Pm1Tnouobeo5zd6MprvFI7sHRHWrp5
MWe7RJVr3xwrM3WVxREZ8oVIp0GtecJJNT7gk/E6sVPCF3H9dfVueNXDGnaqvEoz
cdLddynbgphfWC3CvnuzrhDZElw/KWN8geyhZTQIYLICseBzu+49hGbSWcw8uKZ0
HZAHoQmcg55K1FCrEPYBFJU8xwWZZg==
=wJpn
-----END PGP SIGNATURE-----

--Sig_/BV+FHuqD7/iIFNLJ.71SaBl--
