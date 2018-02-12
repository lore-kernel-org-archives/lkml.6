Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932695AbeBLIQs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 03:16:48 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:38511 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751082AbeBLIQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 03:16:44 -0500
X-Google-Smtp-Source: AH8x226/x6ChMzSoR5xAsvb/uE0tNShE3DM10LDpY1rl4wozxgPHZUh+PXVSxnTp1n5IKJCFLvqVkCqBzJil16ZTSwk=
MIME-Version: 1.0
In-Reply-To: <46988f8227bd3ad617b5c7dd0ce8f159b75ffdb2.1518397634.git.fthain@telegraphics.com.au>
References: <cover.1518397634.git.fthain@telegraphics.com.au> <46988f8227bd3ad617b5c7dd0ce8f159b75ffdb2.1518397634.git.fthain@telegraphics.com.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 Feb 2018 09:16:43 +0100
X-Google-Sender-Auth: zqrPD5vxp47_NJ_KYlh2EUklonk
Message-ID: <CAMuHMdVVu4CZ3sj0fJ4NS0Qn5wJmpVM1Z32_B2bgs5FyQXK8mw@mail.gmail.com>
Subject: Re: [PATCH net v4 01/13] net/8390: Remove redundant make dependencies
To: Finn Thain <fthain@telegraphics.com.au>
Cc: "David S. Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 4:08 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> The hydra, zorro8390 and mcf8390 drivers all #include "lib8390.c" and
> have no need for 8390.o. modinfo confirms no dependency on 8390.ko.
> Drop the redundant dependency from the Makefile. objdump confirms
> that this has no effect on the module binaries.
>
> Cc: Greg Ungerer <gerg@linux-m68k.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

The superfluous additions of 8390.o were introduced in commit
644570b830266ff3 ("8390: Move the 8390 related drivers").

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
