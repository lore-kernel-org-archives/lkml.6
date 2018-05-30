Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935443AbeE3HPc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 03:15:32 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:39495 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932377AbeE3HPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 03:15:31 -0400
X-Google-Smtp-Source: ADUXVKKj0L2l1Qi992oZAq8gRrztAaMJRPf+uaPnsjKU6xoZKDC4CJOWghcBTBGpiheBZgIkN/vyaBJUMmjAKSFoPVY=
MIME-Version: 1.0
In-Reply-To: <20180529145436.GJ23509@sirena.org.uk>
References: <20180514080640.12515-1-linus.walleij@linaro.org>
 <20180514080640.12515-16-linus.walleij@linaro.org> <20180529145436.GJ23509@sirena.org.uk>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 30 May 2018 09:15:30 +0200
Message-ID: <CACRpkdbL2E-dsO_VRDJ+1R62QeNAGh9kAT3ChSoxETNBsqqikg@mail.gmail.com>
Subject: Re: [PATCH 15/19 v3] regulator: fixed/gpio: Pull inversion/OD into gpiolib
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexander Shiyan <shc_work@mail.ru>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Daniel Mack <zonque@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 4:54 PM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, May 14, 2018 at 10:06:36AM +0200, Linus Walleij wrote:
>
>>  arch/arm/mach-pxa/hx4700.c                    |  3 +-
>
> This doesn't apply against the above file in my tree, please check and
> resend.

How typical. I say let's defer this to v4.19 and first see that we land
the fixed regulators conversion first and I'll rebase this on top there.
There is no stress with this so we can take it one step at the time.

Yours,
Linus Walleij
