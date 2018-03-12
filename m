Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932474AbeCLAsW (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 20:48:22 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:29188 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932361AbeCLAsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 20:48:19 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180312004816epoutp0477191d2b75fd1924651806a90c0b1bc3~bBdGE0O7k3002930029epoutp049
X-AuditID: b6c32a39-47fff70000000fc5-f4-5aa5ce50adb4
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Message-id: <5AA5CE4F.6050807@samsung.com>
Date: Mon, 12 Mar 2018 09:48:15 +0900
From: Inki Dae <inki.dae@samsung.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Sylwester Nawrocki <s.nawrocki@samsung.com>, krzk@kernel.org
Cc: kgene@kernel.org, devicetree@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com
Subject: Re: [PATCH 1/4] ARM: dts: exynos5250: Add #sound-dai-cells property
 to hdmi device node
In-reply-to: <39965bce-a6f2-6202-5c3f-97e4446e97eb@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCKsWRmVeSWpSXmKPExsWy7bCmvm7AuaVRBnd/c1tsnLGe1WL+kXOs
        Fv2PXzNbnD+/gd1i0+NrrBaXd81hs5hxfh+Txdojd9ktDr9pZ3Xg9Ni0qpPNY/OSeo++LasY
        PT5vkgtgiUq1yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXL
        zAE6RUmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiqxRtaGikZ2hgrmdkZKRnYhxrZWQKVJKQ
        mvHzxhmWgp/CFS0nrrE0MLYLdDFyckgImEgsvv2PqYuRi0NIYAejxNNrJ1hAEkIC3xklvq5R
        gil6/nkyI0TRBkaJc2uXMoIkeAUEJX5MvgfUwMHBLCAvceRSNkiYWUBT4sWXSSwQ9fcYJa58
        O84OUa8l8eZTDxuIzSKgKvHt/k2wZWxA9sQV98HiogIREjvnfwOrFxFwkDj+txNsELPARaDF
        t28wgySEBZIkPjyaD2ZzCthLNEx6AlYkIXCETWLLhNmsEGe7SNw8/48RwhaWeHV8CzvIpRIC
        0hKXjtpC1LczSuw6e50NwulhlFi+eBE7RIOxxLOFXUwQ//BJvPvawwrRzCvR0SYEUeIh0Xfw
        NAuE7Sgx4fZHaDg+ZZSYc+0LywRG2VlIoTQLEUqzkEJpASPzKkax1ILi3PTUYsMCU73ixNzi
        0rx0veT83E2M4BSnZbmD8dg5n0OMAhyMSjy8MzYtjRJiTSwrrsw9xCjBwawkwtsZBBTiTUms
        rEotyo8vKs1JLT7EaAoM5InMUqLJ+cD0m1cSb2hiaWBiZgRMU5aGhkrivAEBLlFCAumJJanZ
        qakFqUUwfUwcnFINjOdmX9kd+1TA8fBZdt5w/ibhuGCVpUs/P7+7TOf00jdcIdYrM6MZ9jUK
        G11VC//1YPuslrDnxZdOCrGtOZS6n/HyTU4b5/UzpF96BKzcV37//Af918L65oee7G/Z1+gq
        +WTKCvumZXkbI+b/PvHCuEXy3J8IERanvda+oseeBS/52P9fZbZuo4cSS3FGoqEWc1FxIgCZ
        VfwvhwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsVy+t9jQV3/c0ujDBZssrDYOGM9q8X8I+dY
        Lfofv2a2OH9+A7vFpsfXWC0u75rDZjHj/D4mi7VH7rJbHH7TzurA6bFpVSebx+Yl9R59W1Yx
        enzeJBfAEsVlk5Kak1mWWqRvl8CV8fPGGZaCn8IVLSeusTQwtgt0MXJySAiYSDz/PJmxi5GL
        Q0hgHaPE6TmvWUESvAKCEj8m32PpYuTgYBaQlzhyKRvCVJeYMiUXovwBo8TqNXOhyrUk3nzq
        YQOxWQRUJb7dv8kCYrMB2RNX3GcD6RUViJDoPlEJEhYRcJA4/reTBWQOs8BFRomvl9vZQRLC
        AkkSva+msEEseMoocf7edrAFnAL2Eg2TnrBMYOSfheS8WQjnzUI4bwEj8ypGydSC4tz03GKj
        AsO81HK94sTc4tK8dL3k/NxNjMDA3nZYq28H4/0l8YcYBTgYlXh4P2xZGiXEmlhWXJl7iFGC
        g1lJhLczCCjEm5JYWZValB9fVJqTWnyIUZqDRUmc93besUghgfTEktTs1NSC1CKYLBMHp1QD
        o7mr/oc1b/u4c5h7RGfdlEnxevV18tzZOtWLvl/wudm86PBpvhcyZt7f72otE1h81aJnMrO6
        4UWuxJnSrTWv2GMnc4e/4Pm+6vkvOcuDK/iNNq9T7Vbjncp/vqyFU4f38A5G9vez2FaXrzpw
        SLjKMTJwOlfVHu7fvge+xdm1ue3kMTWKYyhZrcRSnJFoqMVcVJwIAFpGbBloAgAA
X-CMS-MailID: 20180312004815epcas1p48afbf67713df95681d4aaefcd8b99bfb
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180307172723epcas1p1b8879bb555737cab7406a172b7d13a56
X-RootMTR: 20180307172723epcas1p1b8879bb555737cab7406a172b7d13a56
References: <CGME20180307172723epcas1p1b8879bb555737cab7406a172b7d13a56@epcas1p1.samsung.com>
        <20180307172711.15697-1-s.nawrocki@samsung.com>
        <5AA1F41B.5080104@samsung.com>
        <39965bce-a6f2-6202-5c3f-97e4446e97eb@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sylwester,

2018년 03월 09일 20:52에 Sylwester Nawrocki 이(가) 쓴 글:
> Hi Inki,
> 
> On 03/09/2018 03:40 AM, Inki Dae wrote:
>> 2018년 03월 08일 02:27에 Sylwester Nawrocki 이(가) 쓴 글:
>>> This property is required for specifying link between the HDMI IP block
>>> and the SoC's audio subsystem.
>>>
>>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>>> ---
>>>  arch/arm/boot/dts/exynos5250.dtsi | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
>>> index 56626d1a4235..71d2ede118e3 100644
>>> --- a/arch/arm/boot/dts/exynos5250.dtsi
>>> +++ b/arch/arm/boot/dts/exynos5250.dtsi
>>> @@ -700,6 +700,7 @@
>>>  					"sclk_hdmiphy", "mout_hdmi";
>>>  			samsung,syscon-phandle = <&pmu_system_controller>;
>>>  			phy = <&hdmiphy>;
>>> +			#sound-dai-cells = <0>;
>>
>> This patch adds this property to hdmi device node which is bound by HDMI driver 
>> of Exynos DRM. As we talked about this at other email thread, seems this property 
>> is required mandatorily for Odroid XU3/4 board which uses Exynos5422.
>> There may be something I'm missing so could you let me know how this property 
>> is required?
> 
> It is required to properly interpret the list of DAI specified in the 'sound-dai'
> property. If a device supports only one DAI it will have #sound-dai-cells = <0>
> and the sound-dai property values in cpu<->codec link may look like this:
> 
>  cpu { ... }
>  codec {
> 	 sound-dai = <&max98090>, <&hdmi>;
>  };
> 
> When the CODEC support more DAIs it will have #sound-dai-cells = <1> and we can
> additionally specify which DAI we exactly refer to, in this case DAI 0:
> 
>  cpu { ... }
>  codec {
> 	sound-dai = <&max98095 0>, <&hdmi>;
>  };
> 
> More details can be found in documentation of of_parse_phandle_with_args()
> function.
> 
> The above refers to cpu/codec mapping like I2S0 -> [max9809x, hdmi], on Exynos5433
> we have I2S0 -> wm5110 and I2S1 -> hdmi.

Thanks for explanation. By the way, who binds '#sound-dai-cells' property?.
This patch adds this property to hdmi device node which will be bound by HDMI driver fo Exynos DRM but I don't see any place to bind '#sound-dai-cells' property in this driver.
So I think some driver like Odroid XU3/4 audio driver(sound/soc/samsung/odroid.c) or ASoC simple audio card driver(sound/soc/generic/simple-card.c) should exist and this property should be placed to such device node.

Thanks,
Inki Dae

> 
> 
