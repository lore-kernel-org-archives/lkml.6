Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757243AbeD0DMt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 23:12:49 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:38656 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753312AbeD0DMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 23:12:48 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w3R3CViB022773
X-Nifty-SrcIP: [209.85.217.173]
X-Google-Smtp-Source: AB8JxZrsW/9YclkQuIqU0nADhtyN6HjZD5AtuZyh5bptgFzKCqHeN+V3cGU42avZTukT7/1CvAC3G5eleT0sdXNLIDY=
MIME-Version: 1.0
In-Reply-To: <20180427014905.19520-1-suzuki.katsuhiro@socionext.com>
References: <20180427014905.19520-1-suzuki.katsuhiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 27 Apr 2018 12:11:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNARSB3q6aheYNjzC4BAP6C+SZE+arDbqbpaK8F31iR82aQ@mail.gmail.com>
Message-ID: <CAK7LNARSB3q6aheYNjzC4BAP6C+SZE+arDbqbpaK8F31iR82aQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] pinctrl: uniphier: add LD20 MPEG2-TS I/O pin-mux settings
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

2018-04-27 10:49 GMT+09:00 Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>:
> The MPEG2-TS input/output core both accepts serial TS and parallel TS.
>
> The serial TS interface uses following pins:
>   hscin0_s : HS0DOUT[0-3]
>   hscin1_s : HS0DOUT[4-7]
>   hscin2_s : HS1BCLKIN, HS1SYNCIN, HS1VALIN, HS1DIN0
>   hscin3_s : HS1DIN[2-5]
>   hscout0_s: HS0DOUT[0-3]
>   hscout1_s: HS0DOUT[4-7]
>
> And the parallel TS interface uses following pins:
>   hscin0_p : HS0BCLKIN, HS0SYNCIN, HS0VALIN, HS0DIN[0-7]
>   hscin1_p : HS1BCLKIN, HS1SYNCIN, HS1VALIN, HS1DIN[0-7]
>   hscout0_p: HS0BCLKOUT, HS0SYNCOUT, HS0VALOUT, HS0DOUT[0-7]
>
> Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
>
> ---
>
> Changes in v2:
>
>   - Fix indent
>   - Sort alphabetically
>   - Fix wrong grouping
>     - Fix hsc'out'0_ci -> hsc'in'0_ci of hscin0 group
>     - Fix hscin'0'_s -> hscin'1'_s of hscin1 group


This version looks good to me.

Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>




-- 
Best Regards
Masahiro Yamada
