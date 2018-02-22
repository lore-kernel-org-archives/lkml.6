Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752203AbeBVE3C (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 23:29:02 -0500
Received: from ozlabs.org ([103.22.144.67]:59727 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752054AbeBVE3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 23:29:01 -0500
Date: Thu, 22 Feb 2018 15:28:57 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greentime Hu <green.hu@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Pull Request for linux-next
Message-ID: <20180222152857.60a47735@canb.auug.org.au>
In-Reply-To: <CAEbi=3ef0YhsWj9Sh6FZPWoaYJEZgtXq6_3u4CnXuqjCCLNOww@mail.gmail.com>
References: <CAEbi=3dGZe8S4pH-jwCZNm4EDA6FnJdUgPZv3CMPRgD=7SpH4Q@mail.gmail.com>
        <20180222112931.7001de9e@canb.auug.org.au>
        <CAEbi=3ef0YhsWj9Sh6FZPWoaYJEZgtXq6_3u4CnXuqjCCLNOww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/hV7GHUo2LVtD6x8YM.4GN0T"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hV7GHUo2LVtD6x8YM.4GN0T
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greentime,

On Thu, 22 Feb 2018 11:36:02 +0800 Greentime Hu <green.hu@gmail.com> wrote:
>
> Sorry about that.
> I did the following steps this time and please pull again.
>=20
> git remote add mainline https://github.com/torvalds/linux
> git fetch --all
> git checkout -b next v4.16-rc1
> git am ./tmp/*.patch
>=20
> Please let me know if I did something wrong.

Looks good.

I have added your tree from tomorrow.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/hV7GHUo2LVtD6x8YM.4GN0T
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqORwkACgkQAVBC80lX
0GyI1Qf/XvrSDxXvSR3mEy1jYiz1v+u+wgz10sVqrey3oIY3wOzDBmM5gbOedIDx
cuMc00a6wtx5nrCRM6rsOceKqaT4tLRjdYjVWrHNSYWMiAzcY76SmgL6+AHaslha
udLwIztF0iON5+v/tZZTuvCeWyatAz5Wxqker6A6RCtFCMgaJ+9AkorTvSeFfVZz
u7jGTWY0LYrliAPdtjMx1PwTyQf6/t+Ftnc1TRpWOWlfNt0DWitDtu+D0VAoJlRm
DdxdG7ZOCfpmGE6l/IrJ9x0zbYtNQDcqe8S34CB2ssWJY9QX6gAoZRk8WEDpRvzO
7nDJrAQhUriieeb7GiF9foWXLEWb3w==
=so+n
-----END PGP SIGNATURE-----

--Sig_/hV7GHUo2LVtD6x8YM.4GN0T--
