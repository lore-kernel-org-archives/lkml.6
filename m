Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933543AbeD1NWn (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 09:22:43 -0400
Received: from sauhun.de ([88.99.104.3]:57920 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933450AbeD1NWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 09:22:42 -0400
Date: Sat, 28 Apr 2018 15:22:40 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: michaelsh@mellanox.com
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 - resent 0/5] Add capabilities to i2c-mlxcpld
Message-ID: <20180428132240.zyztrixveu6kx22y@ninjato>
References: <1522159286-41779-1-git-send-email-michaelsh@mellanox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ncvtkuoyl4fjv5nb"
Content-Disposition: inline
In-Reply-To: <1522159286-41779-1-git-send-email-michaelsh@mellanox.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ncvtkuoyl4fjv5nb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 27, 2018 at 02:01:21PM +0000, michaelsh@mellanox.com wrote:
> From: Michael Shych <michaelsh@mellanox.com>
>=20
> This series is resent (original series has been sent at 5/3/2018).
>=20
> PATCH1
>   It adds support for extended length of read and write transactions.
>=20
> PATCH2
>   It adds support for smbus block read transaction.
>=20
> PATCH3
>   Fix report about supported functionality.
>=20
> PATCH4
>   It allows mlxcpld driver to be connected to pre-defined adapter number.
>=20
> PATCH5
>   It adds capability register description to documentation.
>=20
> Michael Shych (5):
>   i2c: busses: Add support for extended transaction length for
>     i2c-mlxcpld
>   i2c: busses: Add support for smbus block read transaction
>   i2c: busses: Fix adapter functionality support callback
>   i2c: busses: Allow configurable adapter id for mlxcpld
>   i2c: busses: Add capability register description to documentation

Applied to for-next, thanks!


--ncvtkuoyl4fjv5nb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrkdaAACgkQFA3kzBSg
KbbFtxAAgYTinU5rcXbSnY2zlnpP5OGdXatWYN098wCL79QFEf5z/x0LIE7seAeG
NrCZghVXkNpsaiW4OAvR0sE+GfaaQlopoTgmccU0vwjXNKim6nLHBGXqMYwLYCCI
VjEOUg/eBywD1IVDKWlXmDT6l4w2YFwFBfQzWbpzyx9t/AM9jYSOTUAQqmlp0KGC
T2qwT2ei1u5PpesY0lYlNH3tMBPHwYeRkYDNiSjqXTQV3jzoVuX88Tclnz8fhnxh
Cs8pa3x+VhxI1axf4RTvvO8tAdk/KTtQx61VCNBuOcLcBpkJfBBxp4t4aq+ipOOi
qMyo/Nhte/VB+m3cbv+md9Eyeeux2Cry/pZYiyLbYCHFNghWGb2GM+ZnM2f+gyPT
QCCH4F6DEYPD+/ZFdFCevoXZCYxZC+bradcnWBSEAqOPyKxv4qolEePPP0v4ynb/
DKhCvF53eky2Ns7Wxs9tDKJyPug2cLKB0m67k78Bw0MZXVeAarzN+WoxF3UUw3ME
wpDZm/YyCqwn11VVUtHIU6Za8ko7Ol/2h7cuE9zEVmtSTyJf5TfMHkY9QDE09EKQ
NPlZ2ciE0w22UVpK/ZKT9PfF2uNUM++6yYZ/qFB4wthqI73Fy/eRdyhc/+liPqEF
0Ig8g+S0/Wdj0a8NuFRZTif1KDWZpE9dNplIQlQYxkfrI+okQLw=
=VOov
-----END PGP SIGNATURE-----

--ncvtkuoyl4fjv5nb--
