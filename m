Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752594AbeCPFhx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 01:37:53 -0400
Received: from ozlabs.org ([103.22.144.67]:44519 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750847AbeCPFhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 01:37:51 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 16 Mar 2018 16:37:16 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: linux-next: build warning after merge of the tip tree
Message-ID: <20180316163716.5525294f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ov4ippMFQ/Cv/xz2gnpE0o8"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ov4ippMFQ/Cv/xz2gnpE0o8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tip tree, yesterday's linux-next build (x86_64 allnoconfi=
g)
produced this warning:

kernel/cpu.c:129:13: warning: 'cpuhp_is_ap_state' defined but not used [-Wu=
nused-function]
 static bool cpuhp_is_ap_state(enum cpuhp_state state)
             ^~~~~~~~~~~~~~~~~

Introduced by commit

  17a2f1ced028 ("cpu/hotplug: Merge cpuhp_bp_states and cpuhp_ap_states")

--=20
Cheers,
Stephen Rothwell

--Sig_/ov4ippMFQ/Cv/xz2gnpE0o8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqrWAwACgkQAVBC80lX
0Gygiwf6A5SujdvwFHccHTDe1+z3LSdkDcrawGJ4o6sjZ50qutkO6uKWkDJpYa/1
j+NzXaFwkRqfscxR9OkbyBfZu1QEFmKmNHxB85qlOIjVb/dW++FrsXGDNtBvg2f0
pD2RfUdQgBW+EUmRemKO9x84CK5D+1nRfPGVViolGGUwhvPYB96ea8xpGsVX0kjx
ZKCvERAkqqWlr8dykY/cOeD/FydiEHjeVlmcuD4d39vkE3MOvP9add//lhgUGAvl
UrjB29RuDF8Ue2Dp/iAg3gCtr3M5ApVThXrRkD9EZx6fQDF0AfS5f7aVq/hKuzDq
6v8bqZod1f6u0GX/iOUZ84JHpDA/Nw==
=XCDl
-----END PGP SIGNATURE-----

--Sig_/ov4ippMFQ/Cv/xz2gnpE0o8--
