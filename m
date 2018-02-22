Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932959AbeBVPSF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 10:18:05 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:33477 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753827AbeBVPSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 10:18:02 -0500
X-Google-Smtp-Source: AG47ELviU1HLqhBPHvs+yKLXezqZHE3A76eq6nRzSkASjvlP0UKl4IjbbQ606HcE3AR/c6SGTIPFjaM6mMFTzG2JhUA=
MIME-Version: 1.0
In-Reply-To: <bc33320887f448b772004e7c5d97322abb8cae0b.1514578085.git.vilhelm.gray@gmail.com>
References: <cover.1514578085.git.vilhelm.gray@gmail.com> <bc33320887f448b772004e7c5d97322abb8cae0b.1514578085.git.vilhelm.gray@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 22 Feb 2018 16:18:01 +0100
Message-ID: <CACRpkdZKxHRHvURL97iS__fvx_VMtg3ZohJKt4PfFQjZgnAuCA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] isa: Remove ISA_BUS_API selection for ISA_BUS
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

On Fri, Dec 29, 2017 at 9:14 PM, William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:

> ISA_BUS_API is selected by drivers themselves when necessary. The
> ISA_BUS Kconfig option is now simply a mask for true ISA device drivers
> and relevant configuration. For now, the ISA_BUS Kconfig option is only
> available for X86, but may be added for other arch builds in the future
> if the need arises.
>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Patch applied to the GPIO tree for v4.17.

I'd like to have some ACK from some x86 maintainer for this
so it makes me a bit nervous.

Yet again the patch has been sitting since december with no
comments so...

Yours,
Linus Walleij
