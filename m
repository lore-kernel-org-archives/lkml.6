Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753201AbeDLISS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 04:18:18 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:42154 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752751AbeDLISP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 04:18:15 -0400
X-Google-Smtp-Source: AIpwx48BBpkp02i/8vhuXtf28dJ41ncXKiqV9uavRV9bhvFCap/5j4mZEp+Ry3LsYNjOlEeedgntn86DuWa7kEb+ImY=
MIME-Version: 1.0
In-Reply-To: <5aceb51e.1c69fb81.c6613.d3e4SMTPIN_ADDED_MISSING@mx.google.com>
References: <5aceb51e.1c69fb81.c6613.d3e4SMTPIN_ADDED_MISSING@mx.google.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Apr 2018 10:18:14 +0200
X-Google-Sender-Auth: LkLbS--cKHeGOtIMwvcGvSQmqNY
Message-ID: <CAMuHMdVELjqx_B7MUsPFHLTVFjLuEy5Z6sB-bafbZTk+V6+vcQ@mail.gmail.com>
Subject: Re: [PATCH] block/amiflop: Don't log an error message for an invalid ioctl
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Jens Axboe <axboe@kernel.dk>, linux-m68k <linux-m68k@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 3:23 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> Do as the swim3 driver does and just return -ENOTTY.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: linux-m68k@lists.linux-m68k.org
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Reviewed-by:  Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
