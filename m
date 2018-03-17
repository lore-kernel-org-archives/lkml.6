Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752194AbeCQUdy (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 16:33:54 -0400
Received: from sauhun.de ([88.99.104.3]:38620 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750746AbeCQUdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 16:33:51 -0400
Date: Sat, 17 Mar 2018 21:33:49 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Abhishek Sahu <absahu@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Austin Christ <austinwc@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/13] i2c: qup: fix copyrights and update to SPDX
 identifier
Message-ID: <20180317203349.gfgwex3x3jaswuo5@ninjato>
References: <1520860502-14886-1-git-send-email-absahu@codeaurora.org>
 <1520860502-14886-2-git-send-email-absahu@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kntaycu4ovlh74bp"
Content-Disposition: inline
In-Reply-To: <1520860502-14886-2-git-send-email-absahu@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kntaycu4ovlh74bp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 12, 2018 at 06:44:50PM +0530, Abhishek Sahu wrote:
> The file has been updated from 2016 to 2018 so fixed the
> copyright years.
>=20
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> ---
>  drivers/i2c/busses/i2c-qup.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
> index 08f8e01..ac5edfa 100644
> --- a/drivers/i2c/busses/i2c-qup.c
> +++ b/drivers/i2c/busses/i2c-qup.c
> @@ -1,17 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
> - * Copyright (c) 2009-2013, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2009-2013, 2016-2018, The Linux Foundation. All rights =
reserved.

Can we do this? I know that CodeAurora is hosted by LF, but can you
extend their copyright when working for Qualcomm?

>   * Copyright (c) 2014, Sony Mobile Communications AB.
>   *
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 and
> - * only version 2 as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
>   */
> =20
>  #include <linux/acpi.h>
> --=20
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member=
 of Code Aurora Forum, hosted by The Linux Foundation
>=20

--kntaycu4ovlh74bp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqte60ACgkQFA3kzBSg
KbZ2/hAAin+9+AFQNTYeVJrIykxGnfwt6e2ypvzlosRgckZHi4NnfVyXToVUNn0D
MX5+/+Qm5JPcMxuL5kSoUxuiJO5IZVdvlQbtrobIjYwnNnchRuT9FIp6tEzAFaIf
VCnogIobv4fbBAWnQiztjoikd/GF9ctx4yXdYc7aFvATW8Wb5oGcvX6PcCsPm9kD
6As0/t0/rfQv52E5T6ajeBK1OpAXiF8OnftsIGOH7k8sEBkRpj3dvqmGoZxpf9Iy
4M444riccoH+R4/FP5u2gCe/yYYrMfgrFRxLUIpOGqIhJaVqIR9htidrxFtssLwg
R2kdkWRqVQ0nnnqSiTJRS6pmVgwq/RD715mj6b4hCP67dsVG40YaRtlzjkvTKQJr
ApL1im4p1/0kqulRdg7ZpPm3WT217dWpU2Z1XG/fp5xjUucRIBFbl8EjfLRBAfnA
VAKMctaGOD5Sv4B7HtD5Nc+mW2E2ZDa5L8m46oK5qwC9z4sCgWON4B7SZA7SzbDR
2E18ksA2KU1NZh8Cxfqx3W1RYvQDvMy/fjzb6j4xYzVH9Ii4mWoByndGhb0OcbRW
EhpLb9GH830DeRtKz7s/O5gvyzjunO8SxkXUDFuKa/iXbw9PfdpJdmqq46XSfVQI
MPa9Vhw7Eq1eBKv2fPuvpx65pb2d6srajd01j5QYnp/7EXRyIK4=
=umKK
-----END PGP SIGNATURE-----

--kntaycu4ovlh74bp--
