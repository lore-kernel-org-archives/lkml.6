Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752696AbeCOOs0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 10:48:26 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:22060 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752293AbeCOOsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 10:48:24 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w2FElvnr002729
X-Nifty-SrcIP: [209.85.217.176]
X-Google-Smtp-Source: AG47ELtU3RrqwdVFqo9MbXklrOuoAIM1SDCGsCSPNzGCWy/yTLOwPatQEQMerRnyDwJvIMsBu+bcHyup3sItuvFK4+k=
MIME-Version: 1.0
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 15 Mar 2018 23:47:16 +0900
X-Gmail-Original-Message-ID: <CAK7LNASQ=JHNng80W-k6oxtpSRHzxHeZgNZvWFcU1vM52U7Wmg@mail.gmail.com>
Message-ID: <CAK7LNASQ=JHNng80W-k6oxtpSRHzxHeZgNZvWFcU1vM52U7Wmg@mail.gmail.com>
Subject: [GIT PULL] ARM: dts: uniphier: UniPhier DT updates for v4.17
To: arm-soc <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd, Olof,

Please pull UniPhier DT updates for v4.17.

Note:
In this development cycle, I ended up with putting all of arm/arm64 changes
into a single pull request.
This is because some DTSI files are shared across arches.
So, I needed to do this to avoid build errors.



The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-dt-v4.17

for you to fetch changes up to 7f9f76b10dbe3f2585a21699312f74ed2b544b84:

  ARM: dts: uniphier: add sound node for PXs2 (2018-03-15 23:19:05 +0900)

----------------------------------------------------------------
UniPhier ARM SoC DT updates for v4.17

- add sound support
- add ethernet support
- use proper SPDX-License-Identifier style

----------------------------------------------------------------
Katsuhiro Suzuki (6):
      ARM: dts: uniphier: add audio in/out pin-mux node
      arm64: dts: uniphier: add sound node
      arm64: dts: uniphier: add speaker out for LD11/LD20 boards
      arm64: dts: uniphier: add compress audio out for LD11/LD20
      arm64: dts: uniphier: add fixed regulators for audio codec
      ARM: dts: uniphier: add sound node for PXs2

Kunihiko Hayashi (2):
      ARM: dts: uniphier: add AVE ethernet node
      arm64: dts: uniphier: add AVE ethernet node

Masahiro Yamada (2):
      ARM: dts: uniphier: use proper SPDX-License-Identifier style
      arm64: dts: uniphier: use proper SPDX-License-Identifier style

 arch/arm/boot/dts/uniphier-ld4-ref.dts                 |  14 ++-
 arch/arm/boot/dts/uniphier-ld4.dtsi                    |  14 ++-
 arch/arm/boot/dts/uniphier-ld6b-ref.dts                |  25 +++--
 arch/arm/boot/dts/uniphier-ld6b.dtsi                   |  14 ++-
 arch/arm/boot/dts/uniphier-pinctrl.dtsi                |  54 ++++++++--
 arch/arm/boot/dts/uniphier-pro4-ace.dts                |  25 +++--
 arch/arm/boot/dts/uniphier-pro4-ref.dts                |  25 +++--
 arch/arm/boot/dts/uniphier-pro4-sanji.dts              |  25 +++--
 arch/arm/boot/dts/uniphier-pro4.dtsi                   |  32 ++++--
 arch/arm/boot/dts/uniphier-pro5.dtsi                   |  14 ++-
 arch/arm/boot/dts/uniphier-pxs2-gentil.dts             |  49 +++++++--
 arch/arm/boot/dts/uniphier-pxs2-vodka.dts              |  62 +++++++++--
 arch/arm/boot/dts/uniphier-pxs2.dtsi                   |  86 +++++++++++++--
 arch/arm/boot/dts/uniphier-ref-daughter.dtsi           |  14 ++-
 arch/arm/boot/dts/uniphier-sld8-ref.dts                |  14 ++-
 arch/arm/boot/dts/uniphier-sld8.dtsi                   |  14 ++-
 arch/arm/boot/dts/uniphier-support-card.dtsi           |  14 ++-
 arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts | 109
+++++++++++++++++--
 arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts    |  25 +++--
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi       | 124
++++++++++++++++++++--
 arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts | 111
+++++++++++++++++--
 arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts    |  25 +++--
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi       | 135
++++++++++++++++++++++--
 arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts    |  14 ++-
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi       |  14 ++-
 25 files changed, 850 insertions(+), 202 deletions(-)


-- 
Best Regards
Masahiro Yamada
