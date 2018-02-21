Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938395AbeBUPrA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 10:47:00 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:43044 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934310AbeBUPq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 10:46:57 -0500
X-Google-Smtp-Source: AG47ELs7/d2O/gVLYX9KARyM4XGwQ+3Xbdgv2Z8OeiWa0QgADsLMJe8x+YG3FboV/aak8eCYszpJrfxBloKwGzlLhlg=
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJA=2JLqRfERJ1hN=ErUqw+xT8OhZVMjSVeRH4mgrE36Q@mail.gmail.com>
References: <20180220231046.32638-1-laurent.pinchart+renesas@ideasonboard.com>
 <20180220231046.32638-5-laurent.pinchart+renesas@ideasonboard.com>
 <CAMuHMdVJfKXWNFaN259JQ1bOVZQSbC-=u4Kmys2PE+HLa=xQKw@mail.gmail.com> <CAL_JsqJA=2JLqRfERJ1hN=ErUqw+xT8OhZVMjSVeRH4mgrE36Q@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 21 Feb 2018 16:46:56 +0100
X-Google-Sender-Auth: xJ5H9Z_Zsu0080TYodT4oz9fiZg
Message-ID: <CAMuHMdVcbgX-Gi7p15JgsF0Ghe2wo4XEkPM2c=uxgqxJ9f2i=Q@mail.gmail.com>
Subject: Re: [PATCH v4 04/16] of: changesets: Introduce changeset helper methods
To: Rob Herring <robh@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Matt Porter <mporter@konsulko.com>,
        Koen Kooi <koen@dominion.thruhere.net>,
        Guenter Roeck <linux@roeck-us.net>, Marek Vasut <marex@denx.de>,
        Wolfram Sang <wsa@the-dreams.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux I2C <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Wed, Feb 21, 2018 at 4:23 PM, Rob Herring <robh@kernel.org> wrote:
> On Wed, Feb 21, 2018 at 4:21 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> You missed one fix I have in my topic/overlays branch
>> https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/commit/?h=topic/overlays&id=150f95b9dec77ce371c229f7ac4d6dd8620bef4a
>
> Are you planning to try to upstream all this? If not, I'll get Frank

Not really. But I do need a way to load DT overlays at runtime, for testing
hardware on expansion connectors.

> to keep changing the overlay API to make carrying it out of tree more
> painful. :)

He already did a very good job w.r.t. that in v4.15-rc1 ;^)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
