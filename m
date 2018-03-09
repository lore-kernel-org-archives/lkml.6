Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932153AbeCIPJ6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 10:09:58 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:34610 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751102AbeCIPJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 10:09:55 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180309150953epoutp04af9d08f2b1eadd59e45af3573c9e4809~aSRh8qb2Q1213812138epoutp04c
X-AuditID: b6c32a37-433ff70000001029-c8-5aa2a3c114d8
Subject: Re: [PATCH v2 4/4] ARM: dts: Enable HDMI audio on Snow Chromebook
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: kgene@kernel.org, linux-samsung-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?=
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <7be21210-edc4-bfa7-6e77-ee23fae141da@samsung.com>
Date: Fri, 09 Mar 2018 16:09:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-version: 1.0
In-reply-to: <CAJKOXPemC09mmjt9AKa9Qfhy14=CdUampi3=x957=NNEzq7LqQ@mail.gmail.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42LZdlhTX/fg4kVRBr2/xSw2zljPajH/yDlW
        i/7Hr5ktzp/fwG6x6fE1VovLu+awWcw4v4/JYu2Ru+wOHB6bVnWyeWxeUu/Rt2UVo8fnTXIB
        LFFcNimpOZllqUX6dglcGbNnTGcrWMdV8XVWeQPjCY4uRg4OCQETiefH2bsYuTiEBHYwSmx9
        /oexi5ETyPnOKDFjJhOIDVLz9FgLK0TRbkaJCbN3MkE49xklZi/tYAOpEhbwkti58hiYLSKg
        KXH973dWEJtZYC6TxLc+sElsAoYSvUf7wDbwCthJLGx6DWazCKhKLNv+GMwWFYiQWDj1KVSN
        oMSPyfdYQGxOgWCJ/hWT2SFmakq8+DKJBcIWlzh2/yYjhC0vsXnNW2aQ4yQEzrBJTOvZxA7x
        govEvr1drBC2sMSr41vYId6Xlrh01BYiXC3R2dbFDtHbwijxZ9olNoiEtcTh4xehnuGTePe1
        hxWil1eio00IwvSQmLDYBKLaUeLepk9skPBpY5LYfKWbbQKj3Cwk78xC8sIsJC/MQvLCAkaW
        VYxiqQXFuempxYYFxnrFibnFpXnpesn5uZsYwclEy3wH44ZzPocYBTgYlXh4BWYsihJiTSwr
        rsw9xCjBwawkwvu+BijEm5JYWZValB9fVJqTWnyIUZqDRUmcNyDAJUpIID2xJDU7NbUgtQgm
        y8TBKdXAmCb+Ye11GU1RW2+WZecOxd09o7VIkeNo5fHq3Su/vCiYt2vHjpw1z60ecYosrNlz
        q3XHmktLDu9c+cNaPPq6kdbPF6VvLGJVXtb9SIra0q1m/c6pvoE74Yqid0/WHXues6dyFUTE
        Hp5bZ1m8rLbs4Q+VW9qfera+L+ion/WNLTNKgoPzdeexZiWW4oxEQy3mouJEAPk/8SQiAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsVy+t9jAd0DixdFGcw+p2CxccZ6Vov5R86x
        WvQ/fs1scf78BnaLTY+vsVpc3jWHzWLG+X1MFmuP3GV34PDYtKqTzWPzknqPvi2rGD0+b5IL
        YInisklJzcksSy3St0vgypg9YzpbwTquiq+zyhsYT3B0MXJySAiYSDw91sLaxcjFISSwk1Gi
        bXMHI4TzkFFi2+ZFzCBVwgJeEjtXHmMDsUUENCWu//0O1sEsMJdJ4lrja6iODiaJ2ffnsoJU
        sQkYSvQe7WMEsXkF7CQWNr0Gs1kEVCWWbX8MZosKREh0rpzPAlEjKPFj8j0wm1MgWOL3vAb2
        LkYOoA3qElOm5IKEmQXEJY7dv8kIYctLbF7zlnkCo8AsJN2zEDpmIemYhaRjASPLKkbJ1ILi
        3PTcYqMCw7zUcr3ixNzi0rx0veT83E2MwBjYdlirbwfj/SXxhxgFOBiVeHgFZiyKEmJNLCuu
        zD3EKMHBrCTC+74GKMSbklhZlVqUH19UmpNafIhRmoNFSZz3dt6xSCGB9MSS1OzU1ILUIpgs
        EwenVAOjck7Z9f+Pm1bf1pz9xX3y3NtGRZOPXg6xnjGbi7dU4v2/8J18vQnym2XZJVp/TK+f
        vDjBi+fcqvdvUqUWx72MdD8neyrrMpOon6X/IoW/b5inHD3H8E0i3tTW8U25wX3vSxEPHweb
        btnatfmezYdbzZVfTpx70S46z//bYycfxXVGRyvXT/thqcRSnJFoqMVcVJwIAHaBgqB9AgAA
X-CMS-MailID: 20180309150952epcas1p41becb2fe4a1094339a8656c0b969ceb9
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180308162609epcas1p45458c1671c38b389e047f17804690eb9
X-RootMTR: 20180308162609epcas1p45458c1671c38b389e047f17804690eb9
References: <CGME20180308162609epcas1p45458c1671c38b389e047f17804690eb9@epcas1p4.samsung.com>
        <20180307172711.15697-4-s.nawrocki@samsung.com>
        <20180308162559.391-1-s.nawrocki@samsung.com>
        <CAJKOXPemC09mmjt9AKa9Qfhy14=CdUampi3=x957=NNEzq7LqQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/2018 02:01 PM, Krzysztof Kozlowski wrote:
>> diff --git a/arch/arm/boot/dts/exynos5250-snow-common.dtsi b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
>> index bdf59dd3654b..932a00cfd716 100644
>> --- a/arch/arm/boot/dts/exynos5250-snow-common.dtsi
>> +++ b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
>> @@ -9,6 +9,7 @@
>>  #include <dt-bindings/clock/maxim,max77686.h>
>>  #include <dt-bindings/interrupt-controller/irq.h>
>>  #include <dt-bindings/input/input.h>
>> +#include <dt-bindings/sound/samsung-i2s.h>
>>  #include "exynos5250.dtsi"
>>
>>  / {
>> @@ -523,6 +524,9 @@
>>  };
>>
>>  &i2s0 {
>> +       assigned-clocks = <&i2s0 CLK_I2S_RCLK_SRC>;
>> +       assigned-clock-parents = <&clock_audss EXYNOS_I2S_BUS>;
>> +       #clock-cells = <1>;
>
> Shouldn't this be property of exynos5250.dtsi? Along with clock-output-names?

Hmm, it should be safe to move it there. By specifying this property or not
we can control whether the I2S clocks are exposed or not. If we move it to 
exynos5250.dtsi the clocks we always be exposed. But should be the right thing
to do anyway. I will post v3.

Of course we recently made the clock-output-names property deprecated, it will
not bee needed any more. It was there just to ensure the clk names are unique.

-- 
Regards,
Sylwester
