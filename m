Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751826AbeBWJ0A (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 04:26:00 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:42000 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbeBWJZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 04:25:58 -0500
X-Google-Smtp-Source: AG47ELut3MPsxaXuh3ozy77+DPRtS5nr6emAdTt2NBun6SkLb87a9be8rd9pGtTexRv/20Vu9qwIrVzP4eFUkwGYeUs=
MIME-Version: 1.0
In-Reply-To: <1519326370-15805-6-git-send-email-jacopo+renesas@jmondi.org>
References: <1519326370-15805-1-git-send-email-jacopo+renesas@jmondi.org> <1519326370-15805-6-git-send-email-jacopo+renesas@jmondi.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 23 Feb 2018 10:25:57 +0100
X-Google-Sender-Auth: osYQyxJy9xBTT45yHKMy6Z3jQAw
Message-ID: <CAMuHMdUtb7kHbZ-z7JMKfAQZ-cyQaPPeOitwV=WSns+Y7hZkSg@mail.gmail.com>
Subject: Re: [PATCH 5/6] arm64: dts: renesas: r8a77965: Add #pwm-cells property
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 8:06 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> Add "#pwm-cells" property to "pwm@e6e31000" device node.
>
> This silences the following DTC compiler warning:
> Warning (pwms_property): Missing property '#pwm-cells' in node
> /soc/pwm@e6e31000 or bad phandle (referred from /backlight:pwms[0])
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
