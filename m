Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754112AbeEWG1S (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 02:27:18 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:46455 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753989AbeEWG1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 02:27:16 -0400
X-Google-Smtp-Source: AB8JxZqaaVFYGING3xZDA1x1LYu5XKeSPX1yPKEHw09eNoCYXyX8D77rSfwOxDzMCqMCH72XYr0Ru4s6rrVpbdnkc6s=
MIME-Version: 1.0
In-Reply-To: <20180523082047.2aa9e6ac@bbrezillon>
References: <1527001673-16318-1-git-send-email-geert+renesas@glider.be> <20180523082047.2aa9e6ac@bbrezillon>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 23 May 2018 08:27:15 +0200
X-Google-Sender-Auth: Bqyb3zCXcea3t3nUb93aaPurBBk
Message-ID: <CAMuHMdX+nGoS=8RYG7QqCk7iAR_R_UMQ3B+i1XZegPemGJ2kUQ@mail.gmail.com>
Subject: Re: [PATCH] mtd: cmdlinepart: Update comment for introduction of OFFSET_CONTINUOUS
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On Wed, May 23, 2018 at 8:20 AM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> On Tue, 22 May 2018 17:07:53 +0200
> Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>
>> The comment about offset zero was not updated when changing behavior:
>>   - Automatic offset calculation is indicated by OFFSET_CONTINUOUS,
>>   - Zero really means offset zero.
>>
>> Fixes: b175d03dd2072836 ("[PATCH] mtd cmdlinepart: allow zero offset value")
>
> Did we switch to 16bytes for the short commit ids (I usually use 12
> bytes)?

Checkpatch says 12+ chars. I'm putting my bet on Linux growth ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
