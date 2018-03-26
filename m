Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751160AbeCZMMS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 08:12:18 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:38435 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750984AbeCZMMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 08:12:17 -0400
X-Google-Smtp-Source: AG47ELt0I2vHJqi3fCgq5A3bEMm/FOz9oDuYWnauJ6ScfBfmWe+lXxC15zUfTkCtubQmExEkpD8DnYv+z62dUAVXslM=
MIME-Version: 1.0
In-Reply-To: <cover.1520825708.git.fthain@telegraphics.com.au>
References: <cover.1520825708.git.fthain@telegraphics.com.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Mar 2018 14:12:15 +0200
X-Google-Sender-Auth: Us2fOfmseulbkx83ztGKRqHVW5A
Message-ID: <CAMuHMdXiRiHif3G9AJFFzXc3xt5-bHXy1=Ngk3EySkWO0Z8-YQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] m68k/mac: Miscellaneous clean-ups and fixes
To: Finn Thain <fthain@telegraphics.com.au>
Cc: linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On Mon, Mar 12, 2018 at 4:38 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> Finn Thain (3):
>   m68k/mac: Clean up whitespace and remove redundant parentheses
>   m68k/mac: Enable RTC for 100-series PowerBooks
>   m68k/mac: Remove bogus "FIXME" comment

Thanks, applied and queued for v4.17 (with whitespace of 1/3 fixed).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
