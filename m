Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753761AbeC0Rmx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 13:42:53 -0400
Received: from ozlabs.org ([103.22.144.67]:46015 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751073AbeC0Rmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 13:42:50 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 28 Mar 2018 04:41:40 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Petr Machata <petrm@mellanox.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefano Brivio <sbrivio@redhat.com>
Subject: Re: linux-next: manual merge of the ipsec tree with the net tree
Message-ID: <20180328044140.18bab804@canb.auug.org.au>
In-Reply-To: <wih7epx8u60.fsf@dev-r-vrt-156.mtr.labs.mlnx>
References: <20180326091610.148fc62d@canb.auug.org.au>
        <wih7epx8u60.fsf@dev-r-vrt-156.mtr.labs.mlnx>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/H2mH2IuD14TjPrI08+G8TUG"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/H2mH2IuD14TjPrI08+G8TUG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Petr,

On Tue, 27 Mar 2018 17:33:43 +0300 Petr Machata <petrm@mellanox.com> wrote:
>
> Hi, this conflict needs to be resolved differently. Below I'm adding a
> patch on top of linux-next. Squash or apply as you see fit.
>=20
> What's the right way to proceed from here? It looks to me like Stefano
> or Steffen should take this into the ipsec tree (possibly just squash to
> the clamping fix), as they'll hit this conflict the next time they
> rebase on top of net...? Let me know what to do, please.

I fixed up the resolution in linux-next to match your patch from
today.  Dave will need to do this when he merges the ipsec tree into
the net tree before sending it to Linus.

--=20
Cheers,
Stephen Rothwell

--Sig_/H2mH2IuD14TjPrI08+G8TUG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlq6glQACgkQAVBC80lX
0GxWuQf8DzBm0vcumNlIYygzeh1tTKOOcVxdVlC/f3Gdj6Dly7esxhW7xHN0PeCW
wN02A7o/HJZlKceZMHiuJU6aZbQUA6MydZCutQEBPRhiqa2g0PWH5E6HC8JgjXct
D1LMzqR99FEw1J//5GF3R7e4/lWqKuE9c2PVWg6d5kMMfr2scltB+9amSm4K1rVG
s6bwycV9hGy4y+CHSFkjGp5n19DP+nGNw/hNxw96sv7hb5LLbily+W/djPqVqQgF
9NEbSE1cYjG3yPdST3HFkUj90p2RQg9izqPqBTKNJfkUC7YKiQa6e/GAdDRh0FkY
Sv9TM4pz7xJpjyBsA3lqy/GCi/ORZQ==
=EXRF
-----END PGP SIGNATURE-----

--Sig_/H2mH2IuD14TjPrI08+G8TUG--
