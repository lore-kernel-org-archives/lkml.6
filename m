Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753635AbeENMzd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:55:33 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51080 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753532AbeENMzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:55:31 -0400
X-Google-Smtp-Source: AB8JxZpPrS7ObB4QaDBrsc+A8Kji9c4GdatLlM1RdbCC5JRLjp1lSXpyHp9hGe/dAxtfrgaDlVxzrA==
Date: Mon, 14 May 2018 14:55:27 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: sumeet p <srplinux2008@gmail.com>
Cc: jonathanh@nvidia.com, linux-tegra@vger.kernel.org, rui.zhang@intel.com,
        edubezval@gmail.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH V2] thermal: tegra: soctherm: add const to struct
 thermal_cooling_device_ops
Message-ID: <20180514125527.GK18312@ulmo>
References: <1526147228-5317-1-git-send-email-srplinux2008@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="x+RZeZVNR8VILNfK"
Content-Disposition: inline
In-Reply-To: <1526147228-5317-1-git-send-email-srplinux2008@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x+RZeZVNR8VILNfK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 12, 2018 at 11:17:08PM +0530, sumeet p wrote:
> Correct the typecast with const to struct thermal_cooling_device_ops.
> It is the last argument to the function thermal_of_cooling_device_register
> and this argument is of type const. So, declare this structure
> thermal_cooling_device_ops as constant.
>=20
> Signed-off-by: sumeet p <srplinux2008@gmail.com>
> ---
> Changes in V2:
> - Updated Signed-off-by with correct name.
>=20
> ---
>  drivers/thermal/tegra/soctherm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--x+RZeZVNR8VILNfK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlr5hz8ACgkQ3SOs138+
s6FzTw//UHE9kxWKN65Ox6rnF9i4OjP0s00iyS+VHqUde2M9s/yhhFVCKAYwoSy3
lft31j7hHDsVmKDy243aUJrRZ8epvVR3t28wVnDYuS77pvFi6YWxvzaY5UrHrKIk
F0w71k39Xv9OKTCC5v0/vgDUvJcJlhu16AzCBq5DojrfUBP4YgEEngicSFMQCTfG
TRowsWuCgqU4zvLeKRlC6RjG1k+ynIa7e+ddBhg5nfJabf0dUm7pCPepWnQ83/av
4eCoVB1eD8UEiYE9CqI85R/gjIR4LFkGEbQVK+2gMaugkwjNkJ9CRXPXZ0NuS9ws
MTDs5Lt44YAe3ricmrJXcOre3yH1UWla+a6AcCgzlciQUzdWOloec1r7jNMXZSiR
V5mP+/ocvBdzrw+fu71grKVwJvoTb406LvSLYd3qL34NHaPHLc20pmGWmXxgSTvk
2ym7obQjHh8iLS3HFwyUbqkbVN2UbOwZeE7wyaKTzMncCfs+7uLML0CCZ99Fiwb4
StiFFb4EefYiuDa0Ihs57Mf/eh79VMpuCYNQxy4SNTNyyhEH8LNQEr+8Dtj6Emcx
SAqlt34CpQtu03zACeQErCFixFuB1nNr8fgbQ7oXC6mX3g5Z1KLW+ZGAc0oyLyh5
rjUJ6bXfUe1tnxk3vfGBhXQ19iZcvbo7VP4BUm1qFnSTia7RId8=
=9eRK
-----END PGP SIGNATURE-----

--x+RZeZVNR8VILNfK--
