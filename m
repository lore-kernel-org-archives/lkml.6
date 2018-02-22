Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932907AbeBVOYn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 09:24:43 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:54457 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932638AbeBVOYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 09:24:39 -0500
X-Google-Smtp-Source: AH8x2254uXF9zmY2m27SI42tAXM71ctviaRDIfPCR92hTHPmbGOm0aAQ9Qk6tEAM8q9cpoAlg7t9kA==
Reply-To: monstr@monstr.eu
Subject: Re: arch/microblaze/lib/fastcopy.S:33:2: error: #error Microblaze LE
 not support ASM optimized lib func. Disable OPT_LIB_ASM.
To: kbuild test robot <fengguang.wu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org
References: <201802200725.yWq58Mlm%fengguang.wu@intel.com>
From: Michal Simek <monstr@monstr.eu>
Message-ID: <9947be54-1cfb-b84b-f5d7-17c2d0a2b06e@monstr.eu>
Date: Thu, 22 Feb 2018 15:24:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <201802200725.yWq58Mlm%fengguang.wu@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Q3pyFHCQaUXgw6uptCJ21QYznxbYqV5uN"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Q3pyFHCQaUXgw6uptCJ21QYznxbYqV5uN
Content-Type: multipart/mixed; boundary="NbIYeQOaWPzo0PhPfdraQGVHlCKojZzH5";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: kbuild test robot <fengguang.wu@intel.com>, Arnd Bergmann <arnd@arndb.de>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org
Message-ID: <9947be54-1cfb-b84b-f5d7-17c2d0a2b06e@monstr.eu>
Subject: Re: arch/microblaze/lib/fastcopy.S:33:2: error: #error Microblaze LE
 not support ASM optimized lib func. Disable OPT_LIB_ASM.
References: <201802200725.yWq58Mlm%fengguang.wu@intel.com>
In-Reply-To: <201802200725.yWq58Mlm%fengguang.wu@intel.com>

--NbIYeQOaWPzo0PhPfdraQGVHlCKojZzH5
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

I have sent a patch for this issue.
https://lkml.org/lkml/2018/2/22/441

Thanks for reporting,
Michal

On 20.2.2018 00:25, kbuild test robot wrote:
> Hi Arnd,
>=20
> FYI, the error/warning still remains.
>=20
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git master
> head:   79c0ef3e85c015b0921a8fd5dd539d1480e9cd6c
> commit: 71e7673dadfdae0605d4c1f66ecb4b045c79fe0f microblaze: fix endian=
 handling
> date:   5 weeks ago
> config: microblaze-mmu_defconfig (attached as .config)
> compiler: microblaze-linux-gcc (GCC) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/s=
bin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 71e7673dadfdae0605d4c1f66ecb4b045c79fe0f
>         # save the attached .config to linux build tree
>         make.cross ARCH=3Dmicroblaze=20
>=20
> All errors (new ones prefixed by >>):
>=20
>>> arch/microblaze/lib/fastcopy.S:33:2: error: #error Microblaze LE not =
support ASM optimized lib func. Disable OPT_LIB_ASM.
>     #error Microblaze LE not support ASM optimized lib func. Disable OP=
T_LIB_ASM.
>      ^~~~~
>=20
> vim +33 arch/microblaze/lib/fastcopy.S
>=20
> de93c3c1 Michal Simek 2011-01-28 @33  #error Microblaze LE not support =
ASM optimized lib func. Disable OPT_LIB_ASM.
> de93c3c1 Michal Simek 2011-01-28  34  #endif
> de93c3c1 Michal Simek 2011-01-28  35 =20
>=20
> :::::: The code at line 33 was first introduced by commit
> :::::: de93c3c119382cb888ca8a94b642dbcf8035525e microblaze: Fix ASM opt=
imized code for LE
>=20
> :::::: TO: Michal Simek <monstr@monstr.eu>
> :::::: CC: Michal Simek <monstr@monstr.eu>
>=20
> ---
> 0-DAY kernel test infrastructure                Open Source Technology =
Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corpo=
ration
>=20


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--NbIYeQOaWPzo0PhPfdraQGVHlCKojZzH5--

--Q3pyFHCQaUXgw6uptCJ21QYznxbYqV5uN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlqO0p8ACgkQykllyylKDCG7QgCfchV55+qXWNnoDtzMI4ol7KZi
DZAAnijDEkyGEGSk1ahZ+ViSbUlukUFI
=PSnS
-----END PGP SIGNATURE-----

--Q3pyFHCQaUXgw6uptCJ21QYznxbYqV5uN--
