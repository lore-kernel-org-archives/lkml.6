Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752056AbeEQUqb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 16:46:31 -0400
Received: from ozlabs.org ([203.11.71.1]:44765 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750938AbeEQUq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 16:46:29 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 18 May 2018 06:46:26 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: Linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        0-Day Mailing List <lkp@lists.01.org>,
        Linus <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: linux-next: a new pending-fixes branch
Message-ID: <20180518064626.3f79e30f@canb.auug.org.au>
In-Reply-To: <20180517174247.GI8514@sasha-vm>
References: <20180512143523.250ab803@canb.auug.org.au>
        <20180517174247.GI8514@sasha-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/q+yAS7jwNljWY7ZWzXY11hb"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/q+yAS7jwNljWY7ZWzXY11hb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Sasha,

On Thu, 17 May 2018 17:42:49 +0000 Sasha Levin <Alexander.Levin@microsoft.c=
om> wrote:
>
> On Sat, May 12, 2018 at 02:35:23PM +1000, Stephen Rothwell wrote:
> >Hi all,
> >
> >As an outcome of some discussion, I have added a pending-fixes branch
> >to linux-next.  This branch contains Linus' tree merged with branches
> >containing only fixes pending for the current release.  The branch is a
> >strict subset of linux-next each day (as so rebases like linux-next
> >does). =20
>=20
> will you be keeping a history of this branch like the linux-next history
> tree?

I hadn't intended to.  Do you think it would be useful/necessary?  The
commits themselves will be in the linux-next history tree, just not a
separate branch name.

--=20
Cheers,
Stephen Rothwell

--Sig_/q+yAS7jwNljWY7ZWzXY11hb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr96iIACgkQAVBC80lX
0GyQ0Af/b3DC6F3s+A/epMJBLWWvkoX300qKz6q/Nh8FrEzPEtW2JHgL+wl69kl6
+qymGxH5sc1VXixon0PAv8ir8PTHTxwcgqKl6iBIPmpigroHbY4QCPKUFSaDQfFP
dhe3pSj7BrxM566R9jo39ct2MQ+ECvNOQtCt0Ata/xKqFKag8L7pQhdwZpZpRI76
te7Se6Pljkyssj2yWXzWFWGVYE3b/5gl0j1yqSiRq6U7ohw0Ezb6eAuHgMFNA1NO
BYrPAwPjBADnsCD2OYpjc+YmWiHNOdhbHGoeC48FLvGiokTX2it83la+eIrwK+2p
HvorCy2sIFvxlpqSQ+LDwyknSNjd6A==
=t8rP
-----END PGP SIGNATURE-----

--Sig_/q+yAS7jwNljWY7ZWzXY11hb--
