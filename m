Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751726AbeFDDlG (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 23:41:06 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33989 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751470AbeFDDlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 23:41:04 -0400
X-Google-Smtp-Source: ADUXVKLXKqMV+7zhauhe6SIxllh+iv5fDxgRU/o5Ht4R5soB4raoFweyrSguW3ZCCniwouOBGd2P3w==
Date: Sun, 3 Jun 2018 20:41:00 -0700
From: Benson Leung <bleung@google.com>
To: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, bleung@chromium.org
Subject: [GIT PULL] chrome-platform updates for v4.18
Message-ID: <20180604034100.GA158510@decatoncale.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platform.git =
tags/chrome-platform-for-linus-4.18

for you to fetch changes up to 79a3d60300fc28def9b58dc30d86274b47052422:

  platform/chrome: Use to_cros_ec_dev more broadly (2018-05-30 11:53:40 -07=
00)

----------------------------------------------------------------
Changes to chrome-platform for v4.18

Further changes from Dmitry related to the removal of platform data from
atmel_mxt_ts and chromeos_laptop. This time, we have some changes that
teach chromeos_laptop how to supply acpi properties for some input devices
so that the peripheral driver doesn't have to do dmi matching on some
Chromebook platforms.

Also adds the Chromebook Tablet switch driver, which is useful for x86
convertible Chromebooks.

Other misc. cleanup.

Thanks,
Benson

----------------------------------------------------------------
Arnd Bergmann (1):
      platform: chrome: Add input dependency for tablet switch driver

Benson Leung (2):
      platform/chrome: chromeos_tbmc - add SPDX identifier
      Merge branch 'ib-chrome-platform-atmel-mxt-ts-device-properties' into=
 working-branch-for-4.18

Dmitry Torokhov (3):
      platform/chrome: cros_ec_lpc: do not try DMI match when ACPI device f=
ound
      platform/chrome: chromeos_laptop - supply properties for ACPI devices
      platform/chrome: chromeos_laptop: fix touchpad button mapping on Celes

Gwendal Grignou (2):
      platform: chrome: Add Tablet Switch ACPI driver
      platform/chrome: Use to_cros_ec_dev more broadly

 drivers/platform/chrome/Kconfig            |  11 +
 drivers/platform/chrome/Makefile           |   1 +
 drivers/platform/chrome/chromeos_laptop.c  | 315 +++++++++++++++++++++++++=
+---
 drivers/platform/chrome/chromeos_tbmc.c    | 111 ++++++++++
 drivers/platform/chrome/cros_ec_lightbar.c |  21 +-
 drivers/platform/chrome/cros_ec_lpc.c      |  13 +-
 drivers/platform/chrome/cros_ec_sysfs.c    |   2 -
 drivers/platform/chrome/cros_ec_vbc.c      |   9 +-
 include/linux/mfd/cros_ec.h                |   2 +
 9 files changed, 428 insertions(+), 57 deletions(-)
 create mode 100644 drivers/platform/chrome/chromeos_tbmc.c

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlsUtMwACgkQHwn1ewov
5lhSrg//bUo2NmfiS/xpaxafCVpd5CpQLk/MCdcDcDXh6ySX7CreN2ZUk3S9xEdX
UUgUirM9x19xiajWnFOsJPxFe648YfxjKVQKNZ0zQBIShARM7tafhrZpWCKkLke5
uVC97vZzNflfvZjxj+2cQVcil4ixgIw3gpFa8HpfjMCSSC4rwbEvtIav1sj1d+qF
/W8ZAd1MqoP6SEXHifTGXHvXj9zyCT9B4k0lepiot69KtK31J5nSzHitwpKGmlVC
RFwE00sydwJDsQ8hyyqg7+/mYPtPraTV8nJbfyKzE3pgpuiPWjWtyrKrtevc1Dre
I2p2HGzf+dh2usP5B/2cQw1cd9izBozeB+EwssPG5qMtiZuFf2h6IqPFaIRcnJXd
+c912uuBVLNLIkdGh06jxyzFfy9N3jPMu+GHdyKnOihfT66f4FPbq9XQqBWvARLE
aDdVr3j56gJXmdplCjLFqEfXg8yNpWRWXInLyIGPe10r7P5Xvz6h1hBOo8tzoILa
QqxpQ+0vwY9ftGrE++q4GKWXtdiEU59n2pWuZ5hPfjOkPjUIFOpRxqXrpupAuD1P
LbBqEQ0YHiPQwLDN8bYsVj/v6wnl11jtAI34iUfdfx784fiyAaRDkg7pIXqKjQdZ
rCGSQfTsjLLUDG8kYAySsNqZBDl03VmeKkF083z0+oTHASucYaQ=
=JZJD
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
