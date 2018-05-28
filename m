Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754185AbeE1JTd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:19:33 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39122 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753984AbeE1JTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:19:32 -0400
Date: Mon, 28 May 2018 11:19:30 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] drm/sun4i: mark PM functions as __maybe_unused
Message-ID: <20180528091930.yjxlgn6ovgxw5r4w@flea>
References: <20180525155030.3667352-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="p7vd3pnmm36jeakx"
Content-Disposition: inline
In-Reply-To: <20180525155030.3667352-1-arnd@arndb.de>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p7vd3pnmm36jeakx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 25, 2018 at 05:50:08PM +0200, Arnd Bergmann wrote:
> Disabling CONFIG_PM produces a compile time warning when these
> functions are not referenced:
>=20
> drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c:1072:12: error: 'sun6i_dsi_runtime=
_suspend' defined but not used [-Werror=3Dunused-function]
>  static int sun6i_dsi_runtime_suspend(struct device *dev)
>             ^~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c:1043:12: error: 'sun6i_dsi_runtime=
_resume' defined but not used [-Werror=3Dunused-function]
>  static int sun6i_dsi_runtime_resume(struct device *dev)
>             ^~~~~~~~~~~~~~~~~~~~~~~~
>=20
> Fixes: 133add5b5ad4 ("drm/sun4i: Add Allwinner A31 MIPI-DSI controller su=
pport")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--p7vd3pnmm36jeakx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsLyaEACgkQ0rTAlCFN
r3ROBA//T9dF4b0HDQmd8IWj3ldCpIMw6Ems+pmvkNCF+IZNDdBPkLot8UsUoZRl
hmju9/se97XipQLxamJOWG/8+fWmzPQ8O/SDWIfU/5hvDX/EFo8+6Zg7ixayF7nq
14XCtgRLI9kKD11T/CLddLlrZThjP5IVpfLRKVTCGyEdyEO9A+rZoVH9YsN+yliA
6Dsw+767k8vhx0Q6Lh+CR6w01bi+aOPan5/De8xCI14pQ0B6cEtjgOpSLJCtfNi2
qM3WVaGwRsG0s1u+WH4Q2XLFhtjaleCyC4nILWcwdvEwsPzuLjsH/yAoCBzOad8+
gRgOyMbHlbvJKyNagp9G4v1oxTpTPnb5vFBqygocFyuld+15DkJitIIiEFNE4thy
KadncZsrH1TdDWdVAxyZNw9FCTRWIklpGssZX+3G7TvuftGJUHtDqdN+GnIJHR4x
D01CLURnQndwgRikI6mWWNaZsn5IPJEjDJ2TQVYITPsXc6OVYp2QMTDne/UINrfC
D8KgfNsh+8lAjYrXG+M5HDhOatH3kCZt9/eB42uTI/fLkrv9pZRLlYNkQVytftyJ
Bn7q95J2yxbaI9cjuoz6o5CJ5exFSvOqouVDa0dv1FLllFq3fsd7U2EKZq/N4AJV
OVpReTBHnBfVj0xbM/FRLhurrjxvP7RtFDN7CNGAEyaYLPEo2pU=
=2+fp
-----END PGP SIGNATURE-----

--p7vd3pnmm36jeakx--
