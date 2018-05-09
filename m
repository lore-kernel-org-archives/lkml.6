Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935281AbeEINTf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 09:19:35 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45428 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935192AbeEINTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 09:19:30 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180509131928euoutp01d442c915179277568679a97595d49596~s-HiivVBn1989719897euoutp01O
X-AuditID: cbfec7f4-6f9ff700000043e4-90-5af2f55f1a72
Subject: Re: Revert "dmaengine: pl330: add DMA_PAUSE feature"
To: Frank Mori Hess <fmh6jj@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        r.baldyga@hackerion.com, Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "'Linux Samsung SOC'" <linux-samsung-soc@vger.kernel.org>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <182f50b9-55b6-c9ce-07fb-718a1d22e9c8@samsung.com>
Date: Wed, 9 May 2018 15:19:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAJz5OpcGX_3u5POExdhnBbRu-T-m7KodGAvk50BOfZWKeH--kg@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNKsWRmVeSWpSXmKPExsWy7djP87rxXz9FGTyeLGSxccZ6VovpUy8w
        Wqye+pfVYv7juWwW589vYLe4vGsOm8WM8/uYLO7++8RosfPOCWYHTo+ds+6yexzZeYzNY/Ge
        l0wem1Z1snn0bVnF6PF5k1wAWxSXTUpqTmZZapG+XQJXxpklF9gL+jUqLrV+YWlgXK3QxcjJ
        ISFgInFg5lWmLkYuDiGBFYwSR/ZegXK+MEosObGYDcL5zCixZs9cdpiW+3MOsUAkljNKLJq5
        Esp5zyhxfv0xJpAqYQFbifYtp9hAbBEBNYkN2w+CFTEL7GKSWDr7EFgRm4ChRNfbLrAiXgE7
        iXuPT7KA2CwCKhIPn+5jBbFFBWIkps27zgRRIyhxcuYTsBpOgUCJl/M2MoPYzALyEs1bZ0PZ
        4hK3nswHe0JC4BS7xMGdG1kh7naR2NyzgBHCFpZ4dXwL1D8yEv93zmeCsOsl+r4fgWruYZTY
        2zIVKmEtcfj4RaBBHEAbNCXW79KHCNtKXJ50DCwsIcAnceOtIMQNfBKTtk1nhgjzSnS0CUFU
        q0nMOr4ObuvBC5eYJzAqz0Ly2Swk38xC8s0shL0LGFlWMYqnlhbnpqcWG+WllusVJ+YWl+al
        6yXn525iBCap0/+Of9nBuOtP0iFGAQ5GJR5eiZ0fo4RYE8uKK3MPMUpwMCuJ8P5/8ClKiDcl
        sbIqtSg/vqg0J7X4EKM0B4uSOG+cRl2UkEB6YklqdmpqQWoRTJaJg1OqgTG8d+HEP0WTgl7+
        +yxh//YJi9wZdXvr6w9OfhJJzeUyaYq/WJzFlhKWtWuqzyo9U6kAvqiXkzxCXJ9U6y1KnNvx
        wWJjpuYpsTN/9p+NnZ1mZl8c1NMkXiPXcXHj7LOxVXmn/HOs1G/sZ/9W4Hkl7E+z2Cb/b5Vp
        q69tr9tpb6bt+C/iCEefnhJLcUaioRZzUXEiANwradtOAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsVy+t/xe7pxXz9FGUzbJGWxccZ6VovpUy8w
        Wqye+pfVYv7juWwW589vYLe4vGsOm8WM8/uYLO7++8RosfPOCWYHTo+ds+6yexzZeYzNY/Ge
        l0wem1Z1snn0bVnF6PF5k1wAW5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGp
        kr6dTUpqTmZZapG+XYJexpklF9gL+jUqLrV+YWlgXK3QxcjJISFgInF/ziGWLkYuDiGBpYwS
        /8/cZYFIyEicnNbACmELS/y51sUGUfSWUeLTnV9gRcICthLtW06xgdgiAmoSG7YfBJvELLCL
        SaJ1wgkmiI7PjBIz759gB6liEzCU6HrbBdbBK2Ance/xSbBJLAIqEg+f7gNbJyoQI/HjaBcL
        RI2gxMmZT8BsToFAiZfzNjKD2MwCZhLzNj+EsuUlmrfOhrLFJW49mc80gVFoFpL2WUhaZiFp
        mYWkZQEjyypGkdTS4tz03GIjveLE3OLSvHS95PzcTYzAuNx27OeWHYxd74IPMQpwMCrx8Bbs
        /hglxJpYVlyZe4hRgoNZSYT3/4NPUUK8KYmVValF+fFFpTmpxYcYTYGem8gsJZqcD0wZeSXx
        hqaG5haWhubG5sZmFkrivOcNKqOEBNITS1KzU1MLUotg+pg4OKUaGLcvcaqdeUlv65FNRZML
        7L1S5jVe0RHNLXVlSYly/dLy5tSWgmd71/tsXX7L81Xs009WTioyq6/t73zxuGX6jrrvGz0W
        FJeEJRtMFYsWlGKSizi47fuvF7x3pRynzBZpWRd7YSfjLdeXL/dvP80pce6V997w/909Zm7u
        c7W1Qvt/tinZv5IW6VBiKc5INNRiLipOBAAvjfUH4QIAAA==
