Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752539AbeEJVYG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 17:24:06 -0400
Received: from ozlabs.org ([203.11.71.1]:47391 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752299AbeEJVYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 17:24:05 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 11 May 2018 07:24:02 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greentime Hu <green.hu@gmail.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the nds32 tree
Message-ID: <20180511072402.16a5f3d7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ZI4zjYjw_0WnAbMRz46MVup"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZI4zjYjw_0WnAbMRz46MVup
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greentime,

Commits

  711b53601ac1 ("nds32: Renaming the file for unaligned access")
  fd3a79dbf575 ("nds32: Fix the unaligned access handler")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/ZI4zjYjw_0WnAbMRz46MVup
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr0uHIACgkQAVBC80lX
0GyqTgf/d51ikH/BELBphmquD0fC7PPSmIq4etsY3u4gM9D3D1pio055zdmqMA6N
v26G780xNasimlpsHNt9FpoEoXjENR0ghcu/M/Z15r+KpPVWaKVn0QYQIJYerYJi
axOTNM79JWjMFvEBFWD0/g995zv2XkVslnKHfzq7IJSFKVdC5eWbZK1/jEFGo8I7
vjptCE7YqqlYtTVLDu06pzz4nXjt6s4s51VDM10TgcGqjYSeWByICKeOo7FANRW3
SOXt1/Fj/2+v8X6UdxoTMzcAkWB6pH2nr/9Og04ft4hfL56R/UmxVbYMtN4UVpPF
SnmNej9NOeB2IApJOoj6io4xbHTu5w==
=IlJN
-----END PGP SIGNATURE-----

--Sig_/ZI4zjYjw_0WnAbMRz46MVup--
