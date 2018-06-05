Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752008AbeFEUyl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 16:54:41 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34451 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751834AbeFEUyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 16:54:40 -0400
X-Google-Smtp-Source: ADUXVKJMfAKl5Q1luNccjRQ9IltLo8EBybFV3P9/THmfoVGmHin3MApkCn0VASvDmZJxgsLwcyXgJg==
Date: Tue, 5 Jun 2018 13:54:36 -0700
From: Benson Leung <bleung@google.com>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-kernel@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>,
        kernel@collabora.com, Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, Anton Vorontsov <anton@enomsg.org>,
        Kees Cook <keescook@chromium.org>, Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2 2/8] platform/chrome: pstore: Switch to SPDX
 identifier.
Message-ID: <20180605205436.GB117422@decatoncale.mtv.corp.google.com>
References: <20180605175429.9072-1-enric.balletbo@collabora.com>
 <20180605175429.9072-3-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline
In-Reply-To: <20180605175429.9072-3-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Enric,

On Tue, Jun 05, 2018 at 07:54:23PM +0200, Enric Balletbo i Serra wrote:
> Adopt the SPDX license identifier headers to ease license compliance
> management.
>=20
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>=20
> Changes in v2: None
>=20
>  drivers/platform/chrome/chromeos_pstore.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/platform/chrome/chromeos_pstore.c b/drivers/platform=
/chrome/chromeos_pstore.c
> index b0693fdec8c6..4d3d3459e2f9 100644
> --- a/drivers/platform/chrome/chromeos_pstore.c
> +++ b/drivers/platform/chrome/chromeos_pstore.c
> @@ -1,12 +1,7 @@
> -/*
> - *  chromeos_pstore.c - Driver to instantiate Chromebook ramoops device
> - *
> - *  Copyright (C) 2013 Google, Inc.
> - *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation, version 2 of the License.
> - */
> +// SPDX-License-Identifier: GPL-2.0+

GPL-2.0

> +// Driver to instantiate Chromebook ramoops device.
> +//
> +// Copyright (C) 2013 Google, Inc.
> =20
>  #include <linux/acpi.h>
>  #include <linux/dmi.h>
> --=20
> 2.17.1
>=20

Thanks!
--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlsW+IwACgkQHwn1ewov
5ljdYQ/7Bu0fYOOPPJBDl+EQnHGjW3V03CZzRRT2N+S0qJfNpW1XvAAMU5tQWKHu
woQqN4jvcypqoLLvgdhE2VL6PYVyE2YSFi+aTkH4tdR79AkIa0TW0yOPxX2wpC+0
A52jr6nU11HGRnxU9PpM8t3cJnwh2bXMtHA5yjUYp9XLaERFR7+WMiJYQ+utE4L+
DK3P1vowis7dcB2rfVuPhiuHGI7BbGetMMny+TJDXe8o6DpvoDh+nbFQusO2I6u9
qnvTwiNbzyqPOeCt6gtiIG6zHcIOV0KQflhIRWPq1XieGRduqjg3bIYTSrYz+yHL
cIq6NrPpsQz0jl3BCbA2busH8g6rUEiRNqtP3H6MAB/ywz924aHq1A7M8oyvnI3N
ozglSb88fGuQftafMyNeBcOAAYcT08/5Sxa9u24HBEI4N4Z+0NAVUtqjgDw7rSu/
BCa/N6F6woNO9hnzFLpzBsYFozySlENrKS2gFJiStEcP2YRo9bsihANyjYtqWfQu
qw81lVI35SbvcM0i41NMIzDffiWqSJGI/zioivxRnmtXxHOWAU6P9T1ilhJr1b60
4qNPF+5Rzjyd40IVRqdN85p9zaHehYNeqxoNUPmH83MihhOGM3NdL0Sfn1bDmouJ
ygn+fA6MpC4vaGIKnCGEh+K4SnQimRIK2RirErA+/XDLhls3tLk=
=5gJN
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--