X-CMS-MailID: 20180509131926eucas1p1e8701e38323a484e122e40194cffb3d3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180509131926eucas1p1e8701e38323a484e122e40194cffb3d3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180508090407eucas1p13713284c2d3f5aa5c66f8d136be683c1
X-RootMTR: 20180508090407eucas1p13713284c2d3f5aa5c66f8d136be683c1
References: <CGME20180508090407eucas1p13713284c2d3f5aa5c66f8d136be683c1@eucas1p1.samsung.com>
        <2484918.HKVQc3yJkt@bear> <53b13d76-16a1-0e0a-09e1-c917e5d49326@samsung.com>
        <CAJz5OpcGX_3u5POExdhnBbRu-T-m7KodGAvk50BOfZWKeH--kg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

On 2018-05-08 16:36, Frank Mori Hess wrote:
> On Tue, May 8, 2018 at 5:04 AM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> Hi Frank and Vinod,
>>
>> On 2018-04-28 23:50, Frank Mori Hess wrote:
>>> This reverts commit 88987d2c7534a0269f567fb101e6d71a08f0f01d.
>>>
>>> The pl330.c pause implementation violates the dmaengine requirement
>>> for no data loss, since it relies on the DMAKILL
>>> instruction.  However, DMAKILL discards in-flight data from the
>>> dma controller's fifo.  This is documented in the dma-330 manual
>>> and I have observed it with hardware doing device-to-memory burst
>>> transfers.  The discarded data may or may not show up in the
>>> residue count, depending on timing (resulting in data corruption
>>> effectively).
>>>
>>> Signed-off-by: Frank Mori Hess <fmh6jj@gmail.com>
>> This revert completely breaks serial driver operation on almost all Exynos
>> SoCs, because serial driver relies on having PAUSE feature and proper
>> residue reporting from dma engine. Please drop it if possible.
>>
> It will cause the serial driver to not use the pl330.c driver for dma,
> the serial driver will fall back on using the cpu.  This is
> unfortunate, but the dma hardware simply does not support pause.

I understand that pl330 doesn't support real PAUSE, but as it has been
implemented since 2015 the limited support is perfectly possible - just
to let serial driver to read the amount of data transferred.

Please note that DMA engine documentation clearly states that the best
residue granularity the driver might expect is BURST granularity. There
is no way to get the information about the data which still sits in the
DMA engine fifo when transfer is paused/terminated. This means that
the serial driver should set maxburst = 1 if it is interested in
getting exact number of bytes received/sent. With maxburst = 1 there
is no such thing as data loose in the DMA engine fifo.

This also means that there is no valid reason to revert the Robert's
commit. This is how this API works, so please don't break things which
worked for years.

I did some further research and indeed there are some other issues with
both pl330 driver and Samsung SoC serial driver:
1. pl330 incorrectly reported that it supports SEGMENT residue granularity
    instead of BURST granularity, but Samsung serial driver didn't check
    it.
2. Samsung driver incorrectly set src_maxburst to 16, what might result
    in lost data if dma engine does real burst transfers
3. Samsung driver doesn't check if DMA engine supports PAUSE feature and
    proper residue reporting granularity, so your revert simply breaks its
    operation.

Please note that till now everything worked fine a bit by luck, because
the pl330 driver didn't implement peripheral burst transfers and ignored
(incorrectly) configured maxburst.

I've checked other device drivers, which use pl330 DMA on Samsung SoCs and
besides serial, none of them configure maxburst > 1. When I forced such
configuration, none worked fine. I'm a bit confused what does it mean.
Either none of the Samsung SoC integrated peripherals support real burst
DMA transfers, or the PL330 in Samsung SoCs are somehow limited or
dysfunctional. There is already a quirk in pl330 for broken FLUSHP, but I
have no idea how to diagnose if this is the case or the problem is in the
SoC peripherals. I can live with maxburst set to 1 in those drivers as the
proper fix.

> The
> "nice" stop instruction DMAEND is not allowed to be inserted using the
> debug instruction register.  The only possibility for implementing
> pause would be to make the dma transfer do a DMAWFE (wait for event)
> before every transfer.  Then you would need to devote another dma
> thread to doing nothing but DMASEV (send event) to keep the transfer
> going.  The pause could then DMAKILL the event-generating thread
> rather than the transfer thread.  I don't know exactly what the
> performance impact would be, but it couldn't be good.

I agree that it doesn't make sense to implement real PAUSE with such high
cost.

> The serial driver could be modified to still use dma for TX, since it
> only needs pause for RX.  Also, if your serial hardware can report
> exactly how many bytes it has sitting in its rx fifo, the serial
> driver could be modified to use pause-less dma for RX.  This is
> actually what I did for the custom serial hardware I'm using with a
> dma-330, although our serial hardware has a very large rx fifo which
> makes this scheme worthwhile.

When the serial driver fifo size is 16 bytes, it doesn't really make any
sense to use DMA with such limited approach. The maxburst = 1 and proper
residue reporting is the only sane solution in such case.

On the other hand, if you have large fifo in serial driver then it still
MIGHT be faster to read all the fifo content with CPU instead of setting
up DMA engine/pl330 structures... One need to benchmark it on the real
hardware to decide.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
