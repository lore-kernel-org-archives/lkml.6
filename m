Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751582AbeEBOBA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 10:01:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46132 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751109AbeEBOAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 10:00:55 -0400
Message-ID: <1525269652.11756.134.camel@redhat.com>
Subject: Re: linux-next: manual merge of the rdma tree with the rdma-fixes
 tree
From: Doug Ledford <dledford@redhat.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zhu Yanjun <yanjun.zhu@oracle.com>
Date: Wed, 02 May 2018 10:00:52 -0400
In-Reply-To: <20180502102237.GG20375@mtr-leonro.local>
References: <20180501101017.517b38af@canb.auug.org.au>
         <1525136135.11756.94.camel@redhat.com>
         <20180502102237.GG20375@mtr-leonro.local>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-eMP6AqRXDUkEHD4UIcWj"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-eMP6AqRXDUkEHD4UIcWj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-05-02 at 13:22 +0300, Leon Romanovsky wrote:
> On Mon, Apr 30, 2018 at 08:55:35PM -0400, Doug Ledford wrote:
> > On Tue, 2018-05-01 at 10:10 +1000, Stephen Rothwell wrote:
> > > Hi all,
> > >=20
> > > Today's linux-next merge of the rdma tree got a conflict in:
> > >=20
> > >   drivers/infiniband/sw/rxe/rxe_resp.c
> > >=20
> > > between commit:
> > >=20
> > >   9fd4350ba895 ("B/rxe: avoid double kfree_skb")
> > >=20
> > > from the rdma-fixes tree and commit:
> > >=20
> > >   2e47350789eb ("IB/rxe: optimize the function duplicate_request")
> > >=20
> > > from the rdma tree.
> > >=20
> > > I fixed it up (I think - see below) and can carry the fix as necessar=
y.
> > > This is now fixed as far as linux-next is concerned, but any non triv=
ial
> > > conflicts should be mentioned to your upstream maintainer when your t=
ree
> > > is submitted for merging.  You may also want to consider cooperating
> > > with the maintainer of the conflicting tree to minimise any particula=
rly
> > > complex conflicts.
> > >=20
> >=20
> > We will probably merge the for-rc branch into the for-next branch in th=
e
> > next few days, at which point we will do the conflict resolution
> > ourselves and your need to carry anything should drop out.
>=20
> Isn't "rdma/wip/for-testing" branch intended for this?

Not really.  It's there to provide a pre-merged branch for people to
test.  But, I've rarely seen a release cycle where, *sometime*, we
didn't get a patch set in the for-next that depends on changes in the
for-rc area, and in that case, you need to merge for-rc into for-next.=20
If we don't have that this cycle, then you're right, I won't merge for-
rc into for-next and for-testing will be the throwaway merge branch.  On
occasion, if the merge fixups needed between for-rc and for-next get too
difficult for a non-RDMA person to sus out, then we will do a merge of
for-rc into for-next simply so we can provide the right merge fixup, but
I doubt this merge fixup rises to that level.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD
--=-eMP6AqRXDUkEHD4UIcWj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAlrpxJQACgkQuCajMw5X
L934eBAAjucQJds1M425l/yZ0FBrq7ZAmx/z+HaSyTbzk+0vjeSXEnKNWKhS3VNH
MeR13EfT1Jag2e8+WvbetjGEL+fIjZxKVCER0cT9+tJPXaK+kzGlLwsVXcPAbNeX
iAIxOcgh6DQWQ5jU0dfkQdj8omEC8lEZOkY5uGWgqrwtWTAdAQgVPnxJ7cADprGf
1tX9M3GyLU44WCOrxx6UYi1TRJ67ulmwJWaSH7mRocBwvSWaz79phAgVPj9NqJAi
4492FxReszSK0IUl6ckKIGgQKGqPXimyh5Si6Pg1snlsnUMbHsqxPdmWQ11f/7c7
smVT6sh8lTMa2DZj34754dpyRVl9c2l61stjYEeho4LqIGQma+VFmHhSsg5j0+pS
tS88NWmzO2pD9xWBMKkfzmn1N//X+ZClH6IvLzvcQHH/MaKNGBXM6yJ7ONNR8Xsl
G0TbtG3UpeipO3SAQ02oVV/53zxRmIV7+iKhHMboEmwLOwW0EVZ7x/mE3htNHMdy
3NDEN/B5zrpx/61B9vTzxlVBQQwj6qkqBqjA8wXZHUuKJtqeW151g03gbcItEerT
jt7+7wDstW0YfToOumPt9TlfUI2SorXzan9TAHPyUEGW4jaVdNWk9IH2dVgB1ksN
gFxN2rhQnyeESqfBE8O0CISsmAMphF0ws6yDtF/dXnNEsrW9QJ8=
=rqS9
-----END PGP SIGNATURE-----

--=-eMP6AqRXDUkEHD4UIcWj--
