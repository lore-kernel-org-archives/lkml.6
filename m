Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755955AbeEAPgr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 11:36:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59478 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753878AbeEAPgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 11:36:46 -0400
Message-ID: <1525189004.11756.102.camel@redhat.com>
Subject: Re: [PATCH] RDMA/qedr: fix spelling mistake: "failes" -> "fails"
From: Doug Ledford <dledford@redhat.com>
To: Colin King <colin.king@canonical.com>,
        Michal Kalderon <Michal.Kalderon@cavium.com>,
        Ariel Elior <Ariel.Elior@cavium.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 01 May 2018 11:36:44 -0400
In-Reply-To: <20180501082549.22215-1-colin.king@canonical.com>
References: <20180501082549.22215-1-colin.king@canonical.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-S3lX0KyBGy1LG9TOjIxF"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-S3lX0KyBGy1LG9TOjIxF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2018-05-01 at 09:25 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> Trivial fix to spelling mistake in DP_ERR error message
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks, applied.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD
--=-S3lX0KyBGy1LG9TOjIxF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAlroiYwACgkQuCajMw5X
L91Zgg/+LvRAF5RTMvQTjOytdbsBOZIrwIpvKWbvee6wccr8qd9EXPAn3j9wLtCd
pBeUP4nXLB3XA2qNa3eQL+2XU4SRVhesfxwQuo8NHyy1HPKgfNn2Mw/UNKXGwMOR
IzFV7DJ64SOrZ0fhaLAfCklza9pZXooVHDui/7KqdtYcdxVj3qMUXoQxuslzLBUZ
7enS4wgnjga1b02NEBGymut8R+zAbmRhnME2gEelbKki/RbQLL6frrMz5BQLfsf8
cyz7xgMzhCE7XVg0+N9u6pjdCwoogASPmz0/tcphq6h3vNp1ogAsFmCC6nPkRAIj
Sa1bpwtfpaWh+KLv7Z7Tp2++cI/RYrnQ9u6JOSy4vxg4p2IDqY52g2XSBj/8rlYm
4Fxkrbi/txq7urInJki7/Z8D/X781Wn9JEuO1TV19nJjztL0nNsRhr3Z2anNMc1u
r7BOzcW62rxM6HgTiQeH3BPqeSAA4d8egRECgouJGTBBeDl90USb+slD20Bxyvsj
O7BkX8OzD6K6gWFZKbbO9ZfxjRUFQEcal46GU9XuDRftkVTl5PLt05rZmrJCkZpc
+lgbosl6+xj0VkvE44JeCim+LJUzUDlrKmcpcsPB5AlIHWX65pr8JlVuwgA609Aq
CMmW81o5O2aCoiOxjzGlTDihF7QdWpgUJOu63YfIAlOT53x75/Q=
=73Ky
-----END PGP SIGNATURE-----

--=-S3lX0KyBGy1LG9TOjIxF--
