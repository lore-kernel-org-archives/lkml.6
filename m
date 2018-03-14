Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753360AbeCNGH7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 02:07:59 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:31422 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbeCNGH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 02:07:58 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w2E67ofR029111
X-Nifty-SrcIP: [209.85.217.169]
X-Google-Smtp-Source: AG47ELtJ57S6P/XcTTLTzEImrvlz0opdlnnrY0bYAS+sPx7YlbMi6j12NJ9V/eiNa1dUgNpzhJUhhcqV7F4JrqJhFVE=
MIME-Version: 1.0
In-Reply-To: <20180314051137.6091-1-suzuki.katsuhiro@socionext.com>
References: <20180314051137.6091-1-suzuki.katsuhiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 14 Mar 2018 15:07:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQwr1OqhmeyL1ZqRABRuUzk+mh=bDKgDMVV0ZhdyFGxAA@mail.gmail.com>
Message-ID: <CAK7LNAQwr1OqhmeyL1ZqRABRuUzk+mh=bDKgDMVV0ZhdyFGxAA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: uniphier: add PXs2 Audio in/out pin-mux settings
To: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc: linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-14 14:11 GMT+09:00 Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>:
> The UniPhier PXs2 SoC audio core use following 25 pins:
>   ain1    : 2ch I2S input : AI1ADCCK, AI1BCK, AI1D0, AI1LRCK
>   ain2    : 8ch I2S input : AI2ADCCK, AI2BCK, AI2D[0-3], AI2LRCK
>   ainiec1 : S/PDIF input  : XIRQ17 (for AO1IEC)
>   aout2   : 8ch I2S output: AO2BCK, AO2D0, AO2DACCK, AO2LRCK
>                             PORT226, 227, 230 (for AO2D[1-3])
>   aout3   : 2ch I2S output: AO3BCK, AO3DMIX, AO3DACCK, AO3LRCK
>   aoutiec1: S/PDIF output : PORT132(for AO1IEC)
>   aoutiec2: S/PDIF output : AO2IEC
>
> Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
> ---

Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>



-- 
Best Regards
Masahiro Yamada
