Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934385AbeBMQHv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 11:07:51 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:31010 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933848AbeBMQHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 11:07:48 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w1DG7TSt019366
X-Nifty-SrcIP: [209.85.213.42]
X-Google-Smtp-Source: AH8x2244H44WHG68T8eXV78r35arN2bBptK7vb5wCv4bFvQDUOfka+qEtH20Dczn+lIa24BqAdYAsTwsZj1FN2e2MxM=
MIME-Version: 1.0
In-Reply-To: <20180213130156.27827-1-suzuki.katsuhiro@socionext.com>
References: <20180213130156.27827-1-suzuki.katsuhiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 14 Feb 2018 01:06:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNARaJB-ymtj3b0XQn0P7yo7se0CXgCCO6pb5oKEhCxf4CQ@mail.gmail.com>
Message-ID: <CAK7LNARaJB-ymtj3b0XQn0P7yo7se0CXgCCO6pb5oKEhCxf4CQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] add UniPhier audio nodes
To: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-13 22:01 GMT+09:00 Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>:
> This series adds device-tree nodes for Socionext audio system
> for UniPhier LD11/LD20 SoCs. This one enables I2S output for
> Line-In, Line-Out, S/PDIF output and compress audio output.
>
> Katsuhiro Suzuki (3):
>   arm64: dts: uniphier: add sound node for UniPhier
>   arm64: dts: uniphier: add speaker out for UniPhier LD11/LD20 boards
>   arm64: dts: uniphier: add compress audio out for UniPhier LD11/LD20


Series, applied to linux-uniphier.  Thanks!

Note, I locally fixed trivial things:
 - Use #include <...> instead of #include "..." to include dt-binding header
 - Fix DTC warnings (Character '_' not recommended in node)
 - Remove unused labels such as 'audio', 'evea'



>  .../boot/dts/socionext/uniphier-ld11-global.dts    | 62 ++++++++++++++
>  arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi   | 92 +++++++++++++++++++++
>  .../boot/dts/socionext/uniphier-ld20-global.dts    | 62 ++++++++++++++
>  arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   | 96 ++++++++++++++++++++++
>  4 files changed, 312 insertions(+)
>
> --
> 2.15.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
