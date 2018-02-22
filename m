Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933078AbeBVPQV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 10:16:21 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:55495 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932869AbeBVPQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 10:16:18 -0500
X-Google-Smtp-Source: AG47ELu6wBntezwBux9A1uzqaVEtW7JIuw5SpdQwt5WC2F4aZPVmj0pGf4Mzqa7YORrXy/ZcHIfk1CqIwzPVnO3kwnI=
MIME-Version: 1.0
In-Reply-To: <1534276cb63d1e9e6dd139b4edceedbe728f65f5.1514578085.git.vilhelm.gray@gmail.com>
References: <cover.1514578085.git.vilhelm.gray@gmail.com> <1534276cb63d1e9e6dd139b4edceedbe728f65f5.1514578085.git.vilhelm.gray@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 22 Feb 2018 16:16:17 +0100
Message-ID: <CACRpkdaw75RH_WR4Ta9AmqNmGnaPhFKK2HfC=m8SNabACs95vg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] gpio: Change ISA_BUS_API dependency to selection
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Guenter Roeck <linux@roeck-us.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 29, 2017 at 9:13 PM, William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:

> The ISA_BUS_API Kconfig option enables the compilation of the ISA bus
> driver. The ISA bus driver does not perform any hardware interaction,
> and is instead just a thin layer of software abstraction to eliminate
> boilerplate code common to ISA-style device drivers. Since ISA_BUS_API
> has no dependencies and does not jeopardize the integrity of the system
> when enabled, drivers should select it when the ISA bus driver
> functionality is needed.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Patch applied to the GPIO tree for v4.17.

Can you confirm that we don't have any dangling ISA
drivers not using this?

Yours,
Linus Walleij
