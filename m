Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756075AbeDXGy1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 02:54:27 -0400
Received: from mail-ua0-f176.google.com ([209.85.217.176]:35829 "EHLO
        mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755907AbeDXGyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 02:54:23 -0400
X-Google-Smtp-Source: AIpwx4+60sQNFO1IGQSYv5S2AqKo0Cevy6Wj1z76vB8Vccu6zbilSJxfO6yc605IlbmyyiwI6yZc5qF/VT2WeaaK+xk=
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.21.1804240850340.8@nippy.intranet>
References: <S1753929AbeDWBDQ/20180423010320Z+1320@vger.kernel.org>
 <CAK8P3a2Qt3AO_FF_J8px9KoCoNGkPrn-+k1aj-xrySb-0wYx0Q@mail.gmail.com> <alpine.LNX.2.21.1804240850340.8@nippy.intranet>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 24 Apr 2018 08:54:22 +0200
X-Google-Sender-Auth: lLY3TG3gnDse1E2szkRQRIb5W7U
Message-ID: <CAMuHMdU0O5BqXMs1p5ocLr+0re-UoQR0VHcMY-N_0CU25gNR4A@mail.gmail.com>
Subject: Re: [PATCH] m68k: Fix off-by-one calendar month
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Arnd Bergmann <arnd@arndb.de>, Sam Creasey <sammy@sammy.net>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On Tue, Apr 24, 2018 at 1:39 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> On Mon, 23 Apr 2018, Arnd Bergmann wrote:
>> This clashes with a patch I had planned to submit today, but otherwise
>> looks correct and. I'll respin my patch on top of yours. Since I've taken
>> a good look at your changes in the meantime
>>
>> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>
> Thanks, Arnd.
>
> Geert, let me know if I should re-send this with the "reviewed-by" from
> Arnd and "cc" to stable...

Thanks, there's no need for that.
I will add the Reviewed-by while applying, and stable will pick it up based on
the "fix" in the one-line summary.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
