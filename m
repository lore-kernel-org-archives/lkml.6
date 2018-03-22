Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756126AbeCVOaz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 10:30:55 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34364 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751753AbeCVOau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 10:30:50 -0400
X-Google-Smtp-Source: AG47ELvNDskzjPd/SOtPamYIN4++6qr4FA2/7QLCfCeauYOOD6eEOHw2NNmuu2dULKNmLjAGWMQ5FA==
Date: Thu, 22 Mar 2018 15:30:46 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Marcel Ziswiler <marcel@ziswiler.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        Stefan Agner <stefan@agner.ch>, jonathanh@nvidia.com
Subject: Re: [PATCH v2] drm/tegra: dc: use correct format array for Tegra124.
Message-ID: <20180322143046.GB5853@ulmo>
References: <20180320091144.22421-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Content-Disposition: inline
In-Reply-To: <20180320091144.22421-1-marcel@ziswiler.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 20, 2018 at 10:11:44AM +0100, Marcel Ziswiler wrote:
> From: Stefan Agner <stefan@agner.ch>
>=20
> Use tegra124_(primary|overlay)_formats for Tegra124.
>=20
> Fixes: 511c7023cf23 ("drm/tegra: dc: Support more formats")
>=20
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>=20
> ---
>=20
> Changes in v2:
> - re-based on top of today's next
> - added my ACK
>=20
>  drivers/gpu/drm/tegra/dc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

Thierry

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqzvhYACgkQ3SOs138+
s6HMSRAAsAJtTuoQGKKJRqLI27mnGs3elabEL5nZAHkSPAC9HUNvRdR8OjyxGBZE
KBum6wWCuYbiu615YyoJwqj1DeGlp5YXFfiF5cWyvZUjL1z7Y1Nx5qjrTE0SCeuB
l1x28zKv2t2KPAzRPjijczNjbhnhPpoHxD3HYvzSoYF9xW1LM7Mff3eFyWKMCyzx
UNRQ1oR2W5HOrN9nV3/NqWRwWuE/cfrQE3zNDyjR/87WtdzJI+jwOZR/X7fa2a/3
PbY7kytM3fFLaYPQnh89Z+tboOaqvJ2a46ugfqu99vvhZqA7hmKpyic6O7IJWoKN
T6jn/LTlr9AFIcWmNDxNCxyH1xkOY2ephoxssTqUQgEA/ow1AB9zqMle9JeGg+X0
Xjn1a8yOGI8MBRM3Z4zFxk6aI8LeOtbkhL7Az6mgZq9H8dgxM4YJ5OUa6+ouaROA
988xAyFq/HR6cskeHYcbZDQoMNSkMICnT7xALKVHSR5Qeb3wCp8Q0pDEn7vZtOlF
IM2rSnQvAtwd4Zpyp9NMW6onEct6oPvmsJAwkL0Lp93GP2f8+0Zthdy4Sk4ju2+5
JlGlJxLC5LpsSlTUiRQRgqzl5FgyoiAmiz9HEFIb+DevgVWnv5LgOBhg78L0gyU8
PxIvXE4MEULgGt/EiClfOgVke/lgFp1m9SvmNcWK4X7vS/bnF4M=
=GEmo
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
