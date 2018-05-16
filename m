Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752331AbeEPHQg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 03:16:36 -0400
Received: from mail-vk0-f52.google.com ([209.85.213.52]:40281 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751844AbeEPHQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 03:16:35 -0400
X-Google-Smtp-Source: AB8JxZoPeqQGTp30GrK9c8Pn/HqqYIFPdqOb8sONTqzgjjdaRDzpcU4S15e7YhFvpGNhMMl47/HmJCrxHnuQoPkmXAE=
MIME-Version: 1.0
In-Reply-To: <20180516072753.49dd4d88@canb.auug.org.au>
References: <20180516072753.49dd4d88@canb.auug.org.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 16 May 2018 09:16:33 +0200
X-Google-Sender-Auth: NvPpvpaly90mzEvgZK-Uo7y6rGU
Message-ID: <CAMuHMdVEOmrd9da8XR0_wKJw9+KygkCUTSWvQjtP2Xh9aOkSFQ@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the pinctrl tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 11:27 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Commit
>
>   f18fab4bcb4f ("pinctrl: sh-pfc: Add r8a77470 PFC support")
>
> is missing a Signed-off-by from its comitter.

Sorry, I forgot to add it.

Linus, as the merge of sh-pfc is your top commit, shall I fix it up
and send a new
pull request?
Please let me know how to proceed. Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
