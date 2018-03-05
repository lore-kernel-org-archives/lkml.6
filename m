Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932246AbeCEOkY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 09:40:24 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:33663 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932141AbeCEOkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 09:40:16 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180305144013euoutp021ca66c8dd0fa02c0c1aeda283de3d5bb~ZDSfGZh9C1030110301euoutp02V
X-AuditID: cbfec7f2-1dbff70000011644-f8-5a9d56cccef7
Subject: Re: [PATCH v5 0/5] Add coupled regulators mechanism
To: Fabio Estevam <festevam@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Doug Anderson <dianders@chromium.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From: Maciej Purski <m.purski@samsung.com>
Message-id: <6fc780e4-3594-2ca5-dc4e-7e147dc4e40f@samsung.com>
Date: Mon, 05 Mar 2018 15:40:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-version: 1.0
In-reply-to: <CAOMZO5C3YPKvZN+aORA+Jga-P=XgfG2xw7u6Ose5p6Twet2KLw@mail.gmail.com>
Content-type: text/plain; charset="utf-8"; format="flowed"
Content-language: en-US
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTURzAObt3d3fD1XEq/rUwGYgipQlWFzNJFFpkGkURfsiW3nykUzbf
        iihqPgubLGNLzQ9prZX5QHIU5PBBpTPzlYRvMy0rUoykstyuwr79zjm/cw6/w6EJSRPflY5X
        pLJKhTxRSonIjt6NwQP9F2ojD5o0XkzLnWY+o5ldoJj6bjOfGWjsopjZ0Qjm50gpjxk23qWY
        x92TAub++BCPKX7RLTgukhnqDEimyx8iZZ3aSYGsVV9GyW6265FsrdXtDBUpCoxhE+PTWaVv
        0GVRnL6ykUoxh2RqpyaofLRxuBwJacD+8MqgQ+VIREvwAwQ9I0YeN1hDYBwzC3aseo2ab2EJ
        bkTQ9s+bkxYRFDUs8SwLDjgQVop+W9kRn4CW17OERSJwOQHf337aOommKewNhpIoiyPGQVBp
        Xrb6JPaApapRZGEnfBEaNB8R59jDr+op0sJCfA6+LaxYfQIHwOJmMZ9jZygsniA53gdthq/W
        ewHPU2CeM5NcQSj0l+kQxw7wua99u2wvDFdXbDs5MLRupDjOhYIPT7edo7Cmbie4C3aBuqOG
        sLQAFkPpdQmnyGB1zLS9NRiePxmguAeaQjD9Y5yqQm5amx6tTYPWpkFr03APkXrkzKapkmJZ
        lZ+CzfBRyZNUaYpYn+jkpFa09X3ebPatPkPr766YEKaR1E5Mn6qNlPDl6aqsJBMCmpA6il1d
        tqbEMfKsbFaZHKVMS2RVJrSHJqXO4kteeZESHCtPZa+xbAqr3Fnl0ULXfHQoWOCe5+TXczuA
        UefO31g4X6D4clVz7K/v3J9Cu4Dw3SEnPTNnTi83vuwsbE6fFfKHetkZ9zrHDZ+B1Vvx71uy
        woLNddme8We7dGRJb0JYtMN0uuxhhku3sG5NHZrwqGl/RXiTv8ajCkf0iUQFR7Q1+urByYic
        KkP7Zn7XnH2xlFTFyf28CaVK/h+cp7Z4OgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsVy+t/xa7pnwuZGGWxv57TYOGM9q8XUh0/Y
        LOYfOcdqcXbZQTaLh1f9Lb5d6WCyuLxrDpvF2iN32S2WXr/IZNG69wi7A5fHmnlrGD1mN1xk
        8dg56y67x6ZVnWwefVtWMXp83iQXwBbFZZOSmpNZllqkb5fAlbGqZxlbwTnniln3brI1MP40
        62Lk5JAQMJGYP3USaxcjF4eQwBJGiR3zZ7BBOM8YJf42zGIDqRIWsJF40/KbCcQWEXCX2Hjq
        ITOIzSzQwyzxYm4ARMMDRon9/14zdjFycLAJaEmsaY8HqeEVsJPoOfcSrJdFQFXixYSrjCC2
        qECEROfK+SwQNYISPybfYwFp5RQIljg3MQtivJnEl5eHWSFscYnm1pssELa8xOY1b5knMArM
        QtI9C0nLLCQts5C0LGBkWcUoklpanJueW2ykV5yYW1yal66XnJ+7iREYIduO/dyyg7HrXfAh
        RgEORiUe3g0ec6OEWBPLiitzDzFKcDArifBKSQKFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8543
        qIwSEkhPLEnNTk0tSC2CyTJxcEo1MJoLpczcNLleN+LgdKW+o2slJwZwrHm+PMpWtdhyhvyu
        47rfj2578kLZq8xx9jnrXYXcyi+Uis2P+VXskvlls3fTueePWrkj3v5kd3GYWXWvTrhS3iS4
        9doVZp5VKTwf/12+m8m/Zau2QHDzhu3L6u5K3Tio9janOORQC6tpxew5KZYSPQZKEkosxRmJ
        hlrMRcWJAHzHTHCMAgAA
