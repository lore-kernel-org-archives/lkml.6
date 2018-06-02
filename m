Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751772AbeFBJlr (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 05:41:47 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:46166 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750881AbeFBJlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 05:41:44 -0400
X-Google-Smtp-Source: ADUXVKJG0vuGH/Ml0/LZpSq1uuK4MuZAPszQ384yY/SLzcfUDE9St4uI7fHovrfn/wNKcxARzw28G/GnJy3zHXobO68=
MIME-Version: 1.0
In-Reply-To: <152791486506.225090.5983323218999937025@swboyd.mtv.corp.google.com>
References: <1526641120-1585-1-git-send-email-geert+renesas@glider.be>
 <152788083877.225090.16757573144833344500@swboyd.mtv.corp.google.com>
 <CAMuHMdUNXQDdv-CQs+KpaHJ8gGFjFrPRNXF3HPZNyTdQr+23Og@mail.gmail.com> <152791486506.225090.5983323218999937025@swboyd.mtv.corp.google.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 2 Jun 2018 11:41:43 +0200
X-Google-Sender-Auth: C_NeN8F7aWiXv8FUMXIeeipTl14
Message-ID: <CAMuHMdVEGpYCjycdoYkaMjnPQ9dL33yPAm0EUoTtEZxkaup7XA@mail.gmail.com>
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

On Sat, Jun 2, 2018 at 6:47 AM, Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Geert Uytterhoeven (2018-06-01 12:22:33)
>> On Fri, Jun 1, 2018 at 9:20 PM, Stephen Boyd <sboyd@kernel.org> wrote:
>> > Quoting Geert Uytterhoeven (2018-05-18 03:58:40)
>> >> __of_clk_get() calls of_parse_phandle_with_args(), which rejects
>> >> negative indices since commit bd69f73f2c81eed9 ("of: Create function for
>> >> counting number of phandles in a property").
>> >>
>> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> >> ---
>> >> Commit bd69f73f2c81eed9 is in v3.9.
>> >
>> > Did you send this to Russell's patch tracker? Otherwise I can pick it up
>>
>> Not yet. The patch tracker is for reviewed patches, AFAIK.
>>
>> > to clk-next.
>>
>> Thanks!
>>
>
> Ok. If you need my reviewed-by to add it to the tracker feel free to
> have:
>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>

Thanks, but it's much easier if you would take it, and I can avoid looking
up again how to submit it properly to the patch tracker.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
