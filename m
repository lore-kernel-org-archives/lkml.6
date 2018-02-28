Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752317AbeB1JY0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 04:24:26 -0500
Received: from mail-qk0-f181.google.com ([209.85.220.181]:33863 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752084AbeB1JYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 04:24:23 -0500
X-Google-Smtp-Source: AG47ELu+4FIfcoUdbjSBB2ZD7Tn8qQtZLPW8Vavlt1WEEPq10Joxm1BXu4ztATgUeEbKxKqe4HX6MRmvk2obFPBsELo=
MIME-Version: 1.0
In-Reply-To: <15777453e64262505da0c3b803729672c68e84ff.1519771871.git.fthain@telegraphics.com.au>
References: <cover.1519771871.git.fthain@telegraphics.com.au> <15777453e64262505da0c3b803729672c68e84ff.1519771871.git.fthain@telegraphics.com.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 28 Feb 2018 10:24:22 +0100
X-Google-Sender-Auth: GJVrua2OXr3oe1oYUPK9hOF-Taw
Message-ID: <CAMuHMdVEOvy-54aWt2f9X52509YJMp8PvRtJSM7T=MgJa=E=uA@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net/macmace: Drop redundant MACH_IS_MAC test
To: Finn Thain <fthain@telegraphics.com.au>
Cc: "David S. Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 5:22 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> The MACH_IS_MAC test is redundant here because the platform device
> won't get registered unless MACH_IS_MAC.
> Adopt module_platform_driver() convention.
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
