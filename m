Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751983AbeCVCOr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 22:14:47 -0400
Received: from ozlabs.org ([103.22.144.67]:47595 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751753AbeCVCOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 22:14:42 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 22 Mar 2018 13:14:02 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kevin Barnett <kevin.barnett@microsemi.com>,
        Don Brace <don.brace@microsemi.com>
Subject: linux-next: Signed-off-by missing for commit in the scsi-mkp tree
Message-ID: <20180322131402.2367f42c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/SoxzR34PV2QlIOKxOaj..0v"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SoxzR34PV2QlIOKxOaj..0v
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Martin,

Commit

  339faa8150fd ("scsi: smartpqi: workaround fw bug for oq deletion")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/SoxzR34PV2QlIOKxOaj..0v
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqzEWoACgkQAVBC80lX
0GzzQgf5ASxw5dZ5H/VnQmGNKQp3pK4/zqoILOenPaQMQqPZhrM+WEN55rPtBYwy
16hsOwZ9Zt7cpxCJ/ZQF9pUL3WLpztYlTWxJQWWKI3q4vX+d+UygzHUNw4BW3h2n
6pGjXfyqEmVtTD1Xw+u4koidHIBN0isjD0j8X5Cn6KE3trjdQouKRQeaVMKBovts
uwnkTSqvlfxIGwc37UhmdhPpwB5i727z41m0BPTNvJqgS5KrOiCM73+z6uuaCYgb
CmOrfS91EAdStt7fI6Q6HWaAqGw3ijXoK0QQ96+3ZTwv7Q8nyNxcXgGlpo3mMJvB
X46sixK7zI86SJMRbKHseo59YAUiTA==
=0bFF
-----END PGP SIGNATURE-----

--Sig_/SoxzR34PV2QlIOKxOaj..0v--
