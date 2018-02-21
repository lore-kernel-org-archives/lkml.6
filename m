Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932476AbeBUJfB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 04:35:01 -0500
Received: from mail-qt0-f177.google.com ([209.85.216.177]:37920 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753249AbeBUJe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 04:34:59 -0500
X-Google-Smtp-Source: AH8x2240rhz2jKbGDu4OMiU+2EEzwX0UVBGH/83LYztXGmQ+owsCJWCGN4rBjM4AkrDsJNWTIlZbByJruJ0ZnSOATaM=
MIME-Version: 1.0
In-Reply-To: <7b59b34b-92ee-da85-9c76-1d7f8f72c318@samsung.com>
References: <1519117393-31302-1-git-send-email-geert+renesas@glider.be>
 <CGME20180220105101epcas1p32dced553004bbcb54512e5c144ca2a1c@epcas1p3.samsung.com>
 <CAMuHMdWa5RgkGCAucN5ykGRW=FdHUZw=+t5jMAsKhdixMUSQzQ@mail.gmail.com> <7b59b34b-92ee-da85-9c76-1d7f8f72c318@samsung.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 21 Feb 2018 10:34:58 +0100
X-Google-Sender-Auth: uU1Bbbv1EzJhbteZEvs4gzQgSVA
Message-ID: <CAMuHMdU9fbATp04Cvq8vJ_3-gEw8br3YA-AGGFh2L0caJ-0Jhw@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc-k3: Fix out-of-bounds access through DT alias
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaehoon,

On Wed, Feb 21, 2018 at 6:39 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> On 02/20/2018 07:50 PM, Geert Uytterhoeven wrote:
>> On Tue, Feb 20, 2018 at 10:03 AM, Geert Uytterhoeven
>> <geert+renesas@glider.be> wrote:
>>> The hs_timing_cfg[] array is indexed using a value derived from the
>>> "mshcN" alias in DT, which may lead to an out-of-bounds access.
>>>
>>> Fix this by adding a range check.
>>>
>>> Fixes: 7d92895208a008a2 ("mmc: dw_mmc-k3: Fix out-of-bounds access through DT alias")
>>
>> Oops
>>
>> Fixes: 361c7fe9b02eee7e ("mmc: dw_mmc-k3: add sd support for hi3660")
>
> Could you resend the patch with changing commit-msg?
> Then i will pick yours.

Sure. Will send a v2 soon.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
