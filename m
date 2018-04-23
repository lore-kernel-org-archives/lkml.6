Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754884AbeDWMVH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 08:21:07 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:46888 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754788AbeDWMVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 08:21:06 -0400
X-Google-Smtp-Source: AIpwx4/uRIsvpoE92aaj60vuOHHtR9QoTh1QHVWVyo24TL6v5SioXO5Znh2qQY2LpC7PcbMU/uP2R5+10I7422wXdWY=
MIME-Version: 1.0
In-Reply-To: <1524485714-1612-1-git-send-email-geert@linux-m68k.org>
References: <1524485714-1612-1-git-send-email-geert@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 23 Apr 2018 14:21:04 +0200
X-Google-Sender-Auth: dhklPvvwLKsbnlouFlTAcZqSn9E
Message-ID: <CAMuHMdXjphC5SR4BLdN-ojiap3QvtgY1+yp-i9vjhMahnfVv6Q@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.17-rc2
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 2:15 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.17-rc2[1] to v4.17-rc1[3], the summaries are:
>   - build errors: +1/-1

  + /kisskb/src/arch/sh/kernel/setup.c: error: implicit declaration of
function 'early_init_dt_scan' [-Werror=implicit-function-declaration]:
 => 261:2

Obligatory sh4/sh-randconfig build failure.

> [1] http://kisskb.ellerman.id.au/kisskb/head/6d08b06e67cd117f6992c46611dfb4ce267cd71e/ (244 out of 246 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/60cc43fc888428bb2f18f08997432d426a243338/ (244 out of 246 configs)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
