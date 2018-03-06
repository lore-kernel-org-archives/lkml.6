Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754024AbeCFUjH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 15:39:07 -0500
Received: from ozlabs.org ([103.22.144.67]:45811 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753070AbeCFUjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 15:39:06 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 7 Mar 2018 07:38:19 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Evgeny Plehov <EvgenyPlehov@ukr.net>,
        Stefan =?UTF-8?B?QnLDvG5z?= <stefan.bruens@rwth-aachen.de>
Subject: linux-next: Signed-off-by missing for commit in the v4l-dvb tree
Message-ID: <20180307073819.43df8cd7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/OYLogd686Dh5NmxMsA9XrsB"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OYLogd686Dh5NmxMsA9XrsB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mauro,

Commit

  c20ffbfe085f ("media: dvb-usb-cxusb: Geniatech T230C support")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/OYLogd686Dh5NmxMsA9XrsB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqe/DsACgkQAVBC80lX
0Gzytgf9FRq5vnVkq/c0Dbap8aOx/qqH5X8Qvj7mBebr0I6VrrwDKF3Fo4DTRfQ6
ORdDETig4jW6s/cbmQP0QRO1A5Oxwj2Lp11mz7ZS9gTdO7EuzPOsrILqE0mvg5Tr
JkFDKqYV9OgjHiy5edltQcXJGmb/Nggoz1J9sEXTx18FeZ4iLmcRot96WXw5fnuf
japEZr6gFuDhwzoT6aqBUtNd0ccDbFhZhYbt9ppJJS5OhIXXcCL2xBeM6VV78rzN
m8Oz2pPcTJCl0uJaohXVwquI5AGSrzRYYvdITgsvKyMzDvVXn/y8IkAAzSZO5E/6
NySKBh/CV4FNvQq+cnSRpfA5N7G1Pg==
=6Gq/
-----END PGP SIGNATURE-----

--Sig_/OYLogd686Dh5NmxMsA9XrsB--
