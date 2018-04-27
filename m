Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757443AbeD0DOT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 23:14:19 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:40338 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753312AbeD0DOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 23:14:18 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w3R3E6B8023379
X-Nifty-SrcIP: [209.85.217.180]
X-Google-Smtp-Source: AB8JxZoYAEW/KFYExcG6SyhoHy7bOTjHBKKLggthFTkqiyk/t1nJvaxbPARn5YdqtFNYY8QKylED3i25WyZsSWMqREA=
MIME-Version: 1.0
In-Reply-To: <20180427004121.4143-1-suzuki.katsuhiro@socionext.com>
References: <20180427004121.4143-1-suzuki.katsuhiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 27 Apr 2018 12:13:25 +0900
X-Gmail-Original-Message-ID: <CAK7LNATuxGb9Yp6sQBySR75fAcVV5fcZn7GBQ1dAXsW3Xd8hAA@mail.gmail.com>
Message-ID: <CAK7LNATuxGb9Yp6sQBySR75fAcVV5fcZn7GBQ1dAXsW3Xd8hAA@mail.gmail.com>
Subject: Re: [PATCH] reset: uniphier: add LD11/LD20 stream demux system reset control
To: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-27 9:41 GMT+09:00 Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>:
> Add reset lines for MPEG2 transport stream I/O and demux system (HSC)
> on UniPhier LD11/LD20 SoCs.
>
> Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
> ---

Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>




-- 
Best Regards
Masahiro Yamada
