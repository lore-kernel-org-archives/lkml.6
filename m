Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752003AbeB0Grk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 01:47:40 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:41708 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751956AbeB0Gri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 01:47:38 -0500
X-Google-Smtp-Source: AG47ELshhhD15BGHiPWAZUsO5Mrihq5kLrL0NIm9gzb/cLFDCi07d3fjDtrGMmJbBoU0l7j29+izoA==
Date: Mon, 26 Feb 2018 22:47:32 -0800
From: Benson Leung <bleung@google.com>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        lee.jones@linaro.org
Cc: lee.jones@linaro.org, groeck@chromium.org, andy.shevchenko@gmail.com,
        kernel@collabora.com, gwendal@chromium.org,
        linux-kernel@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
        Benson Leung <bleung@chromium.org>, Olof Johansson <olof@lixom.net>,
        bleung@google.com
Subject: Re: [PATCH v3 3/8] mfd: cros_ec: Don't try to grab log when suspended
Message-ID: <20180227064732.GB171936@decatoncale.mtv.corp.google.com>
References: <20180226102606.15093-1-enric.balletbo@collabora.com>
 <20180226102606.15093-4-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
In-Reply-To: <20180226102606.15093-4-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Enric,

Thanks for sending this.

On Mon, Feb 26, 2018 at 11:26:01AM +0100, Enric Balletbo i Serra wrote:
> From: Douglas Anderson <dianders@chromium.org>
>=20
> We should stop our worker thread while we're suspended.  If we don't
> then we'll get messages like:
>=20
>   cros-ec-spi spi5.0: spi transfer failed: -108
>   cros-ec-spi spi5.0: cs-deassert spi transfer failed: -108
>   cros-ec-ctl cros-ec-ctl.0.auto: EC communication failed
>=20
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>=20
> Changes in v3:
> - [3/8] Add Reviewed-by Andy Shevchenko.
>=20
> Changes in v2:
> - [3/8] That patch is new in this series.
>=20
>  drivers/mfd/cros_ec_dev.c                 |  4 ++++
>  drivers/platform/chrome/cros_ec_debugfs.c | 20 ++++++++++++++++++++
>  include/linux/mfd/cros_ec.h               |  2 ++

Looks like this will need an immutable branch between mfd and chrome-platfo=
rm
again, Lee.

Do you want to do one, or should I?

Thanks,
Benson


--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlqU/wQACgkQHwn1ewov
5liGehAAp0PvLwmlAisoSiicY8Jd1Gwurytv5a9oP/w94VW3EUxXreMu5F/1MH56
5kRTCkeLRucf6Vbl46nBUSK7HS95/yQXJeNvR7zIFpNkAtT4lNriK04dtYFBo+2n
YD1GlCyAdU2KiIvUp+VTSZxFnOkvmEI1Z/xpoVJ0kJ1ojEYHbYzYO6Fp1gEl4cza
7mIxVHEU9fB/kq5OJUvdu7Q0KVCVNJf0JROSMd9Lzoqm+goUDVD1ICFZaC/5v6ze
dtADf9gLSCHiU4HnXdjz+lm27XJjqiQj8wvCconGqO71pMarjwYKV8RxR8bnN/tb
hj0Ic8diK7SRltfznvACfRoaoF3WH55tlZL3WCCnM34YfcxmjxMCXEdF4oY8U4Zf
k20vPs1OdQG02HVTzHLFX/tnKNA3iaPMDJtpPeBkdKPS+9kZGJnZzeg4eAy2wdmq
ecuTnFOySJlnFCGUkMC4xWlBT3YY7A3ZbjPqf98U4jkxNXnizwkcrxtETI6u6kNg
mZ6lzi9QMTeXjTPbr92xlJvOSJvombW7rAh7ee53fI13ouBEKv7NHa97sjLV+TRM
6bPtk99Ti46LB9Ko7Bh+HwC4jSQSEy70qKmhbhF59oKjg3y1Bxbia9CDc0EDyIfA
cZDDMg+94j1GeLFUz0860/JyH9mrg9FTd1Hl/CDvrQbdHI3Vnp0=
=Wkic
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
