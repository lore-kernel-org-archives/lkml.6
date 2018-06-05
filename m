Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752139AbeFEUvv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 16:51:51 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38299 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751819AbeFEUvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 16:51:50 -0400
X-Google-Smtp-Source: ADUXVKKQNgqyTGUwXBPweSiJNXogz5lb5UDi7U8zriLolYFoLynRdoxctVYKqxYiW6O4jEivhqLZsg==
Date: Tue, 5 Jun 2018 13:51:46 -0700
From: Benson Leung <bleung@google.com>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-kernel@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>,
        kernel@collabora.com, Olof Johansson <olof@lixom.net>,
        Benson Leung <bleung@chromium.org>, dmitry.torokhov@gmail.com
Subject: Re: [PATCH v2 1/8] platform/chrome: cros_ec: Switch to SPDX
 identifier.
Message-ID: <20180605205146.GA117422@decatoncale.mtv.corp.google.com>
References: <20180605175429.9072-1-enric.balletbo@collabora.com>
 <20180605175429.9072-2-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <20180605175429.9072-2-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Enric,

On Tue, Jun 05, 2018 at 07:54:22PM +0200, Enric Balletbo i Serra wrote:
> Adopt the SPDX license identifier headers to ease license compliance
> management.
>=20
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>=20
> Changes in v2:
> - s/Chrome OS/ChromeOS/
> - [1/9] Fixed wrong copyright year.
>=20
>  drivers/platform/chrome/cros_ec_debugfs.c     | 22 +++---------
>  drivers/platform/chrome/cros_ec_lightbar.c    | 22 +++---------
>  drivers/platform/chrome/cros_ec_lpc.c         | 34 +++++++------------
>  drivers/platform/chrome/cros_ec_lpc_mec.c     | 34 +++++++------------
>  drivers/platform/chrome/cros_ec_lpc_reg.c     | 34 +++++++------------
>  drivers/platform/chrome/cros_ec_proto.c       | 19 +++--------
>  drivers/platform/chrome/cros_ec_sysfs.c       | 22 +++---------
>  drivers/platform/chrome/cros_ec_vbc.c         | 24 +++----------
>  .../platform/chrome/cros_kbd_led_backlight.c  | 19 +++--------
>  9 files changed, 61 insertions(+), 169 deletions(-)
>
Several of these change V2 only to V2+. We should match the old license
notice.

My bad. I made the same error on the tbmc driver. I will fix that myself.

=20
> diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform=
/chrome/cros_ec_debugfs.c
> index c62ee8e610a0..450dac3996ff 100644
> --- a/drivers/platform/chrome/cros_ec_debugfs.c
> +++ b/drivers/platform/chrome/cros_ec_debugfs.c
> @@ -1,21 +1,7 @@
> -/*
> - * cros_ec_debugfs - debug logs for Chrome OS EC
> - *
> - * Copyright 2015 Google, Inc.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program. If not, see <http://www.gnu.org/licenses/>.
> - */
> +// SPDX-License-Identifier: GPL-2.0+
> +// Debug logs for ChromeOS EC.
> +//
> +// Copyright (C) 2015 Google, Inc.
> =20
>  #include <linux/circ_buf.h>
>  #include <linux/debugfs.h>
> diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platfor=
m/chrome/cros_ec_lightbar.c
> index 68193bb53383..c5a6dd4ffa01 100644
> --- a/drivers/platform/chrome/cros_ec_lightbar.c
> +++ b/drivers/platform/chrome/cros_ec_lightbar.c
> @@ -1,21 +1,7 @@
> -/*
> - * cros_ec_lightbar - expose the Chromebook Pixel lightbar to userspace
> - *
> - * Copyright (C) 2014 Google, Inc.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program. If not, see <http://www.gnu.org/licenses/>.
> - */
> +// SPDX-License-Identifier: GPL-2.0+
> +// Expose the Chromebook Pixel lightbar to userspace.
> +//
> +// Copyright (C) 2014 Google, Inc.
> =20
>  #define pr_fmt(fmt) "cros_ec_lightbar: " fmt
> =20
> diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chr=
ome/cros_ec_lpc.c
> index 3682e1539251..f196aa4fa84c 100644
> --- a/drivers/platform/chrome/cros_ec_lpc.c
> +++ b/drivers/platform/chrome/cros_ec_lpc.c
> @@ -1,25 +1,15 @@
> -/*
> - * cros_ec_lpc - LPC access to the Chrome OS Embedded Controller
> - *
> - * Copyright (C) 2012-2015 Google, Inc
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * This driver uses the Chrome OS EC byte-level message-based protocol f=
or
> - * communicating the keyboard state (which keys are pressed) from a keyb=
oard EC
> - * to the AP over some bus (such as i2c, lpc, spi).  The EC does debounc=
ing,
> - * but everything else (including deghosting) is done here.  The main
> - * motivation for this is to keep the EC firmware as simple as possible,=
 since
> - * it cannot be easily upgraded and EC flash/IRAM space is relatively
> - * expensive.
> - */
> +// SPDX-License-Identifier: GPL-2.0+

