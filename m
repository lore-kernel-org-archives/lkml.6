Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032433AbeEZVBy (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 17:01:54 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43123 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032377AbeEZVBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 17:01:53 -0400
X-Google-Smtp-Source: ADUXVKLrwxRRxlmw0mzCCa0xWpglM3CLHTUQf3PCE9s7TIhNrmRpzZYZ74UApAAEZGjV58GDe63Uqw==
Date: Sat, 26 May 2018 14:01:37 -0700
From: Olof Johansson <olof@lixom.net>
To: torvalds@linux-foundation.org
Cc: olof@lixom.net, arm@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20180526210137.wbjji6vfi63k7c3a@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,


Please merge. Thanks!


-Olof


The following changes since commit 771c577c23bac90597c685971d7297ea00f99d11:

  Linux 4.17-rc6 (2018-05-20 15:31:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to e5dd61546a777d19d4fe35e2d0a2b664ca49f6b2:

  Merge tag 'hisi-fixes-for-4.17v2' of git://github.com/hisilicon/linux-hisi into fixes (2018-05-26 12:12:44 -0700)

----------------------------------------------------------------
ARM: SoC fixes for 4.17-rc

A few more fixes for v4.17:
 - A fix for a crash in scm_call_atomic on qcom platforms
 - Display fix for Allwinner A10
 - A fix that re-enables ethernet on Allwinner H3 (C.H.I.P et al)
 - A fix for eMMC corruption on hikey
 - i2c-gpio descriptor tables for ixp4xx
 + a small typo fix

----------------------------------------------------------------
Chen-Yu Tsai (1):
      ARM: dts: sun8i: h3: Re-enable EMAC on Orange Pi One

Colin Ian King (1):
      ARM: sun8i: v3s: fix spelling mistake: "disbaled" -> "disabled"

John Stultz (1):
      arm64: dts: hikey: Fix eMMC corruption regression

Linus Walleij (1):
      ARM: Fix i2c-gpio GPIO descriptor tables

Niklas Cassel (1):
      firmware: qcom: scm: Fix crash in qcom_scm_call_atomic1()

Olof Johansson (3):
      Merge tag 'sunxi-fixes-for-4.17' of https://git.kernel.org/.../sunxi/linux into fixes
      Merge tag 'qcom-fixes-for-4.17-rc7' of git://git.kernel.org/.../agross/linux into fixes
      Merge tag 'hisi-fixes-for-4.17v2' of git://github.com/hisilicon/linux-hisi into fixes

Pascal Roeleven (1):
      ARM: dts: sun4i: Fix incorrect clocks for displays

 arch/arm/boot/dts/sun4i-a10.dtsi                   | 6 +++---
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts        | 1 +
 arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts | 2 +-
 arch/arm/mach-ep93xx/core.c                        | 2 +-
 arch/arm/mach-ixp4xx/avila-setup.c                 | 2 +-
 arch/arm/mach-ixp4xx/dsmg600-setup.c               | 2 +-
 arch/arm/mach-ixp4xx/fsg-setup.c                   | 2 +-
 arch/arm/mach-ixp4xx/ixdp425-setup.c               | 2 +-
 arch/arm/mach-ixp4xx/nas100d-setup.c               | 2 +-
 arch/arm/mach-ixp4xx/nslu2-setup.c                 | 2 +-
 arch/arm/mach-pxa/palmz72.c                        | 2 +-
 arch/arm/mach-pxa/viper.c                          | 4 ++--
 arch/arm/mach-sa1100/simpad.c                      | 2 +-
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts     | 1 -
 drivers/firmware/qcom_scm-32.c                     | 8 ++++----
 15 files changed, 20 insertions(+), 20 deletions(-)
