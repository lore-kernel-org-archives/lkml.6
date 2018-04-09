Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752125AbeDIMv0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 08:51:26 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42118 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751667AbeDIMvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 08:51:24 -0400
X-Google-Smtp-Source: AIpwx49OOwzTDBCwk5Sd4vtoauOu4OzUvmpSvIT06ciN4GsFpq9+dBEX3bAMY4IV88bPpvRewq/a55FymHKf4G4Wnm8=
MIME-Version: 1.0
In-Reply-To: <b5565777219806dc2744af99d3308a31bd948223.1522546571.git.fthain@telegraphics.com.au>
References: <cover.1522546571.git.fthain@telegraphics.com.au> <b5565777219806dc2744af99d3308a31bd948223.1522546571.git.fthain@telegraphics.com.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 9 Apr 2018 14:51:23 +0200
X-Google-Sender-Auth: xaa4Pl5UeGhu-GSGzz3nLHWdsPg
Message-ID: <CAMuHMdVpF_1EFa3AmsBiJ+Gm0sCheYkBf_xUAx_enitUsMCpzg@mail.gmail.com>
Subject: Re: [PATCH 02/12] m68k/mac: Fix SWIM memory resource end address
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Laurent Vivier <lvivier@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 1, 2018 at 3:41 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> The resource size is 0x2000 == end - start + 1.
> Therefore end == start + 0x2000 - 1.
>
> Cc: Laurent Vivier <lvivier@redhat.com>
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
