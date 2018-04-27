Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757434AbeD0DNh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 23:13:37 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:18540 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757352AbeD0DNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 23:13:34 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w3R3DOoU014190
X-Nifty-SrcIP: [209.85.213.41]
X-Google-Smtp-Source: AB8JxZrkfZV7W3HqjLG4VGkssedOZJAIX3dPRby/8rbIFhe6SYHDETXrqFbEb/9fq7qudVxERsvPEYZz+H6LfixZFjU=
MIME-Version: 1.0
In-Reply-To: <20180427004013.4006-1-suzuki.katsuhiro@socionext.com>
References: <20180427004013.4006-1-suzuki.katsuhiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 27 Apr 2018 12:12:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNATb5-7Z-6+TzDmRU3wxpAGDjNA=c1QQ31aGSXRA3Niptg@mail.gmail.com>
Message-ID: <CAK7LNATb5-7Z-6+TzDmRU3wxpAGDjNA=c1QQ31aGSXRA3Niptg@mail.gmail.com>
Subject: Re: [PATCH] clk: uniphier: add LD11/LD20 stream demux system clock
To: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-27 9:40 GMT+09:00 Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>:
> Add clock for MPEG2 transport stream I/O and demux system (HSC) on
> UniPhier LD11/LD20 SoCs.
>
> Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
> ---



Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>




-- 
Best Regards
Masahiro Yamada
