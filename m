Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752131AbeENICO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:02:14 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:10246 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752038AbeENICD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:02:03 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180514080201epoutp0499138bf1ed45269c14c822a72944c747~udAysej7_0978609786epoutp04g
X-AuditID: b6c32a36-b55ff70000001027-11-5af94279f539
Subject: Re: [PATCH] ARM: dts: exynos: Use dedicated DT bindings for Odroid
 X/X2, U3
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <1ac92405-897a-d16b-13a2-e968c687b07d@samsung.com>
Date: Mon, 14 May 2018 10:01:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-version: 1.0
In-reply-to: <20180513122412.shxdxtxt2phb46l5@kozik-lap>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsWy7bCmvm6l088og+snOS02zljPajH/yDlW
        i/PnN7BbbHp8jdXi8q45bBYzzu9jslh75C67ReveI+wOHB6bVnWyeWxeUu/Rt2UVo8fnTXIB
        LFFcNimpOZllqUX6dglcGeteTGUtuMJesfTUFdYGxjVsXYycHBICJhIn37wHs4UEdjBK3PtV
        0cXIBWR/Z5S48+UVI0zRizaQIpDEbkaJU5O/sUA494Gc/sPsIFXCAmESL+e3soDYIgKaEtf/
        fmcFsZkFLjNK9PTbgNhsAoYSvUf7wKbyCthJrDh4hBnEZhFQlfiz8AFYXFQgQqLp+U92iBpB
        iR+T74HN5BSwkDi9YjcjxExNiRdfJrFA2OISx+7fhIrLS2xe85YZ5DgJgctsEv87trNDvOAi
        saj7HxOELSzx6vgWoDgHkC0tcemoLUS4WqKzrYsdoreFUeLPtEvQMLKWOHz8ItQzfBLvvvaw
        QvTySnS0CUGUeEhM2dkFtcpRYubGC0yQANrDKPH7wAGmCYxys5D8MwvJD7OQ/DALyQ8LGFlW
        MYqlFhTnpqcWGxYY6RUn5haX5qXrJefnbmIEpxQtsx2Mi875HGIU4GBU4uENWP4jSog1say4
        MvcQowQHs5II726jn1FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeecofY0SEkhPLEnNTk0tSC2C
        yTJxcEo1MCqF2y5UVHB68vl4zvmfHQ/DuF8LrGA5syJv8daeMr+Nh1/Xbksq4nwiJrV5jocd
        5851C/7dTnY031tfu75u6qmdbHznrvucOyroIrStrKqzYvns1xs2ynTbMXw5+El4+un5As4C
        S/f5GoT/vf4tSW7alutGF9O7+Vd+uLQsuetWz8e4i/nHWlOVWIozEg21mIuKEwF8bb/fJQMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsVy+t9jAd0Kp59RBoeXm1tsnLGe1WL+kXOs
        FufPb2C32PT4GqvF5V1z2CxmnN/HZLH2yF12i9a9R9gdODw2repk89i8pN6jb8sqRo/Pm+QC
        WKK4bFJSczLLUov07RK4Mta9mMpacIW9YumpK6wNjGvYuhg5OSQETCRetL0Hsrk4hAR2Mkqc
        3b8ZynnIKLFu+2dmkCphgTCJl/NbWUBsEQFNiet/v7OCFDELXGaUuHHqEjNExz5GiePnboFV
        sQkYSvQe7WMEsXkF7CRWHDwCNolFQFXiz8IHYHFRgQiJe+c/sUHUCEr8mHwPrJdTwELi9Ird
        QDUcQBvUJaZMyQUJMwuISxy7f5MRwpaX2LzmLfMERoFZSLpnIXTMQtIxC0nHAkaWVYySqQXF
        uem5xUYFhnmp5XrFibnFpXnpesn5uZsYgVGw7bBW3w7G+0viDzEKcDAq8fCuWPkjSog1say4
        MvcQowQHs5II726jn1FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeW/nHYsUEkhPLEnNTk0tSC2C
        yTJxcEo1MPI9COdgvCZcXKTIdefhydkcfY5VKzac0ozfvI7P7JVp/Jo50Z/r1h6NylH8k/I5
        6u7Cuil/JY94Nr2+IFufV7lQ70/U3bvbH7h+PnBv860+h90rGVmvPAm5dFenMvf/+S3TXxpN
        /8NQsWWJ28RXp/caalcm2HpYFdh+9jVj2zXLv9jpWvKHOzOUWIozEg21mIuKEwG9sqpkfgIA
        AA==
X-CMS-MailID: 20180514080201epcas1p1d257ddc7101198c2fcd74b22dafda5c4
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180511081032epcas2p30f381cf699cb7524d9a143390e9c74b5
X-RootMTR: 20180511081032epcas2p30f381cf699cb7524d9a143390e9c74b5
References: <CGME20180511081032epcas2p30f381cf699cb7524d9a143390e9c74b5@epcas2p3.samsung.com>
        <20180511080947.3057-1-s.nawrocki@samsung.com>
        <20180513122412.shxdxtxt2phb46l5@kozik-lap>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/13/2018 02:24 PM, Krzysztof Kozlowski wrote:
> On Fri, May 11, 2018 at 10:09:47AM +0200, Sylwester Nawrocki wrote:
>> Use dedicated Odroid audio subsystem DT bindings instead of the simple-card.
>> This adds support for audio on the HDMI interface.

> How about changing the subject to "Add suppor for audio over HDMI for
> Odroid X/X2/U3"?

Sure, I don't mind.

>> diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/exynos4412-odroidu3.dts
>> index bdcd4523cc1c..7a94a423097d 100644
>> --- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
>> +++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
>> @@ -113,11 +113,12 @@
>>  };
>>  
>>  &sound {
>> -	simple-audio-card,name = "Odroid-U3";
>> -	simple-audio-card,widgets =
>> +	compatible = "hardkernel,odroid-xu4-audio";

> The compatible is the same for all users using DTSI so it could be moved
> to the exynos4412-odroid-common.dtsi itself.

Corrected.

-- 
Regards,
Sylwester
