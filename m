Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751401AbeEBHQx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 03:16:53 -0400
Received: from mail-vk0-f54.google.com ([209.85.213.54]:35190 "EHLO
        mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751127AbeEBHQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 03:16:51 -0400
X-Google-Smtp-Source: AB8JxZrJxVv/Jg4YG/NkgV5ccU7giIueEZhns1VDrbbOVJ0Nc8M6WIDR4H91SHQ+9IN9/GLAMC+OLeUMkpSMDPVZSok=
MIME-Version: 1.0
In-Reply-To: <1525198442-13755-1-git-send-email-geert@linux-m68k.org>
References: <1525198442-13755-1-git-send-email-geert@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 2 May 2018 09:16:50 +0200
X-Google-Sender-Auth: MP8tL-Vzlr_NLm8PdS2Scwc3Wyk
Message-ID: <CAMuHMdU-X+GyC80c6N2E_-D5uuV9FQvHtfr9=96kH7U6V5gJOg@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.17-rc3
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 1, 2018 at 8:14 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.17-rc3[1] to v4.17-rc2[3], the summaries are:
>   - build errors: +3/-0

  + error: core.c: undefined reference to `of_find_regulator_by_node':
 => .text+0xa4d)

i386-randconfig

More context:
    drivers/regulator/core.o: In function `regulator_dev_lookup':

> [1] http://kisskb.ellerman.id.au/kisskb/head/6da6c0db5316275015e8cc2959f12a17584aeb64/ (244 out of 246 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/6d08b06e67cd117f6992c46611dfb4ce267cd71e/ (244 out of 246 configs)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
