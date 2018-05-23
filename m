Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932709AbeEWLxt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 07:53:49 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:44548 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932501AbeEWLxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 07:53:45 -0400
X-Google-Smtp-Source: AB8JxZpbsB4AS4aEO1Gab82Jru29duYZ3qypi6ZlbqjcquiwqkMlrjI6CQMIdYE4JistIA6BBbMeYwurlShaRpmaBFg=
MIME-Version: 1.0
In-Reply-To: <20180523114230.10109-1-marek.vasut+renesas@gmail.com>
References: <20180523114230.10109-1-marek.vasut+renesas@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 23 May 2018 13:53:43 +0200
X-Google-Sender-Auth: M5D0A_XN6buBhjyjjM0VlXczbBQ
Message-ID: <CAMuHMdV5q2JrHSMN2hjt0384AMg64W8w+g6LL6Z3HhzLNZGMFw@mail.gmail.com>
Subject: Re: [PATCH 1/6] mfd: da9063: Rename PMIC_DA9063 to PMIC_CHIP_ID_DA9063
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
> The PMIC_DA9063 is a complete misnomer, it denotes the value of the
> DA9063 chip ID register, so rename it as such. It is also the value
> of chip ID register of DA9063L though, so drop the enum as all the
> DA9063 "models" share the same chip ID and thus the distinction will
> have to be made using DT or otherwise.
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
