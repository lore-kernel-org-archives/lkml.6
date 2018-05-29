Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754531AbeE2FyM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 01:54:12 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:39830 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754449AbeE2FyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 01:54:09 -0400
X-Google-Smtp-Source: AB8JxZoqMH1+NJ3wfczhdhgZdHAuSi285CacLMBxtOyMfYuhnQlPSiJ7U9u1FduRzTDwx1WKdHYL6w==
Date: Mon, 28 May 2018 22:54:05 -0700
From: Benson Leung <bleung@google.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Benson Leung <bleung@chromium.org>, Olof Johansson <olof@lixom.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        Thierry Escande <thierry.escande@collabora.com>,
        Lee Jones <lee.jones@linaro.org>,
        Shawn Nematbakhsh <shawnn@chromium.org>, linux-kernel@vger.kernel.org,
        bleung@google.com
Subject: Re: [PATCH] platform: chrome: Add input dependency for tablet switch
 driver
Message-ID: <20180529055405.GA26811@decatoncale.mtv.corp.google.com>
References: <20180528155858.2966723-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <20180528155858.2966723-1-arnd@arndb.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Mon, May 28, 2018 at 05:58:46PM +0200, Arnd Bergmann wrote:
> Without CONFIG_INPUT, or with a modular input layer and built-in
> tablet driver, we get a link error:
>=20
> ERROR: "input_event" [drivers/platform/chrome/chromeos_tbmc.ko] undefined!
> ERROR: "input_register_device" [drivers/platform/chrome/chromeos_tbmc.ko]=
 undefined!
> ERROR: "input_set_capability" [drivers/platform/chrome/chromeos_tbmc.ko] =
undefined!
> ERROR: "devm_input_allocate_device" [drivers/platform/chrome/chromeos_tbm=
c.ko] undefined!
>=20
> This adds the corresponding Kconfig dependency
>=20
> Fixes: b418f74170d7 ("platform: chrome: Add Tablet Switch ACPI driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the catch! Applied for 4.18.

Benson

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlsM6v0ACgkQHwn1ewov
5liGsRAAsRAnftkMzYqfKc4H+Cy7clolMUffmtFBjco+o8Q/LJDUFh054XP5vLmk
wbF87OwZPJM8T6zv6A0jNUUuy2Zm34e62dHXIfDYM+kX6Xr+CEO4fccVdHLLmAR/
BYs3o+g4EUMwirpyd2Uxd/NyIWBx6u5iLDMjjIyddu/iixd59hJ1CrNrWeawn2FL
vOxWc2fn4Bc95Z6y1eP6R4XGEIpQLN/0RfUh3y8DjjW4yHmKXhWeaDV18jCzwp06
UmmnHRWMy+TMZmJ01JAvkp3T5iP8Xl+YmRVxu2P+yGmHYvTwG+vOIsJn53h2Hlwg
x16pc5Qt0cipZYbDMoQpW6eGAjL27k9UEfbVESPPYPxO7cPfAaysCpFgGMbITS6X
AjAYUNslpbs21LbqvnGW7dB01s2Rmk2oVKdTio57QrY6/33ayiLWqS+wvh3/Gr6m
bkTC6UHcSGAtnEseKU2MhB3VcxM1lwzrlRqu/8C5eVW/+lA0goU0a/ND7Lmu5+ui
umYBn19VdmPQvqmrCL9EQS4AI3a7p49/VJOWTm2mt5k5jQzw8u+ixhSmuJplTQFw
VNsrpj6NojIozOgpDnQR3eyIsPFhGvRY4r6bcZ2tuhkJu/kY19YFguWedjLdnv5G
xGCYN25792MXIl+Pqat5LVOnzVd/9hY5RTW7vziZSnMNZ887gaw=
=fgTg
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
