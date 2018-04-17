Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754005AbeDQN7N (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 09:59:13 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:43991 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753771AbeDQN7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 09:59:12 -0400
X-Google-Smtp-Source: AIpwx4/eZ/ZfQkI31UiygOAuO3K7BLlHyE/OMKdNwNwaDmzGZ7yzPhD0gIUdTTjiNtdNDLolnSniPBQdkIuPOWbZCRI=
MIME-Version: 1.0
In-Reply-To: <CAMRc=Me6b0e+d6QRTdr7G9zLdqonjxLBp6h6bM_JaF8OytR=QA@mail.gmail.com>
References: <20180417102917.7794-1-brgl@bgdev.pl> <2a2ac117-900c-77b6-f247-49777493e55f@ti.com>
 <CAMpxmJUBFEF7FDp910HwsrNhGhwJDrgRR_9qL0DE5W1M=39MgQ@mail.gmail.com> <CAMRc=Me6b0e+d6QRTdr7G9zLdqonjxLBp6h6bM_JaF8OytR=QA@mail.gmail.com>
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Tue, 17 Apr 2018 15:59:10 +0200
Message-ID: <CAMpxmJVa8xCsru4ixBxMmZe4_aDyiuPvfd_wgUTckG5jWahe1g@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 0/4] ARM: davinci: remove the mach-specific
 aemif driver - part 1
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-17 14:41 GMT+02:00 Bartosz Golaszewski <brgl@bgdev.pl>:
> 2018-04-17 14:36 GMT+02:00 Bartosz Golaszewski <bgolaszewski@baylibre.com>:
>> 2018-04-17 12:53 GMT+02:00 Sekhar Nori <nsekhar@ti.com>:
>>> Hi Bartosz,
>>>
>>> On Tuesday 17 April 2018 03:59 PM, Bartosz Golaszewski wrote:
>>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>>
>>>> This is the first part of changes required to remove duplicate aemif
>>>> support from mach-davinci.
>>>>
>>>> I actually noticed that one of my previous changes from 2017 broke nand
>>>> in legacy mode - the clock lookup no longer works. This series addresses
>>>> it as well.
>>>>
>>>> First patch just uses a static string for the ti-aemif driver name.
>>>>
>>>> The second adds support for board files to the aemif driver.
>>>>
>>>> Last two add nand support to da850-lcdk in legacy mode and make
>>>> da850-evm use the platform driver instead of the mach-specific one.
>>>>
>>>> If these patches get accepted, I'll prepere a follow-up moving all
>>>> other boards to the new platform driver.
>>>>
>>>> This series applies on top of v8 of David Lechner's CCF series.
>>>
>>> Are there any patches in the series that can safely be applied to v4.17-rc1?
>>>
>>> Thanks,
>>> Sekhar
>>
>> Hi Sekhar,
>>
>> yes, all of them. They're not linked to David's work in any way.
>>
>> Bart
>
> Oops, -ETOOFAST, I rebased it on top of David's v9, let me check how
> it works with mainline - it should be mostly fine.
>
> Bart

Ok, so the patches apply and build nicely on top of v4.17-rc1, but
they only actually work with David's v9 branch. On the other hand nand
doesn't work with mainline now anyway so I assume it's safe to apply
them and wait for David's patches to be merged.

Thanks,
Bartosz
