Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751869AbeCNX7E (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 19:59:04 -0400
Received: from ozlabs.org ([103.22.144.67]:53879 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751751AbeCNX7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 19:59:02 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 15 Mar 2018 10:58:31 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Petr Mladek <pmladek@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Tejun Heo <tj@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Dave Young <dyoung@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] dump_stack: convert generic dump_stack into a weak
 symbol
Message-ID: <20180315105831.327ff20f@canb.auug.org.au>
In-Reply-To: <20180314194237.45e2709c@vmware.local.home>
References: <20180305053742.9149-1-sergey.senozhatsky@gmail.com>
        <CAK8P3a1aCQWwrJuCmx-nrMG58NQFCkCPRuAT5g43Lty13nE2dg@mail.gmail.com>
        <20180307022127.GB802@jagdpanzerIV>
        <CAK8P3a172j6r2HEwQ3cOOqXgXkFbxYifQ96VRFZ3+=wGawYNLQ@mail.gmail.com>
        <20180307104002.GA505@jagdpanzerIV>
        <CAK8P3a3eK4iS9rEWvoRfH75zjj7KHpsPnofoGdWH28Dqbz-UyQ@mail.gmail.com>
        <20180307114845.GA894@jagdpanzerIV>
        <20180309095054.vrngc6fz7wo3hd4x@pathway.suse.cz>
        <20180314194237.45e2709c@vmware.local.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/3ea8B=M9/S259IXrRb_Id_x"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3ea8B=M9/S259IXrRb_Id_x
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Steve,

On Wed, 14 Mar 2018 19:42:37 -0400 Steven Rostedt <rostedt@goodmis.org> wro=
te:
>
> I still would like to keep it in lib. If blackfin is going to be nuked
> in 4.17, and nds32 is the only one that is causing a issue. I would
> highly recommend fixing nds32 and have Stephen stop building blackfin.

nds32 was "fixed" a few days ago and I stopped building blackfin a while
ago as well.

--=20
Cheers,
Stephen Rothwell

--Sig_/3ea8B=M9/S259IXrRb_Id_x
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqptycACgkQAVBC80lX
0GzOlwf+OtyLHiBOwdQzuR2OTmUwyn7wgnhmGmOdgoq3shh+rCmW8hZqM+wMIY34
Wtvh6GOqVs8sY3Vp6A+yJxk/dOtN06Wg7qIDo1GQBdZXD23rnuzquuvgqw8DrfTd
+ccxjsarL5wizkOz/bEuxHsNjy80bmnodqDfLmumVXwj1Th8KwDMJVrNyFGFWeXn
hM5r5C7PIwf3eALF0z4eVpWwx4Lidzd1qTjaDey/vNG978FAuj/0BYFMBn+nYbql
GYvwdX3OWDpjtPRSs1K/rhNOYHHNNmvU2ZgrLdEAa8cpaisi2DxNNJH+aa2tzE6B
QFkkXxDV0/dniTVekRzyh39Efs8kgw==
=1GtF
-----END PGP SIGNATURE-----

--Sig_/3ea8B=M9/S259IXrRb_Id_x--
