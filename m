Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753033AbeE3ODa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 10:03:30 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54712 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751844AbeE3ODY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 10:03:24 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180530140322euoutp013a4d0fca635b6ea0f52ee9323a25f43e~zcQ3Duhnr3089330893euoutp01Y
X-AuditID: cbfec7f5-f95739c0000028a9-84-5b0eaf27e95a
Subject: Re: Regression in Linux next again
To: Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, Carlos Hernandez <ceh@ti.com>
From: Maciej Purski <m.purski@samsung.com>
Date: Wed, 30 May 2018 16:03:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180530091314.GB6920@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsWy7djPc7rq6/miDZ7/kbKY+vAJm8W+vt9s
        FpseX2O1uLxrDpvF7CX9LBb7r3g5sHl8+zqJxWPTqk42j81L6j2O39jO5PF5k1wAaxSXTUpq
        TmZZapG+XQJXxtnze1gLFrFXvPg6naWB8TJrFyMHh4SAicSfd2VdjFwcQgIrGCWOdkxngXC+
        MEo07VgJ5XxmlPhxZQdbFyMnWMflh4/YQWwhgeVALZ3WEEVvgTo6/jGBJIQFtCXa5s8FaxAR
        cJX43nMWbBKzQDOjxMUPqxlBdrMJaEmsaY8HqWERUJVo7JrLCmKLCkRILJz6lBHE5hUQlDg5
        8wkLiM0pYCSxfNtssDizgKPEn8eHWCFscYlbT+YzQdjyEtvfzmEG2SUhsIpd4t5FiGZegTKJ
        R9cPs0N84CJxsKUR6hthiVfHt0DFZST+74QYJCGQL9H67DFUvEJiX+9pVgjbWuLw8YtQtqPE
        oyNHmSDhyCdx460gxA18EpO2TWeGCPNKdLQJQVQrSbyY8RdquoTE0pOPWCcwKs1C8uUsJJ/N
        QvLZLCSfLWBkWcUonlpanJueWmycl1quV5yYW1yal66XnJ+7iRGYdE7/O/51B+O+P0mHGAU4
        GJV4eDes5IsWYk0sK67MPcQowcGsJMJbupcnWog3JbGyKrUoP76oNCe1+BCjNAeLkjhvnEZd
        lJBAemJJanZqakFqEUyWiYNTqoGRe2/Fpkdf+GtM9/I8tLdOLPwmEGa77diUqVklsWe9Mm52
        y0strWR8ffgxd9T8krtCX/Rvld/9UbP7Pof0JYZJK/8Le919tM4r8PGBe3t1HgaKhH6Y7KO9
        tGfZRNsbdv9KTVL2/rJbybfG/VyCvsw82SvJGzZ4MaYabm8L86ie80V/34QNhzo+KLEUZyQa
        ajEXFScCANarTm42AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsVy+t/xe7pq6/miDVr+cVhMffiEzWJf3282
        i02Pr7FaXN41h81i9pJ+Fov9V7wc2Dy+fZ3E4rFpVSebx+Yl9R7Hb2xn8vi8SS6ANUrPpii/
        tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEv4+z5PawFi9gr
        XnydztLAeJm1i5GTQ0LAROLyw0fsILaQwFJGie0rdCHiEhJn7/+HqhGW+HOti62LkQuo5jWj
        xITWP2wgCWEBbYm2+XPBbBEBV4nvPWdZQIqYBZoZJZ4d+swI0bGaUaLn5FOgKg4ONgEtiTXt
        8SAmr4CdRPcfDZBeFgFVicauuWDLRAUiJDpXzmcBsXkFBCVOznwCZnMKGEks3zabEcRmFrCV
        uDN3NzOELS5x68l8JghbXmL72znMExiFZiFpn4WkZRaSlllIWhYwsqxiFEktLc5Nzy020itO
        zC0uzUvXS87P3cQIjLJtx35u2cHY9S74EKMAB6MSD++GlXzRQqyJZcWVuYcYJTiYlUR4S/fy
        RAvxpiRWVqUW5ccXleakFh9iNAV6biKzlGhyPjAB5JXEG5oamltYGpobmxubWSiJ8543qIwS
        EkhPLEnNTk0tSC2C6WPi4JRqYDykme3K+OBw/M4Q79LiR9cZLmbJe3BcEjarqjbJUPaawbzu
        qUjdufA73feU1j/MceydPevehq3Zd255nLrOcjlE78I//asmCk7+N/+3vO/hjmqfJ2cf7hFe
        fMyG6dTWHJsrvu731cNUCtc/OP+t2CNJqG1BDc9Uo3fblxR7KepVO69uO6jWrsRSnJFoqMVc
        VJwIAPfwrwrIAgAA
Message-Id: <20180530140318eucas1p2af2d01b9678e8914c2b8e099c584ec11~zcQzVKtj30757607576eucas1p2V@eucas1p2.samsung.com>
X-CMS-MailID: 20180530140318eucas1p2af2d01b9678e8914c2b8e099c584ec11
X-Msg-Generator: CA
X-RootMTR: 20180530091325epcas4p20dea07f013a3512ce4ea92120da90f61
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180530091325epcas4p20dea07f013a3512ce4ea92120da90f61
References: <20180529221501.GJ5702@atomide.com>
        <CGME20180530091325epcas4p20dea07f013a3512ce4ea92120da90f61@epcas4p2.samsung.com>
        <20180530091314.GB6920@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05/30/2018 11:13 AM, Mark Brown wrote:
> On Tue, May 29, 2018 at 03:15:01PM -0700, Tony Lindgren wrote:
> 
>> I think I bisected this same issue for the second time now
>> but for a different merge window. What's up with that?
> 
> Last time we just reverted it as Maciej was unable to reproduce your
> problem, he's tried again with some alterations.
> 
>> Reverting both patches fixes the issue for me. I could
>> not debug it further because of the compile error(s).
> 
> OK, unless this gets fixed really quickly I'll revert again.
> 

I'm afraid, I have no idea, how to fix it quickly. You can revert it and
in the next version I'll fix the build error and split the last patch even
more, so we could perform a more precise bisection. I'd be grateful if you
could push it on your test coupled branch and Tony could test it again before
merging it with next again.

Best regards,

Maciej Purski
