Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752597AbeEGOFd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 10:05:33 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:45647 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751943AbeEGOF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 10:05:28 -0400
X-Google-Smtp-Source: AB8JxZpBHKjeYGjv/4j28Abh0fw7oMWwzQmMtu8GfdUe7BCu3kNao3Xllg2S6fZe1yV8PNiVaxT0jPstAcnLCABpirc=
MIME-Version: 1.0
In-Reply-To: <3f06d7b8-7124-1b98-2f52-51951c6d7624@physik.fu-berlin.de>
References: <1467564402-2649-1-git-send-email-ysato@users.sourceforge.jp>
 <c1ec211d-cbe2-1139-edb0-8baa0e7364e8@physik.fu-berlin.de>
 <8c75b447-fc14-871e-1a04-733132527b65@landley.net> <E7B2D113-C30D-4A32-AFB6-DC91DDADE0E8@physik.fu-berlin.de>
 <20171117191706.GF1627@brightrain.aerifal.cx> <7193aa1b-50e3-11d4-f93d-f567e2e06b8c@physik.fu-berlin.de>
 <20180105212857.GR1627@brightrain.aerifal.cx> <20180503013708.GC1392@brightrain.aerifal.cx>
 <20180503023320.GD1392@brightrain.aerifal.cx> <048ab147-21b8-045d-d21c-e1be2dd0e954@physik.fu-berlin.de>
 <87k1sgtf8t.wl-ysato@users.sourceforge.jp> <5f690985-e905-deb9-aa4f-51561463ae22@physik.fu-berlin.de>
 <9051f0a5-bc75-b49e-c8c3-aa877be1979e@landley.net> <3f06d7b8-7124-1b98-2f52-51951c6d7624@physik.fu-berlin.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 7 May 2018 16:05:27 +0200
X-Google-Sender-Auth: JBOsVgluTKeLT2oouXnZD-CwFR0
Message-ID: <CAMuHMdVGBhMY1zapuP65KOFkQ1GEt_rV=wUneH+RG6LqpqndRw@mail.gmail.com>
Subject: Re: [J-core] [PATCH v5 00/22] sh: LANDISK and R2Dplus convert to
 device tree
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Rob Landley <rob@landley.net>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Mon, May 7, 2018 at 3:50 PM, John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On 05/07/2018 03:40 PM, Rob Landley wrote:
>> On a related note, is there a list of boards anywhere? I'm working on a
>> 7760
>> system at $DAYJOB, Rich has a landisk which according to
>> https://www.openbsd.org/landisk.html is an SH7751R, and Sato-san says that
>> QEMU's -r2d emulates that too? ("RTS7751R2Dplus is QEMU-SH4 target. So
>> easy
>> trying.")
>
> I have lots of Dreamcasts (SH7091), one SH7785LCR evaulation board and one
> SH7724 Evovec board. I also own one KMC KZ-SH3-03 (SH7708, SH-3) board and
> several small SH-2 and SH-2A boards (from a Japanese electronics magazine).
>
> I think Geert Uytterhoven has also one SH-4 board (if I remember correctly)
> and one of the gcc upstream maintainers has an AP-SH4AD-0A board from Alpha
> Project.

Sorry to disappoint you, but my SH-4A CPU cores are buried in Renesas ARM SoCs.
Using those means resurrecting "SH Core Linux" and forward-porting it to
still-supported SoCs first.

>> What other boards do we need to covert to device tree? arch/sh/boards has
>> 15 C
>> files and 19 subdirectories, but I dunno the status of any of them...
>
> Hard to say. At least the ones above plus the ST-40 boards should be
> included.

I also have access to a remote Migo-R (SH7722).

[*] https://marc.info/?l=linux-sh&m=130034400711357 first.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
