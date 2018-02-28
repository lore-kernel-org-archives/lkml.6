Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752401AbeB1L3o (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 06:29:44 -0500
Received: from mail-qt0-f180.google.com ([209.85.216.180]:33502 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751994AbeB1L3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 06:29:43 -0500
X-Google-Smtp-Source: AG47ELslfC0TqIO6GXnYtr73b7aSXj5i+M9uwB2F6sAZ7vEHKUCr3KYzfQZ0uOBRWl+roensxW5B24efkhX3UOA70lY=
MIME-Version: 1.0
In-Reply-To: <1519817278-30770-1-git-send-email-geert@linux-m68k.org>
References: <1519817278-30770-1-git-send-email-geert@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 28 Feb 2018 12:29:41 +0100
X-Google-Sender-Auth: IgnC2Nv31s0V1xxsrTQl8aoDiyo
Message-ID: <CAMuHMdVEFXL6hXhBNya-9LjORrZnyJJPzoBNMrufAdPEBVhLtA@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.16-rc3
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 12:27 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.16-rc3[1] to v4.16-rc2[3], the summaries are:
>   - build errors: +1/-16

  + /home/kisskb/slave/src/arch/powerpc/kvm/powerpc.c: error: label
'out' defined but not used [-Werror=unused-label]:  => 1611:1

ppc64_defconfig+NO_ALTIVEC

> [1] http://kisskb.ellerman.id.au/kisskb/head/4a3928c6f8a53fa1aed28ccba227742486e8ddcb/ (268 out of 274 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/91ab883eb21325ad80f3473633f794c78ac87f51/ (all 274 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
