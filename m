Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754189AbeCGMxw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 07:53:52 -0500
Received: from ozlabs.org ([103.22.144.67]:48111 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751142AbeCGMxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 07:53:50 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 7 Mar 2018 23:53:29 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Tejun Heo <tj@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, Dave Young <dyoung@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] dump_stack: convert generic dump_stack into a weak
 symbol
Message-ID: <20180307235329.53331366@canb.auug.org.au>
In-Reply-To: <CAK8P3a2sA0BmR4cS4Af+d42MabzkZZEBvMaTpoWwOu-N7pP=dg@mail.gmail.com>
References: <20180305053742.9149-1-sergey.senozhatsky@gmail.com>
        <CAK8P3a1aCQWwrJuCmx-nrMG58NQFCkCPRuAT5g43Lty13nE2dg@mail.gmail.com>
        <20180307022127.GB802@jagdpanzerIV>
        <CAK8P3a172j6r2HEwQ3cOOqXgXkFbxYifQ96VRFZ3+=wGawYNLQ@mail.gmail.com>
        <20180307104002.GA505@jagdpanzerIV>
        <CAK8P3a3eK4iS9rEWvoRfH75zjj7KHpsPnofoGdWH28Dqbz-UyQ@mail.gmail.com>
        <20180307114845.GA894@jagdpanzerIV>
        <20180307234142.1c7d2710@canb.auug.org.au>
        <CAK8P3a2sA0BmR4cS4Af+d42MabzkZZEBvMaTpoWwOu-N7pP=dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/QgMsei/S.KTruUSJ1_Y0=7B"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QgMsei/S.KTruUSJ1_Y0=7B
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Wed, 7 Mar 2018 13:48:09 +0100 Arnd Bergmann <arnd@arndb.de> wrote:
>
> Right. At the moment, the plan is to remove metag, score, unicore32,
> m32r, frv and blackfin. If you are building any more of those, you can
> stop that as well.

OK, thanks.  Will I get a tree with those removal commits in linux-next
(sometime soon)? (I already have the metag removal via the metag tree.)

> The fate of tile and mn10300 is still open, but I suspect they won't
> last long either.

Noted.

--=20
Cheers,
Stephen Rothwell

--Sig_/QgMsei/S.KTruUSJ1_Y0=7B
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqf4MkACgkQAVBC80lX
0GwXVgf/aAZtEA6SHcuFADY5/9kG531G7e4IPyzbAncnx4mofYbilxgYUXrxmlBs
lFZUZBduqZb2qIhX0ldttkchNPgq8PtJFLFAfJgp6ryIY9AFhfbRyr6kGfaaUsS7
6v+w8iJ+qN9vUgRhiLyx6WIjNTN7+A8F+k6E1+OMpcbGgp6RJCogf3Q9q8JRsTDV
e5Wz9XeZDl1y/7UEE8ofoh9wP7CYZ77rvdh5ihkmFvcEGTcz38IErFcyKuc8uNTu
OpV/Br/b52n9fDEisGJgEYYWmjsqr7L8s+qxt/x10Sl5Rmt7zSOoBQcmVFw1QUdR
C4BmFIETfUSwYF19Uvb3wEfCi3yvlQ==
=ANd4
-----END PGP SIGNATURE-----

--Sig_/QgMsei/S.KTruUSJ1_Y0=7B--
