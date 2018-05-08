Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754612AbeEHHRd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 03:17:33 -0400
Received: from mail-ua0-f174.google.com ([209.85.217.174]:33107 "EHLO
        mail-ua0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754183AbeEHHRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 03:17:31 -0400
X-Google-Smtp-Source: AB8JxZr7Vx9lUsfRjxZV5M3ORvBQBP+lwNh9dDBHqpyNAnheDb+Ushnpf0HMSKKqYQq8h5/qNiNVyE80P+BIVfBpPc4=
MIME-Version: 1.0
In-Reply-To: <1525762955-26767-1-git-send-email-geert@linux-m68k.org>
References: <1525762955-26767-1-git-send-email-geert@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 8 May 2018 09:17:30 +0200
X-Google-Sender-Auth: rsI9JlrklDgO-UfFhYlUWlcWkhM
Message-ID: <CAMuHMdX6BD3a2CR23zEpnUYszo=mEbH-ucNwPTHhrtayJAud2w@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.17-rc4
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Israel Rukshin <israelr@mellanox.com>, netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 8, 2018 at 9:02 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.17-rc4[1] to v4.17-rc3[3], the summaries are:
>   - build errors: +1/-4

  + /kisskb/src/include/linux/mlx5/driver.h: error: 'struct irq_desc'
has no member named 'affinity_hint':  => 1299:13

xtensa-allmodconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/75bc37fefc4471e718ba8e651aa74673d4e0a9eb/ (244 out of 246 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/6da6c0db5316275015e8cc2959f12a17584aeb64/ (244 out of 246 configs)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
