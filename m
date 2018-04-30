Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752583AbeD3IIz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 04:08:55 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38401 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751819AbeD3IIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 04:08:52 -0400
X-Google-Smtp-Source: AB8JxZqwa8c4WsiV5EahugmUSw1vcU5sg6yv7OwqWTeHZlo5XBvo6/XvnYTwU8xNYfQU4V5gN2XNqA==
Date: Mon, 30 Apr 2018 10:08:49 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 12/15] memory: tegra: Add Tegra124 memory controller
 hot resets
Message-ID: <20180430080849.GD2484@ulmo>
References: <cover.1523301400.git.digetx@gmail.com>
 <0afee59fe60d661e8068763e66db109242a81554.1523301400.git.digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xB0nW4MQa6jZONgY"
Content-Disposition: inline
In-Reply-To: <0afee59fe60d661e8068763e66db109242a81554.1523301400.git.digetx@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xB0nW4MQa6jZONgY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 13, 2018 at 02:33:51PM +0300, Dmitry Osipenko wrote:
> Define the table of memory controller hot resets for Tegra124.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/tegra124.c | 42 +++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)

Applied, thanks.

Thierry

--xB0nW4MQa6jZONgY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrmzxEACgkQ3SOs138+
s6EdRBAAlLjyIyoYp7Uu+fyffbae0hJ7AasQX+qfYvXirA1U83Agc1NO8BLRPjJf
stvArJHjsNhWmlIi1MjdVYIRd6u6napXxZJ/ju0Y/fzs+tRbkhsfc4LIIRdx1RaZ
rDhnkHB1EOqftp2yYRA+Z9MAxWHGNSesAqSgRYZ+w40whvZef+ogE/jX9JXEcsIV
gmvAw88TvrJ4FKjSxkpWmG06808MnS6k025CmlMuRnCgYBDsS2vPxn00x7Ltr+o+
k1aWKXf2bbcHQZGGtmkAvaPP31G8P0BlSeTn80n59rIYfNhUFvIfapSWIkezr2l0
/8RWAMDZBinthNJud/BjZMOXJ4LlNLnhss+7ihJkeJ1l4GgscQnq+tRpbPWLF77j
2wjDFb0t2gqCLn55H8SQjg/AHvNKh+uUTyBhIsqY4g7s6ovkXBk/x8IV9WlPm/5j
5SS9h0cJf0HYDPW6Li+Oe9kTHhjQs9Q9GCc5jNVr3ltQiS46RkmYDw2sqpN6wyt/
10WIee03R454clQxRUmiz8NBXZ4qzAGBPvJNOZqG06eyN0SmpP3pnGNoLxaV0Ebh
KZQJsT2YRyeEN4SIj42/zf5ZOL6ll38G7/RMxrSSLJ5QIzGV24sHoHm27VoYD6Zx
tZ0MwuVny0+K14wU9tkNif/6CzEAB4xikzVtMC4dUgjKnv5aNTE=
=RD/6
-----END PGP SIGNATURE-----

--xB0nW4MQa6jZONgY--
