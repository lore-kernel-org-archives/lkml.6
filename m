Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752601AbeBZK2h (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 05:28:37 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:45938 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752024AbeBZK2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 05:28:33 -0500
X-Google-Smtp-Source: AG47ELs0oAUwJy2epaGd30ukzFwhq7fiyUTOXvTlx1dOLBHsRj5kFN0z0UiTkRFPSBulLhelNdDpdoidxiia9BT2cUs=
MIME-Version: 1.0
In-Reply-To: <9a55e8b3-bf34-d8a4-f5a6-01e86374f42f@maciej.szmigiero.name>
References: <9a55e8b3-bf34-d8a4-f5a6-01e86374f42f@maciej.szmigiero.name>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 26 Feb 2018 11:28:32 +0100
Message-ID: <CACRpkdbZ30G1wBOpLR7JxLjBKU1ozd8d8upVbymfiEb0q-ibqA@mail.gmail.com>
Subject: Re: [PATCH] Revert "gpio: winbond: fix ISA_BUS_API dependency"
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 3:55 PM, Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:

> This reverts commit 92a8046c9d952a2a7d21dfcd3afadc72a0bc0f72.
>
> Now that the patch series changing ISA_BUS_API dependency to selection
> was merged this reversion will do the same for gpio-winbond driver to
> make it consistent with other ISA bus gpio drivers.
>
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>

Patch applied.

Yours,
Linus Walleij
