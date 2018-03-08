Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751305AbeCHVBR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 16:01:17 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36736 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750928AbeCHVBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 16:01:16 -0500
Message-ID: <1520542871.3126.116.camel@redhat.com>
Subject: Re: linux-next: Signed-off-by missing for commits in the rdma tree
From: Doug Ledford <dledford@redhat.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Thu, 08 Mar 2018 16:01:11 -0500
In-Reply-To: <20180309075119.7b536dcd@canb.auug.org.au>
References: <20180309075119.7b536dcd@canb.auug.org.au>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-987OTnOD2uQZDei6/xj3"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-987OTnOD2uQZDei6/xj3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-03-09 at 07:51 +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> Commits
>=20
>   63cf1a902c9d ("IB/srpt: Add RDMA/CM support")
>   86af61764151 ("IB/rxe: remove unnecessary skb_clone")
>   31f1bd14cbfe ("IB/rxe: remove unnecessary rxe in rxe_send")
>   befd8d98f230 ("IB/rxe: change the function rxe_init_device_param type")
>=20
> are missing a Signed-off-by from their committer.

I originally committed all of these and my SOB is there.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD
--=-987OTnOD2uQZDei6/xj3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAlqhpJcACgkQuCajMw5X
L90UMw/6A5AmmsVmxotOt7OoldAUhVaFwT90seKfvaHGYX5kCOtD4Ip8F8XsGD1T
fpQJH64yooX7X27x8Z9lrpszV+f3s1nub9TWeBixpI9fgjG6y46HR/T/4UupbK2b
VA9AE6Shl18Oyw1W/DMotFzGuYIW8Niy1yQu9LZtk7o6kerazuni26/6ZNWYu+w8
S9X4ynQ6iLkqoKSu+zAQCvQTH3xsIU+fYfM5qVcZCik8+z06d8wEV71ySI6J0RbV
Jvfa7yhoppj4iW8qE2ga3zhth2kqzea5k2ro/d0ynNfLgGYFoMgOq6M8STHGm5jm
ZhqSTK+oY+uD/YCQD84nqsjXP1HWp9MtziV54FBhYoizmDY/bcsWagBwWTtSNJwR
2E7KacsRc4kTl13w6uB4jIipm9pNqVGUvCIh3xBWVi1NyNB1/NH5+XkxXaB6H8GD
fGVlE0eASvii39pLU6CR9y3z476rbquxqNzVXQH2V+2+Yy34yXS2rvJPXpBA9N/0
TxL/UpEoH3UUQeScrKmKhYvKKHeZguobnEj0R0PzsHdHuk7ZjxwqcIeN2JAPurJb
h+dhFehd4Slev09ruLAwEYIBvUsermWzlQJ0Nqne/9Ur/HO7UR8oFY4IWT6nxdk5
lb3OcI/Kn9FNi+WiaYeuvI5icdnnaIiUWiXjQ4f5due02lK6lXw=
=6gfP
-----END PGP SIGNATURE-----

--=-987OTnOD2uQZDei6/xj3--
