Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751962AbeFESPb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 14:15:31 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34717 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751769AbeFESPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 14:15:30 -0400
X-Google-Smtp-Source: ADUXVKKjNaE0B8Ioo/szCunvaxvlgGo2ixe6xXIaeKBGZIGv7BztUvwoz252xa+7ih3eWE5683Ji6A==
Date: Tue, 5 Jun 2018 11:15:26 -0700
From: Benson Leung <bleung@google.com>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-kernel@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>,
        kernel@collabora.com, Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>, bleung@chromium.org
Subject: Re: [PATCH v2 7/8] extcon: usbc-cros-ec: Switch to SPDX identifier.
Message-ID: <20180605181526.GA214655@decatoncale.mtv.corp.google.com>
References: <20180605175429.9072-1-enric.balletbo@collabora.com>
 <20180605175429.9072-8-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <20180605175429.9072-8-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 05, 2018 at 07:54:28PM +0200, Enric Balletbo i Serra wrote:
> Adopt the SPDX license identifier headers to ease license compliance
> management.
>=20
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Benson Leung <bleung@chromium.org>

> ---
>=20
> Changes in v2:
> - [8/9] Fixed wrong copyright year.
>=20
>  drivers/extcon/extcon-usbc-cros-ec.c | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/extcon/extcon-usbc-cros-ec.c b/drivers/extcon/extcon=
-usbc-cros-ec.c
> index 6721ab01fe7d..ef5a23e46e71 100644
> --- a/drivers/extcon/extcon-usbc-cros-ec.c
> +++ b/drivers/extcon/extcon-usbc-cros-ec.c
> @@ -1,18 +1,8 @@
> -/**
> - * drivers/extcon/extcon-usbc-cros-ec - ChromeOS Embedded Controller ext=
con
> - *
> - * Copyright (C) 2017 Google, Inc
> - * Author: Benson Leung <bleung@chromium.org>
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0+
> +// ChromeOS Embedded Controller extcon
> +//
> +// Copyright (C) 2017 Google, Inc.
> +// Author: Benson Leung <bleung@chromium.org>
> =20
>  #include <linux/extcon-provider.h>
>  #include <linux/kernel.h>
> --=20
> 2.17.1
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlsW0z4ACgkQHwn1ewov
5lgRvg//UZuiVZZPvJYNXlOSghA6Y9LGzX6hj8EphKxGRLTy+RVWzetuqlEd/oBt
44mOcFlOVEoDtp7WHMLZrAZSa/15rOTb9oEcnFNFdfhP9aZXQREAHfiQ4lZktdqb
M1rASBMCm90fzGV20WoXSTHiSU7SRsd2l6mPv6LzDdvuEDf/RZ0Lrl7hyY4voRVp
Ngh4W84ojq49FOr3yBJUAEM5TOaTlKoQY5PAxzNEG4d5GET2WQJEBcFub2R9ZHzL
7xpThq53PHxEsNSJ0LX1uRHyAD/H7NNiJrMkO/eyA+BHhq8EZ9C13e3+CK4FjFqh
J7g4azkEEK3g3c8RkLTovvfj/bkpPobsKw5zV8vJTRpWwjYqyZ+yxKZVCkMBSxJ0
3s61OXgtD58F/3NwAmmeIkYLEYvcv1ud9YMd3gKif/CSV+BgQUJUyyPw+UmeotSc
KlhoJBoOzZRkHEjIRaLqKphiGGQVCXyS/WG65i5f9YcqZRLLduMBcnmGBaigqsyD
qXGI3B+Y9ID0LrnJ8z+Ykq0M0lyO9YdUiOQY4MOzrlOEh8SBO4TP+GiIuIC2aFDA
5yPxAoxKUI2UXWK8Szss6jybdgNg/lXvnDFRwZSaxZ0zoNaWjmaXQHKY9RUDLUDb
BCAnXNyXOsXId1jQ0N2wh6aibxPAswejnlk8Ebc4tOBfVoaKuxk=
=rM54
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
