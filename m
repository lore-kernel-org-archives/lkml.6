Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932993AbeBVPPT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 10:15:19 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:39606 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932887AbeBVPPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 10:15:13 -0500
X-Google-Smtp-Source: AH8x227wCy3hZxz6vZ+qmvWWLvaD/5COVdYgmIqSE+UlFdW3noDOwGLrTWgOo5JQNH+mb268usHXD0wpdkb4UY5wqkE=
MIME-Version: 1.0
In-Reply-To: <a7ce7198b68405660a8610c302057f1507ca5e3c.1514578085.git.vilhelm.gray@gmail.com>
References: <cover.1514578085.git.vilhelm.gray@gmail.com> <a7ce7198b68405660a8610c302057f1507ca5e3c.1514578085.git.vilhelm.gray@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 22 Feb 2018 16:15:12 +0100
Message-ID: <CACRpkda6YCZDimX4OtH2MmOFJH5m3ycA7szZ986u9R94KyJ4_g@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] watchdog: Change ISA_BUS_API dependency to selection
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Guenter Roeck <linux@roeck-us.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>
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
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Patch applied to the GPIO tree for v4.17.

Yours,
Linus Walleij
