Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754681AbeDZIlP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 04:41:15 -0400
Received: from mail-ua0-f178.google.com ([209.85.217.178]:41667 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753951AbeDZIlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 04:41:11 -0400
X-Google-Smtp-Source: AB8JxZrFjv7yFWH/P0qNkRIGgXzT4Yv/o7gb2NM6v3J1F4a3XBgKI5suHwbU9rsQS9NXLFx9z5x6uWVMXd/qlaZ4w+E=
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.21.1804261806450.8@nippy.intranet>
References: <S1753913AbeDWBDM/20180423010312Z+539@vger.kernel.org> <alpine.LNX.2.21.1804261806450.8@nippy.intranet>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 26 Apr 2018 10:41:10 +0200
X-Google-Sender-Auth: lgZra3-h9b21jUe7tO1qODmQAkw
Message-ID: <CAMuHMdXdFGnNogdeSd-UBdaX0-hzUHtcAGyQLpc3G_e9KTTNtw@mail.gmail.com>
Subject: Re: [PATCH] m68k: Fix off-by-one calendar month
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On Thu, Apr 26, 2018 at 10:23 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> I just noticed that my patch overlooked m68328_hwclk(). Like the other
> platforms, this one also needs tm_mon decremented.

I had noticed, but this is a fake date anyway.
So I don't know if it's worth fixing...

> Geert, can you amend the commit in your tree or should I submit this
> separately?

If it's worth fixing, please submit it separately.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