X-CMS-MailID: 20180305144012eucas1p1b83feabb41bb4d224308eaf226da29b3
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180302085118eucas1p15a6a5ec5f7f47a6f67a45c5e9495b120
X-RootMTR: 20180302085118eucas1p15a6a5ec5f7f47a6f67a45c5e9495b120
References: <CGME20180302085118eucas1p15a6a5ec5f7f47a6f67a45c5e9495b120@eucas1p1.samsung.com>
        <1519980169-8491-1-git-send-email-m.purski@samsung.com>
        <CAOMZO5C3YPKvZN+aORA+Jga-P=XgfG2xw7u6Ose5p6Twet2KLw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,
thank you for your response.
Could you tell me on which board precisely (on which DTS) has this issue occurred?
Also, I don't understand, did you boot successfully and you got only a lockdep 
warning or you encountered an actual deadlock?

Best regards,
Maciej Purski


On 03/05/2018 01:34 PM, Fabio Estevam wrote:
> Hi Maciej,
> 
> On Fri, Mar 2, 2018 at 5:42 AM, Maciej Purski <m.purski@samsung.com> wrote:
>> Hi all,
>>
>> this patchset adds a new mechanism to the framework - regulators' coupling.
>>
>> On Odroid XU3/4 and other Exynos5422 based boards there is a case, that
>> different devices on the board are supplied by different regulators
>> with non-fixed voltages. If one of these devices temporarily requires
>> higher voltage, there might occur a situation that the spread between
>> devices' voltages is so high, that there is a risk of changing
>> 'high' and 'low' states on the interconnection between devices powered
>> by those regulators.
>>
>> Algorithmicaly the problem was solved by:
>> Inderpal Singh <inderpal.s@samsung.com>
>> Doug Anderson <dianders@chromium.org>
>>
>> The discussion on that subject can be found here:
>> https://lkml.org/lkml/2014/4/29/28
>>
>> Therefore this patchset is an attempt to apply the idea to regulators core
>> as concluded in the discussion by Mark Brown and Doug Anderson.
>>
>> This feature is required to enable support for generic CPUfreq
>> and devfreq drivers for the mentioned boards.
>>
>> Note on the locking model:
>> When balancing voltage of a group of coupled regulators, we lock all
>> of them for the whole operation. When voltage of an individual regulator
>> is about to change, its suppliers are additionally locked.
>>
>> The current assumption is that an uncoupled regulator is a special case
>> of a coupled one, so they should share a common voltage setting path.
> 
> This series breaks has reached linux-next 20180305 and it breaks
> booting on imx6:
> 
> [    0.269646] imx-pgc-pd imx-pgc-power-domain.0: Linked as a consumer
> to 20dc000.gpc
> [    0.270348]
> [    0.270363] ============================================
> [    0.270373] WARNING: possible recursive locking detected
> [    0.270385] 4.16.0-rc3-next-20180305 #156 Not tainted
> [    0.270397] --------------------------------------------
> [    0.270408] swapper/0/1 is trying to acquire lock:
> [    0.270419]  (&rdev->mutex){+.+.}, at: [<c04d80c4>]
> regulator_lock_supply+0x24/0x44
> [    0.270460]
> [    0.270460] but task is already holding lock:
> [    0.270471]  (&rdev->mutex){+.+.}, at: [<c04dc6e4>]
> regulator_enable+0x78/0x298
> [    0.270502]
> [    0.270502] other info that might help us debug this:
> [    0.270513]  Possible unsafe locking scenario:
> [    0.270513]
> [    0.270523]        CPU0
> [    0.270532]        ----
> [    0.270540]   lock(&rdev->mutex);
> [    0.270555]   lock(&rdev->mutex);
> [    0.270572]
> [    0.270572]  *** DEADLOCK ***
> [    0.270572]
> [    0.270585]  May be due to missing lock nesting notation
> [    0.270585]
> [    0.270598] 3 locks held by swapper/0/1:
> [    0.270606]  #0:  (&dev->mutex){....}, at: [<c057f368>]
> __driver_attach+0x58/0xcc
> [    0.270642]  #1:  (&dev->mutex){....}, at: [<c057f378>]
> __driver_attach+0x68/0xcc
> [    0.270672]  #2:  (&rdev->mutex){+.+.}, at: [<c04dc6e4>]
> regulator_enable+0x78/0x298
> [    0.270701]
> [    0.270701] stack backtrace:
> [    0.270719] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
> 4.16.0-rc3-next-20180305 #156
> [    0.270731] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [    0.270741] Backtrace:
> [    0.270767] [<c010d154>] (dump_backtrace) from [<c010d414>]
> (show_stack+0x18/0x1c)
> [    0.270783]  r7:00000000 r6:60000093 r5:00000000 r4:c1078360
> [    0.270805] [<c010d3fc>] (show_stack) from [<c0a4724c>]
> (dump_stack+0xb4/0xe8)
> [    0.270830] [<c0a47198>] (dump_stack) from [<c0174f4c>]
> (__lock_acquire+0x13a4/0x199c)
> [    0.270848]  r9:c17d75fc r8:c11ae35c r7:c17c73b0 r6:ec060000
> r5:ec060570 r4:c11ae35c
> [    0.270867] [<c0173ba8>] (__lock_acquire) from [<c0175d68>]
> (lock_acquire+0x70/0x90)
> [    0.270883]  r10:00000000 r9:ec195800 r8:00000001 r7:00000001
> r6:60000013 r5:00000000
> [    0.270893]  r4:ffffe000
> [    0.270914] [<c0175cf8>] (lock_acquire) from [<c0a60760>]
> (__mutex_lock+0x64/0x978)
> [    0.270929]  r8:00000001 r7:00000001 r6:00000000 r5:00000000 r4:ec00b89c
> [    0.270947] [<c0a606fc>] (__mutex_lock) from [<c0a61098>]
> (mutex_lock_nested+0x24/0x2c)
> [    0.270963]  r10:00000000 r9:ec195800 r8:00000001 r7:00000001
> r6:ec195800 r5:00000000
> [    0.270975]  r4:ec00b800
> [    0.270992] [<c0a61074>] (mutex_lock_nested) from [<c04d80c4>]
> (regulator_lock_supply+0x24/0x44)
> [    0.271013] [<c04d80a0>] (regulator_lock_supply) from [<c04da9b0>]
> (regulator_balance_voltage+0x298/0x584)
> [    0.271024]  r5:000b1008 r4:ec195800
> [    0.271042] [<c04da718>] (regulator_balance_voltage) from
> [<c04dc748>] (regulator_enable+0xdc/0x298)
> [    0.271059]  r10:00000000 r9:00000000 r8:00000001 r7:00000001
> r6:ec195800 r5:ec195824
> [    0.271069]  r4:00000001
> [    0.271086] [<c04dc66c>] (regulator_enable) from [<c04d6dd8>]
> (imx6_pm_domain_power_on+0x30/0x1b4)
> [    0.271102]  r9:00000000 r8:c102d114 r7:c1008908 r6:c102d114
> r5:ec3d7a00 r4:ec3d7a00
> [    0.271119] [<c04d6da8>] (imx6_pm_domain_power_on) from
> [<c04d6d18>] (imx_pgc_power_domain_probe+0x64/0xf4)
> [    0.271135]  r8:c102d114 r7:ec49c810 r6:c102d114 r5:ec49c800 r4:ec3d7a00
> [    0.271153] [<c04d6cb4>] (imx_pgc_power_domain_probe) from
> [<c0580ef0>] (platform_drv_probe+0x54/0xb8)
> [    0.271168]  r7:fffffdfb r6:c102d114 r5:ec49c810 r4:ec49c810
> [    0.271189] [<c0580e9c>] (platform_drv_probe) from [<c057f288>]
> (driver_probe_device+0x2b0/0x338)
> [    0.271204]  r7:c17e234c r6:00000000 r5:c17e2348 r4:ec49c810
> [    0.271222] [<c057efd8>] (driver_probe_device) from [<c057f3d8>]
> (__driver_attach+0xc8/0xcc)
> [    0.271237]  r10:c0f00630 r9:00000000 r8:c1008908 r7:c1008908
> r6:ec49c844 r5:c102d114
> [    0.271248]  r4:ec49c810 r3:00000000
> [    0.271267] [<c057f310>] (__driver_attach) from [<c057d348>]
> (bus_for_each_dev+0x6c/0xbc)
> [    0.271280]  r7:c1008908 r6:c057f310 r5:c102d114 r4:00000000
> [    0.271298] [<c057d2dc>] (bus_for_each_dev) from [<c057eb64>]
> (driver_attach+0x20/0x28)
> [    0.271314]  r7:00000000 r6:c103b0a8 r5:ec479b00 r4:c102d114
> [    0.271332] [<c057eb44>] (driver_attach) from [<c057e588>]
> (bus_add_driver+0x18c/0x214)
> [    0.271351] [<c057e3fc>] (bus_add_driver) from [<c057fdbc>]
> (driver_register+0x80/0x100)
> [    0.271366]  r7:c0e125e4 r6:c0f63850 r5:c0f41c18 r4:c102d114
> [    0.271383] [<c057fd3c>] (driver_register) from [<c0580e44>]
> (__platform_driver_register+0x38/0x4c)
> [    0.271396]  r5:c0f41c18 r4:ffffe000
> [    0.271418] [<c0580e0c>] (__platform_driver_register) from
> [<c0f41c30>] (imx_pgc_power_domain_driver_init+0x18/0x20)
> [    0.271438] [<c0f41c18>] (imx_pgc_power_domain_driver_init) from
> [<c0102764>] (do_one_initcall+0x50/0x1a0)
> [    0.271464] [<c0102714>] (do_one_initcall) from [<c0f00f04>]
> (kernel_init_freeable+0x118/0x1d0)
> [    0.271481]  r9:c0f63858 r8:000000f2 r7:c0e125e4 r6:c0f63850
> r5:c1079f80 r4:c0f77ab4
> [    0.271508] [<c0f00dec>] (kernel_init_freeable) from [<c0a5c6f0>]
> (kernel_init+0x10/0x118)
> [    0.271524]  r10:00000000 r9:00000000 r8:00000000 r7:00000000
> r6:00000000 r5:c0a5c6e0
> [    0.271533]  r4:00000000
> [    0.271552] [<c0a5c6e0>] (kernel_init) from [<c01010b4>]
> (ret_from_fork+0x14/0x20)
> [    0.271564] Exception stack(0xec069fb0 to 0xec069ff8)
> [    0.271579] 9fa0:                                     00000000
> 00000000 00000000 00000000
> [    0.271594] 9fc0: 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 00000000
> [    0.271609] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [    0.271621]  r5:c0a5c6e0 r4:00000000
> [    0.271723] imx-pgc-pd imx-pgc-power-domain.1: Linked as a consumer
> to 20dc000.gpc
> [    0.273566] 2020000.serial: ttymxc0 at MMIO 0x2020000 (irq = 26,
> base_baud = 5000000) is a IMX
> [    1.660948] console [ttymxc0] enabled
> [    1.666242] 21ec000.serial: ttymxc2 at MMIO 0x21ec000 (irq = 65,
> base_baud = 5000000) is a IMX
> [    1.683484] etnaviv etnaviv: bound 130000.gpu (ops gpu_ops)
> [    1.689464] etnaviv etnaviv: bound 134000.gpu (ops gpu_ops)
> 
> If I revert this series I am able to boot again.
> 
> 
> 
