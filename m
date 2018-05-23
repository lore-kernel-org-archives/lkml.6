Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934631AbeEWT4x (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 15:56:53 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42222 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934181AbeEWT4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 15:56:50 -0400
X-Google-Smtp-Source: AB8JxZp7YkZh5dqdkdxCtxfjrM285/51QagGHVL0sGjmwtB0F8QTj1Mf3YDv4iC0Gwcy17m7BotB5A==
Date: Wed, 23 May 2018 12:56:45 -0700
From: Benson Leung <bleung@google.com>
To: dmitry.torokhov@gmail.com, bleung@google.com, bleung@chromium.org,
        linux-input@vger.kernel.org, dtor@chromium.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] IB chrome-platform/input for atmel_mxt_ts &
 chromeos_laptop for device properties
Message-ID: <20180523195645.GA92470@decatoncale.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

The following changes since commit 96a938aa214e965d5b4a2f10443b29cad14289b9:

  Input: atmel_mxt_ts - remove platform data support (2018-04-09 22:55:16 -=
0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platform.git =
ib-chrome-platform-atmel-mxt-ts-device-properties

for you to fetch changes up to 5020cd29d8bfcb3f3add43ea7d58b07011ab96d8:

  platform/chrome: chromeos_laptop - supply properties for ACPI devices (20=
18-05-23 12:48:31 -0700)

----------------------------------------------------------------
Dmitry Torokhov (1):
      platform/chrome: chromeos_laptop - supply properties for ACPI devices

 drivers/platform/chrome/chromeos_laptop.c | 307 ++++++++++++++++++++++++++=
+---
 1 file changed, 278 insertions(+), 29 deletions(-)

Thanks!
--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlsFx30ACgkQHwn1ewov
5liYXBAAkOHTPkMgVunnQHlQmWXD7WJkAQUBn+p+h/f1/MCdO1Z9LdnjGwYPT5lQ
4TXRdA9XaII+Me08mwDc6z2E1HrZpTeSgPPJ6+pPKBJGq0RkabXqrwd2lNMJws6C
rp43TzUsulf8i7gHVPksviato6QkYzkCBlfRmh8tqDVrFNwI9ZYEWylaEP/+6J4X
rEFue9YTigMnp7djW/t0ZltWTcNNNQjoIuHJQUI//urTypiVFmDUmOSssiBk9/8q
k96mpauCxZWkCv89fJKbMAPw+vxjSY6lEJoO/IhSJlHut2Xe3ponH9GbrMK0ApwZ
FCGUBtoka1HxyUVAiq7+Em51XwP9BXJqFAkDO+jvljewf5PIywd74lHDmJAnVqne
Q4mKpMmzo/LSGWax9Mdf7QEuOPAApdet3rmHconLZQLTjWquhOvItRTFGmK6lr3g
gJ5oYK2QxL8zjEoL9uGY+qlGENlvXArx0z0CVvrRmMN84GwEIL5poaOB20z/bWcN
e2OT93IwwzDS7EmsnN9b1PC2b/AdURbI0ksliieljqobLsknJe1wIoqhZA3UChdz
zKKB2ejcbYMZ6VByTTZjxapVs2we8HLl0YwyV6HT8hnnfRRNO5+oI/FnhwN3hyC+
iLjkQfy98MRLeZ8CFTvk5/njUs6BxttXASYIjKWDX9E/7IBMgkg=
=CogP
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
