Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753327AbeEOMYo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 08:24:44 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49600 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753169AbeEOMYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 08:24:40 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180515122438euoutp01f8310a6c00c6d590df00d40a259aaa77~u0PXrLWNb0056300563euoutp017
X-AuditID: cbfec7f5-b45ff700000028a9-d6-5afad1812a5e
Subject: Re: Revert "dmaengine: pl330: add DMA_PAUSE feature"
To: Vinod <vkoul@kernel.org>
Cc: Frank Mori Hess <fmh6jj@gmail.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        r.baldyga@hackerion.com, Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <bd1e3060-df5f-692c-f022-9dd3b06b553f@samsung.com>
Date: Tue, 15 May 2018 14:24:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180515062144.GC13271@vkoul-mobl>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJKsWRmVeSWpSXmKPExsWy7djP87qNF39FGZw9ImKxccZ6VovpUy8w
        Wqye+pfVYv7juWwW589vYLe4vGsOm8WM8/uYLO7++8RosfPOCWYHTo+ds+6yexzZeYzNY/Ge
        l0wem1Z1snn0bVnF6PF5k1wAWxSXTUpqTmZZapG+XQJXxt/2K+wF9x0r3t/4yN7A+Mqki5GT
        Q0LARKJj3nGmLkYuDiGBFYwSh49eh3K+MEpMOH2EDcL5zCixcE8fI0zLlo2zoKqWM0o0Ll8E
        VfWeUWJHzxNWkCphAVuJ9i2ngBIcHCICMhLn9kWD1DAL7GWSOHjtFTNIDZuAoUTX2y6wGl4B
        O4l9DzhAwiwCqhKd+2cygdiiAjES0+ZdB7N5BQQlTs58wgJicwoYSFy9spQNxGYWkJfY/nYO
        M4QtLnHryXyw4yQEzrFLzN5+mRXiaheJ+28OsUPYwhKvjm+BsmUkTk/uYYGw6yX6vh+Bau5h
        lNjbMpUJImEtcfj4RVaQQ5kFNCXW79KHCNtKXN7ZxQwSlhDgk7jxVhDiBj6JSdumQ4V5JTra
        hCCq1SRmHV8Ht/XghUvMExiVZyH5bBaSb2Yh+WYWwt4FjCyrGMVTS4tz01OLjfNSy/WKE3OL
        S/PS9ZLzczcxAhPU6X/Hv+5g3Pcn6RCjAAejEg/vjhk/o4RYE8uKK3MPMUpwMCuJ8O42Agrx
        piRWVqUW5ccXleakFh9ilOZgURLnjdOoixISSE8sSc1OTS1ILYLJMnFwSjUwXtnwMpH3g9yj
        W18rqsx7TMxlfxeueNPqLfGCrekf2weJifcO/3f8EjCTvbLq0Q6uMOYPXnEidzen5s897vJ3
        HT+v4UO5XVP+rdUr1f79tqGA4bS6XERB8sPFSStq11zQmrjsnMS5ha6KFbERmh+djXvuxbo7
        rL12+XH/0eKfgrWBs/66S6wXUWIpzkg01GIuKk4EADrp5e9MAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xe7p1F39FGbRekLTYOGM9q8X0qRcY
        LVZP/ctqMf/xXDaL8+c3sFtc3jWHzWLG+X1MFnf/fWK02HnnBLMDp8fOWXfZPY7sPMbmsXjP
        SyaPTas62Tz6tqxi9Pi8SS6ALUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshU
        Sd/OJiU1J7MstUjfLkEv42/7FfaC+44V7298ZG9gfGXSxcjJISFgIrFl4yymLkYuDiGBpYwS
        X25eZ4dIyEicnNbACmELS/y51sUGUfSWUaLjegszSEJYwFaifcspoAQHhwhQw7l90SA1zAJ7
        mSTuLb3LCNFwjEXi4rd2RpAGNgFDia63XWANvAJ2EvsecICEWQRUJTr3z2QCsUUFYiR+HO1i
        AbF5BQQlTs58AmZzChhIXL2ylA3EZhYwk5i3+SEzhC0vsf3tHChbXOLWk/lMExiFZiFpn4Wk
        ZRaSlllIWhYwsqxiFEktLc5Nzy020itOzC0uzUvXS87P3cQIjMltx35u2cHY9S74EKMAB6MS
        D++OGT+jhFgTy4orcw8xSnAwK4nw7jYCCvGmJFZWpRblxxeV5qQWH2I0BXpuIrOUaHI+MF3k
        lcQbmhqaW1gamhubG5tZKInznjeojBISSE8sSc1OTS1ILYLpY+LglGpgdHk14cKUmeXn/y91
        fRu949U6x2NbN+mbfJpy6+vc3Tv3V217qjl51x/3Yy8vbFyw0vfzpritv9rmzH21/Uyj4901
        Ww8qlGyc/aXSdl/ih0Z5l9B/HXY2mmH3Hjv4tq385/dQtKrm42u18l79OyortjS+0vhUW79i
        0Y41G40bMkuTt2uw3nvSHbhSiaU4I9FQi7moOBEAAtuwOd8CAAA=
