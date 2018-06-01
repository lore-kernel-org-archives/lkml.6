Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753554AbeFATWi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 15:22:38 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:42489 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752783AbeFATWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 15:22:35 -0400
X-Google-Smtp-Source: ADUXVKLqLiRabskyRud//X/lO/IwcZ/r8Pjo2zd9KLVP4GDnvDntFmDi9kN3S0oxMKBAh+Q+xWtcPcU4Hdj6UmLYCm4=
MIME-Version: 1.0
In-Reply-To: <152788083877.225090.16757573144833344500@swboyd.mtv.corp.google.com>
References: <1526641120-1585-1-git-send-email-geert+renesas@glider.be> <152788083877.225090.16757573144833344500@swboyd.mtv.corp.google.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 1 Jun 2018 21:22:33 +0200
X-Google-Sender-Auth: chXuxcg1h0yNoP3NC5iNSrcGy6c
Message-ID: <CAMuHMdUNXQDdv-CQs+KpaHJ8gGFjFrPRNXF3HPZNyTdQr+23Og@mail.gmail.com>
Subject: Re: [PATCH] clkdev: Remove duplicated negative index check from __of_clk_get()
To: Stephen Boyd <sboyd@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Fri, Jun 1, 2018 at 9:20 PM, Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Geert Uytterhoeven (2018-05-18 03:58:40)
>> __of_clk_get() calls of_parse_phandle_with_args(), which rejects
>> negative indices since commit bd69f73f2c81eed9 ("of: Create function for
>> counting number of phandles in a property").
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> Commit bd69f73f2c81eed9 is in v3.9.
>
> Did you send this to Russell's patch tracker? Otherwise I can pick it up

Not yet. The patch tracker is for reviewed patches, AFAIK.

> to clk-next.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
