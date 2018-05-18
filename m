Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752322AbeERG2W (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 02:28:22 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49433 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751672AbeERG2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 02:28:20 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180518062818euoutp01aed4428ec924e1085b3933e9e1e8be45~vqUGowQ_Z1114211142euoutp019
X-AuditID: cbfec7f5-b5fff700000028a9-c9-5afe72807357
Subject: Re: Revert "dmaengine: pl330: add DMA_PAUSE feature"
To: Vinod <vkoul@kernel.org>, Frank Mori Hess <fmh6jj@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>, r.baldyga@hackerion.com,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <7f0b7404-ee12-977f-02a4-a463d1873aee@samsung.com>
Date: Fri, 18 May 2018 08:28:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180518040349.GB2932@vkoul-mobl>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRjld+92dzea3Ka2D1cZi6KCfFDCxVL8o2j2R0R/GAwzb3lRaU7Z
        nGWljR6WQ1QsU+erF2WmqcPMmRk+2ErRqT0Ua2ZoScEU05TMR253lv+d75zzcc4HH4lLXvB9
        yHh1MqtRMyo5IeI1WH737NZrlpQB1gVfuq6whk8X5Pci+kn+Ip8uHy0laJutVkC/bSoh6EJb
        C0bbl34i2vzpNR4mVJiNdoGiw2whFPebv2MKU2Umociur0SKadPmo4RStD+GVcWnsBr/0GhR
        XMW1cizJBucem8b5emTxNCAhCdReaMzL5RuQiJRQFQimvlW4hxkEBaMGxA3TCIbnyojVle4B
        PcEJjxBUTFS7XZMICj8O4U6XJxUC1+s7XRteVBjY5gcwpwmnCjDIH/nMdwoEFQgGh8FlElOh
        kHPLijkxj9oG1Z0WF+9NRcLtsgGM86yHN0VjPCcWUv7wp6PHxeOULzx3lOAclsLQWLkrDCiL
        AL7aqty9D8Czjmwehz3hh7VewOGN0HUzy81fguy5DvdyFoKXV/MxTtgH7da+ldbkSsJOqGny
        5+gQ+NI3K3DSQHnAoGM918ED8hoKcI4Ww40MCefeDkbr03+prb39eC7aalxzmXHNNcY11xj/
        595BvEokZXXahFhWu0fNnvXTMglanTrW73RiggmtvFTXkvVXI2pZONWGKBLJ14lzcxaVEj6T
        ok1NaENA4nIvcXDQklIijmFSz7OaxJManYrVtiEZyZNLxVE70pUSKpZJZs+wbBKrWVUxUuij
        R+1VmyKi0+yz+nnyQtFyt0eAP6NqTLdLpwL0h2sjRpavzHo3peWoMw+hvGOGu8cH390rlU4t
        ZxrJkeG02YMNk6AWPrhYd7k5SiolT0g/eM/ZH86EM9ir1owgR837LbLJCXOcF0rxDo4kNsj6
        iyNjbcVWk4dsRhc+foQylAbIedo4JnAXrtEyfwHmyZfTTgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsVy+t/xe7r1Rf+iDFa8UbTYOGM9q8X0qRcY
        LVZP/ctqMf/xXDaL8+c3sFtc3jWHzWLG+X1MFnf/fWK02HnnBLMDp8fOWXfZPY7sPMbmsXjP
        SyaPTas62Tz6tqxi9Pi8SS6ALUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshU
        Sd/OJiU1J7MstUjfLkEvY0XrfKaC8xIVKzc9Z21gPCbcxcjJISFgInH2egNbFyMXh5DAUkaJ
        KS/PMkEkZCROTmtghbCFJf5c64Iqesso8fbhN0aQhLCArUT7llNsILaIgIPE+V/XmUCKmAVm
        MkksOboJbJKQwAVWiZXzJEBsNgFDia63XWANvAJ2Ev1TjoPVsAioSqw9dQwsLioQI/HjaBcL
        RI2gxMmZT8BsTgF9id9HzoHVMwuYSczb/JAZwpaX2P52DpQtLnHryXymCYxCs5C0z0LSMgtJ
        yywkLQsYWVYxiqSWFuem5xYb6hUn5haX5qXrJefnbmIERuW2Yz8372C8tDH4EKMAB6MSD++L
        iX+jhFgTy4orcw8xSnAwK4nwWpn+ixLiTUmsrEotyo8vKs1JLT7EaAr03ERmKdHkfGDCyCuJ
        NzQ1NLewNDQ3Njc2s1AS5z1vUBklJJCeWJKanZpakFoE08fEwSnVwDjpfuTtj9sNhPco6yj9
        zrngxZyZ9MHBfIpV3I/6My96yjNSn/QHLNebu+5fzy9Hg1jjLpfYNrGbDy8d/HsztmKCnH7l
        bHuJvDqvqXWWaS4ZZsuiT7HkWB9dYV3PcCOf1WG1j+y/K/oBwice+7+rcTdqvbSk8fRNp3ty
        ZbFxukvKTptGGD2YrsRSnJFoqMVcVJwIAEeSIpjgAgAA
X-CMS-MailID: 20180518062815eucas1p10e1a213f6ceb84ca1e2ab16b0938a8cd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180518062815eucas1p10e1a213f6ceb84ca1e2ab16b0938a8cd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180518040358epcas2p353b0096d33116ca78a03b16d24569813
X-RootMTR: 20180518040358epcas2p353b0096d33116ca78a03b16d24569813
References: <CAJz5OpcGX_3u5POExdhnBbRu-T-m7KodGAvk50BOfZWKeH--kg@mail.gmail.com>
        <182f50b9-55b6-c9ce-07fb-718a1d22e9c8@samsung.com>
        <CAJz5Opfqbj6waPrJ3gQsM50=StH_HHvsYySj7sqgeQcKtAVrHQ@mail.gmail.com>
        <eb17d6a7-a188-3ef4-2641-5fd588b16431@samsung.com>
        <CAJz5Opfd9zeEAShFtUNhW4yLfVykef=2QdWWzq88Dtddn4eymQ@mail.gmail.com>
        <06f54061-c537-b399-e493-ec2cdf4def5d@samsung.com>
        <20180515062144.GC13271@vkoul-mobl>
        <CAJz5Open++Dj=a4ty-JbnZBFoqbMQKU6qYumJKSRMRLp_3erSw@mail.gmail.com>
        <20180517041946.GQ13271@vkoul-mobl>
        <CAJz5Opfep+TL0k_3kG7uQc_nU-BdFy1wsD1jo1agwtSvw0JibQ@mail.gmail.com>
        <CGME20180518040358epcas2p353b0096d33116ca78a03b16d24569813@epcas2p3.samsung.com>
        <20180518040349.GB2932@vkoul-mobl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On 2018-05-18 06:03, Vinod wrote:
> On 17-05-18, 12:20, Frank Mori Hess wrote:
>> Sorry to keep coming back to this, but I'm experiencing a bit of
>> incredulity that you are saying what you seem to be saying.  You seem
>> to be saying dmaengine provides no way to permanently stop a transfer
>> safely other than transferring the full number of bytes initially
>> requested.  So the proper resolution is the 8250 serial driver needs
>> to remove rx dma support, because they are just trying to do something
>> that is not supported.

...

>> I see two ways of interpreting what you are saying. First, from the
>> point of view of the user of the dmaengine api.  From this point of
>> view it is impossible for data loss to occur during pause or reading
>> the residue, so saying they cause no data loss during
>> pause/residue/terminate is meaningless.  This is because the user
>> can't confirm any data loss until after they have read the residue and
>> the transfer is terminated, since optimistically the data may still be
>> available if only the user would resume and allow the transfer to
>> continue.
>>
>> Second there is the interpretation I want to believe.  This is "no
>> data loss on pause" means that after the pause, no data has been
>> discarded by the dma controller hardware, in fact all the data it has
>> read before being paused has been fully transferred to its
>> destination.  Reading the residue while paused gives you an accurate,
>> up-to-date state of the paused transfer.  Then finally, although in
>> general dma terminate causes data loss, it does not in this case since
>> we terminated while we were paused and read the up-to-date residue.
>> This is the interpretation implicit in the 8250 serial driver.
> You are simply mixing things up! On Pause we don't expect data loss, as user can
> resume the transfer. This means as you rightly guessed, the DMA HW should not drop
> any data, nor should SW.
>
> Now if you want to read residue at this point it is perfectly valid. But if you
> decide to terminate the channel (yes it is terminate_all API), we abort and don't
> have context to report back!
>
> As Lars rightly pointed out, residue calculation are very tricky, DMA fifo may
> have data, some data may be in device FIFO, so residue is always from DMA point
> of view and may differ from device view (more or less depending upon direction)
>
> Now if you require to add more features for your usecase, please do feel free to
> send a patch. The framework can always be improved, we haven't solved world
> hunger yet!

Okay, I see that in theory, there are some tricky bits in implementing DMA
support in UART drivers. On the other hand there are already drivers 
with seems
to be working fine. This discussion is about revert of the feature 
present in
pl330 driver, which is required by other in-kernel driver without proper 
fix to
them.

Can we drop it for now and discuss what and how should be implemented to 
make
everyone happy, without any regressions?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
