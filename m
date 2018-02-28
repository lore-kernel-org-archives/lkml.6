Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752516AbeB1MRn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 07:17:43 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33378 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752469AbeB1MRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 07:17:41 -0500
X-Google-Smtp-Source: AG47ELv7wwXfp28rAlwT+dFgwEQ2YHBmTvHkvsT6pwowKpiWIsjGfkAR6u4CfngVplAWAwE7f+QOnJRkuevaQeQz678=
MIME-Version: 1.0
In-Reply-To: <20180228111113.13639-1-jeffy.chen@rock-chips.com>
References: <20180228111113.13639-1-jeffy.chen@rock-chips.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 28 Feb 2018 13:17:39 +0100
X-Google-Sender-Auth: ivcajJC_MA4sQgih1khVKCA-3sg
Message-ID: <CAMuHMdWLL9CxmxSLsqs1QX0dDHVhp4NrW4Me2EZaZE_bJ330bA@mail.gmail.com>
Subject: Re: [PATCH] soc: rockchip: power-domain: remove PM clocks
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>, Heiko Stuebner <heiko@sntech.de>,
        Caesar Wang <wxt@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeffy,

On Wed, Feb 28, 2018 at 12:11 PM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
> Currently we are adding all of the attached devices' clocks as pm clocks
> and enable them when powering on the power domain.
>
> This seems unnecessary, because those clocks are already controlled in
> the devices' drivers with better error handling.
>
> Tested on my chromebook minnie(rk3288) and chromebook kevin(rk3399).
>
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>

Thanks for your patch!

Just wondering: so you prefer to handle the clocks explicitly in all drivers,
instead of delegating this task to Runtime PM?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