This one was submitted previously as GPL-2.0 only, so let's keep it that wa=
y.
GPL-2.0
=20

> +// LPC access to the ChromeOS Embedded Controller.
> +//
> +// Copyright (C) 2012-2015 Google, Inc.
> +//
> +// This driver uses the ChromeOS EC byte-level message-based protocol for
> +// communicating the keyboard state (which keys are pressed) from a keyb=
oard EC
> +// to the AP over some bus (such as i2c, lpc, spi).  The EC does debounc=
ing,
> +// but everything else (including deghosting) is done here.  The main
> +// motivation for this is to keep the EC firmware as simple as possible,=
 since
> +// it cannot be easily upgraded and EC flash/IRAM space is relatively
> +// expensive.
> =20
>  #include <linux/acpi.h>
>  #include <linux/dmi.h>
> diff --git a/drivers/platform/chrome/cros_ec_lpc_mec.c b/drivers/platform=
/chrome/cros_ec_lpc_mec.c
> index 2eda2c2fc210..7c69883cea5d 100644
> --- a/drivers/platform/chrome/cros_ec_lpc_mec.c
> +++ b/drivers/platform/chrome/cros_ec_lpc_mec.c
> @@ -1,25 +1,15 @@
> -/*
> - * cros_ec_lpc_mec - LPC variant I/O for Microchip EC
> - *
> - * Copyright (C) 2016 Google, Inc
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * This driver uses the Chrome OS EC byte-level message-based protocol f=
or
> - * communicating the keyboard state (which keys are pressed) from a keyb=
oard EC
> - * to the AP over some bus (such as i2c, lpc, spi).  The EC does debounc=
ing,
> - * but everything else (including deghosting) is done here.  The main
> - * motivation for this is to keep the EC firmware as simple as possible,=
 since
> - * it cannot be easily upgraded and EC flash/IRAM space is relatively
> - * expensive.
> - */
> +// SPDX-License-Identifier: GPL-2.0+

This one was submitted previously as GPL-2.0 only, so let's keep it that wa=
y.
GPL-2.0
=20

> +// LPC variant I/O for Microchip EC.
> +//
> +// Copyright (C) 2016 Google, Inc.
> +//
> +// This driver uses the ChromeOS EC byte-level message-based protocol for
> +// communicating the keyboard state (which keys are pressed) from a keyb=
oard EC
> +// to the AP over some bus (such as i2c, lpc, spi).  The EC does debounc=
ing,
> +// but everything else (including deghosting) is done here.  The main
> +// motivation for this is to keep the EC firmware as simple as possible,=
 since
> +// it cannot be easily upgraded and EC flash/IRAM space is relatively
> +// expensive
> =20
>  #include <linux/delay.h>
>  #include <linux/io.h>
> diff --git a/drivers/platform/chrome/cros_ec_lpc_reg.c b/drivers/platform=
/chrome/cros_ec_lpc_reg.c
> index dcc7a3e30604..4a1013964841 100644
> --- a/drivers/platform/chrome/cros_ec_lpc_reg.c
> +++ b/drivers/platform/chrome/cros_ec_lpc_reg.c
> @@ -1,25 +1,15 @@
> -/*
> - * cros_ec_lpc_reg - LPC access to the Chrome OS Embedded Controller
> - *
> - * Copyright (C) 2016 Google, Inc
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * This driver uses the Chrome OS EC byte-level message-based protocol f=
or
> - * communicating the keyboard state (which keys are pressed) from a keyb=
oard EC
> - * to the AP over some bus (such as i2c, lpc, spi).  The EC does debounc=
ing,
> - * but everything else (including deghosting) is done here.  The main
> - * motivation for this is to keep the EC firmware as simple as possible,=
 since
> - * it cannot be easily upgraded and EC flash/IRAM space is relatively
> - * expensive.
> - */
> +// SPDX-License-Identifier: GPL-2.0+

Same here.
GPL-2.0
=20

> +// LPC access to the ChromeOS Embedded Controller.
> +//
> +// Copyright (C) 2016 Google, Inc.
> +//
> +// This driver uses the ChromeOS EC byte-level message-based protocol for
> +// communicating the keyboard state (which keys are pressed) from a keyb=
oard EC
> +// to the AP over some bus (such as i2c, lpc, spi).  The EC does debounc=
ing,
> +// but everything else (including deghosting) is done here.  The main
> +// motivation for this is to keep the EC firmware as simple as possible,=
 since
