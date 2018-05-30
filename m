Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968643AbeE3H33 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 03:29:29 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:36617 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935695AbeE3H30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 03:29:26 -0400
X-Google-Smtp-Source: ADUXVKIXfjH9e1pd+IWOWuXzb7vCScUpARs4zB4ahvSBjBPiMQ1ClVT0P6ye5CN8HRvvIaP6v3G28tx7j1X1uVbSu5M=
MIME-Version: 1.0
In-Reply-To: <20180530150711.2c7c1fe9@canb.auug.org.au>
References: <20180530150711.2c7c1fe9@canb.auug.org.au>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 30 May 2018 09:29:24 +0200
Message-ID: <CACRpkdaotBXbA4pPFHRH0S1SF7-XX_T6yAOwZcbsR3RBcj+-=Q@mail.gmail.com>
Subject: Re: linux-next: manual merge of the regulator tree with the arm-soc tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 7:07 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
>
> Today's linux-next merge of the regulator tree got a conflict in:
>
>   arch/arm/mach-omap1/board-ams-delta.c
>
> between commit:
>
>   0486738928bf ("ARM: OMAP1: ams-delta: add GPIO lookup tables")
>
> from the arm-soc tree and commit:
>
>   6059577cb28d ("regulator: fixed: Convert to use GPIO descriptor only")
>
> from the regulator tree.
>
> I fixed it up (see below - it may be better done) and can carry the fix
> as necessary.


OMG that patch on a patch makes my head spin.

I think I just have to look at the eventual result in linux-next and see if
it makes proper sense, and rely on Janusz to test the result and help
to fix it up.

I was unaware of this concurrent gpiod conversion inside OMAP1 but
I'm happy to see that it happens. We might have some fallout, but I'm
sure Janusz is on top of things.

Yours,
Linus Walleij
