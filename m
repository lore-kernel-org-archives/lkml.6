Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbeCMGMX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 02:12:23 -0400
Received: from ozlabs.org ([103.22.144.67]:38931 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751506AbeCMGMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 02:12:21 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 13 Mar 2018 17:11:53 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: linux-next: build warning after merge of the net-next tree
Message-ID: <20180313171153.1614c11e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Wl6iJ1tKm+Q8I7P1_1+dzoi"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Wl6iJ1tKm+Q8I7P1_1+dzoi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (sparc
defconfig) produced this warning:

net/core/pktgen.c: In function 'pktgen_if_write':
net/core/pktgen.c:1710:1: warning: the frame size of 1048 bytes is larger t=
han 1024 bytes [-Wframe-larger-than=3D]
 }
 ^

Introduced by commit

  35951393bbff ("pktgen: Remove VLA usage")

--=20
Cheers,
Stephen Rothwell

--Sig_/Wl6iJ1tKm+Q8I7P1_1+dzoi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqna6kACgkQAVBC80lX
0Gw78gf9Hq44rfIszKMfLn0M4BdQBhc/UkNLyeEGSMAIoG0Wgkq5x/1ZJj1O+d/R
45VwFQsbHbqi/UKSWbCwoUmzWSLHOjDxZKzSdbrG/henuV4BWAvqGZlAP5MeG6+9
mYFlFFIFIzkpXrXHHsj9dk57INByaQEd/+JX7ndITgecrtSf2mn35w+0BvVniEGZ
JGmsZ/KBSAWESMbN0YH8f8NVDtYpt9PpibMEHKlvzm+FNYXEM154wo6NJz1JMU8s
dPsctANoMGAHaDNfbOLQoGuT5vtrRBtf1/PnkCXSW1t60ZL5fR2ZbMQiwngr/j3u
2VQ/zBtyIky6+5eQCiVeqtTFU1duhw==
=gtpH
-----END PGP SIGNATURE-----

--Sig_/Wl6iJ1tKm+Q8I7P1_1+dzoi--
