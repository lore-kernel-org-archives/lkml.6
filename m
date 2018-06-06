Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAtbMnYT"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E5AEC6037B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932156AbeFFGYi (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 02:24:38 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:37569 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932103AbeFFGYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 02:24:36 -0400
X-Google-Smtp-Source: ADUXVKLDoD6xUF6Akgxjao1dE4Qpr3X62qT7QlXaiorBJ9N8kLK4jV7cIi0z2s92vQ866YscKWHNpaQG5Qc68805n00=
MIME-Version: 1.0
In-Reply-To: <20180605231013.1803-1-marek.vasut+renesas@gmail.com>
References: <20180605231013.1803-1-marek.vasut+renesas@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 6 Jun 2018 08:24:35 +0200
X-Google-Sender-Auth: szPG2IDQ02dfxc9TygyQboQsZvM
Message-ID: <CAMuHMdVR3dE+FW-O+obbXAwYx_meaJmSoQf61rdiQF2YYDZFGw@mail.gmail.com>
Subject: Re: [PATCH v4 01/12] mfd: da9063: Fix failpath in core
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On Wed, Jun 6, 2018 at 1:10 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> In case mfd_add_devices() fails, da9063_irq_exit() is not called to
> undo the IRQchip setup done by da9063_irq_init(). Fix this by adding
> the missing fail path.

Thanks for your patch!

> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

Please retain Reviewed-by tags (from Vaishali and me).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
