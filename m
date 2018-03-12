Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932267AbeCLTAD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 15:00:03 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:40286 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751232AbeCLTAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 15:00:02 -0400
X-Google-Smtp-Source: AG47ELu2LVyQqkHlBxoAzlxT4swYi+OtIQWuuUkeHlkMFHCDV7+P7nC+pwNs3SywtxAuRqnVKQpb9GDwWLcdHXso0YQ=
MIME-Version: 1.0
In-Reply-To: <1520867826-16455-1-git-send-email-geert@linux-m68k.org>
References: <1520867826-16455-1-git-send-email-geert@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 Mar 2018 20:00:00 +0100
X-Google-Sender-Auth: 8JoaXTze4QCNi103dFMNCf_9kxA
Message-ID: <CAMuHMdUH6wKY=z1W31gY4E677xchNE0KC8d7dVZQkXRoa8r-Og@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.16-rc5
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 4:17 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.16-rc5[1] to v4.16-rc4[3], the summaries are:
>   - build errors: +2/-1

Just the usual known sh4 randconfig issues.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
