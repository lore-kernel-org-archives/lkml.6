Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932905AbeCGMmJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 07:42:09 -0500
Received: from ozlabs.org ([103.22.144.67]:34669 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753983AbeCGMmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 07:42:08 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 7 Mar 2018 23:41:42 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
        Tejun Heo <tj@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Dave Young <dyoung@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] dump_stack: convert generic dump_stack into a weak
 symbol
Message-ID: <20180307234142.1c7d2710@canb.auug.org.au>
In-Reply-To: <20180307114845.GA894@jagdpanzerIV>
References: <20180305053742.9149-1-sergey.senozhatsky@gmail.com>
        <CAK8P3a1aCQWwrJuCmx-nrMG58NQFCkCPRuAT5g43Lty13nE2dg@mail.gmail.com>
        <20180307022127.GB802@jagdpanzerIV>
        <CAK8P3a172j6r2HEwQ3cOOqXgXkFbxYifQ96VRFZ3+=wGawYNLQ@mail.gmail.com>
        <20180307104002.GA505@jagdpanzerIV>
        <CAK8P3a3eK4iS9rEWvoRfH75zjj7KHpsPnofoGdWH28Dqbz-UyQ@mail.gmail.com>
        <20180307114845.GA894@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/MNa1L8Q6xW4DCYqZoYwuj2s"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MNa1L8Q6xW4DCYqZoYwuj2s
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Sergey,

On Wed, 7 Mar 2018 20:48:56 +0900 Sergey Senozhatsky <sergey.senozhatsky.wo=
rk@gmail.com> wrote:
>
> On (03/07/18 11:57), Arnd Bergmann wrote:
> [..]
> > >> Originally I planned to wait a few more releases, but the last maint=
ainer
> > >> has commented that he will now send a patch for immediate removal,
> > >> so 4.17 is almost certain at this point. =20
> > >
> > > Would be great to get it removed as soon as possible then. Otherwise =
we
> > > will get broken blackfin build errors from Stephen (or would need to =
hold
> > > off Dave's patch). =20
> >=20
> > You could also add a patch to your tree that removes the blackfin
> > dump_stack() function, or we could ask Stephen and the other
> > people operating build bots to stop building blackfin right now
> > (they will have to do that anyway once the arch gets removed). =20
>=20
> OK. Petr, Stephen, what would be your preference?

I can easily stop building blackfin - and, if the intention is to
remove it, there is not much point in wasting resources building it any
anyway.

--=20
Cheers,
Stephen Rothwell

--Sig_/MNa1L8Q6xW4DCYqZoYwuj2s
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqf3gYACgkQAVBC80lX
0Gy6GQf8D4vZnoWoasod6+by1mLCpB1Yig5E03vMWebC07NRl7qNC/eelAkEDfTU
dDjItXsGKt3FtfzuwpS1+xMXrcJWeb1/tIv4zQy1hPY1JY75eZIqfV/zIaovRsk8
DnB+l1ImtqAWJ27ZvDkg8IdL+QhsPPC8yswjVecctcv0WR/ECE3JS10DIHVes1h8
t+nlwGdT11RjUvru/J1NO9/RHG36jNwyeG+oyF9ILSA2Na28vVSXswb06ajCt0gj
Rk8CvkJTTMxDmqQtbLHCtg6RoxMG6UwSS/P66V6J35FHRWZbN/1bblyBScjdAbuG
vcIa0OB7MP220octZb2wNyC3kLkToQ==
=5T7g
-----END PGP SIGNATURE-----

--Sig_/MNa1L8Q6xW4DCYqZoYwuj2s--
