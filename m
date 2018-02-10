Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750968AbeBJHIe (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 02:08:34 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:35032 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750756AbeBJHId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 02:08:33 -0500
X-Google-Smtp-Source: AH8x224QMdikp26ytAPWN2g/eVEU2V+ZswSTNSMEj1iFhyvVuRYePmS+feAj01FpUiRIJTozxUklQg==
Date: Fri, 9 Feb 2018 23:08:27 -0800
From: Benson Leung <bleung@google.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, bleung@chromium.org, groeck@chromium.org,
        dtor@chromium.org, dmitry.torokhov@gmail.com, olof@lixom.net,
        linux@roeck-us.net, bleung@google.com
Subject: [GIT PULL] chrome-platform updates for v4.16
Message-ID: <20180210070827.GB9881@bleung-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit 50c4c4e268a2d7a3e58ebb698ac74da0de40ae36:

  Linux 4.15-rc3 (2017-12-10 17:56:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platform.git =
tags/chrome-platform-for-linus-4.16

for you to fetch changes up to d48b8c58c57f6edbe2965f0a5f62c5cf9593ca96:

  platform/chrome: Use proper protocol transfer function (2017-12-17 14:04:=
21 -0800)

----------------------------------------------------------------
chrome-platform-for-linus-4.16

Moving cros_ec_dev to drivers/mfd.
Other small maintenance fixes.

----------------------------------------------------------------
Arnd Bergmann (1):
      cros_ec: fix nul-termination for firmware build info

Benson Leung (1):
      Merge branch 'ibs-for-chrome-platform-merged' into working-branch-for=
-4.16

Bhumika Goyal (1):
      platform/chrome: chromeos_laptop: make chromeos_laptop const

Colin Ian King (1):
      platform/chrome: cros_ec_lpc: remove redundant pointer request

Enric Balletbo i Serra (1):
      platform/chrome: cros_ec_lpc: Register the driver if ACPI entry is mi=
ssing.

Shawn Nematbakhsh (1):
      platform/chrome: Use proper protocol transfer function

Thierry Escande (3):
      cros_ec: Split cros_ec_devs module
      cros_ec: Move cros_ec_dev module to drivers/mfd
      platform/chrome: cros_ec_lpc: Add support for Google Glimmer

 drivers/mfd/Kconfig                            | 10 ++++++
 drivers/mfd/Makefile                           |  1 +
 drivers/mfd/cros_ec.c                          |  4 +--
 drivers/{platform/chrome =3D> mfd}/cros_ec_dev.c |  8 +++--
 drivers/{platform/chrome =3D> mfd}/cros_ec_dev.h |  0
 drivers/platform/chrome/Kconfig                | 10 ++----
 drivers/platform/chrome/Makefile               |  7 ++--
 drivers/platform/chrome/chromeos_laptop.c      | 22 ++++++-------
 drivers/platform/chrome/cros_ec_debugfs.c      |  5 ++-
 drivers/platform/chrome/cros_ec_debugfs.h      | 27 ----------------
 drivers/platform/chrome/cros_ec_lightbar.c     |  6 ++--
 drivers/platform/chrome/cros_ec_lpc.c          | 44 ++++++++++++++++++++++=
+---
 drivers/platform/chrome/cros_ec_proto.c        |  8 +++--
 drivers/platform/chrome/cros_ec_sysfs.c        |  7 ++--
 drivers/platform/chrome/cros_ec_vbc.c          |  1 +
 include/linux/mfd/cros_ec.h                    |  4 +++
 16 files changed, 94 insertions(+), 70 deletions(-)
 rename drivers/{platform/chrome =3D> mfd}/cros_ec_dev.c (99%)
 rename drivers/{platform/chrome =3D> mfd}/cros_ec_dev.h (100%)
 delete mode 100644 drivers/platform/chrome/cros_ec_debugfs.h

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

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlp+mmsACgkQHwn1ewov
5lhZkBAAgNPLCCe5ZpfL3U+BTh1g+n0CVlKiMvw5IxU3TpWKV1MDuxxJCXUFyIM9
UYG05ylqQxT/+kbq913w/RZ0a3hNbMrG21+8X8I6vFluHhp3v3NE/fu5hrtjCxxc
ixfGuzr/TXsxRwiqpLapaJuYvHJEz+kKpzI1YUuWg+mPfNJWPJQBW5oGQ9Z40cPG
m3aPGJXfgIngob0YC+Nleubgpvw7W/hckeLYS90GGPtEg+35mb4HOsWCarlNctN4
YgHoagARGTKets7fm72fwQfPfJFcJ3RZ2nao5r1gVITIMk6IlqNBSGB/InIIo/oH
7TRbdaykCzN9fN7JLnYHGJLCGFyX9mNNX3mtnPzXROj9V5cNUxk4MoKY41OcpDR5
A+DkgaiN+h5MHamh1Wunmgi8o1TS/xJFvQ5mxa9PVycfn1Qf5nlvaysr5g7t2eqk
gjpUmwJOvA0nuK5AsiiG5Z45AXCIxxS2QdwUrIU4VRZeuU2QbXxATWHtVQFRKQ4t
7ZZt9azMYv3+0c7XIpslv1JKqrtPl3b8b2iBhswfiovXUxXY89T/aj5AoI1knK67
8pa4KFjZS9PSz9h9A/ahmz9knS8ga/iKsVRXNpWo1zjK3W6oTYvg7nT2rmq70zS1
SHyZOcph+0cWk73eyvSDKmIUupPNnmadQtlVoZYP4yUVIxIMD38=
=asiT
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--
