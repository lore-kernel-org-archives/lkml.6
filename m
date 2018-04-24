Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754401AbeDXJMK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 05:12:10 -0400
Received: from mail-vk0-f41.google.com ([209.85.213.41]:33300 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754276AbeDXJMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 05:12:06 -0400
X-Google-Smtp-Source: AIpwx48ZZxDOZp5pFrziOptLjHCz1sbe5g1TEaERAGbIMGvMwtclGTpHYLPmOu5Aml+MIVErqbwZkWE6la/iYyycW08=
MIME-Version: 1.0
In-Reply-To: <20180424084124.6tpxf3ekadzefwd4@verge.net.au>
References: <20180410123241.25745-1-wsa+renesas@sang-engineering.com>
 <20180411073215.fzvh4ejj2kd7wam3@verge.net.au> <20180416091257.swbt7i6zjfbwysg2@dell>
 <20180424084124.6tpxf3ekadzefwd4@verge.net.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 24 Apr 2018 11:12:04 +0200
X-Google-Sender-Auth: hJUARs3pOT0PgWS9uB4eSrGVtBM
Message-ID: <CAMuHMdWLya+=QeCwzszMxGPm7b3KbdsNFgc0vsk8NWC5tDO2QQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] backlight: pwm_bl: don't use GPIOF_* with gpiod_get_direction
To: Simon Horman <horms@verge.net.au>
Cc: Lee Jones <lee.jones@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 10:41 AM, Simon Horman <horms@verge.net.au> wrote:
> On Mon, Apr 16, 2018 at 10:12:57AM +0100, Lee Jones wrote:
>> On Wed, 11 Apr 2018, Simon Horman wrote:
>> > On Tue, Apr 10, 2018 at 02:32:40PM +0200, Wolfram Sang wrote:
>> > > The documentation was wrong, gpiod_get_direction() returns 0/1 instead
>> > > of the GPIOF_* flags. The docs were fixed with commit 94fc73094abe47
>> > > ("gpio: correct docs about return value of gpiod_get_direction"). Now,
>> > > fix this user (until a better, system-wide solution is in place).
>> > >
>> > > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> > > Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
>> >
>> > Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
>>
>> Thanks for the Reviewed-by Simon.  I have applied it to the original mail.
>>
>> Do you know why you mail wasn't sent attached to the original thread?
>> For some reason I received this mail on it's own i.e. not in reply
>> to the original.
>
> No, not off hand. Perhaps I responded to the email in some unusual way
> but by now I don't recall. In any case I'll try to be more careful
> in future.

I see Lee is using gmail for sending, so I assume also for receiving.

While I did receive Simon's reply in-thread, lately I had issues with gmail
not always doing so, and sometimes failing to do deduplication when receiving
email through multiple paths (mailing lists and/or directly).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
