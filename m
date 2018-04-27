Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757497AbeD0Gze (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 02:55:34 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:39140 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757283AbeD0Gzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 02:55:31 -0400
X-Google-Smtp-Source: AB8JxZqHD2WOEUuKaqr8L4wCSuwtRxzjHtcn4aQMm2w8GpXOutQzv5cYILPC6V/gnRsG/D49Ivd/n3qSTo3r6JgSGi8=
MIME-Version: 1.0
In-Reply-To: <d59432ee-15a3-495b-29db-2d2eb51be97d@linux-m68k.org>
References: <d59432ee-15a3-495b-29db-2d2eb51be97d@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 27 Apr 2018 08:55:29 +0200
X-Google-Sender-Auth: TLEWa4sBgDnLril-Q3qLnlt9mSk
Message-ID: <CAMuHMdX5b5CULTjR+Uh3P2ga=yk==b=6KAwXY+AqzE0eOA7FoA@mail.gmail.com>
Subject: Re: [PATCH] m68k: Fix calendar month regression on M68328
To: Greg Ungerer <gerg@linux-m68k.org>,
        Finn Thain <fthain@telegraphics.com.au>
Cc: linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, Finn,

On Fri, Apr 27, 2018 at 3:33 AM, Greg Ungerer <gerg@linux-m68k.org> wrote:
> On 27/04/18 11:12, Finn Thain wrote:
>> My earlier fix for read_persistent_clock() neglected to cover
>> m68328_hwclk(). Correct this oversight.
>>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
>> ---
>> Greg, the read_persistent_clock() change has already been queued
>> by Geert. Should this patch be pushed together with that one
>> (presuming your ack)? Sorry for the inconvenience.
>
> If Geert is happy to add it to his tree that would seem to make sense.
> Otherwise I can take it via the m68knommu tree. Either way:
>
>   Acked-by: Greg Ungerer <gerg@linux-m68k.org>

I'm reconsidering.

I'll apply it to my tree, and fold it into the original fix for v4.18.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
