Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751546AbeBWOJv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 09:09:51 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:37634 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751432AbeBWOJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 09:09:47 -0500
X-Google-Smtp-Source: AG47ELs6HQUQfph9PTUaNc2+JAxLaXInCvrFz2PhJ9ASlFnnj1sz0hCVSPx/oGdCqGg92MkUD04HelZB3dYwuilxg7Q=
MIME-Version: 1.0
In-Reply-To: <ec0c1668-dc0d-cd44-1c87-b1d71215f477@maciej.szmigiero.name>
References: <cover.1514578085.git.vilhelm.gray@gmail.com> <1534276cb63d1e9e6dd139b4edceedbe728f65f5.1514578085.git.vilhelm.gray@gmail.com>
 <CACRpkdaw75RH_WR4Ta9AmqNmGnaPhFKK2HfC=m8SNabACs95vg@mail.gmail.com>
 <20180222203009.GA10834@sophia> <278aed38-1b40-e362-00e2-38d61a4b81c2@maciej.szmigiero.name>
 <ec0c1668-dc0d-cd44-1c87-b1d71215f477@maciej.szmigiero.name>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 23 Feb 2018 15:09:45 +0100
Message-ID: <CACRpkdYmUrVAnZLJtxEdp__W8j1kFVPAhVDYr1Rb_1DczwzS+Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] gpio: Change ISA_BUS_API dependency to selection
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 2:50 PM, Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:
> On 22.02.2018 21:44, Maciej S. Szmigiero wrote:

>> Note that gpio-winbond (CONFIG_GPIO_WINBOND) driver was originally
>> merged using ISA_BUS_API selection as done for other ISA bus gpio drivers
>> by this patch, then temporary switched to the previous ("depends on")
>> style by commit 92a8046c9d952a to fix a circular Kconfig dependency.
>> So now this commit (92...) should be reverted to make gpio-winbond
>> driver Kconfig dependency / selection consistent with the remaining ISA
>> bus gpio drivers.
>>
>> Unfortunately, I can't test the reversion myself because it looks like
>> Linus didn't push his trees yet to git.kernel.org after applying this
>> series (or I am not looking at the right place - linusw/linux-gpio.git?).
>
> It looks like the series has been pushed to git.kernel.org now.
> I have tested the reversion of commit 92a8046c9d952a and can confirm
> that the ISA_BUS_API dependency / selection for gpio-winbond works
> then as intended (in a way that is consistent with other ISA bus gpio
> drivers).
>
> @Linus:
> Will you revert that commit or should I submit a patch that does it?

Oh send me a patch, that's easiest.

Yours,
Linus Walleij
