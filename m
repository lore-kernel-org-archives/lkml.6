Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751141AbeECLCW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 07:02:22 -0400
Received: from mail.bootlin.com ([62.4.15.54]:48990 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750930AbeECLCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 07:02:18 -0400
Date: Thu, 3 May 2018 13:02:16 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Satendra Singh Thakur <satendra.t@samsung.com>
Cc: David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Madhur Verma <madhur.verma@samsung.com>,
        Hemanshu Srivastava <hemanshu.s@samsung.com>
Subject: Re: [PATCH 09/13] drm/kms/mode/sun4i-tv: using helper func
 drm_display_mode_from_videomode for calculating timing parameters
Message-ID: <20180503110216.63bg3kw7cwppqbzx@flea>
References: <cover.1525087679.git.satendra.t@samsung.com>
 <CGME20180503105821epcas5p21a35d9eb29f83201d337a195d218fdd3@epcas5p2.samsung.com>
 <6919c8943505fe0c1f700e223a77194f85e64a58.1525087679.git.satendra.t@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lgigkszbbzx6w4e4"
Content-Disposition: inline
In-Reply-To: <6919c8943505fe0c1f700e223a77194f85e64a58.1525087679.git.satendra.t@samsung.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lgigkszbbzx6w4e4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2018 at 04:28:06PM +0530, Satendra Singh Thakur wrote:
> To avoid duplicate logic for horizonal/vertical sync_start/end
> helper func drm_display_mode_from_videomode is used
>=20
> Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
> Cc: Madhur Verma <madhur.verma@samsung.com>
> Cc: Hemanshu Srivastava <hemanshu.s@samsung.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--lgigkszbbzx6w4e4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrq7CAACgkQ0rTAlCFN
r3S/pg/+MXe2gtCoXT5/fNuuCzaAxJ1efpfbmb7+5tnqwIDypqISdBQ81iTDczF6
1yROTIOXSEDjNFeU8L1hyfi0qS0q2bh5b66iu/dOfqdk9LmI5HYNHTcC21lbLSM2
uxQoXCwZf3flcvaqiAl3lXDekiwftj5JPQK4YkJ5NG5N0QvzFVBX30U8BBsvKw4I
98VsraYe6+J9+HH4+KfoUz7lC11+xwOZIUqmmTdlrz1kLFqFliNouoxrwmSOZDjX
SejVTym6JtdIM+Gd68Vx3fsH4tcBCvdq7l1oQ9vLogXVs1lWSlXugM7Hbdp3X8oz
RK4J1Mh6wZA+Bv5XLhe2WPIqQrFFrhJ+1a+6jQVVkvHTN1Xm3rmDZ8vVcfF/0toz
xpnKxjbJTjYkbZ+21d5gaYmwi5+3LBXslDGG3dShCT+CQfnyMpMc1JzTN8u8uut2
ALVnNYpiCOlk1q9XnY7dmJnw2fJvCWih8BSnoZ0lxh+uEYdfx1u9k/s5BWcz+k+Q
v261DCAOtOYadQyrHAkCTE5TaRrjoYa0LuQuLThC0s/YHwk4iRGG0lYf2wCKy1Sp
hkxjhbNkszeAnFxurCtIxWco1AjgxRVcFZGVcl9hUOXCTn2TjJeqlXC/QcsNLte9
KhA9JmcQxqe7HhkpNhJlzFHADnwj3ca4morZJfaMwI+K5zFhNus=
=OP/7
-----END PGP SIGNATURE-----

--lgigkszbbzx6w4e4--
