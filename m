Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932670AbeEWMA0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 08:00:26 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:45987 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932534AbeEWMAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 08:00:23 -0400
X-Google-Smtp-Source: AB8JxZpvlBZTrrtDRmvhMwLZ/JRFLwfPL5LBzc9l7QEgsE9RwdMCqsxjKw6/WXQtO/wLCP54v2vGTKdJJuixofZQyEQ=
MIME-Version: 1.0
In-Reply-To: <20180523114230.10109-3-marek.vasut+renesas@gmail.com>
References: <20180523114230.10109-1-marek.vasut+renesas@gmail.com> <20180523114230.10109-3-marek.vasut+renesas@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 23 May 2018 14:00:21 +0200
X-Google-Sender-Auth: uf2n1olL2-WW9ODinaI1ty1Qows
Message-ID: <CAMuHMdVXkP8kueeepdD86PLiqpE3DEWDGXZ7QQqDRr8fyszyRQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] mfd: da9063: Add DA9063L type
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
> Add type for DA9063L, which is a reduced variant of the DA9063
> without RTC block and with less regulators.
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
