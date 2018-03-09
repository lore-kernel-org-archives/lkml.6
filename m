Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751085AbeCILxM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 06:53:12 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:50103 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbeCILxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 06:53:09 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180309115306epoutp040b1d2bc64f18605fae514bb5e5d197ce~aPlt_Aa4Q1687916879epoutp04Z
X-AuditID: b6c32a36-ca9ff70000001028-32-5aa275a10ae3
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"
Subject: Re: [PATCH 1/4] ARM: dts: exynos5250: Add #sound-dai-cells property
 to hdmi device node
To: Inki Dae <inki.dae@samsung.com>, krzk@kernel.org
Cc: kgene@kernel.org, devicetree@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <39965bce-a6f2-6202-5c3f-97e4446e97eb@samsung.com>
Date: Fri, 09 Mar 2018 12:52:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
In-reply-to: <5AA1F41B.5080104@samsung.com>
Content-language: en-GB
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsWy7bCmru7C0kVRBusW6VhsnLGe1WL+kXOs
        FpPuT2Cx6H/8mtni/PkN7BabHl9jtbi8aw6bxYzz+5gs1h65y+7A6bFpVSebx+Yl9R59W1Yx
        enzeJBfAEsVlk5Kak1mWWqRvl8CV8Xr+BuaCf3wVu9c0MzYwNvN0MXJySAiYSDSd2MLYxcjF
        ISSwg1FifutRdgjnO6PE2kePmWCqtk15yQKR2M0o8e75ElaQBK+AoMSPyfdYQGxmAU2JF18m
        QRXdZ5SYufw5WJGwQJLEh0fzmUFsEaBJv9u72ECKmAUuMkqcu30DLMEmYCjRe7SPEWKqncSb
        WyBTOThYBFQl2q4EgYRFBSIkFk59ClbCKaAt0XTsBxPEYnGJY/dvMkLY8hIHrzwHO0JC4DKb
        xIJ5W9khXnCRmDmvlQ3CFpZ4dXwLO8h8CQFpiUtHbSHC1RKdbV3sEL0tjBJ/pl2CqreWOHz8
        IivEAj6Jd197WCF6eSU62oQgSjwk+g6eZoGwHSUm3P4IdpuQwAZGiYYlVRMY5WYhhdcspPCa
        heSFWUheWMDIsopRLLWgODc9tdiwwEivODG3uDQvXS85P3cTIzi5aJntYFx0zucQowAHoxIP
        7wPHhVFCrIllxZW5hxglOJiVRHjfZS6KEuJNSaysSi3Kjy8qzUktPsQozcGiJM4bEOASJSSQ
        nliSmp2aWpBaBJNl4uCUamAMfnUtKGvTnF9rt+vNV9rzd0fjmpr1doInA5yPn6m+bVfUKXHN
        UdIqMGo7v9OEGcK7pJw2tSjf/3op63vYNJvtZSqi1r8dV51dwd+T46y7bhb7vt0V0+Xn5U9i
        Oq/SOKnc8qHXlYhlFbNU+dsiJvBMPnSPR+N+6Q/f3W3Zv6uWr9woLvC5WTZeiaU4I9FQi7mo
        OBEAPyOgLSoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsVy+t9jAd2FpYuiDBp3iVtsnLGe1WL+kXOs
        FpPuT2Cx6H/8mtni/PkN7BabHl9jtbi8aw6bxYzz+5gs1h65y+7A6bFpVSebx+Yl9R59W1Yx
        enzeJBfAEsVlk5Kak1mWWqRvl8CV8Xr+BuaCf3wVu9c0MzYwNvN0MXJySAiYSGyb8pIFxBYS
        2Mko8WpPJYjNKyAo8WPyPaA4BwezgLrElCm5ECUPGSXu3hIFsYUFkiR6X01hA7FFgMb8bu8C
        srmAyi8ySny93M4O4ggJbGCUmLVxF9gCNgFDid6jfYwQC+wk3tyCWMAioCrRdiUIJCwqECHR
        uXI+WDmngLZE07EfTCA2s4C4xLH7NxkhbHmJg1ees0xgFJiF5NRZCKfOQtIxC0nHAkaWVYyS
        qQXFuem5xUYFhnmp5XrFibnFpXnpesn5uZsYgZGw7bBW3w7G+0viDzEKcDAq8fBauCyMEmJN
        LCuuzD3EKMHBrCTC+y5zUZQQb0piZVVqUX58UWlOavEhRmkOFiVx3tt5xyKFBNITS1KzU1ML
        UotgskwcnFINjK3VliKKB/76OjVPWT7D+O3Kz7IvPu2Ntlp+0vBqy2Q/7yxjfiuxX3Uta79o
        XH3yukF1an10rvNOx+5+rfdSt7dGLNqwSiYtYua9VK4v53/sDpvrENO/yMbzxtk7b1N6rnU/
        0q+wO1Ui0GY5o+5p9dmznuyssXt5kmeaZUjxnY0/dTA6et//ACWW4oxEQy3mouJEAKHQP/2A
        AgAA
X-CMS-MailID: 20180309115305epcas1p4d7b896da0a3776a355509cadcb27ecdb
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180307172723epcas1p1b8879bb555737cab7406a172b7d13a56
X-RootMTR: 20180307172723epcas1p1b8879bb555737cab7406a172b7d13a56
References: <CGME20180307172723epcas1p1b8879bb555737cab7406a172b7d13a56@epcas1p1.samsung.com>
        <20180307172711.15697-1-s.nawrocki@samsung.com>
        <5AA1F41B.5080104@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Inki,

On 03/09/2018 03:40 AM, Inki Dae wrote:
> 2018년 03월 08일 02:27에 Sylwester Nawrocki 이(가) 쓴 글:
>> This property is required for specifying link between the HDMI IP block
>> and the SoC's audio subsystem.
>>
>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> ---
>>  arch/arm/boot/dts/exynos5250.dtsi | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
>> index 56626d1a4235..71d2ede118e3 100644
>> --- a/arch/arm/boot/dts/exynos5250.dtsi
>> +++ b/arch/arm/boot/dts/exynos5250.dtsi
>> @@ -700,6 +700,7 @@
>>  					"sclk_hdmiphy", "mout_hdmi";
>>  			samsung,syscon-phandle = <&pmu_system_controller>;
>>  			phy = <&hdmiphy>;
>> +			#sound-dai-cells = <0>;
> 
> This patch adds this property to hdmi device node which is bound by HDMI driver 
> of Exynos DRM. As we talked about this at other email thread, seems this property 
> is required mandatorily for Odroid XU3/4 board which uses Exynos5422.
> There may be something I'm missing so could you let me know how this property 
> is required?

It is required to properly interpret the list of DAI specified in the 'sound-dai'
property. If a device supports only one DAI it will have #sound-dai-cells = <0>
and the sound-dai property values in cpu<->codec link may look like this:

 cpu { ... }
 codec {
	 sound-dai = <&max98090>, <&hdmi>;
 };

When the CODEC support more DAIs it will have #sound-dai-cells = <1> and we can
additionally specify which DAI we exactly refer to, in this case DAI 0:

 cpu { ... }
 codec {
	sound-dai = <&max98095 0>, <&hdmi>;
 };

More details can be found in documentation of of_parse_phandle_with_args()
function.

The above refers to cpu/codec mapping like I2S0 -> [max9809x, hdmi], on Exynos5433
we have I2S0 -> wm5110 and I2S1 -> hdmi.


-- 
Regards,
Sylwester
