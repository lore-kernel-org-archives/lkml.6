Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755817AbeCHPJt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 10:09:49 -0500
Received: from mail.bootlin.com ([62.4.15.54]:52640 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754898AbeCHPJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 10:09:48 -0500
Date: Thu, 8 Mar 2018 16:09:44 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Mylene Josserand <mylene.josserand@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] ARM: dts: sun9i: Add enable-method for SMP support
 for the A80 SoC
Message-ID: <20180308150944.mlkgsrwhsk7hrlcp@flea.lan>
References: <20180308150012.19045-1-wens@csie.org>
 <20180308150012.19045-4-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="22gesboi3cwo33jg"
Content-Disposition: inline
In-Reply-To: <20180308150012.19045-4-wens@csie.org>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--22gesboi3cwo33jg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 08, 2018 at 11:00:11PM +0800, Chen-Yu Tsai wrote:
> Using the enable-method property for SMP support would allow future PSCI
> implementations to override any in-OS support. This is better than just
> matching against the machine compatible, and then having to determine
> whether other methods are available or not.
>=20
> This adds enable-method properties to all CPU nodes.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--22gesboi3cwo33jg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqhUjcACgkQ0rTAlCFN
r3RH/Q/+PMF0nKf4Bo592DAtUNM88kk7y2NhRJjfizmMN2gObNoaqG6myczNM0bm
XMIl5whmglM64iVwd/TOxfqLTq/kaElCQ+YQGRigmPv1/wgo14bMh5zaWJwWqMQX
YNexhJRMIuKvxkluZIHYgNo0NkWcDhk89vpcQL45hUqPSBhVFt4bSwV6zcfshZA2
NZE73OKG1A8Ki2r4dLaliESwmJvg5fwbD4U9N2ar70NwAaVP4OAnCNLR97YPa+Bx
94WnqzlL0MbBc9wFMn6in4ZG/dgMVR4FiNoIJav3d7QY0JQcgSEX7Lm98LvXMEe1
yYzmGk8szWazJNLOUkKihcjaNse0fafh338rjfF4GHFGJsDYqMaEqXC5ungvLk7r
Mpr3bYXbmDVzcxcZpq6fAdC3YASJa3+ZLx5NtWXHQMfgm1NC/0uRTnXAFMWvkCAe
PNlYug7gD7Zqwc3nHeG5Vz3dLN4Zec8tQIdAe4tusbMtV4ikjUeiINuVyYgFmED6
dm4jvmlvVT+YYB3LXOdLhM+qlK9e4RY9DYXVcTmb0YKzI3TJe+FcM3NaofYFvlyp
4iXBrTpF6Y74gWbLkR8604UukD0uTqdT6xsfrTSzaZ4xt+G60W22+IVFUiygD1q7
dGDm8fiRlbwLzFTqYnNZq3/3xdibDzLukws/0oXbQi1lLxsuD/4=
=mR8N
-----END PGP SIGNATURE-----

--22gesboi3cwo33jg--
