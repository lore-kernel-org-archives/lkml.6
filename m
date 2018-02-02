Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751606AbeBBGiv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 01:38:51 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39520 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbeBBGin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 01:38:43 -0500
X-Google-Smtp-Source: AH8x226pdeERkOoLPtOkbLeiA6wcfhz1ewCJEyq+tPoiVDoVLSzG28xSY1yTszusY+KsDE+HK25GWw==
Reply-To: monstr@monstr.eu
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
From: Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] arch/microblaze patches for 4.16-rc1
Message-ID: <ae6c735f-e9de-dbc2-7018-51fac09a5702@monstr.eu>
Date: Fri, 2 Feb 2018 07:38:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="JI55PJeBcpb4ViTURqQHzU8wqfApdaSq5"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JI55PJeBcpb4ViTURqQHzU8wqfApdaSq5
Content-Type: multipart/mixed; boundary="feyQTUSmyK9vhCVWk6eBLjGtoSbcexDpY";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Message-ID: <ae6c735f-e9de-dbc2-7018-51fac09a5702@monstr.eu>
Subject: [GIT PULL] arch/microblaze patches for 4.16-rc1

--feyQTUSmyK9vhCVWk6eBLjGtoSbcexDpY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

please pull the following fixes to your tree.

Thanks,
Michal


The following changes since commit a8750ddca918032d6349adbf9a4b6555e7db20=
da:

  Linux 4.15-rc8 (2018-01-14 15:32:30 -0800)

are available in the git repository at:

  git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-4.16-rc1

for you to fetch changes up to 7b6ce52be3f86520524711a6f33f3866f9339694:

  microblaze: Setup proper dependency for optimized lib functions
(2018-01-22 11:24:14 +0100)

----------------------------------------------------------------
Microblaze patches for 4.16-rc1

- Fix endian handling and Kconfig dependency
- Fix iounmap prototype

----------------------------------------------------------------
Arnd Bergmann (2):
      microblaze: fix endian handling
      microblaze: fix iounmap prototype

Michal Simek (1):
      microblaze: Setup proper dependency for optimized lib functions

 arch/microblaze/Kconfig.platform |  1 +
 arch/microblaze/Makefile         | 17 +++++++++++------
 arch/microblaze/include/asm/io.h |  2 +-
 arch/microblaze/mm/pgtable.c     |  2 +-
 4 files changed, 14 insertions(+), 8 deletions(-)



--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--feyQTUSmyK9vhCVWk6eBLjGtoSbcexDpY--

--JI55PJeBcpb4ViTURqQHzU8wqfApdaSq5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlp0B2wACgkQykllyylKDCEW4ACaAoioD97fhYTMdBjlUOocrUte
1HUAnigiFDBgzjsj79Iq3U/C3smAdu4x
=jKZ5
-----END PGP SIGNATURE-----

--JI55PJeBcpb4ViTURqQHzU8wqfApdaSq5--
