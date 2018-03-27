Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753580AbeC0QcP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 12:32:15 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:19355 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753528AbeC0QcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 12:32:10 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w2RGVuEN015246
X-Nifty-SrcIP: [209.85.213.54]
X-Google-Smtp-Source: AIpwx49/+9tsAnjfDz1bNsSDr9wPz5bNuDIIjQS0nOb58rxiB6S1Iae9lewNBys+Bx9fV+zcSfSm6ED6Yhr2XjCGOVg=
MIME-Version: 1.0
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 28 Mar 2018 01:31:15 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQWikF9K41uzkQjixUEO=_s14txEhvd=rmLY69JShezKg@mail.gmail.com>
Message-ID: <CAK7LNAQWikF9K41uzkQjixUEO=_s14txEhvd=rmLY69JShezKg@mail.gmail.com>
Subject: [GIT PULL] ARM: dts: uniphier: UniPhier DT updates for 4.17 (2nd)
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm-soc <arm@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd, Olof,

Sorry for this very late pull request.
If possible, could you pull a little more for v4.17-rc1 ?



The following changes since commit 7f9f76b10dbe3f2585a21699312f74ed2b544b84:

  ARM: dts: uniphier: add sound node for PXs2 (2018-03-15 23:19:05 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-dt-v4.17-2

for you to fetch changes up to aba054a1cd45d87ce473fea6cabbf4b2dc677569:

  arm64: dts: uniphier: add ethernet node for PXs3 (2018-03-28 01:16:18 +0900)

----------------------------------------------------------------
UniPhier ARM SoC DT updates for v4.17 (2nd)

- add syscon property to sound nodes
- add more ethernet pin groups
- add ethernet support for PXs3 SoC

----------------------------------------------------------------
Katsuhiro Suzuki (2):
      arm64: dts: uniphier: add syscon property for UniPhier sound system
      ARM: dts: uniphier: add syscon property for UniPhier sound system

Kunihiko Hayashi (2):
      ARM: dts: uniphier: add pinctrl groups of ethernet for second instance
      arm64: dts: uniphier: add ethernet node for PXs3

 arch/arm/boot/dts/uniphier-pinctrl.dtsi            | 10 ++++++
 arch/arm/boot/dts/uniphier-pxs2.dtsi               |  3 +-
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi   |  3 +-
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   |  3 +-
 .../arm64/boot/dts/socionext/uniphier-pxs3-ref.dts | 22 +++++++++++++
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi   | 36 ++++++++++++++++++++++
 6 files changed, 74 insertions(+), 3 deletions(-)


-- 
Best Regards
Masahiro Yamada
