Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1035049AbeE1PwT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:52:19 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:33148 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967041AbeE1KPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:15:54 -0400
X-Google-Smtp-Source: ADUXVKIMZHJWGjlUIp8H9QmyHLndAFghl88TjzHnQeb+mcYT96Ej2tpdwel3p25kIPXD7WFJdrjBb9oWAFZ7GlbJm9c=
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.21.1805281521420.10@nippy.intranet>
References: <1527378785-13326-1-git-send-email-linux@roeck-us.net>
 <alpine.LNX.2.21.1805271212480.9@nippy.intranet> <55c1c33b-4a34-bd72-57de-577ce8d95e0b@gmail.com>
 <alpine.LNX.2.21.1805271547090.9@nippy.intranet> <2ffd0de6-e8d6-6449-7c05-cbbfd8a99a97@gmail.com>
 <alpine.LNX.2.21.1805281521420.10@nippy.intranet>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 28 May 2018 12:15:52 +0200
X-Google-Sender-Auth: 94nZbkrxlzVD9lpDjsCuejQZV1g
Message-ID: <CAMuHMdWXnP96p9swox6FXg2-2doeNGK+G9eQyZ-td+xWGSKKoQ@mail.gmail.com>
Subject: Re: [RFC PATCH] m68k: set dma and coherent masks for Macintosh SONIC
 based ethernet
To: Finn Thain <fthain@telegraphics.com.au>,
        Christoph Hellwig <hch@lst.de>
Cc: Michael Schmitz <schmitzmic@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>, Joshua Thompson <funaho@jurai.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 7:26 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> On Mon, 28 May 2018, Michael Schmitz wrote:
>> Am 27.05.2018 um 17:49 schrieb Finn Thain:
>> > On Sun, 27 May 2018, Michael Schmitz wrote:
>> >
>> >> That should have fixed the warning already ...
>> >
>> > It's still not fixed (hence my "acked-by" for Geunter's patch).
>> >
>>
>> Odd - does link order still matter even though the
>> arch_setup_dev_archdata() function from the core platform code is
>> declared as a weak symbol?
>>
>> I'll see what I can find out on elgar ...
>>
>
> Any one of the numerous patches/rfcs/suggestions that I sent will avoid
> the WARN splat.
>
> When I said "it's still not fixed", what I meant to say was, "it's still
> not fixed in mainline and no proposed fix was accepted to the best of my
> knowledge".

Indeed.

Do we have a consensus on the way forward? The merge window for
v4.18 will open soon.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