X-CMS-MailID: 20180515122431eucas1p13d52747049f0d72ffc8e072f5f4b8759
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180515122431eucas1p13d52747049f0d72ffc8e072f5f4b8759
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180508090407eucas1p13713284c2d3f5aa5c66f8d136be683c1
X-RootMTR: 20180508090407eucas1p13713284c2d3f5aa5c66f8d136be683c1
References: <CGME20180508090407eucas1p13713284c2d3f5aa5c66f8d136be683c1@eucas1p1.samsung.com>
        <2484918.HKVQc3yJkt@bear> <53b13d76-16a1-0e0a-09e1-c917e5d49326@samsung.com>
        <CAJz5OpcGX_3u5POExdhnBbRu-T-m7KodGAvk50BOfZWKeH--kg@mail.gmail.com>
        <182f50b9-55b6-c9ce-07fb-718a1d22e9c8@samsung.com>
        <CAJz5Opfqbj6waPrJ3gQsM50=StH_HHvsYySj7sqgeQcKtAVrHQ@mail.gmail.com>
        <eb17d6a7-a188-3ef4-2641-5fd588b16431@samsung.com>
        <CAJz5Opfd9zeEAShFtUNhW4yLfVykef=2QdWWzq88Dtddn4eymQ@mail.gmail.com>
        <06f54061-c537-b399-e493-ec2cdf4def5d@samsung.com>
        <20180515062144.GC13271@vkoul-mobl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On 2018-05-15 08:21, Vinod wrote:
> On 11-05-18, 14:57, Marek Szyprowski wrote:
>> On 2018-05-10 18:04, Frank Mori Hess wrote:
>>> On Thu, May 10, 2018 at 4:31 AM, Marek Szyprowski
>>> <m.szyprowski@samsung.com> wrote:
>>>> On 2018-05-09 19:48, Frank Mori Hess wrote:
>>>>> On Wed, May 9, 2018 at 9:19 AM, Marek Szyprowski
>>>>> <m.szyprowski@samsung.com> wrote:
>>>>>> I understand that pl330 doesn't support real PAUSE, but as it has been
>>>>>> implemented since 2015 the limited support is perfectly possible - just
>>>>>> to let serial driver to read the amount of data transferred.
>>>>>>
>>>>>> Please note that DMA engine documentation clearly states that the best
>>>>>> residue granularity the driver might expect is BURST granularity. There
>>>>>> is no way to get the information about the data which still sits in the
>>>>>> DMA engine fifo when transfer is paused/terminated. This means that
>>>>>> the serial driver should set maxburst = 1 if it is interested in
>>>>>> getting exact number of bytes received/sent. With maxburst = 1 there
>>>>>> is no such thing as data loose in the DMA engine fifo.
>>>>> That is not my understanding of the dmaengine pause requirements, but
>>>>> of course Vinod can speak authoritatively on this.
>>>> Basing on the comments in dma_residue_granularity enum documentation (see
>>>> include/linux/dmaengine.h) there is no better granularity of residue
>>>> reporting than BURST units. If driver needs byte accuracy, then it should
>>>> use MAXBURST=1 and DMA_SLAVE_BUSWIDTH_1_BYTE configuration.
>>> That's an interesting line of thought.  The 8250 serial driver clearly
>>> assumes it can do the sequence
>>>
>>> dma pause
>>> read residue
>>> dma terminate
>>>
>>> without data loss.
>> Right. From DMA engine API perspective this is the only valid way to
>> read the
>> residue when you terminate the transfer.
> Not really, API allows you to read any point of time, you may support it or not
> is different matter. Granularity of reporting is also a different point.

I mean to read the residue in stable conditions (the incoming bytes has 
been either
read by dma or still sits in the uart fifo). Too bad that it is not 
possible to read
residue after terminating the transfer. This would remove the need for 
this fake
pause support.

>>>     It checks for the capabilities
>>>
>>> cmd_pause
>>> cmd_terminate
>>> residue_granularity != DMA_RESIDUE_GRANULARITY_DESCRIPTOR
>> Checking for cmd_pause is a bit too strict, because cmd_pause means 'driver
>> supports both pause and resume', but the serial driver doesn't use resume at
>> all. A check for residue_granularity != DMA_RESIDUE_GRANULARITY_DESCRIPTOR
>> is on the other hand a bit too loose.
> thats true and it was added for audio which does pause/resume. If you feel it
> helps in serial to get pause & resume capabilities independently we can split
> them up, feel free to send a patch

