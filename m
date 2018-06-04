Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753974AbeFDHQN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:16:13 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:35498 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751942AbeFDHQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:16:10 -0400
X-Google-Smtp-Source: ADUXVKII5WJLkKJ4o03aywhbDvTv3z/6hYz0/pSVGo+PDgumXdhi5e9XHhEtr2e1PdFb0C4Z2d2axgFI9eLoClNC2hw=
MIME-Version: 1.0
In-Reply-To: <20180602101155.26375-1-marek.vasut+renesas@gmail.com>
References: <20180602101155.26375-1-marek.vasut+renesas@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 4 Jun 2018 09:16:07 +0200
X-Google-Sender-Auth: _42qT7C4okUrV3Vyo26gxfAefoQ
Message-ID: <CAMuHMdX0Z9hEtuhnW1G-Si5mREM-JP5UTOqvjji9W00Pr1hKyw@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] mfd: da9063: Fix failpath in core
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
> In case mfd_add_devices() fails, da9063_irq_exit() is not called to
> undo the IRQchip setup done by da9063_irq_init(). Fix this by adding
> the missing fail path.
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
