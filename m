Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755883AbeCHNnl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 08:43:41 -0500
Received: from mail-qt0-f182.google.com ([209.85.216.182]:32990 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755002AbeCHNnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 08:43:39 -0500
X-Google-Smtp-Source: AG47ELtDl6lXVIDiyYrPY35wCckQCxTNqGCzlSpih+IEy4vzcYhbyaP2xyyMDWMDmRM9J1CNh3CUNA==
Date: Thu, 8 Mar 2018 14:43:35 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: tegra: adjust tested variable
Message-ID: <20180308134335.GD3529@ulmo>
References: <1517063308-16679-1-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="P+33d92oIH25kiaB"
Content-Disposition: inline
In-Reply-To: <1517063308-16679-1-git-send-email-Julia.Lawall@lip6.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--P+33d92oIH25kiaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 27, 2018 at 03:28:28PM +0100, Julia Lawall wrote:
> Check the variable that was most recently initialized.
>=20
> The semantic match that finds this problem is as follows:
> (http://coccinelle.lip6.fr/)
>=20
> // <smpl>
> @@
> expression x, y, f, g, e, m;
> statement S1,S2,S3,S4;
> @@
>=20
> x =3D f(...);
> if (\(<+...x...+>\&e\)) S1 else S2
> (
> x =3D g(...);
> |
> m =3D g(...,&x,...);
> |
> y =3D g(...);
> *if (e)
>  S3 else S4
> )
> // </smpl>
>=20
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>=20
> ---
>  drivers/firmware/tegra/bpmp.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Thierry

--P+33d92oIH25kiaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqhPgUACgkQ3SOs138+
s6HFwQ/+OPn2T/yc9RXznPlpyt5yMNxjvCUFFnugI3o+WQu1wvM42JahxvRFe3rY
HgWdRrg/7AMMIpFU+uXOjjDxBhCzGT+91CoOdD3ugACu9lvCNAxxvw+wlrOvcP9k
aMB63V8RxtEzlsEIowVlt3uS6TDiHJSCSGVj1tTq3JuLRQZ6mZ5Kw2sU4827tR/4
sdrlElA9F4s7fJbDxvQK8l16BQKa9KqH38v/uNyH8Bomn3mtknV7IrrdgYiYBXAZ
ytACHn8ifEziLZI1F1RKR4yJ4lEmOVQsFaD7Uk920M4y+mmKlOSyIDLQpZdJtcxg
KFCVqo8bE1Jmv12fypPn4hkj27JSTLpu0Kb1D3xEEIfXdL0JMfihgKyy/CwOZO7d
1AFynLn0n+ZAaJgqKpCgfFTiX/5YBD7LvGqhikowVLg2l5XZxdZdl83YKzh0/JIL
xsMD1Ieg34xszH/0qfNGNbi0NhxRJrcyLZTF8OU32cVXYQkRAWahJupLro02q9Uv
kDlDfMNWllZl/3landBv/IjFq5RefKDRwOiOFYP9+6jWOU9B/VPBQqC3yMp0CDx6
biYU1SjlMLhNm0K5XX0vOvheyiekM/ht5+7qibEryurFtkqRYqhqF5wmZan09uru
7MOzjmu+S20S/mxvZB4yvqAoz3XR4r/zLFpuC/UJr+2oqMyQ2o8=
=Bc3N
-----END PGP SIGNATURE-----

--P+33d92oIH25kiaB--
