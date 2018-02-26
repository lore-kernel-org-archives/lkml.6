Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752639AbeBZIeg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 03:34:36 -0500
Received: from mail-qk0-f174.google.com ([209.85.220.174]:41009 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752549AbeBZIeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 03:34:31 -0500
X-Google-Smtp-Source: AG47ELuN/VfZo0pE7Q+riNP04cRsue8qKrDbwmh2hWx6SO4PWEr5cC2pvmiHljfZOrjC7FYexFgUHtQEBVopDl8QzNg=
MIME-Version: 1.0
In-Reply-To: <20180225235432.31209-2-rabel@robertabel.eu>
References: <9ec3c54c-f8fe-22d7-783e-8cf9862405bb@robertabel.eu>
 <20180225235432.31209-1-rabel@robertabel.eu> <20180225235432.31209-2-rabel@robertabel.eu>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Feb 2018 09:34:30 +0100
X-Google-Sender-Auth: YesreEcqeyqlbfK_Tuv8uthoNEg
Message-ID: <CAMuHMdX_+N4WzXp+g+B9f5H9k1LCe2vyGUO-RRkOAiARerTWtw@mail.gmail.com>
Subject: Re: [PATCH 1/4] auxdisplay: charlcd: fix two-line command ^[[LN not
 marked as processed
To: Robert Abel <rabel@robertabel.eu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <w@1wt.eu>, Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 12:54 AM, Robert Abel <rabel@robertabel.eu> wrote:
> Signed-off-by: Robert Abel <rabel@robertabel.eu>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
