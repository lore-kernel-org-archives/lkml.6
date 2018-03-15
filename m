Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932572AbeCOPwr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:52:47 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39675 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752503AbeCOPwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:52:45 -0400
X-Google-Smtp-Source: AG47ELviYGpd7cHdDYzMwX88It3wg4DPURnHPq50V69qw4UaB7uK/WKyGtxuuAOcaLwCXI+JnpXHXw==
Date: Thu, 15 Mar 2018 16:52:42 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/tegra: plane: Keep 'dependent' blending state of
 unaffected planes
Message-ID: <20180315155242.GA12548@ulmo>
References: <ebc6aef3f5cd7b9b9bb25ceff9e86e742390cfca.1521121707.git.digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <ebc6aef3f5cd7b9b9bb25ceff9e86e742390cfca.1521121707.git.digetx@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 15, 2018 at 05:24:31PM +0300, Dmitry Osipenko wrote:
> This way new state takes into account the current state of unaffected
> (by the atomic commit) planes.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>=20
> v2: Dropped unrelated 'cleanup' changes and fixed
>     s/state->dependent[i]/state->dependent[index]/ typo.
>=20
>  drivers/gpu/drm/tegra/plane.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

I've amended the commit in drm/tegra/fixes to match this v2.

Thanks,
Thierry

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqqlscACgkQ3SOs138+
s6H3dg/8DYbt0DnbCFtOHw571eklrOVaOmBT7DyZ/v/OUzpm5qjg01mEpRpP3U1F
Hdke00z0yPdy0CphcesqFLOYnzOdHXXPWoi2pskyII4aCQKCC2JcyK+FVzhJELc4
qBe34d/xabaGt+9oLwK8FSQgnXyYXi0HRiq8Yo6EXsv1Ouh5EagkE3TT+WTaOoku
AMCCkUzDEctw8yR7aQru7h0SEI2f0ipjJH7SPtBtLPdV3OMMBLny/7z7PYMyvkrB
ISRC1yNaGbp8HReWZmi+rcekMKPFgZk5Csp8LCe6l8To8APKhDR2G6ygcWbb7W2v
y0ToJ1BPtUZlUpQpLGMxtgUegP9RD0eSz47HfXAr+hVk5/X3EAPMkrb5b4/HHnqM
RMZ0BTC5pWUnSLuOBRzG/w/yge1vTArRt+JYS0aIbuCeuifzw4+m5iqtzT/+gylA
jv4gXbxCZYI9Eggt/LPY/7j9EQynNjJg5JmCP2J2DUlfeqzo9+frDiYpOCdvcvl8
v43Z+5CgJnDqb+5C1uaFv4V/2eOnFUawODnrlk9bRIqj1pjBeIaBMrgarCDS15kp
VTskgWQupJZq3o5XPPTbqUb31xZqyNyon9Vcvsl40acfXGuRThPVh04fvRx0izEJ
znbc6t7akh9p22ZGQDXTbkME0p/PDP7xcj903pFJCUzsjGGScNo=
=4tFC
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
