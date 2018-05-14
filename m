Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752380AbeENWVP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 18:21:15 -0400
Received: from ozlabs.org ([203.11.71.1]:38273 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752363AbeENWVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 18:21:13 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 15 May 2018 08:21:09 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the pm tree
Message-ID: <20180515082109.3b57619a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/LKqNOwcm4.nPHJQHAB_CO6g"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LKqNOwcm4.nPHJQHAB_CO6g
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

Commit

  e689ba60f1f0 ("Merge branch 'opp/genpd-pstate-updates' of git://git.kerne=
l.org/pub/scm/linux/kernel/git/vireshk/pm")

is missing a Signed-off-by from its author and committer.

This is probably because (despite its description) this is not a merge
commit - it seems to have been flattened in the rebase :-(

--=20
Cheers,
Stephen Rothwell

--Sig_/LKqNOwcm4.nPHJQHAB_CO6g
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr6C9UACgkQAVBC80lX
0Gxkcgf+MyAN7c+JKK6o8UuErih3oy4BEVABQox3PL3w7Pw4Ai9YaKRII1I2efM6
QbjKLwY2MLIEOT1VtOjlC0yslaiobtD6bXKHBHrbhs0pjfsLEz3elEbz+bCMIIBH
0WysIdS9dfMA3uOBi8+OhvJ4gU7ELH7DqFX1AW00d543j2Ny4vBuULK+O2v02xfb
i9o3NLVp7dfyzNtiAJGuvRjZ00itd5ubaTOq+/WLM0sB+rf5E1wZXhZMUkioh7un
HqodRIuMpfhyQFHJqhITsx9YVnQdM7h1KBfAZqR4Z6RE11bm/6fQYI6GWS4xS51d
dEt7pxXIk1ZR9/BRaKcZgP45j22qTg==
=I+fN
-----END PGP SIGNATURE-----

--Sig_/LKqNOwcm4.nPHJQHAB_CO6g--
