Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968542AbeE3B3q (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 21:29:46 -0400
Received: from ozlabs.org ([203.11.71.1]:56103 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968253AbeE3B3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 21:29:45 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 30 May 2018 11:29:42 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build failure after merge of the kbuild tree
Message-ID: <20180530112942.2cfc2251@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ezt8wi.HWin5WsXSitODAqj"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ezt8wi.HWin5WsXSitODAqj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Masahiro,

After merging the kbuild tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

make was continually spawning test compiles.

I used the kbuild tree from next-20180529 for today.

A (partial) strace seemed to show that it was testing for compiler flags
(some more than once).

--=20
Cheers,
Stephen Rothwell

--Sig_/ezt8wi.HWin5WsXSitODAqj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsN/oYACgkQAVBC80lX
0Gwj7QgAisO4aksHIvPCu7NasI8joEAxTcwWmnEvnBe9miNLq4lvfmFc1XhVKsZR
sms5E1YvwdyN4UlLNgbKyVwqm7W6tykoFjdozsT6zpvCXyQT8mRFjDpxNjySEEsW
/dwzh7OmPjtzwSs25HFvN53/WfAgP/v9jl2EP8BR1wMJELZjCeXrGCkdC6n4uEVQ
RG20hzUkRDikRWw3VErDbOAMnekjeG2hq3pImTYA/pL9nHUJGsVHcMksk8dqqjnH
P0G9dCCs0T4CIkGBoT9Vhf8AQI993ODFQMTfK4p+wFNZzNBYkuDjVC3jd/LD7Byg
uBHbGhACh5Ph6DeJVTR2A8EvPp9vTQ==
=whsx
-----END PGP SIGNATURE-----

--Sig_/ezt8wi.HWin5WsXSitODAqj--
