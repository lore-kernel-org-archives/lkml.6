Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752724AbeDLIAO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 04:00:14 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35055 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751450AbeDLIAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 04:00:09 -0400
X-Google-Smtp-Source: AIpwx49vTdElTnoca48d3x7mYkYjQCg2/yHQILdgh13KI1JsDt6nWmpOnHeocghf1SVCJrN85w9ozQ==
Reply-To: monstr@monstr.eu
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
From: Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] arch/microblaze patches for 4.17-rc1
Openpgp: preference=signencrypt
Message-ID: <9d01b6cf-e828-79d3-374e-be419c105938@monstr.eu>
Date: Thu, 12 Apr 2018 10:00:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="kRq0XAmJxsHXCteh6XLQpreCWHNrFHB42"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kRq0XAmJxsHXCteh6XLQpreCWHNrFHB42
Content-Type: multipart/mixed; boundary="AlGRaFyw8RZtRcNtFlRbTjj7lAAEdNybk";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Message-ID: <9d01b6cf-e828-79d3-374e-be419c105938@monstr.eu>
Subject: [GIT PULL] arch/microblaze patches for 4.17-rc1

--AlGRaFyw8RZtRcNtFlRbTjj7lAAEdNybk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

please pull the following patches to your tree.

Thanks,
Michal


The following changes since commit c698ca5278934c0ae32297a8725ced2e27585d=
7f:

  Linux 4.16-rc6 (2018-03-18 17:48:42 -0700)

are available in the Git repository at:

  git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-4.17-rc1

for you to fetch changes up to 70f6283a372bef685fd64564646a3b49a55be1ea:

  microblaze: Use generic pci_mmap_resource_range() (2018-03-19 15:33:05
+0100)

----------------------------------------------------------------
Microblaze patches for 4.17-rc1

- Use generic pci_mmap_resoruce_range()

----------------------------------------------------------------
David Woodhouse (1):
      microblaze: Use generic pci_mmap_resource_range()

Michal Simek (1):
      microblaze: Provide pgprot_device/writecombine macros for nommu

 arch/microblaze/include/asm/pci.h     |  7 ++++---
 arch/microblaze/include/asm/pgtable.h |  2 ++
 arch/microblaze/pci/pci-common.c      | 99
+++++++++----------------------------------------------------------------=
--------------------------
 3 files changed, 15 insertions(+), 93 deletions(-)


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--AlGRaFyw8RZtRcNtFlRbTjj7lAAEdNybk--

--kRq0XAmJxsHXCteh6XLQpreCWHNrFHB42
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlrPEgIACgkQykllyylKDCHORQCgl8UR682LQcvt6k5gJDQQCRr8
MDAAni6ZJClxI1gA1HRneWSSQVU6LJaE
=v17q
-----END PGP SIGNATURE-----

--kRq0XAmJxsHXCteh6XLQpreCWHNrFHB42--
