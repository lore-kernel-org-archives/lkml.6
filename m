Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751572AbeCPLzi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 07:55:38 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46497 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbeCPLzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 07:55:35 -0400
X-Google-Smtp-Source: AG47ELtpMJe4OnWGVjRUhV/TGerZ/OP4JrpmYxhzczlC4qOUuBYl2SLAWBY8nu/GiE58By0Zbqj6Ug==
To: Linus Torvalds <torvalds@linux-foundation.org>
Reply-To: monstr@monstr.eu
Cc: LKML <linux-kernel@vger.kernel.org>
From: Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] arch/microblaze fixes for 4.16-rc6
Message-ID: <b30cd129-e617-ffe8-18a6-127d558a1abd@monstr.eu>
Date: Fri, 16 Mar 2018 12:55:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="SalikHoWNf2FWRTOVfV5WCm2UCS7MowbC"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SalikHoWNf2FWRTOVfV5WCm2UCS7MowbC
Content-Type: multipart/mixed; boundary="tUeaOPzPESdBDkBe85Syic2uDehf5HpKy";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Message-ID: <b30cd129-e617-ffe8-18a6-127d558a1abd@monstr.eu>
Subject: [GIT PULL] arch/microblaze fixes for 4.16-rc6

--tUeaOPzPESdBDkBe85Syic2uDehf5HpKy
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

please pull the following fixes to your tree to fix current issues.

Thanks,
Michal

The following changes since commit 91ab883eb21325ad80f3473633f794c78ac87f=
51:

  Linux 4.16-rc2 (2018-02-18 17:29:42 -0800)

are available in the git repository at:

  git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-4.16-rc6

for you to fetch changes up to 101646a24a2f9cdb61d7732459fbf068a7bbb542:

  microblaze: switch to NO_BOOTMEM (2018-03-16 12:51:27 +0100)

----------------------------------------------------------------
Microblaze fixes for 4.16-rc6

- Use NO_BOOTMEM to fix boot issue
- Fix opt lib endian dependencies

----------------------------------------------------------------
Michal Simek (1):
      microblaze: Setup dependencies for ASM optimized lib functions

Rob Herring (2):
      microblaze: remove unused alloc_maybe_bootmem
      microblaze: switch to NO_BOOTMEM

 arch/microblaze/Kconfig             |  1 +
 arch/microblaze/Kconfig.platform    |  2 +-
 arch/microblaze/include/asm/setup.h |  1 -
 arch/microblaze/lib/fastcopy.S      |  4 ----
 arch/microblaze/mm/init.c           | 64
++++++-------------------------------------------------
 5 files changed, 8 insertions(+), 64 deletions(-)

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--tUeaOPzPESdBDkBe85Syic2uDehf5HpKy--

--SalikHoWNf2FWRTOVfV5WCm2UCS7MowbC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlqrsLAACgkQykllyylKDCFFdQCbBY9DstyXAaWYbjHWBHzxKeZQ
iKcAnRNa2S1pE9ISi4Sf+WwuSY+70SZV
=fVJh
-----END PGP SIGNATURE-----

--SalikHoWNf2FWRTOVfV5WCm2UCS7MowbC--
