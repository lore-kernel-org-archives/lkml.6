Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751414AbeDWF2X (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 01:28:23 -0400
Received: from ozlabs.org ([203.11.71.1]:47105 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750786AbeDWF2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 01:28:21 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 23 Apr 2018 15:27:02 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>
Subject: linux-next: Signed-off-by missing for commit in the hwmon-staging
 tree
Message-ID: <20180423152702.3c0c8c7f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/+JEVcCjifdXUZw/PYepuUdH"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+JEVcCjifdXUZw/PYepuUdH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

Commit

  bcafe0ea7e4f ("hwmon: MC13783: Add uid and die temperature sensor inputs")

is missing a Signed-off-by from its committer.  It was rebased since
yesterday.

--=20
Cheers,
Stephen Rothwell

--Sig_/+JEVcCjifdXUZw/PYepuUdH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrdbqYACgkQAVBC80lX
0GwajAf/WVoG3dOIR3uPKB5b/DZiQS8VMg/AkuiFTWj88YL1IwbUFYOrkqz84F64
C+xeVAu2SAkZ01uG4KthEjbFlwgRpiFh+cH1CiPwkbgujqp598hsv1ciZCyJA85+
UK498hrFG2/JwpkNiHps63F4Lus5kAckN+93hZuLU1DfsW2nSc2hAaBkaQa0/sCu
hdjiUTkTnF/Xpq/ChJ4YULjb2JkrhKPQT/vWhcdeY616tzf+Ki6NBu6dI+1Gz6u2
wSRIOtkNK+ZUXxrtX0yVlEbkCUVW6H5TEoU/Ssuso5Npwf0tlP+bX6EjYeNnnyBv
ZTw+Go8huTAo7kkUG1NzfeJxRXu/Gw==
=JJZC
-----END PGP SIGNATURE-----

--Sig_/+JEVcCjifdXUZw/PYepuUdH--
