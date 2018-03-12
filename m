Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932188AbeCLJH1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:07:27 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35664 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750811AbeCLJH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:07:26 -0400
X-Google-Smtp-Source: AG47ELsJSuNpAxqrgyR/exUAyYbV5vROxzuJpYK/MjRp12Q1bnwA4ifPx9uJbXwcK7L+yuoTKbnlSA==
Date: Mon, 12 Mar 2018 10:07:22 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] drm/panel: =?utf-8?Q?ili?=
 =?utf-8?B?OTMyMu+8mk1ha2U=?= local symbols static
Message-ID: <20180312090722.GA15972@ulmo>
References: <1514948938-19996-1-git-send-email-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <1514948938-19996-1-git-send-email-weiyongjun1@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 03, 2018 at 03:08:58AM +0000, Wei Yongjun wrote:
> Fixes the following sparse warnings:
>=20
> drivers/gpu/drm/panel/panel-ilitek-ili9322.c:182:12: warning:
>  symbol 'ili9322_inputs' was not declared. Should it be static?
> drivers/gpu/drm/panel/panel-ilitek-ili9322.c:343:28: warning:
>  symbol 'ili9322_regmap_config' was not declared. Should it be static?
>=20
> Also change ili9322_inputs to 'const char * const' to avoid
> chackpatch warning.
>=20
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/gpu/drm/panel/panel-ilitek-ili9322.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

Thierry

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqmQ0gACgkQ3SOs138+
s6GlqQ/+KJXNzbIjv4Sa6byAkGRURI08KPknoVTwvFLjtcMdwU1cuzUOmycBEXct
P+ku7t1HOgGYPO88y3Lphd0s1HoJbMkvVuCy3oVjehHxXLrnkU0p8ClUJ70BnslZ
yHaZ83Hb7jt7w8LO76z+AESsApcuzjm/umsTRqJKBm/MWau/PZOfsTdUAQ4VUlkm
ubjATUHsl5n5DBbXVvmJHcsuVJ44zlHkUXs1DEbGZfu6dwStGZ6n8fmPfREghff+
sYs4VGp+AjP/eejPW0aUg5/D1Q+PVjqS5Hg+rxKGNlsMg8G4hqxrkNGbz96qDZBX
11G3aUfZduB1wybjXP9Fy504JUgN4bkQc8EtEjvyIFr+f/HWn+CncrSm9bXK3D7Z
ceIofeSbuhGAVycXdaMzRUhr5OnUpZTzPku1ZNW7XTfajzbXOJYAJtaVI2KyrtP0
HWdq5PFMm1g6YLA69C0ovnzyyLRjymTySXN4cCXG81781F6VRd3LQaidXwwejDvW
ezDs+begqtnZyzrjBxMJY06OISjfh9lyFAn748GHnf2/3LsZPSq0pqqVX2baBHzd
b+eiUqUNlfbdQ15jCKwON7nnqvlgF2KrxVfWfBcpDwdmjTKWzMz/MzPl3m+z+abd
O6hWVB7q5v19FvWx8DK2WHrWQn2tc2SOYP/WVOxpyXvvwzfD3+8=
=qVsj
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
