Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752044AbeEMWJC (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 18:09:02 -0400
Received: from ozlabs.org ([203.11.71.1]:58985 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751053AbeEMWJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 18:09:00 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 14 May 2018 08:08:56 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the netfilter tree
Message-ID: <20180514080856.369027d7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/zzwc=nD+l0LTsGSMcHUVPO="; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zzwc=nD+l0LTsGSMcHUVPO=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  ecb5a282f87d ("netfilter: nf_tables: fix memory leak on error exit return=
")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/zzwc=nD+l0LTsGSMcHUVPO=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr4t3gACgkQAVBC80lX
0GxtvggAhMqTbCeKFP1HhEUHLyKBhFmoy6LP2r34wMeqimb8hzie0mcPvAZG62aD
+7DF+DJ8xYawdn7ZRBX3PBu1qwQ5ogNDwnLiWkG4IGk50wh51qB+xtdy6k2XUgw0
8DR9cpifd73GTVcs/13NPV+J2wlX3naYZlyGmr8HJ99ZZ3i9wDblYgj6ZzBirUfn
xMu8/Koy1kyRaBJrYJSf+xxLYOVweUK6SuGaXt+dOxtrzzDsUm8dW/iNageyr6w5
NIKR3KPYA2S5EUIUkLG18rpOgGmW6NpWeMfofWYJsKDz7WfdF3QQhlv3k4keAyiS
DLEjAOKJNE5vEw844vu2D/S6M/8aRA==
=npef
-----END PGP SIGNATURE-----

--Sig_/zzwc=nD+l0LTsGSMcHUVPO=--
