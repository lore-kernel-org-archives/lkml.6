Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754543AbeEWMGG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 08:06:06 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:33866 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754438AbeEWMGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 08:06:02 -0400
X-Google-Smtp-Source: AB8JxZr1+jze3oAPbptrn8b971fS0OO48tuMGzaWnpR3kk8kHrApcDqLphPJz+EuNqgTv3EQcQPY/StAH/QnZnDWsHQ=
MIME-Version: 1.0
In-Reply-To: <20180523114230.10109-6-marek.vasut+renesas@gmail.com>
References: <20180523114230.10109-1-marek.vasut+renesas@gmail.com> <20180523114230.10109-6-marek.vasut+renesas@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 23 May 2018 14:06:01 +0200
X-Google-Sender-Auth: YkGB45PmcINMzYx2DM1RdJRp-hQ
Message-ID: <CAMuHMdWqRFeP0VQaABLxOfh5r7KUmvfr-gOFhcxTKk28GpyPpQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] mfd: da9063: Add DA9063L support
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 1:42 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Add support for DA9063L, which is a reduced variant of the DA9063
> with less regulators and without RTC.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
