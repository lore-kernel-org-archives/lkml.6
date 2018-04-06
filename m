Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756425AbeDFN5j (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 09:57:39 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:46482 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753203AbeDFN5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 09:57:35 -0400
X-Google-Smtp-Source: AIpwx4819adO7+TfH/J/1E1D2cecohX64TPiwzTxZ8bAOOk4J20gHooAeSTtV1eBO1xdpLN7Rw112fi1V63i9jo99PQ=
MIME-Version: 1.0
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 6 Apr 2018 15:57:34 +0200
X-Google-Sender-Auth: 1BP9xpAW3qzr5hzUDlUJXdJ56as
Message-ID: <CAK8P3a2rJKC4riAnYwM2RhtQBuVgOYC5qfYg+tL8YVd-CT6ygg@mail.gmail.com>
Subject: Re: [GIT PULL 1/3] ARM: SoC device tree updates for 4.17
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        arm-soc <arm@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 6, 2018 at 6:24 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Apr 5, 2018 at 2:29 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> One clear sign that the branch is indeed bigger than usual: the
>> shortlog+diffstat exceeds the 100KB limit for the linux-arm-kernel
>> mailing list.
>
> I think you replied to the wrong pull request, and meant to reply to
> the DT one..
>
> The platform updates one was not that big.

D'oh. If anyone still needs the original pull request message in the
mailing list archives, I've copied that again below.

      Arnd

----
The following changes since commit 661e50bc853209e41a5c14a290ca4decc43cbfd1:

  Linux 4.16-rc4 (2018-03-04 14:54:11 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-dt

for you to fetch changes up to 518d2f43c358da2072948f64df99b1bd417288dc:

  arm: dts: modify Nuvoton NPCM7xx device tree structure (2018-04-05
11:13:39 +0200)

----------------------------------------------------------------
ARM: SoC device tree updates for 4.17

This is the usual set of changes for device trees, with over 700
non-merged changesets. There is an ongoing set of dtc warning fixes and
the usual bugfixes, cleanups and added device support.

The most interesting bit as usual is support for new machines listed
below:

- The Allwinner H6 makes its debut with the Pine-H64 board, and we get
  two new machines based on its older siblings: the H5 based OrangePi
  Zero+ and the A64 based Teres-I Laptop from Olimex. On the 32-bit side,
  we add The Olimex som204 based on Allwinner A20, and the Banana Pi M2
  Zero development board (based on H2).

- NVIDIA adds support for Tegra194 aka "Xavier", plus their p2972
  development board and p2888 CPU module.

- The Nuvoton npcm750 is a BMC that was newly added, for now we only
  support running on the evaluation board.

- STmicroelectronics stm32 gains support for the stm32mp157c and two
  evaluation boards.

- The Toradex Colibri board family grows a few members based on the
  i.MX6ULL variant.

- The Advantec DMS-BA16 is a Qseven module using the NXP i.MX6
  family of chips.

- The Phytec phyBOARD Mira is a family of industrial boards based on
  i.MX6. For now, four models get added.

- TI am335x based PDU-001 is an industrial embedded machine used for
  traffic monitoring

- The Aspeed platform now supports running on the BMC on the Qualcomm
  Centriq 2400 server

- Samsung Exynos4 based Galaxy S3 is a family of mobile phones Qualcomm
  msm8974 based Galaxy S5 is a rather different phone made by the same
  company.

- The Xilinx Zynq and ZynqMP platforms now gained a lot of dts file
  for the various boards made by Xilinx themselves, as well as the
  Digilent Zybo Z7.

- The ARM Versatile family now supports the "IB2" interface board.

- The Renesas H2 based "Stout" and the H3 based Salvator-X are more
  evaluation boards named after a kind of beer, as most of them are.
  The r8a77980 (V3H) based "Condor" apparently doesn't follow that
  tradition. ;-)

- ROC-RK3328-CC is a simple developement board from the Libre Computer
  Project, based on the Rockchips RK3328 SoC

- Haiku is another development board plus Qseven module based on Rockchips
  RK3368 and made by Theobroma Systems.
