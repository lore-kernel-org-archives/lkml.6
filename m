Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751728AbeBYJwD (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 04:52:03 -0500
Received: from mail-qt0-f175.google.com ([209.85.216.175]:45505 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751683AbeBYJv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 04:51:59 -0500
X-Google-Smtp-Source: AG47ELsE2zkxoNP9dKQtmM3GHxRZnpg0VporIrb7XZUuPn8Rk8uvKyYwUFsQR0ilofUc4uzwl2YzZQufN7VV6CNh0CM=
MIME-Version: 1.0
In-Reply-To: <855f562229a4738706e30bcf232c58f14912f37e.1519514463.git.fthain@telegraphics.com.au>
References: <cover.1519514463.git.fthain@telegraphics.com.au> <855f562229a4738706e30bcf232c58f14912f37e.1519514463.git.fthain@telegraphics.com.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 25 Feb 2018 10:51:58 +0100
X-Google-Sender-Auth: ThZLDsDsRR9Jvpm-29vYpJsKUks
Message-ID: <CAMuHMdWDy=mjcHQGJYuxhTCrTKk0DkWhvJbW6K15Tbf6P6evcQ@mail.gmail.com>
Subject: Re: [PATCH net 2/4] net/macsonic: Drop redundant MACH_IS_MAC test
To: Finn Thain <fthain@telegraphics.com.au>
Cc: "David S. Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 25, 2018 at 12:27 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> The MACH_IS_MAC test is redundant here because the platform device
> won't get registered unless MACH_IS_MAC.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
