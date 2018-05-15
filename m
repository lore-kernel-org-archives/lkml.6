Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752855AbeEOVRy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 17:17:54 -0400
Received: from ozlabs.org ([203.11.71.1]:43703 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752389AbeEOVRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 17:17:52 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 16 May 2018 07:17:40 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jiri Kosina <jikos@kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Subject: linux-next: Signed-off-by missing for commit in the hid tree
Message-ID: <20180516071731.59cf5d23@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/BRRv7rsYZSfyzlkFFM9XpJQ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BRRv7rsYZSfyzlkFFM9XpJQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jiri,

Commit

  f82719790751 ("HID: steam: add battery device.")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/BRRv7rsYZSfyzlkFFM9XpJQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr7TnQACgkQAVBC80lX
0GxC1Af/T2EyExKX2WjLoS6kZMpE+qAuQSy5H+2b0trAeuQyvOIRUWTO4P/f7rUO
yXoySPxQIanvhH+/iUsltUolDsXSmKjIDpmqhw+QuEN47YYMv043kZVPwui03i4v
3dfrz17CWfInst3n6L9li4wSUyUdC48sKIi3aPlrbp7vehYRpzg3lzfrRpYyP8fZ
yO48f1+W/iApBY9kAdb2/Fvn7k8uTvlzKE3W1cESz07tBGkOpvZkJ9J0MeI4LDB7
FPdu7C9UfPToM00I7cmfdscYnsJQ/tyCXuTStH2F9uImMFiagq/NaxlwwBa/3bia
mCZVmDhYvqxRyQv1JHGr44GMNpTcdg==
=RSzN
-----END PGP SIGNATURE-----

--Sig_/BRRv7rsYZSfyzlkFFM9XpJQ--
