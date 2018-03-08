Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751232AbeCHVMS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 16:12:18 -0500
Received: from ozlabs.org ([103.22.144.67]:42625 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750955AbeCHVMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 16:12:16 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 9 Mar 2018 08:11:38 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commits in the rdma tree
Message-ID: <20180309081138.170ac574@canb.auug.org.au>
In-Reply-To: <1520542871.3126.116.camel@redhat.com>
References: <20180309075119.7b536dcd@canb.auug.org.au>
        <1520542871.3126.116.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/8QtisrC+.BveJDe1+RADjcE"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8QtisrC+.BveJDe1+RADjcE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Doug,

On Thu, 08 Mar 2018 16:01:11 -0500 Doug Ledford <dledford@redhat.com> wrote:
>
> On Fri, 2018-03-09 at 07:51 +1100, Stephen Rothwell wrote:
> >=20
> > Commits
> >=20
> >   63cf1a902c9d ("IB/srpt: Add RDMA/CM support")
> >   86af61764151 ("IB/rxe: remove unnecessary skb_clone")
> >   31f1bd14cbfe ("IB/rxe: remove unnecessary rxe in rxe_send")
> >   befd8d98f230 ("IB/rxe: change the function rxe_init_device_param type=
")
> >=20
> > are missing a Signed-off-by from their committer. =20
>=20
> I originally committed all of these and my SOB is there.

Yes, but Jason has (presumably) rebased them, so he is the committer now.

--=20
Cheers,
Stephen Rothwell

--Sig_/8QtisrC+.BveJDe1+RADjcE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqhpwoACgkQAVBC80lX
0GwEzgf9FQqbZi5muYhbSfVdLHUkm1cwBpxZD54pdVKntNpw5Z6byyKTYx67eMW+
njjqbwNiUiRcu5nUK9hQ8XHqfdTiqs1oyOpT7oDpe7BYhb96p3SIpPws4eXlDHE/
MLbfnc9R0icKaao2GiMr5567cfN1cgnHhhVEfUmRK4KGL8SEQYjXV2lvR1OVo6A3
TE9PWfSmATkwDNEAote+LqCe+PZE3eNz8vImj1C/z59qFkj/z7KFMIxt1tK1dWJF
iFbPMwkKj58LekrZtOPfyezS2PbWrF3oz1b/+kOJe3TN+3W4LSNlDl9AWCWWKKOm
f9MkXSgp70HKa7a9AwwckTxTdO/hug==
=VgQj
-----END PGP SIGNATURE-----

--Sig_/8QtisrC+.BveJDe1+RADjcE--
