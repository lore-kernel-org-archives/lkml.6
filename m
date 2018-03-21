Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751548AbeCUGpZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 02:45:25 -0400
Received: from ozlabs.org ([103.22.144.67]:37931 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751317AbeCUGpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 02:45:22 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 21 Mar 2018 17:44:22 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build warning after merge of the rtc tree
Message-ID: <20180321174422.0be4dedc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/3IVKS+d_kqWJra3g6k1uU+Z"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3IVKS+d_kqWJra3g6k1uU+Z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Alexandre,

After merging the rtc tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

drivers/rtc/rtc-st-lpc.c: In function 'st_rtc_probe':
drivers/rtc/rtc-st-lpc.c:198:18: warning: unused variable 'tm_check' [-Wunu=
sed-variable]
  struct rtc_time tm_check;
                  ^~~~~~~~

Introduced by commit

  50f37481e794 ("rtc: st-lpc: remove artificial limitation")

--=20
Cheers,
Stephen Rothwell

--Sig_/3IVKS+d_kqWJra3g6k1uU+Z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqx/0YACgkQAVBC80lX
0Gyhdgf/Qvk2Gt1DkERHxo+rbqc7rZ3XU29MtKvF+JV0mHHNuxT3/hl0U0FGv3Ll
wA1t0u/oUL0qFi6EX5/fKhUpLg4XuB0MeFnkhHNt2V6G/ihLWUGFy98sLDK/fn/E
2flSRkR6eXsN6iqB3m2lqbV37QKyxGocFxS5e3XBBURxp2Cd7PHDETVDxb5Li+gQ
KwDY0ZtZzT0soKQBFhFlloCsgFv+KLRQi8d3iEx7HUy9W52++FIgXbqkJw+zSUnl
ObZtmZIaYBoheR8vuZQxV7Hu9h+zDPd/0h5SvzV8Kqf6pWVPAzB9fVxUEkdydWDY
W/sLvo+Oegj5RKhDH50vwvJaUGSsGA==
=6Y2P
-----END PGP SIGNATURE-----

--Sig_/3IVKS+d_kqWJra3g6k1uU+Z--
