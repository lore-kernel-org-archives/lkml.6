Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754474AbeCGM5Z (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 07:57:25 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:36341 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754443AbeCGM5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 07:57:18 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180307125715euoutp015d08ab296b6609cbfd51bda323b22e09~ZpLJnwn6D0284802848euoutp012
X-AuditID: cbfec7f4-6f9ff700000043e4-1e-5a9fe1a96f73
Subject: Re: Regulator regression in next-20180305
To: Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From: Maciej Purski <m.purski@samsung.com>
Message-id: <bb1adc11-40ff-d37d-60f1-d6e706b058a6@samsung.com>
Date: Wed, 07 Mar 2018 13:57:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-version: 1.0
In-reply-to: <20180306163035.GE13586@sirena.org.uk>
Content-type: text/plain; charset="windows-1252"; format="flowed"
Content-language: en-US
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsWy7djPc7orH86PMlj33NRi44z1rBZTHz5h
        s3h41d9i0+NrrBaXd81hs5i9pJ/FYu2Ru+wW+694OXB4fPs6icVj56y77B6bVnWyeWxeUu/R
        t2UVo8fnTXIBbFFcNimpOZllqUX6dglcGacvXGYr+CZZcWPKTOYGxhciXYycHBICJhKzTn1n
        6WLk4hASWMEocb93PTNIQkjgM6PE1NWOMEXHJnxkhChaBhRf+osZwnnGKHFuaQMrSJWwgJHE
        9k2tYLaIgLtE68VLrCBFzAK7mCTeXznH1sXIwcEmoCWxpj0epIZXwE6iadMzRhCbRUBV4uzi
        PnYQW1QgQmLh1KeMEDWCEj8m32MBsTkFjCVO/j/ABGIzCzhKPFi0kxXCFpdobr3JAmHLS2xe
        8xbsOAmB62wSTcua2SFecJG4OAvGFpZ4dXwLlC0j0dlxkAnCrpa4+HUXG4RdI9F4ewNUjbXE
        50lbmCEW8ElM2jadGeQXCQFeiY42IYgSD4llS/ayQNiOEhvWTmGFh+K+RwETGOVmIXlnFpIX
        ZiF5YRaSFxYwsqxiFE8tLc5NTy02ykst1ytOzC0uzUvXS87P3cQITDGn/x3/soNx15+kQ4wC
        HIxKPLwb9s+LEmJNLCuuzD3EKMHBrCTCu/HB/Cgh3pTEyqrUovz4otKc1OJDjNIcLErivHEa
        dVFCAumJJanZqakFqUUwWSYOTqkGxgUdi6a57k9kcv+59VVI4jKRt5c8uzMrBf8e2fWk4D67
        0X6viHRPv9ZE+bzC9vdJSj/3CRm/2nOrNORSWtan5+Z1ZzpmXm4IFD5UWHpW3ungsf1OO9T/
        vdzrEnro39e9kfLe9/RtFjUHeBZ+d5nRYXFPzjr/8dwGZ8O0m5O5dI2e/sq9H/K8U4mlOCPR
        UIu5qDgRAJa8g2gtAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsVy+t/xa7orH86PMnh4VMJi44z1rBZTHz5h
        s3h41d9i0+NrrBaXd81hs5i9pJ/FYu2Ru+wW+694OXB4fPs6icVj56y77B6bVnWyeWxeUu/R
        t2UVo8fnTXIBbFFcNimpOZllqUX6dglcGacvXGYr+CZZcWPKTOYGxhciXYycHBICJhLHJnxk
        7GLk4hASWMIo8eHyB1YI5xmjxJsjf9lAqoQFjCS2b2plBbFFBNwlWi9eAitiFtjDJHH1YT8j
        SEJI4DNQ+1KLLkYODjYBLYk17fEgYV4BO4mmTc/ASlgEVCXOLu5jB7FFBSIkOlfOZ4GoEZT4
        MfkemM0pYCxx8v8BJhCbWcBWYsH7dSwQtrhEc+tNKFteYvOat8wTGAVmIWmfhaRlFpKWWUha
        FjCyrGIUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAiMhW3Hfm7ewXhpY/AhRgEORiUe3g3750UJ
        sSaWFVfmHmKU4GBWEuHd+GB+lBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe8waVUUIC6Yklqdmp
        qQWpRTBZJg5OqQZGgThPbi+tj0kSZ5bM9BPcmmVfo3tWiGdS4qrzv+ta95fpqp1XD3/2ruj0
        j0rjmOUGBdV7A9UWHL1QvZdh3dWqld0N9tuKdydlsP/dLxf6Wtvt1nv2qKlXmzQk25b3Sm+d
        Evj4eaRX3e4OcyPV50y3eW1jf64xYrBqNNrgvdjiW77NlWm+3KuVWIozEg21mIuKEwHEDE39
        gQIAAA==
X-CMS-MailID: 20180307125713eucas1p11ddee2a9ff9024302e65873417f59d5c
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180306163044epcas2p1b5bc62e4cba6c6e8c8ea7e75329c11ef
X-RootMTR: 20180306163044epcas2p1b5bc62e4cba6c6e8c8ea7e75329c11ef
References: <20180305231246.GB5799@atomide.com>
        <CAOMZO5CXy=7ZKVapp_2Q4wq=mY-dJ0owZZN84vqUj1j1xasOKg@mail.gmail.com>
        <CGME20180306163044epcas2p1b5bc62e4cba6c6e8c8ea7e75329c11ef@epcas2p1.samsung.com>
        <20180306163035.GE13586@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
sorry it took me so long to answer.

On 03/06/2018 05:30 PM, Mark Brown wrote:
> On Mon, Mar 05, 2018 at 08:22:26PM -0300, Fabio Estevam wrote:
>> On Mon, Mar 5, 2018 at 8:12 PM, Tony Lindgren <tony@atomide.com> wrote:
> 
>>> Looks like with next-20180305 there's a regulator regression
>>> where mmc0 won't show any cards or produces errors:
> 
>>> mmcblk0: error -110 requesting status
>>> mmc1: new high speed SDIO card at address 0001
>>> mmcblk0: error -110 requesting status
>>> mmcblk0: recovery failed!
>>> print_req_error: I/O error, dev mmcblk0, sector 0
>>> Buffer I/O error on dev mmcblk0, logical block 0, async page read
>>> mmcblk0: error -110 requesting status
>>> mmcblk0: recovery failed!
> 
> No other error messages?  That seems like there's something going on
> that's very different to what Fabio was reporting...  I'm guessing some
> voltage application didn't go through but it's hard to tell with so
> little data.  dra7 does seem to have what Fabio had though so there's
> definitely some effect on the OMAP platforms.
>  >> I have also seen regulator issues due to this series:
>> https://lkml.org/lkml/2018/3/5/731
> 
> Looking at your stuff I'm having trouble figuring out what's going on -
> we're getting double locking of a parent regulator during enable
> according to your backtraces but it's not clear to me what took that
> lock already.  regulator_enable() walks the supplies before it takes
> the lock on the regulator it's immediately being called on, not holding
> any locks on supplies while enabling.  regulator_balance_voltage() then
> tries to lock the supplies again but lockdep says the lock is already
> held by regulator_enable().  It's also weird that this doesn't seem to
> be showing up on other boards in kernelci, the regulator setup on those
> i.MX boards looks to be quite simple so I'd expect a much wider impact.
>

I'm trying to figure out what is so special about these boards. The only strange 
thing, that I haven't noticed at first, is that all regulators share a common 
supply - dummy regulator. It is defined in anatop_regulator.c.


> I'm wondering if your case is more pain from mutex_lock_nested(), both
> regulator_lock_coupled() and regulator_lock_supply() will end up using
> indexes starting at 0 for the locking classes.  That doesn't smell right
> though, but in case my straw clutching works:
> 
> If we can't figure it out I'll just drop the series but I'd prefer to at
> least understand what's going on.
>

I have been struggling to reproduce the issue on my exynos boards, but all I 
have achieved is getting the same lockdep warning, but everything else works 
fine. I think it was a false positive caused by using the same indices in 
lock_coupled() and lock_supply().

> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index e685f8b94acf..2c5b20a97f51 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -159,7 +159,7 @@ static void regulator_lock_supply(struct regulator_dev *rdev)
>   {
>   	int i;
>   
> -	for (i = 0; rdev; rdev = rdev_get_supply(rdev), i++)
> +	for (i = 1000; rdev; rdev = rdev_get_supply(rdev), i++)
>   		mutex_lock_nested(&rdev->mutex, i);
>   }
>   
> 

Best regards,
Maciej Purski
