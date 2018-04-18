Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753306AbeDRIRz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 04:17:55 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:44175 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752630AbeDRIRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 04:17:54 -0400
Subject: Re: [RESEND PATCH v2 0/4] ARM: davinci: remove the mach-specific
 aemif driver - part 1
To: Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
CC: Bartosz Golaszewski <brgl@bgdev.pl>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180417102917.7794-1-brgl@bgdev.pl>
 <2a2ac117-900c-77b6-f247-49777493e55f@ti.com>
 <CAMpxmJUBFEF7FDp910HwsrNhGhwJDrgRR_9qL0DE5W1M=39MgQ@mail.gmail.com>
 <e3fc3019-888c-cbc3-5e1b-e24c30bc4d49@oracle.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <4aa845a4-a96f-c574-19a2-3dd5521fa5bd@ti.com>
Date: Wed, 18 Apr 2018 13:47:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <e3fc3019-888c-cbc3-5e1b-e24c30bc4d49@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 April 2018 10:59 PM, Santosh Shilimkar wrote:
> On 4/17/2018 5:36 AM, Bartosz Golaszewski wrote:
>> 2018-04-17 12:53 GMT+02:00 Sekhar Nori <nsekhar@ti.com>:
>>> Hi Bartosz,
> 
> [...]
> 
>>>> This series applies on top of v8 of David Lechner's CCF series.
>>>
>>> Are there any patches in the series that can safely be applied to
>>> v4.17-rc1?
> 
>>
>> Hi Sekhar,
>>
>> yes, all of them. They're not linked to David's work in any way.
>>
> Please separate the driver/emif/* patches from the series. These
> are not fixes so they are not rcx candidates. But will queue them
> up for next merge window. Thanks !!

Thanks Santosh! Can you please queue the drivers/emif/ patches on an
immutable branch based off v4.17-rc1 which I can then merge to queue the
platform patches?

Thanks,
Sekhar
