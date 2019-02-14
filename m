Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7246C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD1A222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438070AbfBNJxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:53:14 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:52545 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbfBNJxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:53:14 -0500
Received: from [192.168.1.110] ([77.2.75.124]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M2w0K-1gvJdO0z4W-003Na2; Thu, 14 Feb 2019 10:53:06 +0100
Subject: Re: [PATCH 1/2] x86: gpio: AMD G-Series pch gpio platform driver
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86 <platform-driver-x86@vger.kernel.org>
References: <1549588593-4856-1-git-send-email-lkml@metux.net>
 <CACRpkdaSEZMR7LuLbO1V0k9QEBu4FWxFbq4ZL1pE9dAvNT1z_Q@mail.gmail.com>
 <f751539b-d844-9ab1-169b-ce6aa0056de6@metux.net>
 <CACRpkdbvY1FiqmBHj74x4H9XX8SZW7voTMfj5jq-as73_B071Q@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <6f723c65-be90-132d-e714-616a21149fe0@metux.net>
Date:   Thu, 14 Feb 2019 10:53:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CACRpkdbvY1FiqmBHj74x4H9XX8SZW7voTMfj5jq-as73_B071Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:VBwySvyHr82DeS3HR4C5rGVY86dMJCt5A1ga+wloQLnyA6bEpy5
 oXjY5o4vgWqEt1WU6Y9LKZNHloQrm/ky7WgYgr6HoSG+xfT7M0eOA78Zjzbi/mqajx5F9gU
 oO0j8veA+XPN8ReSK3a3mllm1gLPs1nr98aHY+uSn4IYqdg68KXfaN4jGKy/HedaO6UCwzl
 /RLjyMhO5BGyoI/6wf2pA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WwKhC28vBDQ=:/xDgd+r99u5OwoJGtLo2gw
 0IiZl8HAgoERPoyssgjkLmdpWwf2+J/dsDtkK1WRFidEVgUYO5TOSzRFzdhJKaFpsVePgsiD8
 PNGaTcVKnotsIvkkD+tDqA3tcU5To+HCRGjQcTOxrLYJnBm1xQCXbtBTRvMkU+XEgaMaQO8hL
 /0e7DTxUpuET90zZAOHx20vVJA2Hb6wIY7eOt59UKJDj7Z+288sIKOcDI3gtuwagAJNlIhsmd
 r9RBRxSGhRMKVZKY3ujbsK5UphLOIXpb2pNPCNekoH48FWOEkAzmAtezhEziDnxhXtLukjGvN
 zTSR6R8Qps0vmkOr1Ju1n5ZuAt1FG4BWo0ODx9lQzO15Osf56to2Kn4hAXT/rkVNNZeJ8ACtW
 QHDi931bNt4z50dXC69kTUROS3xd0GbgpWMcSOCJgBC5P9Y+/wkz9KDB2d3A7cHnJ4VA5QSIs
 xvq6n+iYOeG4OTcPfcyOZ/3LnJqzPfT092TCv8Eh+Av+YgNTVRgVyAa1qq3H4GfmKOhAOFIvo
 HpO+l2h16YxDHiZjf4Ydsq0gFXPY/MyU+JVgByyIOO8a1PnhnS8CGEiceSpjof7Wv0WkNIDLS
 cRFbJkYg6KY/ztDX+SSwAUxPj1ZA5EYHlJ4I4/5AgHCWPJOV/NQ/FD+pgkMQps7gDFhfqFr9H
 Uuvlioz28tNUaafFv4AwI6Epre4Lu5z/Y8WZ+vfXWbu0Umu9HnWB7HIiXgQOBORt1QoI0m9ii
 oMhQ4L05Hgo2ill7fmUSeuCQdWVYCbDw/0RDMo31KbEbifhcoEbrskf+nfI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.02.19 10:02, Linus Walleij wrote:

Hi,

> What we normally do is expose all the lines from a gpio chip> as kernel abstraction.> > This is because at least in theory this chip
can be used by> several boards.
I'm afraid it's a bit more complicated. The register set doesn't
seem to be linear. I have absolutely no idea what the undocumented
registers do. For the sake of security, I would hate to see them
accessible from userland.

> The chip abstraction does have facilities for masking off
> unavailable lines: in struct gpio_chip there is .valid_mask
> and even a callback .init_valid_mask() to set it up.

Okay, but then again I'd need to pass this from the board
driver into the gpio driver. Feels much easier and safer to
just pass the registers.

What I perhaps could do: add all documented registers as gpio's
in the gpio driver and make the board driver a dummy consumer
for the unused ones.

> So this is what you should use to make existing lines
> unavailable, do not try to hide them by not exposing
> registers or line offsets. The abstraction should model
> the hardware, not the usecase.

According to my information, it is the hardware who dictates that
non-linear layout. Even the PIN naming is non-linear. And I don't
like to see this passed to upper layers, or even userland. So,
at least the gpio driver should only serve the documented gpios
and present them lineary.

Maybe the holes in the register set are technically also gpios,
but used by some internal logic and not properly masked out in
hw - really weird things (possibly damage) could happen.

> FYI there are tons of systems out there that expose a
> whole range of GPIOs that the developer have no clue
> where they are connected on the PCB, the most common
> case is that they are not connected (sometimes not
> even leaving the chip die) or go to test points. They are
> very seldom dangerous, in fact I've never seen dangerous
> GPIOs, just dangerous set-ups of pins already known
> to be in use for something.

Can't speak about standard ICs/SoCs, but i've seen such things
in some of my client's fpga designs. For example incomplete
decoders, gpios attached to internal state machines, etc, etc
So, I've learned to be *very* cautious with undocumented registers.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
