Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752770AbeDPQ1h (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 12:27:37 -0400
Received: from mail-ua0-f172.google.com ([209.85.217.172]:41068 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751953AbeDPQ1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 12:27:35 -0400
X-Google-Smtp-Source: AIpwx4/y2wRCFiwENsGqCqGaxcML4jrCRe1SG2Pjqjwg7Z3mjTmicNsBUldmx3G1Qcy3dnPaYjY85FWu4ZOIRFvU9Xw=
MIME-Version: 1.0
In-Reply-To: <1523890952-20866-1-git-send-email-yamada.masahiro@socionext.com>
References: <1523890952-20866-1-git-send-email-yamada.masahiro@socionext.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 16 Apr 2018 18:27:33 +0200
X-Google-Sender-Auth: 3qCVSM1AwLs9sxCznDUrU5zl3Sg
Message-ID: <CAMuHMdWYOPPzo6HJF5H+L8x6vWwcQMCYS-eV-Xz0AS2FtQ8c1Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: renesas: replace toshiba, mmc-wrprotect-disable
 with disable-wp
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yamada-san,

On Mon, Apr 16, 2018 at 5:02 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Follow up commit 788778b0d21a ("mmc: tmio: deprecate "toshiba,
> mmc-wrprotect-disable" DT property").

Thanks for following up this work.

(I had the exact same changes queued up in my local branch, to be sent out
 after v4.17-rc1, but you beat me to it ;-)

> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
