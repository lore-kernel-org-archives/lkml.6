Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754097AbeBGMyq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 07:54:46 -0500
Received: from mout.gmx.net ([212.227.17.22]:57345 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754007AbeBGMyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 07:54:44 -0500
Date: Wed, 7 Feb 2018 13:54:34 +0100
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
        linux-gpio@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Albert Herranz <albert_herranz@yahoo.es>,
        Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2 3/6] gpio: Add GPIO driver for Nintendo Wii
Message-ID: <20180207125434.d7wogzlkfthzob5t@latitude>
References: <20180122050411.32460-1-j.neuschaefer@gmx.net>
 <20180122050411.32460-4-j.neuschaefer@gmx.net>
 <CACRpkdZLiw=e-XiS9cbQuJGJ2tJVV86qKaLCy2yG==FSENhAHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="k64rgg4kcmxdkt7v"
Content-Disposition: inline
In-Reply-To: <CACRpkdZLiw=e-XiS9cbQuJGJ2tJVV86qKaLCy2yG==FSENhAHw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K0:R52YoqoVWOGVzME58AnuSapFhtuA1bLQoUlL9NztxUCQaKCTBZy
 t59m76E1oAI07o7j8wCj+wjXO/d4k2Z1ZcF4gz+99kh2saDQ2PBoYnpUr9UOjy+KtJJ7FRG
 OeMjNNnrDcRoavNB2ySrRZNFQQcVjvFrHlruhnUW9eTX5WEBailuW5NEJS/dzM5WAAlwQe1
 stll9wi7WY/fp2pJbvuvQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6PhaMktYqKc=:jiMH2mOEsJqt5pNKknrhcx
 ibQOBVIiCofX/05j9B2xHSlY3Q3znpoNC3JkY2iYAp65tF7PVZ/Ujt0KBXmsjTCKUdp81bvwQ
 wKolLhDBsF5CwgpotgN/jP9RsjxMxEMlff0p1K2SVi9a2FbQDdyaAiZ9sLv3TB+2WU/+DaK3O
 grJ4CtTrVADLLUR8kdlvyc2dZMhGjKZNPK81JHQZcxDOlIEgSH0goE1uHyv2sNEYSqfIGJAw4
 rAMzF5XrC++8v6+Vn3s5C27ahUyJgjNO98f4zTSVE75xdcKKVvn9qzTvUcqAW9dw+5GSKUxf7
 bwvijCFSNnzE2qN6nMDMAEyH50LxuSVnM3mw5CuvFkDWe47ubFVrQ4a+0/wjoHkxNd79zQ3XH
 +L50RMIwyn3/s6bco6ZPiT63ymG3sY2ahMyC5atyLw10obyGSeVcGDUc+dpN3mDjBO5Klvj35
 Qi7BFbv9mim7vxw8Ne/cwRXgB+NFXr723pVn3wPdMCBm4R5d1hJrYAp+FGt1UWrK8mjuD1J+K
 1soORmOpYgIcwv6BzbqTlYaTrBhQCCHD6WdwKYzNjWncnXH5GpgOTH2d4IKguC06HvQW7B+Z3
 tDWmibZmYYFw5A9IEKrGsfvMbN4EBz4yGPiug49VEQKAlsp4v8fyoNXg8WSE3cB2u3XbPEJ+W
 PrrLfA0+bQvyD5umeMncodQjN9bIohmLc4cAWMEEK7zcOU3fh+4SIV5tpPsCj2hm5sbim+7Ot
 U7/d9IORNk5XGjzliSEsZNVDcBUnrtUXUtar9E0z/fIO0ByWtIAwl+omAI2yB6G0TXDJITNfu
 6YqFliV3Z6zJoIm+hT16U/0rs7k2A==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k64rgg4kcmxdkt7v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 07, 2018 at 01:29:45PM +0100, Linus Walleij wrote:
> On Mon, Jan 22, 2018 at 6:04 AM, Jonathan Neusch=C3=A4fer
> <j.neuschaefer@gmx.net> wrote:
>=20
> > The Nintendo Wii's chipset (called "Hollywood") has a GPIO controller
> > that supports a configurable number of pins (up to 32), interrupts, and
> > some special mechanisms to share the controller between the system's
> > security processor (an ARM926) and the PowerPC CPU. Pin multiplexing is
> > not supported.
> >
> > This patch adds a basic driver for this GPIO controller. Interrupt
> > support will come in a later patch.
> >
> > This patch is based on code developed by Albert Herranz and the GameCube
> > Linux Team, file arch/powerpc/platforms/embedded6xx/hlwd-gpio.c,
> > available at https://github.com/DeltaResero/GC-Wii-Linux-Kernels, but
> > has grown quite dissimilar.
> >
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > Cc: Albert Herranz <albert_herranz@yahoo.es>
> > Cc: Segher Boessenkool <segher@kernel.crashing.org>
> > ---
> >
> > v2:
>=20
> All looks very good to me, Andy had some additional comments,
> once addressed in v3 I will apply this.
>=20
> You only need to resend this patch as I already applied the DT
> bindings.

This driver can't be used until the resource mapping problem on PPC32
(see patch 1/6 and the related discussion) is solved or worked around
with out-of-tree patches (such as patch 1/6). Should I send v3 anyway?


Thanks,
Jonathan Neusch=C3=A4fer

--k64rgg4kcmxdkt7v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJaevcCAAoJEAgwRJqO81/b+8AP/1ktieY5QgM4XqJ854jjrcr1
os/BTiYn6I9sxipwbqGwy48eqAoDJKoFrJBYklkSkRtS0141RLozcU0ImtLRvx8k
feGqYgHG6SINHXrUObmlVNbt3InwHXtl455m2bHAovrwdWrKh4fucVf7Yg7VwO2w
THVQIXwzGuoFxzbnLLHl+DRnUTbAOtwwSQN2pQ8QzFXVkbtwm0U80ZRkm8+2HmBe
mfrA6Av3H1/9HTtbp6Plx9SVsC4ZFUnzXsIiUlO9zAfhe/vfGJy4DkUgovEY2YGX
pWHmN9V1fQgzSYfgvqRwQx6Uis7JYDgEnT3hiZd98bddNWUG3vAGMGPjomgYSSIw
XPVQDNbOU8rP5VcOdLlQS+LQybl3nUL9It1Pei2GvC1oLCshXg2TNbpLcK6alf0v
19kwP7IAW9F4JH9QEnH2yQVdJZTHV8XSw9IYxALyOuzvnmrgd6dAhplx2EL4TbPT
2L+oY0qYtl5zOluKZ6sLmYD2ZLK0WiehVTRqjvu25TrKXu352fJyOPrmFCnfTCDt
K6nTS+JBVgVLTNbopdj/1bRLdRym5bljmpVQjbnjcHhY8RiVHntImsDKZIt0tq7W
qgaCGoNGRFt21Kb28quNuhhdzVxhz70kzPUHsEBbopAFh0LeKdrNloB9jfgxANG0
ccu2K8aRsheyqEjnkP/K
=OU8F
-----END PGP SIGNATURE-----

--k64rgg4kcmxdkt7v--
