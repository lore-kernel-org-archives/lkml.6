Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932806AbeEWMBG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 08:01:06 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:43691 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932702AbeEWMA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 08:00:59 -0400
X-Google-Smtp-Source: AB8JxZrh33WRarmbVtYE9IdmPT8xd1GKgV8/lzhE99H6GvkG/6vH5dPA/wPE2VNQcJLJ5PTGqgnn6+Tf3zYD6v/EB/k=
MIME-Version: 1.0
In-Reply-To: <20180523114230.10109-4-marek.vasut+renesas@gmail.com>
References: <20180523114230.10109-1-marek.vasut+renesas@gmail.com> <20180523114230.10109-4-marek.vasut+renesas@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 23 May 2018 14:00:58 +0200
X-Google-Sender-Auth: EIqrjb5bd32KnkLqqI29JTMgPKc
Message-ID: <CAMuHMdVFVFxKGuM39N4R6+TUgEX3sHKnud44uQSwjYK4LUiWKw@mail.gmail.com>
Subject: Re: [PATCH 4/6] mfd: da9063: Disallow RTC on DA9063L
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
> The DA9063L does not contain RTC block, unlike the full DA9063.
> Do not allow binding RTC driver on this variant of the chip.
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
