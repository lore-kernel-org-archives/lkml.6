Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933173AbeCGNLI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 08:11:08 -0500
Received: from ozlabs.org ([103.22.144.67]:53609 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751150AbeCGNLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 08:11:06 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 8 Mar 2018 00:10:45 +1100
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
Message-ID: <20180308001045.36c7e903@canb.auug.org.au>
In-Reply-To: <CAK8P3a1_cBKDYtaC7JxzbVhhfNmqcX7ULap3LK-Q-0dUj-MEgg@mail.gmail.com>
References: <20180305053742.9149-1-sergey.senozhatsky@gmail.com>
        <CAK8P3a1aCQWwrJuCmx-nrMG58NQFCkCPRuAT5g43Lty13nE2dg@mail.gmail.com>
        <20180307022127.GB802@jagdpanzerIV>
        <CAK8P3a172j6r2HEwQ3cOOqXgXkFbxYifQ96VRFZ3+=wGawYNLQ@mail.gmail.com>
        <20180307104002.GA505@jagdpanzerIV>
        <CAK8P3a3eK4iS9rEWvoRfH75zjj7KHpsPnofoGdWH28Dqbz-UyQ@mail.gmail.com>
        <20180307114845.GA894@jagdpanzerIV>
        <20180307234142.1c7d2710@canb.auug.org.au>
        <CAK8P3a2sA0BmR4cS4Af+d42MabzkZZEBvMaTpoWwOu-N7pP=dg@mail.gmail.com>
        <20180307235329.53331366@canb.auug.org.au>
        <CAK8P3a1_cBKDYtaC7JxzbVhhfNmqcX7ULap3LK-Q-0dUj-MEgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/YZSY/Zajd5S=_5VbghL9ViQ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YZSY/Zajd5S=_5VbghL9ViQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Wed, 7 Mar 2018 13:58:13 +0100 Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Mar 7, 2018 at 1:53 PM, Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
> > Hi Arnd,
> >
> > On Wed, 7 Mar 2018 13:48:09 +0100 Arnd Bergmann <arnd@arndb.de> wrote: =
=20
> >>
> >> Right. At the moment, the plan is to remove metag, score, unicore32,
> >> m32r, frv and blackfin. If you are building any more of those, you can
> >> stop that as well. =20
> >
> > OK, thanks.  Will I get a tree with those removal commits in linux-next
> > (sometime soon)? (I already have the metag removal via the metag tree.)=
 =20
>=20
> Yes, I should do that any day now, but first have a stack of arm-soc pull
> requests to take care of.
>=20
> I was planning to add these to my asm-generic tree, which is already
> in linux-next, and related (enough).

Excellent, thanks.
--=20
Cheers,
Stephen Rothwell

--Sig_/YZSY/Zajd5S=_5VbghL9ViQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqf5NUACgkQAVBC80lX
0Gy5FAf/c5ch5egW1P+YZeLTANf6R2Odgq1YpCgcm2TSIqFVp/GGvU+57LuL59Ic
UvezDMARjWsUkFGZL3q5yKRYKkSKPwlRViM3CIUo8oojjlLZAudxnW2MCM5XHVt/
9U5C+LlcxU502/X3rx1dcYIPZMp75PHCWC7QkT7LzPIk06fyLPDWulkZgbgFxsrk
NOLIQXUfKvVszCLySO4HIAKDLZt7rmcSpOnRhOTlWOS/fujnRp1XCC+o82SBBc8I
oDF//5ojOFQ8qeOvUANY76YBbfuSOHTFjTUiPMeNYuzPFLQKnLE2LUKink4FLlUt
CLw0pCVq5DL1Mqy+JckuAXN6L6n+xw==
=cGwJ
-----END PGP SIGNATURE-----

--Sig_/YZSY/Zajd5S=_5VbghL9ViQ--
