Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752547AbeETCjY (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 22:39:24 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:22346 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752407AbeETCjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 22:39:23 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w4K2dJqd013023
X-Nifty-SrcIP: [209.85.213.43]
X-Google-Smtp-Source: AB8JxZo55jUQtYsbzZTGavr3EHkE9bDkhOmu/Gu2g9Z91Y+tl1BGmSH/v3N+KNYRDtLkaz/H8t2lIQRNIGEafyOhUv8=
MIME-Version: 1.0
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sun, 20 May 2018 11:38:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNASUq_9osPdzbiMCbYzeqc=W3Yv7tB63V+5gXqcZ9QBtYA@mail.gmail.com>
Message-ID: <CAK7LNASUq_9osPdzbiMCbYzeqc=W3Yv7tB63V+5gXqcZ9QBtYA@mail.gmail.com>
Subject: [GIT PULL] arm64: dts: uniphier: UniPhier DT updates for v4.18
To: arm-soc <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd, Olof,

Here are UniPhier DT (64bit) updates for the v4.18 merge window.
Please pull!


The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-dt64-v4.18

for you to fetch changes up to b076ff8bddfba793d49bca14feb49a0e84f41843:

  arm64: dts: uniphier: add syscon-phy-mode property to each ethernet
node (2018-04-25 00:21:14 +0900)

----------------------------------------------------------------
UniPhier ARM64 SoC DT updates for v4.18

- add more properties to ethernet nodes

----------------------------------------------------------------
Kunihiko Hayashi (2):
      arm64: dts: uniphier: add clock-names and reset-names to ethernet node
      arm64: dts: uniphier: add syscon-phy-mode property to each ethernet node

 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 5 ++++-
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 3 +++
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi | 8 +++++++-
 3 files changed, 14 insertions(+), 2 deletions(-)


-- 
Best Regards
Masahiro Yamada
