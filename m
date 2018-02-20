Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751665AbeBTXGW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 18:06:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:39430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750998AbeBTXGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 18:06:21 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBB7320C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Tue, 20 Feb 2018 23:06:16 +0000
From: James Hogan <jhogan@kernel.org>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Linux MIPS <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2 1/8] MIPS: Loongson64: cleanup all cs5536 files to use
 SPDX Identifier
Message-ID: <20180220230615.GI6245@saruman>
References: <20171226132339.7356-1-jiaxun.yang@flygoat.com>
 <20171230182830.6496-1-jiaxun.yang@flygoat.com>
 <20171230182830.6496-2-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cf0hFtnykp6aONGL"
Content-Disposition: inline
In-Reply-To: <20171230182830.6496-2-jiaxun.yang@flygoat.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cf0hFtnykp6aONGL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Sun, Dec 31, 2017 at 02:28:24AM +0800, Jiaxun Yang wrote:
> diff --git a/arch/mips/loongson64/common/cs5536/cs5536_acc.c b/arch/mips/loongson64/common/cs5536/cs5536_acc.c
> index ab4d6cc57384..ba0474bb4a3d 100644
> --- a/arch/mips/loongson64/common/cs5536/cs5536_acc.c
> +++ b/arch/mips/loongson64/common/cs5536/cs5536_acc.c
> @@ -1,3 +1,5 @@
> +// SPDX-License-Identifier: GPL-2.0
> +

No other cases I've seen bother with the blank line. Please remove
throughout the series.

>  /*
>   * the ACC Virtual Support Module of AMD CS5536
>   *
> @@ -7,10 +9,6 @@
>   * Copyright (C) 2009 Lemote, Inc.
>   * Author: Wu Zhangjin, wuzhangjin@gmail.com
>   *
> - * This program is free software; you can redistribute	it and/or modify it
> - * under  the terms of	the GNU General	 Public License as published by the
> - * Free Software Foundation;  either version 2 of the  License, or (at your
> - * option) any later version.

or any later version implies it should be "GPL-2.0+"

Same throughout. Please check carefully you aren't changing the stated
license on any files.

Cheers
James

--cf0hFtnykp6aONGL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqMqecACgkQbAtpk944
dnqS0A/9FX4z+Hgy85g4WVOGYHRirj92ioOnyIn2MfOBUznt9mS63ggbSNjVq2V8
Jy/XhGpucoXPfp/HbCABPoVV2CAYsADkQJG5S8udwzgR5i/i9yaq8qV9h+pRYjwa
cAXtqwy02OEnZXdF0R2XZGZvSCtjeDRAuX6Po6qgl1uFbPWmMxSPnZN2vPXGFN7h
en9P9n93B83dRiYt92WB4jFxLmGsWHG8d1T79Cy/uu3GlcV/9rxILCvjO44NOBZK
NWUt4O0gDG6uMPOGZjpD8gxscf22F8oCftLdXzj9AwR3QcEvnv9zcXXx1HYcfUYH
xwc/+/uVFlf1PCau0Fe+hi6YOuNS+PgJHDSZYa15y2rSI4gQOMegDnb43+NBulq2
SxlNJvL90sNGKF6T44pbUEZDU0IGdm1bxTWojfxpkeXT9R7QZbbPQ7wbsyI1qequ
pLjHAPj+YDHVHR0ESC3rjF9uX3NjL5HXZwy5OjVCvf2SV5Y+U1x1BD8wH4Jkr+yL
yOkH1ucb/dZ+m2Z5ICSUYNbgGcCLWnCxGE/sv5CcPFLp8bJiuVcieiY8ETBZdQUA
y7tcBZKrL6NfovnquvLUQtYi7AwwF4cFigS/W7P04kloQvRuhxiydGsaay7dHt18
DdWzn3ydjsQy0xXQO7Xima0mqu3Snr3Q2zKdMrw42IB/BH5vftQ=
=HsSx
-----END PGP SIGNATURE-----

--cf0hFtnykp6aONGL--
