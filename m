Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751314AbeBRI0n (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 03:26:43 -0500
Received: from ozlabs.org ([103.22.144.67]:54965 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751052AbeBRI0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 03:26:41 -0500
Date: Sun, 18 Feb 2018 19:25:55 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: linux-next: Signed-off-by missing for commit in the tip tree
Message-ID: <20180218192555.73537987@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/owyJgx.grxFGcTYjGywLaXi"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/owyJgx.grxFGcTYjGywLaXi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  f091f1d6a2b4 ("tools/headers: Synchronize kernel ABI headers, v4.16-rc1")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/owyJgx.grxFGcTYjGywLaXi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqJOJMACgkQAVBC80lX
0Gx1JQf/WyWEGejyCrXI7rhrs1PhIZa1S7MopA0YexpxviQGImamRfJEX5ofQr5i
upd1kb40qKc1gAbxuQ1wIyMFjbyH/BtdhZ3+NpwMzF6wPaQvJeGHLwHiKKcjPW5e
z+BlfZ2EiXdg2V0Wg/JmHQS4n5EEhuIPe7nsNaHPuBZ/svrcyhZdEpiAAv3s92WE
O9KbPEG3NIZlw/0SSY4zSWt9K/h7Elp/3sCeQh6bQ9J7XBBadMRNL+efuxVAlVSw
wxZzbIlR6INuRkbzN0+6q3uGJg4VdEuxfsVh1JryzhFise63vGkXtEivWhIfDJ27
gdGpUlsgss1AI/o7EwFkTK0zHZ9oBQ==
=lWW8
-----END PGP SIGNATURE-----

--Sig_/owyJgx.grxFGcTYjGywLaXi--
