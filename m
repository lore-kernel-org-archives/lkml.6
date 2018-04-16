Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754146AbeDPIpI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 04:45:08 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:45615 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754111AbeDPIpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 04:45:02 -0400
X-Google-Smtp-Source: AIpwx4/DzemmI1XuLgA6pMYQZfJt+7aq4PmlwHSY2DPlNzZla1u96qkOhUz6hYR5zFdy9PSKhPJyTIB7az7xtAqqXWA=
MIME-Version: 1.0
In-Reply-To: <b2886156-4d6e-4c0c-1047-a54da8049ef6@linaro.org>
References: <b2886156-4d6e-4c0c-1047-a54da8049ef6@linaro.org>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 16 Apr 2018 18:14:40 +0930
X-Google-Sender-Auth: 7bfltqS66bdMX6QaLg80dz3vy3g
Message-ID: <CACPK8Xep6XJ_hKD0had9BJOspvaLKDAXMwdGtO9xmqgM5x02vw@mail.gmail.com>
Subject: Re: [GIT PULL] clockevents for 4.17
To: Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>, Tomer Maimon <tmaimon77@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3G8jLfu015390

Hi Thomas,

On 3 April 2018 at 22:30, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> It contains the following changes for 4.17:
>
>  - Fix timer name and register flow for imx's timer tmp and handle
> different counter width (Anson Huang)
>
>  - Add the NPCM7xx timer support (Tomer Maimon)

I can't see this tree in 4.17-rc1. Do you know what happened there?

Cheers,

Joel


>
> Thanks
>
>   -- Daniel
>
>
>
>
> The following changes since commit bd03143007eb9b03a7f2316c677780561b68ba2a:
>
>   alarmtimer: Init nanosleep alarm timer on stack (2018-03-29 16:10:07
> +0200)
>
> are available in the git repository at:
>
>   https://git.linaro.org/people/daniel.lezcano/linux.git clockevents/4.17
>
> for you to fetch changes up to 0136c741ff40e03323419feec05fcd594f36a463:
>
>   clocksource/drivers/imx-tpm: Add different counter width support
> (2018-03-30 22:44:11 +0200)
>
> ----------------------------------------------------------------
> Anson Huang (4):
>       dt-bindings: timer: tpm: fix typo of clock name
>       clocksource/drivers/imx-tpm: Fix typo of clock name
>       clocksource/drivers/imx-tpm: Correct some registers operation flow
>       clocksource/drivers/imx-tpm: Add different counter width support
>
> Tomer Maimon (2):
>       dt-binding: timer: document NPCM7xx timer DT bindings
>       clocksource/drivers/npcm: Add NPCM7xx timer driver
>
>  Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.txt |  21
> ++++++++++++++++++++
>  Documentation/devicetree/bindings/timer/nxp,tpm-timer.txt         |   2 +-
>  drivers/clocksource/Kconfig                                       |   8
> ++++++++
>  drivers/clocksource/Makefile                                      |   1 +
>  drivers/clocksource/timer-imx-tpm.c                               |  43
> ++++++++++++++++++++++++++++++----------
>  drivers/clocksource/timer-npcm7xx.c                               | 215
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 279 insertions(+), 11 deletions(-)
>  create mode 100644
> Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.txt
>  create mode 100644 drivers/clocksource/timer-npcm7xx.c
>
>
> --
>  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
