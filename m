Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751776AbeCVXeN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 19:34:13 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:37022 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751319AbeCVXeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 19:34:11 -0400
X-Google-Smtp-Source: AG47ELthadwCx84tSDdhqyffy91MbtAQGVbbUgNSj4cKFim+ygdLllkMDyj7My7/++/UzRMqvsRA4A==
Date: Thu, 22 Mar 2018 16:34:08 -0700
From: Benson Leung <bleung@google.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Nick Dyer <nick@shmanahar.org>, Olof Johansson <olof@lixom.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/14] platform/chrome: chromeos_laptop - stop setting
 suspend mode for Atmel devices
Message-ID: <20180322233408.GA29926@decatoncale.mtv.corp.google.com>
References: <20180320223138.234724-1-dmitry.torokhov@gmail.com>
 <20180320223138.234724-6-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <20180320223138.234724-6-dmitry.torokhov@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Tue, Mar 20, 2018 at 03:31:29PM -0700, Dmitry Torokhov wrote:
> Atmel touch controller driver no longer respects suspend mode specified in
> platform data, so let's stop setting it.
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Applied to my working branch for atmel_mxt_ts + chromeos_laptop.c for
v4.17. Thanks!

> ---
>  drivers/platform/chrome/chromeos_laptop.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/platform/chrome/chromeos_laptop.c b/drivers/platform=
/chrome/chromeos_laptop.c
> index 54a13c70e1d8f..0a43f1833de3f 100644
> --- a/drivers/platform/chrome/chromeos_laptop.c
> +++ b/drivers/platform/chrome/chromeos_laptop.c
> @@ -100,7 +100,6 @@ static struct mxt_platform_data atmel_224s_tp_platfor=
m_data =3D {
>  	.irqflags		=3D IRQF_TRIGGER_FALLING,
>  	.t19_num_keys		=3D ARRAY_SIZE(mxt_t19_keys),
>  	.t19_keymap		=3D mxt_t19_keys,
> -	.suspend_mode		=3D MXT_SUSPEND_T9_CTRL,
>  };
> =20
>  static struct i2c_board_info atmel_224s_tp_device =3D {
> @@ -111,7 +110,6 @@ static struct i2c_board_info atmel_224s_tp_device =3D=
 {
> =20
>  static struct mxt_platform_data atmel_1664s_platform_data =3D {
>  	.irqflags		=3D IRQF_TRIGGER_FALLING,
> -	.suspend_mode		=3D MXT_SUSPEND_T9_CTRL,
>  };
> =20
>  static struct i2c_board_info atmel_1664s_device =3D {
> --=20
> 2.16.2.804.g6dcf76e118-goog
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlq0PVkACgkQHwn1ewov
5ljBzQ/+PrDaiWJ3IZp3EYweoviwzp9WehOW0f6bsa5TVlli9qrkNsyPfWhu8hFE
1FcLd1saP9j67ctaeQVUZnVvx0vPEF5EyxeoqTKG8ouS5cM04UFeCkzX8+iJq4Mz
PjO1q9NAWANzJgFyskWQVSOq5n4Y41tUI47pk0GyWzD2G77PRx/Y819lvuH0GAvn
GnP46ZmjBYkjkkwLXJbaewp/Sm5Zf8x5/9uWR1X4g8oQXB8OHvcgo6n7GsZUtgR5
WDpl4B9Ct7KlWJzQvY2Wesp2/0hyt6XuYNKiMMZrPtgB9XpUKCJNOfDYrRnMftL+
lZmHVSmiPUAxG8RgiZQKNg3+r/UTjrrUL3PgbjqWJbVCSxae6e4QRf5h872WVBy4
R9835W6SPODZZWfjGf8tPWXfCFpRh8/Vx2YZPPdY35m2A/8sFcZYP+fsjJrt62pe
/Mvy0TpQoI/Cma5G9OeJfj1ndCYo/pO93bBoMTJB8+jSd18TOzL3lwo3tO4EEtyG
DnYlHR8hetucGAwIA1kMPQXwcruZc13YKUYzl/j5LmAvWMxkDuOq+/3NTp4lMFn9
4ePDtjwX9uGgsf9gVZtBTEwEMNK0nWBSpiywfOJkuZ5nxdcPW3EsbPsFGU9i4Thg
sK5wET7RfgH102m7UPsiK5ATNvOGNccR/3+i6UKGuVdHUhSQAJM=
=qWkj
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
