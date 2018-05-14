Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752386AbeENIfo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:35:44 -0400
Received: from mail-ua0-f171.google.com ([209.85.217.171]:39274 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752105AbeENIfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:35:42 -0400
X-Google-Smtp-Source: AB8JxZqvboZjiC+rhG1Y9JlfEPQmZ4QdB5LDqCyxnX/5q8I0KszlrgIADGlN9oQETfpOse19GrmZxOoeNAzHEyjh9HA=
MIME-Version: 1.0
In-Reply-To: <1526286669-484-1-git-send-email-geert@linux-m68k.org>
References: <1526286669-484-1-git-send-email-geert@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 14 May 2018 10:35:40 +0200
X-Google-Sender-Auth: zpbSCyaMtcMb7vClbxVRsQZo7-U
Message-ID: <CAMuHMdUoDmXZy+fF_-op6Pk8gdaOFDvzvpDOkXcZ3uvTpqVKOg@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.17-rc5
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 10:31 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.17-rc5[1] to v4.17-rc4[3], the summaries are:
>   - build errors: +4/-1

  + /kisskb/src/arch/sh/boards/mach-landisk/setup.c: error: implicit
declaration of function 'ioremap_prot'
[-Werror=implicit-function-declaration]:  => 64:2

sh-randconfig

Probably not a regression, but I haven't seen this one before.

  + error: "__udivdi3" [drivers/mtd/nand/raw/nand.ko] undefined!:  => N/A

m68k-allmodconfig

Patch available.

> [1] http://kisskb.ellerman.id.au/kisskb/head/67b8d5c7081221efa252e111cd52532ec6d4266f/ (244 out of 246 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/75bc37fefc4471e718ba8e651aa74673d4e0a9eb/ (244 out of 246 configs)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
