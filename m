Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753608AbeFDHSB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:18:01 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:39797 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752770AbeFDHR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:17:58 -0400
X-Google-Smtp-Source: ADUXVKJyCQWm53Myx6xFcNM3hhA7YKIEpU/H1+pnR89WgK+oLxPz1JgsJFXgKkxqYXkuFxOROtMBxPk7fsoWIwzRivs=
MIME-Version: 1.0
In-Reply-To: <20180602101155.26375-2-marek.vasut+renesas@gmail.com>
References: <20180602101155.26375-1-marek.vasut+renesas@gmail.com> <20180602101155.26375-2-marek.vasut+renesas@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 4 Jun 2018 09:17:56 +0200
X-Google-Sender-Auth: iUyzAek4Kuu3fMoJdLZ1okcPFK4
Message-ID: <CAMuHMdVdN4OGLztHtZE9BuiAm_QAvji96VSBX6g3DLbNhb6z_g@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] mfd: da9063: Use REGMAP_IRQ_REG
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

On Sat, Jun 2, 2018 at 12:11 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Convert the regmap_irq table to use REGMAP_IRQ_REG().
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
