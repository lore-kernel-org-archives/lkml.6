Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752555AbeETCfC (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 22:35:02 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:64818 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752407AbeETCfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 22:35:01 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w4K2Ynrx019956
X-Nifty-SrcIP: [209.85.213.52]
X-Google-Smtp-Source: AB8JxZqPl/NrMvZIdTP9iNfC5xLqb38kC//ODVGRmIsOMLO2/+8b+4N80HOjRCkxPUcPabI7QplUfeR3CJDQqDTFoo8=
MIME-Version: 1.0
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sun, 20 May 2018 11:34:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNATphrRyYvMXMMJz--UtfNk2BZLWHAp3XXpQLob5=5w2Qg@mail.gmail.com>
Message-ID: <CAK7LNATphrRyYvMXMMJz--UtfNk2BZLWHAp3XXpQLob5=5w2Qg@mail.gmail.com>
Subject: [GIT PULL] ARM: dts: uniphier: UniPhier DT updates for v4.18
To: arm-soc <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd, Olof,

Here are UniPhier DT (32bit) updates for the v4.18 merge window.
Please pull!


The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-dt-v4.18

for you to fetch changes up to 526f872b8492fbfb1a0f342e601bdc5ba322f16b:

  ARM: dts: uniphier: add syscon-phy-mode property to each ethernet
node (2018-04-25 00:21:51 +0900)

----------------------------------------------------------------
UniPhier ARM SoC DT updates for v4.18

- add more properties to ethernet nodes

----------------------------------------------------------------
Kunihiko Hayashi (2):
      ARM: dts: uniphier: add required clocks and resets to Pro4 ethernet node
      ARM: dts: uniphier: add syscon-phy-mode property to each ethernet node

 arch/arm/boot/dts/uniphier-pro4.dtsi | 10 +++++++---
 arch/arm/boot/dts/uniphier-pxs2.dtsi |  3 +++
 2 files changed, 10 insertions(+), 3 deletions(-)



-- 
Best Regards
Masahiro Yamada
