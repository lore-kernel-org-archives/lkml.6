Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754139AbeDMJ3G (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 05:29:06 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:16877 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753588AbeDMJ3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 05:29:04 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180413092902epoutp0219f0f0b528cf6d3231e371cb654aff6b~k9M6y1f6m0993009930epoutp02O
X-AuditID: b6c32a48-8c1ff70000000ff2-93-5ad0785ea8dc
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "Li, Philip" <philip.li@intel.com>
Subject: Re: [GIT PULL] Thermal management updates for v4.17-rc1
Date: Fri, 13 Apr 2018 11:28:56 +0200
Message-id: <4212243.RcCUWlsaar@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <16cbc915-ad89-7bab-c644-8086cfef082f@linaro.org>
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsWy7bCmqW5cxYUog4e7eCzmfZa1mH/lGqvF
        5V1z2Cw+9x5htLh06CKTxZOHfWwWj/resjuwe+ycdZfdY/Gel0wed67tYfM4MeM3i8fnTXIB
        rFFcNimpOZllqUX6dglcGe2tHawF16UrZkyYytjAeF60i5GTQ0LAROLLtY+sXYxcHEICOxgl
        LtyZwAjhfGeU+HjtPztMVXcvTGIDo8SHC83MEM5XRonGeR+YQarYBKwkJravYgSxRQT0JBrf
        tzGB2MwCXxglHt7kB7GFBRwkGjZcYwGxWQRUJU6dmgDUy8HBK6ApcfYOL0hYVMBLYsu+drBW
        TgE7idcP34GN5BUQlPgx+R4LxEhtiSfvLrBC2JoSL75MYgG5R0LgCJvE4a07WCCudpE4PesI
        K4QtLPHq+Baob6Qlnq3ayAjR0Mwo8W3HHmaIxARGiT3rhSBsa4nDxy9CbeCT6Dj8lx3kUAkB
        XomONqgSD4mpy5dBzXeUeLFgEjskUG4wSkxfcJhlAqPsLCSHz0Jy+Cwkhy9gZF7FKJZaUJyb
        nlpsVGCiV5yYW1yal66XnJ+7iRGcJLQ8djAeOOdziFGAg1GJh1eh8nyUEGtiWXFl7iFGCQ5m
        JRHemwUXooR4UxIrq1KL8uOLSnNSiw8xSnOwKInzNvieiRISSE8sSc1OTS1ILYLJMnFwSjUw
        nn1vWMXtXrVbgsGxefZeXrbV1kUK0377XRacO61A9fhSw/r8fPe4uMKq7w9+Sh5R8Mjg4Dim
        OHfORf0/3ycHatv+3PpUoy1cSD9jiQ/PrbRJ0+51PVXmXyzm1BZx7v+vrp5mVr+/6UGnn1ie
        UNC9eK83Je2szbFAm/lVZvmt3T+kO9quiC1WYinOSDTUYi4qTgQA0LLjwQ4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsVy+t9jQd3YigtRBtM+aFrM+yxrMf/KNVaL
        y7vmsFl87j3CaHHp0EUmiycP+9gsHvW9ZXdg99g56y67x+I9L5k87lzbw+ZxYsZvFo/Pm+QC
        WKO4bFJSczLLUov07RK4MtpbO1gLrktXzJgwlbGB8bxoFyMnh4SAiUR37wTGLkYuDiGBdYwS
        px5Ng3K+Mkq0LD3PClLFJmAlMbF9FSOILSKgJ9H4vo0JpIhZ4AujxOIDe8CKhAUcJBo2XGMB
        sVkEVCVOnZrA3MXIwcEroClx9g4vSFhUwEtiy752JhCbU8BO4vXDd1DLmhglvk2YCzaHV0BQ
        4sfke2BzmAW0JZ68u8AKModZQF1iypTcCYz8s5BUzUJSNQuhagEj8ypGydSC4tz03GKjAqO8
        1HK94sTc4tK8dL3k/NxNjMCQ3nZYq38H4+Ml8YcYBTgYlXh4FSrPRwmxJpYVV+YeYpTgYFYS
        4b1ZcCFKiDclsbIqtSg/vqg0J7X4EKM0B4uSOC9//rFIIYH0xJLU7NTUgtQimCwTB6dUA6PR
        4oaVnfYXO0/MmzVhRe7d8w+kp4ZK1Kx9+91b+JqAWbI1xyMPEzWTdSddXype+qxfbclYJXee
        wfPe8cDjRre4Ps5adyz56UweVYOzuzJuME9hSHsWY3f0fW/uCqFrFtWHT66IF2aY9zv/RfC9
        Zefln9Sk1dya8oi7pf29xsMO7riDi98zX16kxFKckWioxVxUnAgAdoHHzWUCAAA=
X-CMS-MailID: 20180413092901epcas2p43245301152a01c782620f0ab95b2a692
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180413092901epcas2p43245301152a01c782620f0ab95b2a692
X-RootMTR: 20180413092901epcas2p43245301152a01c782620f0ab95b2a692
References: <1523436077.16235.5.camel@intel.com>
        <3546651.LUmDXQgY88@amdc3058>
        <16cbc915-ad89-7bab-c644-8086cfef082f@linaro.org>
        <CGME20180413092901epcas2p43245301152a01c782620f0ab95b2a692@epcas2p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3D9TCvN019454

On Friday, April 13, 2018 11:19:40 AM Daniel Lezcano wrote:
> On 13/04/2018 11:08, Bartlomiej Zolnierkiewicz wrote:
> > On Friday, April 13, 2018 11:00:43 AM Daniel Lezcano wrote:
> >> On 13/04/2018 10:55, Bartlomiej Zolnierkiewicz wrote:
> >>> On Friday, April 13, 2018 01:39:05 PM Zhang Rui wrote:
> >>>> Hi, Eduardo,
> >>>>
> >>>> On 四, 2018-04-12 at 21:08 -0700, Eduardo Valentin wrote:
> >>>>> Hello,
> >>>>>
> >>>>> On Thu, Apr 12, 2018 at 09:55:19AM -0700, Linus Torvalds wrote:
> >>>>>>
> >>>>>> On Wed, Apr 11, 2018 at 10:08 PM, Zhang Rui <rui.zhang@intel.com>
> >>>>>> wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>> could you please illustrate me what the kconfig & warning is?
> >>>>>> Just "make allmodconfig" and the warning is about a uninitialized
> >>>>>> variable.
> >>>>>>
> >>>>>> Line 304 in drivers/thermal/samsung/exynos_tmu.c if my shell
> >>>>>> history
> >>>>>> is to be believed.
> >>>>>>
> >>>>>>                 Linus
> >>>>> Yeah, this has also passed my local compilation error. Somehow my
> >>>>> gcc4.9
> >>>>> is not catching it. Using an older gcc (gcc4.6) does catch it.
> >>>>>
> >>>>> Anyways, given that the conversion functions are written to cover
> >>>>> for unexpected cal_type, the right way of fixing this is to rewrite
> >>>>> the conversion functions to allow for returning error codes and
> >>>>> adjusting the callers as expected.
> >>>>>
> >>>>> Rui, bzolnier, please consider the following fix:
> >>>>>
> >>>> as it is late in this merge window, I'd prefer to
> >>>> 1. drop all the thermal-soc material in the first pull request which I
> >>>> will send out soon.
> >>>> 2. you can prepare another pull request containing the thermal-soc
> >>>> materials except the exynos fixes
> >>>> 3. exynos fixes with the problem solved can be queued for -rc2 or
> >>>> later.
> >>>
> >>> Could you please just merge the obvious fix from Arnd instead?
> >>>
> >>> [ it was posted two weeks ago and ACKed by me ]
> >>>
> >>> https://patchwork.kernel.org/patch/10313313/
> >>
> >> I'm not sure these are correct fixes.
> >>
> >> The change 480b5bfc16e1 tells:
> >>
> >> "There should be no functional changes caused by this patch."
> >>
> >> but the fix above returns 0 as a default value instead of '50' or '25'
> >> for the 5440 and that impacts the threshold etc ...
> >>
> >> IMO, the correct fix would be to define a default value '50', override
> >> it at init time to '25' if it is a 5440. And then the variable 'temp'
> >> and 'temp_code' get this value in the default case.
> > 
> > It is okay to return 0 because this code-path (the default one) will be
> > never hit by the driver (probe makes sure of it) - the default case is
> > here is just to silence compilation errors..
> 
> The init function is making sure cal_type is one or another. Can you fix
> it correctly by replacing the 'switch' by a 'if' instead of adding dead
> branches to please gcc?
> 
> if (data->cal_type == TYPE_TWO_POINT_TRIMMING) {
> 	return ...;
> }
> 
> return ...;

I'm not the one that added this switch statement (it has been there since
2011) and I would be happy to remove it.  However could we please defer
this to v4.17 and merge the current set of Exynos thermal fixes/cleanups
(they simplify the driver a lot and make ground for future changes)?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
