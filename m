Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751858AbeDKFoa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 01:44:30 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44646 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751221AbeDKFo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 01:44:28 -0400
X-Google-Smtp-Source: AIpwx4/vLE9AW6ireCBPs//cg5up1RaLICjtwQNpjHEv8pJFmtkhryvLN7cB9wwAuHFYFCRLYieC4w==
Date: Tue, 10 Apr 2018 22:44:25 -0700
From: Benson Leung <bleung@google.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Nick Dyer <nick@shmanahar.org>, Olof Johansson <olof@lixom.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/14] chrome_laptop: stop being a platform driver
Message-ID: <20180411054425.GB123734@decatoncale.mtv.corp.google.com>
References: <20180320223138.234724-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Content-Disposition: inline
In-Reply-To: <20180320223138.234724-1-dmitry.torokhov@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Tue, Mar 20, 2018 at 03:31:24PM -0700, Dmitry Torokhov wrote:
> Hi,
>=20
> This series is a combination of Atmel touchscreen driver stopping using
> platform data and moving over to generic device properties, and
> chromeos-laptop switching from being platform driver, which is the wrong
> abstraction for it, and moving to using i2c bis notifier. Switching from
> platform driver to the notifiers allows us to get rid of the ugly code th=
at
> manually tries to handle deferrals in case i2c bus is not ready at the ti=
me
> we start initializing the module.
>=20
> Thanks!

This series is in next now. I will roll up a pull request for v4.17 soon.

Thanks!
Benson

>=20
> Changes v1->v2:
>=20
> - switched suspend mode handling to use DMI quirk. We'll clean it up prop=
erly
>   in the Atmel driver later, for now we just want to untangle Atmel and
>   chromeos-laptop
>=20
> - added Nick's Acks.
>=20
> Dmitry Torokhov (14):
>   Input: atmel_mxt_ts - do not pass suspend mode in platform data
>   Input: atmel_mxt_ts - switch from OF to generic device properties
>   Input: atmel_mxt_ts - switch ChromeOS ACPI devices to generic props
>   platform/chrome: chromeos_laptop - add SPDX identifier
>   platform/chrome: chromeos_laptop - stop setting suspend mode for Atmel =
devices
>   platform/chrome: chromeos_laptop - introduce pr_fmt()
>   platform/chrome: chromeos_laptop - factor out getting IRQ from DMI
>   platform/chrome: chromeos_laptop - rework i2c peripherals initialization
>   platform/chrome: chromeos_laptop - parse DMI IRQ data once
>   platform/chrome: chromeos_laptop - use I2C notifier to create devices
>   platform/chrome: chromeos_laptop - rely on I2C to set up interrupt trig=
ger
>   platform/chrome: chromeos_laptop - use device properties for Pixel
>   platform/chrome: chromeos_laptop - discard data for unneeded boards
>   Input: atmel_mxt_ts - remove platform data support
>=20
>  MAINTAINERS                                |   1 -
>  drivers/input/touchscreen/atmel_mxt_ts.c   | 231 +++---
>  drivers/platform/chrome/chromeos_laptop.c  | 896 +++++++++++----------
>  include/linux/platform_data/atmel_mxt_ts.h |  31 -
>  4 files changed, 579 insertions(+), 580 deletions(-)
>  delete mode 100644 include/linux/platform_data/atmel_mxt_ts.h
>=20
> --=20
> Dmitry

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlrNoLkACgkQHwn1ewov
5liJNg//YNh3mmayr0k6DYadfO6qloDG9k5Hj/cnTvIxQNoXtnosEOEcs9hNtKIc
7LjEznLWoWEighv8c91JATcmFp3qwvewCXMtA7M8L4vLHwoLao4HGx0WD4n5y/j6
XPh4HQsgh4WYwCQOv0WinmcQ2cF02RxyNOr7+UeO8M0C7r3iKgF9xrRzQJjyZF1n
T25+Yoh743H9tYyDXWlzlLZMtnZy9UJX8UnNGSarMDNuQl6P8nVJ/mg93DDRcJDJ
eyWM1vWYMevEWt7QtpQKrdpdWUV8bOobBl+MZW1QR3vkHRU6MPugkE+p73Qlf0DZ
C3Jr/dfBepEcc3s39LHRo7nZOmDx6F7gKgjnn72nJjRn+KxX9XptSn1bOD0oZHmA
+AysWH10JPMizL9aZLGodP6DhFntF8nACyV/Ty75DfHfw23fPwUEoc34wa/yeKR+
vllT1/LEdstijYkHbbwTAPbrEu/zZyivEs2HEa0chW86QEc4SaSQtryxflI2k/u0
15YwwpiS7YWHqFoYgWwAJ/IE3BLpCuidgoHeMEZFAZ4eS0zjylizMrJ76D4lrH/I
icJOUWa7h+79nzjiCLSYC+sOZ9di7sFNoCEDQsia49eYJ9lKKACsC0zTDIbD3+9m
gWbHTnDibj8Z0fEiZlgN3umxLOnWUdbRYtzHFEQNuZ7xlbl/HKM=
=nmh/
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--
