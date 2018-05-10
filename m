Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752528AbeEJVRg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 17:17:36 -0400
Received: from ozlabs.org ([203.11.71.1]:53355 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752412AbeEJVRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 17:17:35 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 11 May 2018 07:17:16 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hangbin Liu <liuhangbin@gmail.com>
Subject: linux-next: Signed-off-by missing for commit in the net tree
Message-ID: <20180511071716.038a9095@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/XTrBRb.gUvpaOdyj_1G8dYp"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XTrBRb.gUvpaOdyj_1G8dYp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  0e8411e426e2 ("ipv4: reset fnhe_mtu_locked after cache route flushed")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/XTrBRb.gUvpaOdyj_1G8dYp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr0ttwACgkQAVBC80lX
0GxpFwf/RnGxZS4x+O/f1PVDtXeueAtMOWuiOW0z2oLkB2bMchUBAdJAFAJ/TdRO
AkXbxDyZ5aFsULDUU8SLlWG9C2MPjSJm5ADwx2s5dIzNjThW1eAG9/jJoXcrz6uc
WGHrNDhi+TVgjxKpWMqwsJvgPN1Nau+hiClT+SCroMDipyuv8aPjZMK28UeTGtsU
o9uG7ilcEJKn5OOSaN/NKhtCCRmjo2fvwvpROqTNjVLFkclNrQx1SbQ+WD7HjRgg
QoaHiL399TZxAlZ4orJWFXsW0E8cADedeJ6Wpe8GB6nlc5k45/mqEwsOlJW8/ORj
rQTQe3R1LeE2cGTqiBXw5Fb/W8qAbw==
=af6P
-----END PGP SIGNATURE-----

--Sig_/XTrBRb.gUvpaOdyj_1G8dYp--
