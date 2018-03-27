Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752271AbeC0Mxm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 08:53:42 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:39555 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752040AbeC0Mxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 08:53:41 -0400
X-Google-Smtp-Source: AG47ELvRgio9vDqsohPVmuLAVAmTIvkZLu1GHSIavUX6eKcf1lF3fxdU8/8NeUIdp8KRv5R60dQ9gsArIbqTy+bB9yo=
MIME-Version: 1.0
In-Reply-To: <20180321225001.GA27480@piout.net>
References: <20180321225001.GA27480@piout.net>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 27 Mar 2018 14:53:40 +0200
X-Google-Sender-Auth: HUfJ_DrWbv1scnD6pfgA_FWsYJo
Message-ID: <CAK8P3a1vih1nLSVZsAZabnVNq6icuJ6Qu7pAGVVQG2z3ZW2Uxw@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: at91: DT for 4.17 #2
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Olof Johansson <olof@lixom.net>, arm-soc <arm@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 11:50 PM, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> Arnd, Olof,
>
> A few DT fixes that came in late in the cycle.
>
> The following changes since commit 6fa65edf87886f85a18680ed7bdedc15cb810065:
>
>   ARM: dts: at91: use 'atmel' as at24 manufacturer for at91sam9263ek (2018-02-13 17:15:18 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.17-dt2
>
> for you to fetch changes up to 26f2cacde21b713f7f917d2193a76cc7636ee88e:
>
>   ARM: dts: at91sam9260: pullup rx on usart0 (2018-03-21 21:47:00 +0100)
>
> ----------------------------------------------------------------
> AT91 DT for 4.17 #2:
>
> Pinctrl fixes, the UART pullups were discussed back in 2016.
>

Pulled into next/dt, thanks!

     Arnd
