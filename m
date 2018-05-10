Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753432AbeEJETU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 00:19:20 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:49930 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbeEJETT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 00:19:19 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w4A4J9mn027087
X-Nifty-SrcIP: [209.85.213.42]
X-Google-Smtp-Source: AB8JxZr+OVZV+tXjpDinD87KaGgLDsjUKfCNvCXtOiIVzbhLYAqfjz+Snq/PefSiXG/+V8tJKHtFRfg7aLrQRFcjy8o=
MIME-Version: 1.0
In-Reply-To: <CAK7LNASuFh4wcSJ7HTW-+ZQCjZWt0QtjrOQQogoqzbM2W9n+nA@mail.gmail.com>
References: <CAK7LNASuFh4wcSJ7HTW-+ZQCjZWt0QtjrOQQogoqzbM2W9n+nA@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 10 May 2018 13:18:28 +0900
X-Gmail-Original-Message-ID: <CAK7LNARwR+9RhGTSJDxZY+NpLAzJNYgTV=v5GOR=nuT5SWqQFA@mail.gmail.com>
Message-ID: <CAK7LNARwR+9RhGTSJDxZY+NpLAzJNYgTV=v5GOR=nuT5SWqQFA@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: uniphier: fixes for v4.17
To: arm-soc <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd, Olof,


2018-04-29 0:47 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Hi Arnd, Olof,
>
> Please pull some fixes of ARM UniPhier DT.


I am guessing why this has not been pulled yet.
Right, I was late - you had already sent the fixes pull request to Linus.

Do you have a chance to send another fixes PR for 4.17?






>
>
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
>
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
> tags/uniphier-fixes-v4.17
>
> for you to fetch changes up to 8b82b66e68b32dd8e22a04db6a0494bfdd65156f:
>
>   arm64: dts: uniphier: stabilize ethernet of LD20 reference board
> (2018-04-29 00:33:42 +0900)
>
> ----------------------------------------------------------------
> UniPhier ARM SoC fixes for v4.17
>
> - Fix input delay parameter of eMMC PHY
> - Weaken drive-strength of ethernet PHY pins of LD20 reference board
>
> ----------------------------------------------------------------
> Masahiro Yamada (2):
>       arm64: dts: uniphier: fix input delay value for legacy mode of eMMC
>       arm64: dts: uniphier: stabilize ethernet of LD20 reference board
>
>  arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi    | 2 +-
>  arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts | 8 ++++++++
>  arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi    | 2 +-
>  arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi    | 2 +-
>  4 files changed, 11 insertions(+), 3 deletions(-)
>
>
>
>
> --
> Best Regards
> Masahiro Yamada



-- 
Best Regards
Masahiro Yamada