Okay, I will prepare a patch for this.

> For Pause/resume data loss is _not_ expected.
>
>>> and some of the 8250 drivers like 8250_dw.c set a maxburst > 1.  If it
>>> can't count on the pause/residue/terminate working without data loss
>>> then it is just broken.  As is the 8250_omap.c driver.  Is the
>>> description of dmaengine_pause in the documentation of "This pauses
>>> activity on the DMA channel without data loss" to be interpreted as
>>> "as long as you resume afterwards"?
>> I assume that this requirement is for both - resuming and terminating.
> Terminate is abort, data loss may happen here.

Okay. Then it is up to the drivers to rely on this or not.

>>>>> I also don't agree
>>>>> that data loss cannot happen for single transfers.  It only becomes
>>>>> less likely since there are fewer bytes in the dma controller fifo and
>>>>> they stay there for a shorter period of time.  But even so, there is
>>>>> nothing stopping the DMAKILL from killing the transfer thread after it
>>>>> does a single byte load but before it does the associated single byte
>>>>> store, as they are performed by separate instructions.  As far as your
>>>>> serial port goes, the byte has been read by the host, even though it
>>>>> never made it to memory, so it is gone forever.  The dma-330 does have
>>>>> a load lock which prevents some operations from interrupting a
>>>>> load/store combination, but in my observations DMAKILL does not
>>>>> respect the load lock.
>>>> For the last 3 years no one observed any issue with the current design
>>>> (single transfers with DMA_SLAVE_BUSWIDTH_1_BYTE). By removing this
>>>> feature we will loose ability to use DMA in the serial drivers, what is
>>>> mainly useful for low-power bluetooth operation (serial console is really
>>>> negligible case).
>>> It's not surprising it hasn't been reported.  It is a race that
>>> requires a DMAKILL to be issued just as a byte is in-flight through
>>> the dma controller.  The only reason a driver would pause the
>>> un-resumeable pl330 would be because the driver either knows or
>>> suspects no more data will be arriving and it gives up on the
>>> transfer.  The only reason I noticed is we had a test which sent data
>>> to a serial port, waited just long enough for the serial port rx to
>>> timeout, then sent more data just as the pause was issuing DMAKILL.
>>> And then the test did this a few hundred thousand times until it
>>> noticed bad data.  Also, given the way 8250 rx timeouts work, a person
>>> typing into a serial console wouldn't type fast enough to trigger the
>>> bug unless the baud rate was set extremely low.  And if someone lost a
>>> keystroke every 10^5 bytes, who would blame the dma controller?
>> Like I already said, console is not a proper use case for serial dma.
>> The more appropriate is bluetooth and still, I'm not aware of the issue
>> with the current code.
> Why do you say serial is not important?

I mean that using DMA engine for uart/serial device for implementing only a
console support is a bit pointless, because typically console doesn't 
transfer
much data and overhead of using DMA mode (setting up dma engine) is bigger
than doing all the transfers in PIO mode.

>>> I do admit I didn't do this test using single transfers, because our
>>> goal was getting bursts to work.  Unfortunately, the test program
>>> relies on some custom hardware I no longer have access to so I can't
>>> easily re-run the test now.  However, since the DMA-330 manual
>>> documents the DMAKILL instruction to:
>>>
>>> "Remove all entries in the MFIFO for the DMA channel."
>>> "Remove all entries in the read buffer queue and write buffer queue
>>> for the DMA channel."
>>>
>>> Relying on it to work as a safe pause for single transfers seems like
>>> wishful thinking.  I sure didn't want to believe the DMA-330 couldn't
>>> be safely paused, but I eventually had to resign myself to it.
>> Okay, so you don't have any evidence that DMA transfers done in single
>> reads/writes is broken with the current cmd_pause implementation.
>>
>> This revert in fact at best disables DMA mode in the serial drivers (or
>> in worse case, i.e. Exynos, causes current drivers to do trashed
>> transfers due to lack of checking for the needed dma engine
>> capabilities).
>>
>> Maybe instead of reverting support for it, there should be a check for
>> BURST vs. SINGLE mode and we would keep the current implementation for
>> SINGLE transfers?
>>
>> Vinod, could you comment a bit this discussion from the DMA engine
>> maintainer perspective?
> So I will try to summarise here:
>
> - Pause/resume does not expect data loss
> - Status can be queried any point of time
> - Granularity reporting is upto device
> - To support a use case and device limitations it is okay to support only
>    singles.

What about the revert this thread is about? I would really like to have some
evidence of broken data in single transfer modes before removing 
functionality
that was present for years.

The discussed use case (pause+terminate) is crucial for serial devices at
least on Samsung SoCs and this revert break them.

Quick grep shows that PL330 is being used by a few other SoC families too,
but I didn't check if any of them use it for serial device.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