> +// it cannot be easily upgraded and EC flash/IRAM space is relatively
> +// expensive.
> =20
>  #include <linux/io.h>
>  #include <linux/mfd/cros_ec.h>
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/c=
hrome/cros_ec_proto.c
> index 8350ca2311c7..13b925aba61d 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -1,18 +1,7 @@
> -/*
> - * ChromeOS EC communication protocol helper functions
> - *
> - * Copyright (C) 2015 Google, Inc
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - */
> +// SPDX-License-Identifier: GPL-2.0+

GPL-2.0

> +// ChromeOS EC communication protocol helper functions.
> +//
> +// Copyright (C) 2015 Google, Inc.
> =20
>  #include <linux/mfd/cros_ec.h>
>  #include <linux/delay.h>
> diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/c=
hrome/cros_ec_sysfs.c
> index f34a50121064..68979cebb2c8 100644
> --- a/drivers/platform/chrome/cros_ec_sysfs.c
> +++ b/drivers/platform/chrome/cros_ec_sysfs.c
> @@ -1,21 +1,7 @@
> -/*
> - * cros_ec_sysfs - expose the Chrome OS EC through sysfs
> - *
> - * Copyright (C) 2014 Google, Inc.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program. If not, see <http://www.gnu.org/licenses/>.
> - */
> +// SPDX-License-Identifier: GPL-2.0+
> +// Expose the ChromeOS EC through sysfs.
> +//
> +// Copyright (C) 2014 Google, Inc.
> =20
>  #define pr_fmt(fmt) "cros_ec_sysfs: " fmt
> =20
> diff --git a/drivers/platform/chrome/cros_ec_vbc.c b/drivers/platform/chr=
ome/cros_ec_vbc.c
> index 5356f26bc022..a4934f41f462 100644
> --- a/drivers/platform/chrome/cros_ec_vbc.c
> +++ b/drivers/platform/chrome/cros_ec_vbc.c
> @@ -1,22 +1,8 @@
> -/*
> - * cros_ec_vbc - Expose the vboot context nvram to userspace
> - *
> - * Copyright (C) 2015 Collabora Ltd.
> - *
> - * based on vendor driver,
> - *
> - * Copyright (C) 2012 The Chromium OS Authors
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0+
> +// Expose the vboot context nvram to userspace.
> +//
> +// Copyright (C) 2012 Google, Inc.
> +// Copyright (C) 2015 Collabora Ltd.
> =20
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> diff --git a/drivers/platform/chrome/cros_kbd_led_backlight.c b/drivers/p=
latform/chrome/cros_kbd_led_backlight.c
> index ca3e4da852b4..bd4aa9331806 100644
> --- a/drivers/platform/chrome/cros_kbd_led_backlight.c
> +++ b/drivers/platform/chrome/cros_kbd_led_backlight.c
> @@ -1,18 +1,7 @@
> -/*
> - *  Keyboard backlight LED driver for Chrome OS.
> - *
> - *  Copyright (C) 2012 Google, Inc.
> - *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0+
> +// Keyboard backlight LED driver for ChromeOS.
> +//
> +// Copyright (C) 2012 Google, Inc.
> =20
>  #include <linux/acpi.h>
>  #include <linux/leds.h>
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

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlsW9+IACgkQHwn1ewov
5lhg1hAAq0BHYWRCGXqjuGYVOU8eJf/fFMA9Hgy50puCotkvPwZOc+AZj1I+Qnn/
VavzVLlvai9pE0vQOMZoV+OvCUHPD5QbPj3dgAprYPNA+hNvOBYO0DktycM5VmEi
d+1nwtITjD7wVT9z3GuGBmPPkptTqIYuj1rQGYclX+RAV1ZFgwH+0sD5VP4qkHag
IIG2u7D86znb4hZK5fV/psdsmCy0/dnyk12BwHrcZWffYQYwXEao6MentolhoylK
6vqvvlKORadO+EiSBVo4tS64ej7pFB1CNvAYTkhEGBNoy90P19QIIu7wv+gftfZ6
HJymTrxnX+XcNgb9eJYGlPVklB6Yvcez1mu/b/QTiOJ+mgEHHiEglmrThBSdDiu0
gaP9BY/LPjsb5Alv/O93ayqYftfU2paDGvvIhzUw8b9pHVVZKQkPK02b2rUv53Gb
+l/pEVgLsp9WOcnL103TWYnaO35tygk95Q4dd6NwcAv7sBQ5PdHjwFWem821UKgP
Eh3FoI/0FvCO9Jnx4xeB3GRqTCyyNEh7UsLJ8JlC3LXIxdfIgM5vCFrim2eN5RNE
F3pR965fV3leiRkBkW4jTcn3ER5o8yfGhyfOJxGwcpALcIvfobzaWN1sQBpcyDTl
8hyHDiQmbP48PUPgSHImvYIorGUQxAbl8Mf7/DnyVeM39ivLndk=
=N0lc
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
