Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752217AbeCNQiN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 12:38:13 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34221 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbeCNQiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:38:11 -0400
X-Google-Smtp-Source: AG47ELs9ZR+18vnAxGjGZrDxWiQTu4tdNOUKMcs/YP6Ayk7i9PDnXqmar8J1/DA3iReGO1h4x/hzhA==
Date: Wed, 14 Mar 2018 17:38:08 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 36/47] pwm: remobe pwm-bfin driver
Message-ID: <20180314163808.GA9201@ulmo>
References: <20180314153603.3127932-1-arnd@arndb.de>
 <20180314153603.3127932-37-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <20180314153603.3127932-37-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 14, 2018 at 04:35:49PM +0100, Arnd Bergmann wrote:
> The blackfin architecture is getting removed, so this driver is now
> obsolete as well.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/pwm/Kconfig    |   9 ---
>  drivers/pwm/Makefile   |   1 -
>  drivers/pwm/pwm-bfin.c | 157 -------------------------------------------=
------
>  3 files changed, 167 deletions(-)
>  delete mode 100644 drivers/pwm/pwm-bfin.c

Do you want to apply this in a batch or do you want me to pick it up
into the PWM tree?

If you want to go for the former:

Acked-by: Thierry Reding <thierry.reding@gmail.com>

Otherwise, just let me know and I'll pick this up for v4.17.

Thanks,
Thierry

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqpT+0ACgkQ3SOs138+
s6EarRAAoBH+bt5yIhEuCAQW+TacABePYy8Pn4yMZza56aih0v61Jnr6fxkwRaNK
lz5LPOPVcC8S3yWHwWQEw8CFMLwR/jfNvV4cjaiYW5e96KfXHFXTpy7MuzJUMRn8
2qSIoL1Y9ldUpbMeW2yp01zX9QmZEP5kn5dZ9sONR0E32nij3SHlJ7UE5LbRkDHP
ZI+WvI59PE4ZsKHIbF4nnO/PjZlZ59YRHwxJ8RuulVY4ca5S3IOfZneOwCN6iuDg
DFYhYWXdQ+CfcITxWDpWawlR8cyOyhiTEA0nvnDu06q7kXs500Tf+2iWva76guaK
GqX2pepOdwzIt4tC4zcUs/BeKjZG7BiyBo4Nx786B1pPbdLzuKW+tZ81BppsbUiA
hND76qcBMfCe/Bnx0pk2WKTk6lUHdqqJk20xbdIgQtzQrcFJoSpGJ+tAQFg2e2Tv
FtXnmBWxTVprG1lQtf0MI6Wpj77LD7DShD1TFnn5EYrs9JBFosr6EnPtz2gKPWZp
6a38qX4kr/JZc9W2DUTe5sWJXqsoVWD+9wwYGoOdWt8Hp7rhph1Eb/wQW8bMi+4L
/RcaK0XOKWk8XKUDlj5CinUhh0yh/hHRrWaARhzMAeRsfhBzvY7XJsAHAV0OTi6s
mVElonYi4vHjhRxHKzHgmcr+wD3/L85W9lJTrAilN42LCcVcepo=
=52J1
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
