Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933070AbeBVPO3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 10:14:29 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:41668 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932915AbeBVPO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 10:14:26 -0500
X-Google-Smtp-Source: AH8x226nIDdX0YBXAFB9trFxfjlUg46zTlitrMQdcKB3iQ66Cr59pVyog9Vj8xhXHI/IXMta3DhGggWk8IOlluPHvRw=
MIME-Version: 1.0
In-Reply-To: <84517171cdb142f3f04b45de6ef8daf13442a866.1514578085.git.vilhelm.gray@gmail.com>
References: <cover.1514578085.git.vilhelm.gray@gmail.com> <84517171cdb142f3f04b45de6ef8daf13442a866.1514578085.git.vilhelm.gray@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 22 Feb 2018 16:14:24 +0100
Message-ID: <CACRpkdYznjnQDZ6Urti9a2DYdqzWs7w8vHnc7EKkJ+V31sBb8g@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] iio: Change ISA_BUS_API dependency to selection
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Guenter Roeck <linux@roeck-us.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
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
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Patch applied to the GPIO tree for v4.17.

Yours,
Linus Walleij
