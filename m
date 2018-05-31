Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755940AbeEaSE5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 14:04:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59070 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755848AbeEaSEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 14:04:55 -0400
Message-ID: <dc29e2b147cae0e13e570c2c6c62a433414b25ac.camel@redhat.com>
Subject: Re: [PATCH] RDMA/qedr: fix spelling mistake: "adrresses" ->
 "addresses"
From: Doug Ledford <dledford@redhat.com>
To: Colin King <colin.king@canonical.com>,
        Michal Kalderon <Michal.Kalderon@cavium.com>,
        Ariel Elior <Ariel.Elior@cavium.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 31 May 2018 14:03:53 -0400
In-Reply-To: <20180530094029.10747-1-colin.king@canonical.com>
References: <20180530094029.10747-1-colin.king@canonical.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-fZQ65AHqLw3T4cI0Jayg"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fZQ65AHqLw3T4cI0Jayg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-05-30 at 10:40 +0100, Colin King wrote:
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
--=-fZQ65AHqLw3T4cI0Jayg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAlsQOQkACgkQuCajMw5X
L91YzxAAhBw5z7RJNEPHFbcMVhdKm8qDhCcv+N84eMt1ngLnALedIyWisgl3GodM
Z8d/yE/CQG1JDRbuJlc6qZ0E3iMnkA8h2PMnVGIYI4F/Nf/zNGbNSnd18hwsewjx
KlAUtv8F9eGM/3xsb8+0F3fTFdqkIKmULbs9WKUsThCSlq+SqOrEZBXK1Zd9KfAq
aDnAoGzuHgrukTN00yOwwTq3hRxDuA+a1SJ2BGPdiMCDEj7tfDve0ZBpL9orTAwX
YsoBaGIOJGgJmPlpgCRXhaZw/cOvvlmPoUSB0i+lH42qtGHI2VjzGTWtref9jqFp
+8ntHWETIEUNDmggVjnrkruogp0LU59zQbFPFV9IiJGK68MVDzM29Vxh0ToG35wl
/eVhnQ78Im32PmdSvfa8ctmChDEJNeDpXG9XHwPq8mjoXGPkKpDnomA7zZKRDgwR
2HR6IgN9iHSwn0RCNXNLxGzwJIqxHLbq8eKkDUpCx59H+LLAlywBWp67oxNEqDKx
SoyP/MSc2tvtEVcRKvsl1VnKN+GbFpI6TqJg3jk/w6Th1oyAwi2PnzuDi/vyGWXq
LZAeU8mV707db70kOI4P9xyIivUHJllycUD7Bl2rfa0za/colXPZQZvbcwUwXFZf
CyR4H3oGgvgWm5ByRzZwonqtYd2la1+rPGHVq15cfGkJUHl3fP4=
=k/CM
-----END PGP SIGNATURE-----

--=-fZQ65AHqLw3T4cI0Jayg--
