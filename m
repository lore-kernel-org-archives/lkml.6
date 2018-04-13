Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754266AbeDMLMr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 07:12:47 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:60777 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753602AbeDMLMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 07:12:45 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180413111243epoutp01329d5003900972529543c59b601e41f0~k_ncIsx-22946229462epoutp01R
X-AuditID: b6c32a35-151ff70000000fee-4b-5ad090aa5afe
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "Li, Philip" <philip.li@intel.com>
Subject: Re: [GIT PULL] Thermal management updates for v4.17-rc1
Date: Fri, 13 Apr 2018 13:12:39 +0200
Message-id: <2093381.eDLEWQi9DB@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <10298074.ogKH1ypqfx@amdc3058>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsWy7bCmvu6qCReiDJaekbeY91nWYv6Va6wW
        l3fNYbP43HuE0eLSoYtMFk8e9rFZPOp7y+7A7rFz1l12j8V7XjJ53Lm2h83jxIzfLB6fN8kF
        sEZx2aSk5mSWpRbp2yVwZRzpe8lU0CFQcW/fNpYGxh08XYycHBICJhL7p31l72Lk4hAS2MEo
        MfnraTYI5zujxJfZ35hgqqb/PcsIkdjAKDHx5AV2kISQwFdGiU/fg0BsNgEriYntqxhBbBEB
        PYnG921gzcwCXxglHt7kB7GFBRwkGjZcYwGxWQRUJd6v62UFsXkFNCV+7joO1isq4CWxZV87
        WC+ngLbEv68LoGoEJX5MvscCMVNeYt/+qawQto7E2WPrwI6TEDjAJrHm5gZ2iKtdJN78fMcC
        YQtLvDq+BSjOAWRLS1w6agtR38wo8W3HHmaImgmMEnvWC0HY1hKHj1+EWsAn8e5rDytEL69E
        RxtUiYfE/J1XoMY7SnRfvQ0NoJuMEj+v7WGdwCg7C8nds5DcPQvJ3QsYmVcxiqUWFOempxYb
        FhjqFSfmFpfmpesl5+duYgSnCC3THYxTzvkcYhTgYFTi4VWoPB8lxJpYVlyZe4hRgoNZSYT3
        ZsGFKCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8T33ORAkJpCeWpGanphakFsFkmTg4pRoYfR1j
        zk26up/Nim3Pl+tSZ2e1plt6rNC/u2zet2TJirLfWqk5nSm1t8S275iU8fFowxq1SfdnqX9N
        UuM/urR6TaFYfmnnxXOLPMwYO/bZlYR1cm7WfXLXyYht9aGIw88/TiiNZm244frOuPcTR4BY
        6/TomZ0sZV1ay9WSQu5obzYyKHS/qpmkxFKckWioxVxUnAgAfZ5xLQ0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsVy+t9jQd1VEy5EGRy9wWcx77Osxfwr11gt
        Lu+aw2bxufcIo8WlQxeZLJ487GOzeNT3lt2B3WPnrLvsHov3vGTyuHNtD5vHiRm/WTw+b5IL
        YI3isklJzcksSy3St0vgyjjS95KpoEOg4t6+bSwNjDt4uhg5OSQETCSm/z3LCGILCaxjlNjQ
        pNHFyAVkf2WU2HzoPRtIgk3ASmJi+yqwIhEBPYnG921MIEXMAl8YJRYf2MMKkhAWcJBo2HCN
        BcRmEVCVeL+uFyzOK6Ap8XPXcbBmUQEviS372plAbE4BbYl/XxewQmxrZZT4Pr+DEaJBUOLH
        5Htgg5gF5CX27Z/KCmFrSazfeZxpAiP/LCRls5CUzUJStoCReRWjZGpBcW56brFRgWFearle
        cWJucWleul5yfu4mRmBYbzus1beD8f6S+EOMAhyMSjy8CpXno4RYE8uKK3MPMUpwMCuJ8N4s
        uBAlxJuSWFmVWpQfX1Sak1p8iFGag0VJnPd23rFIIYH0xJLU7NTUgtQimCwTB6dUA+PsI06/
        /q7zMT6cIf1jV49O3N93U2wMruxnu3vmsethNz3fRXUmFSz39+VWKqz59dVWYbX0t5yZfk/m
        zGUqPZwt35337/pMMUbTqL0hcVu4djh5z39X68Gp7Jdo+Cvks9vssIPP5y2tfn1FfYUUmyvj
        u8eFL5NXW6tckF5QmNGVNv2FdkmrgJYSS3FGoqEWc1FxIgC+gXN8ZwIAAA==
X-CMS-MailID: 20180413111242epcas1p4cd5ecac004dd9c1e00e1608088ff88e2
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180413111242epcas1p4cd5ecac004dd9c1e00e1608088ff88e2
X-RootMTR: 20180413111242epcas1p4cd5ecac004dd9c1e00e1608088ff88e2
References: <1523436077.16235.5.camel@intel.com>
        <3b41052a-233d-9992-223a-d16f48295905@linaro.org>
        <10298074.ogKH1ypqfx@amdc3058>
        <CGME20180413111242epcas1p4cd5ecac004dd9c1e00e1608088ff88e2@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, April 13, 2018 12:41:18 PM Bartlomiej Zolnierkiewicz wrote:
> On Friday, April 13, 2018 12:30:04 PM Daniel Lezcano wrote:
> > On 13/04/2018 11:28, Bartlomiej Zolnierkiewicz wrote:
> > 
> > [ ... ]
> > 
> > >>> It is okay to return 0 because this code-path (the default one) will be
> > >>> never hit by the driver (probe makes sure of it) - the default case is
> > >>> here is just to silence compilation errors..
> > >>
> > >> The init function is making sure cal_type is one or another. Can you fix
> > >> it correctly by replacing the 'switch' by a 'if' instead of adding dead
> > >> branches to please gcc?
> > >>
> > >> if (data->cal_type == TYPE_TWO_POINT_TRIMMING) {
> > >> 	return ...;
> > >> }
> > >>
> > >> return ...;
> > > 
> > > I'm not the one that added this switch statement (it has been there since
> > > 2011) and I would be happy to remove it. 
> > 
> > Actually the switch statement was fine until the cleanup.
> 
> I don't see how it was fine before as the driver has never used the default
> case (always used TYPE_ONE_POINT_TRIMMING or TYPE_TWO_POINT_TRIMMING).
> 
> Could you please explain this more?
> 
> > > However could we please defer
> > > this to v4.17 and merge the current set of Exynos thermal fixes/cleanups
> > > (they simplify the driver a lot and make ground for future changes)?
> > 
> > Regarding the latest comment, this can be fixed properly by 'return' (or
> > whatever you want which does not get around of gcc warnings).
> 
> Do you mean that you want the patch with switch statement removal?
> 
> Is incremental fix OK or do you want something else?

Danial has already posted it, I hope the fix is fine with you.

Also sorry for the delay with handling issue - I was on holiday last two
days and for some reason I was under (wrong) impression that the previous
fix has been in thermal tree (so I was quite surprised today reading this
mail thread).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
