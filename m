Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753090AbeEKM5v (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 08:57:51 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:42743 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752677AbeEKM5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 08:57:48 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180511125746euoutp01ff1073048ffc3e2de4e9218900eeb328~tmHKKisUs0039800398euoutp01t
X-AuditID: cbfec7f5-b45ff700000028a9-33-5af593492fef
Subject: Re: Revert "dmaengine: pl330: add DMA_PAUSE feature"
To: Frank Mori Hess <fmh6jj@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        r.baldyga@hackerion.com, Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <06f54061-c537-b399-e493-ec2cdf4def5d@samsung.com>
Date: Fri, 11 May 2018 14:57:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAJz5Opfd9zeEAShFtUNhW4yLfVykef=2QdWWzq88Dtddn4eymQ@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRmVeSWpSXmKPExsWy7djP87qek79GGdz9LGixccZ6VovpUy8w
        Wqye+pfVYv7juWwW589vYLe4vGsOm8WM8/uYLO7++8RosfPOCWYHTo+ds+6yexzZeYzNY/Ge
        l0wem1Z1snn0bVnF6PF5k1wAWxSXTUpqTmZZapG+XQJXxv35CQXHDSpmPtvO3sDYqN7FyMkh
        IWAi0f77PnMXIxeHkMAKRomWo4vZQBJCAl8YJbbcc4dIfGaUePFkKitMx/61txkhEssZJfZP
        aWaCcN4zSnx5/YMJpEpYwFaifcspsFEiAmoSG7YfZAEpYhbYwSSx/PYXRpAEm4ChRNfbLrAi
        XgE7iYVLZgAVcXCwCKhK7DmhAxIWFYiRmDbvOhNEiaDEyZlPWEBsToFAia9zj4BdxCwgL7H9
        7RxmCFtc4taT+WAHSQgcY5dY/OcV1NkuEv+OvGWCsIUlXh3fwg5hy0icntzDAmHXS/R9PwLV
        3MMosbdlKlSDtcTh4xdZQY5jFtCUWL9LHyJsK3Gt/xMzSFhCgE/ixltBiBv4JCZtmw4V5pXo
        aBOCqFaTmHV8HdzWgxcuMU9gVJ6F5LNZSL6ZheSbWQh7FzCyrGIUTy0tzk1PLTbOSy3XK07M
        LS7NS9dLzs/dxAhMT6f/Hf+6g3Hfn6RDjAIcjEo8vAVxX6KEWBPLiitzDzFKcDArifDuWwEU
        4k1JrKxKLcqPLyrNSS0+xCjNwaIkzhunURclJJCeWJKanZpakFoEk2Xi4JRqYHS68tDcQSO/
        4U+n4cOLirbbQlXPadbmPGieemaaUp3Y/5PPBf6KZT1i/Z+/KO2RzvNri6YHpyb6TOdQDVG9
        oV3406s+23XZFy6Vk/JHHTmnOCxvvh7m+un4K62H9zI3fjjeO6E46OyMIu5tphbzHI7N+NSh
        mClpfuFiZXTurUy2p4VVos2axkosxRmJhlrMRcWJAG9P0JlLAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsVy+t/xe7oek79GGeybwGexccZ6VovpUy8w
        Wqye+pfVYv7juWwW589vYLe4vGsOm8WM8/uYLO7++8RosfPOCWYHTo+ds+6yexzZeYzNY/Ge
        l0wem1Z1snn0bVnF6PF5k1wAW5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGp
        kr6dTUpqTmZZapG+XYJexv35CQXHDSpmPtvO3sDYqN7FyMkhIWAisX/tbcYuRi4OIYGljBKn
        p91nhEjISJyc1sAKYQtL/LnWxQZiCwm8ZZTY/7oaxBYWsJVo33IKLC4ioCaxYftBFpBBzAI7
        mCQ2H54F1fCaWeLBwiwQm03AUKLrLcQgXgE7iYVLZgA1cHCwCKhK7DmhAxIWFYiR+HG0iwWi
        RFDi5MwnYDanQKDE17lHwO5hFjCTmLf5ITOELS+x/e0cKFtc4taT+UwTGIVmIWmfhaRlFpKW
        WUhaFjCyrGIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAiMx23Hfm7Zwdj1LvgQowAHoxIPb0Hc
        lygh1sSy4srcQ4wSHMxKIrz7VgCFeFMSK6tSi/Lji0pzUosPMZoC/TaRWUo0OR+YKvJK4g1N
        Dc0tLA3Njc2NzSyUxHnPG1RGCQmkJ5akZqemFqQWwfQxcXBKNTBaNSq9sk785b5zjj3PMRb5
        VUpqSyNOHZy74PBqhi/pSw//OWaypiP/T8utJZVZCqIP9Xe3N3rZdE5cfS+Eb+9MhcIvilI7
        7XZVOO14pHZ8NYc9f1z8xjcz1ZROCEyIWqJjorT1ukPB+uOCWz6xXv5isvDWnHK/m2WbT/8N
        /fCiKt1yWen1uQxhSizFGYmGWsxFxYkAd0nFu90CAAA=
X-CMS-MailID: 20180511125744eucas1p1d61fdc9709033179b915390dfe1019e4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180511125744eucas1p1d61fdc9709033179b915390dfe1019e4
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
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

On 2018-05-10 18:04, Frank Mori Hess wrote:
> On Thu, May 10, 2018 at 4:31 AM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> On 2018-05-09 19:48, Frank Mori Hess wrote:
>>> On Wed, May 9, 2018 at 9:19 AM, Marek Szyprowski
>>> <m.szyprowski@samsung.com> wrote:
>>>> I understand that pl330 doesn't support real PAUSE, but as it has been
>>>> implemented since 2015 the limited support is perfectly possible - just
>>>> to let serial driver to read the amount of data transferred.
>>>>
>>>> Please note that DMA engine documentation clearly states that the best
>>>> residue granularity the driver might expect is BURST granularity. There
>>>> is no way to get the information about the data which still sits in the
>>>> DMA engine fifo when transfer is paused/terminated. This means that
>>>> the serial driver should set maxburst = 1 if it is interested in
>>>> getting exact number of bytes received/sent. With maxburst = 1 there
>>>> is no such thing as data loose in the DMA engine fifo.
>>> That is not my understanding of the dmaengine pause requirements, but
>>> of course Vinod can speak authoritatively on this.
>> Basing on the comments in dma_residue_granularity enum documentation (see
>> include/linux/dmaengine.h) there is no better granularity of residue
>> reporting than BURST units. If driver needs byte accuracy, then it should
>> use MAXBURST=1 and DMA_SLAVE_BUSWIDTH_1_BYTE configuration.
> That's an interesting line of thought.  The 8250 serial driver clearly
> assumes it can do the sequence
>
> dma pause
> read residue
> dma terminate
>
> without data loss.

Right. From DMA engine API perspective this is the only valid way to 
read the
residue when you terminate the transfer.

>    It checks for the capabilities
>
> cmd_pause
> cmd_terminate
> residue_granularity != DMA_RESIDUE_GRANULARITY_DESCRIPTOR

Checking for cmd_pause is a bit too strict, because cmd_pause means 'driver
supports both pause and resume', but the serial driver doesn't use resume at
all. A check for residue_granularity != DMA_RESIDUE_GRANULARITY_DESCRIPTOR
is on the other hand a bit too loose.

> and some of the 8250 drivers like 8250_dw.c set a maxburst > 1.  If it
> can't count on the pause/residue/terminate working without data loss
> then it is just broken.  As is the 8250_omap.c driver.  Is the
> description of dmaengine_pause in the documentation of "This pauses
> activity on the DMA channel without data loss" to be interpreted as
> "as long as you resume afterwards"?

I assume that this requirement is for both - resuming and terminating.

>>> I also don't agree
>>> that data loss cannot happen for single transfers.  It only becomes
>>> less likely since there are fewer bytes in the dma controller fifo and
>>> they stay there for a shorter period of time.  But even so, there is
>>> nothing stopping the DMAKILL from killing the transfer thread after it
>>> does a single byte load but before it does the associated single byte
>>> store, as they are performed by separate instructions.  As far as your
>>> serial port goes, the byte has been read by the host, even though it
>>> never made it to memory, so it is gone forever.  The dma-330 does have
>>> a load lock which prevents some operations from interrupting a
>>> load/store combination, but in my observations DMAKILL does not
>>> respect the load lock.
>> For the last 3 years no one observed any issue with the current design
>> (single transfers with DMA_SLAVE_BUSWIDTH_1_BYTE). By removing this
>> feature we will loose ability to use DMA in the serial drivers, what is
>> mainly useful for low-power bluetooth operation (serial console is really
>> negligible case).
> It's not surprising it hasn't been reported.  It is a race that
> requires a DMAKILL to be issued just as a byte is in-flight through
> the dma controller.  The only reason a driver would pause the
> un-resumeable pl330 would be because the driver either knows or
> suspects no more data will be arriving and it gives up on the
> transfer.  The only reason I noticed is we had a test which sent data
> to a serial port, waited just long enough for the serial port rx to
> timeout, then sent more data just as the pause was issuing DMAKILL.
> And then the test did this a few hundred thousand times until it
> noticed bad data.  Also, given the way 8250 rx timeouts work, a person
> typing into a serial console wouldn't type fast enough to trigger the
> bug unless the baud rate was set extremely low.  And if someone lost a
> keystroke every 10^5 bytes, who would blame the dma controller?

Like I already said, console is not a proper use case for serial dma.
The more appropriate is bluetooth and still, I'm not aware of the issue
with the current code.

> I do admit I didn't do this test using single transfers, because our
> goal was getting bursts to work.  Unfortunately, the test program
> relies on some custom hardware I no longer have access to so I can't
> easily re-run the test now.  However, since the DMA-330 manual
> documents the DMAKILL instruction to:
>
> "Remove all entries in the MFIFO for the DMA channel."
> "Remove all entries in the read buffer queue and write buffer queue
> for the DMA channel."
>
> Relying on it to work as a safe pause for single transfers seems like
> wishful thinking.  I sure didn't want to believe the DMA-330 couldn't
> be safely paused, but I eventually had to resign myself to it.

Okay, so you don't have any evidence that DMA transfers done in single
reads/writes is broken with the current cmd_pause implementation.

This revert in fact at best disables DMA mode in the serial drivers (or
in worse case, i.e. Exynos, causes current drivers to do trashed
transfers due to lack of checking for the needed dma engine
capabilities).

Maybe instead of reverting support for it, there should be a check for
BURST vs. SINGLE mode and we would keep the current implementation for
SINGLE transfers?

Vinod, could you comment a bit this discussion from the DMA engine
maintainer perspective?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
