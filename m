Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751828AbeDKFjr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 01:39:47 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:37411 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbeDKFjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 01:39:46 -0400
X-Google-Smtp-Source: AIpwx49jPQpzz++Lba9BSXEdXbrUEDdDXIJ0Vxq9Y8yXailGRNrcp/zfWtzBOKM1BK/TaY4helyFDQ==
Date: Tue, 10 Apr 2018 22:39:41 -0700
From: Benson Leung <bleung@google.com>
To: lee.jones@linaro.org
Cc: bleung@google.com, bleung@chromium.org, linux-kernel@vger.kernel.org,
        enric.balletbo@collabora.com, gwendal@chromium.org
Subject: [GIT PULL] Immutable branch between MFD and Platform due for the
 v4.17 merge window
Message-ID: <20180411053941.GA123734@decatoncale.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lee,

Please take a look at this IB that incorporates v4 of Enric's cros_ec debug=
fs
and sysfs series.

Thanks!
Benson

The following changes since commit 3eb2ce825ea1ad89d20f7a3b5780df850e4be274:

  Linux 4.16-rc7 (2018-03-25 12:44:30 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platform.git =
ib-chrome-platform-cros-ec-sysfs-debugfs-for-v4.17

for you to fetch changes up to c1d1e91aff3d1183d6b16a282c2575e3e006cee4:

  platform/chrome: mfd/cros_ec_dev: Add sysfs entry to set keyboard wake li=
d angle (2018-04-10 22:25:07 -0700)

----------------------------------------------------------------
Enric Balletbo i Serra (3):
      platform/chrome: cros_ec_sysfs: introduce to_cros_ec_dev define.
      platform/chrome: cros_ec_sysfs: use permission-specific DEVICE_ATTR v=
ariants
      platform/chrome: cros_ec_debugfs: Use octal permissions '0444'

Gwendal Grignou (2):
      platform/chrome: cros_ec_sysfs: Modify error handling
      platform/chrome: mfd/cros_ec_dev: Add sysfs entry to set keyboard wak=
e lid angle

Shawn Nematbakhsh (1):
      platform/chrome: cros_ec_debugfs: Add PD port info to debugfs

 drivers/mfd/cros_ec_dev.c                 |  31 +++----
 drivers/platform/chrome/cros_ec_debugfs.c |  76 +++++++++++++++-
 drivers/platform/chrome/cros_ec_sysfs.c   | 141 +++++++++++++++++++++-----=
----
 include/linux/mfd/cros_ec.h               |   2 +
 include/linux/mfd/cros_ec_commands.h      |   3 +
 5 files changed, 194 insertions(+), 59 deletions(-)


--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlrNn50ACgkQHwn1ewov
5lifBg//R8JNidEP99ljDEjap/CYgbwy9HZdmmXIP2hzwt7PQM8Oi28NTqM6QRwY
sg7IJngnzYLlIToZ3ICXboVjzkXlNxht/0k8XxN2Vjma7ElkVfYnptBCGV7aiSR8
D27WrfHKS9ocMuxOTwzKPBPz7bgUw8epTLBLgvkXmDCqPf5Tj2IJJjKwZNzR469W
a/B8PtyrVT3nbmdOQOWBWAbbULjwNWDvaeYUufdTZ6N8eiNpxKFMMM5iJ/7oZpTr
sigfp8sGnx/amaXxn7isy1uVaIL6edaRRrpOsd2hEg7sA8AZUcqolLVVqdbcJW+k
g4zzc0sq/yQD9Z1VoCQJ7CFmFtuoVPGhef636uJcnw3BDOtyObQS8ZpjhPGRiRWl
00Z4xp2sDiDjQ1FwwPSDsnfRxNf6ew3d4YI0BFtAlaiSxS2Dvo/1NTON+cCUdSvY
SRxztlbODxfI05RR+ueMaON9YGv7grdvzujTnbieDsXtpMafrc6/zotQbFXLnJC5
FgXTg5Le5vqV2HXza3BwzuoraxR9yVjq4/Teyp6fO999luqjXnSELxo/y60M1Z9r
l0/62K5FH+Zm4+GVfDn1iBIVCtiefe7nvDGyqlttPj90yS2vHabILMqwf+mawmNB
EmrfcFHvDQSXNzHKsryt2j30+OjRhNfYDanP3gdYig3fHfZyn9Q=
=3iqT
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
