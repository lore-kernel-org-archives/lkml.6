Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755634AbeCSPOu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 11:14:50 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:13598 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755226AbeCSPOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 11:14:46 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180319151444epoutp0476c259b9853fa70df947f8f6ef0f2f44~dWynV9ViP2067820678epoutp04C
X-AuditID: b6c32a36-c91ff70000001028-94-5aafd3e36299
Subject: Re: [PATCH v2] ASoC: samsung: Mark unused Odroid compatibles as
 deprecated
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sangbeom Kim <sbkim73@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <12dfaefb-fd79-7a1d-2676-307d4e28b7e1@samsung.com>
Date: Mon, 19 Mar 2018 16:14:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-version: 1.0
In-reply-to: <CAJKOXPcBesWpBoq07XbE1j3F1_N5dAWMTRkv8SN=tSMEm1q0iQ@mail.gmail.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsWy7bCmvu7jy+ujDL6eVLS4cvEQk8XUh0/Y
        LOYfOcdqcf78BnaLb1c6mCwu75rDZrH0+kUmi9a9R9gtLq74wuTA6bHhcxObx5p5axg9ds66
        y+6xaVUnm0ffllWMHp83yQWwRXHZpKTmZJalFunbJXBldG9bwlLwQqJiyY+T7A2M34W7GDk5
        JARMJJa8mMPYxcjFISSwg1Hi2Kl5LBDOd0aJzdM+ssBUnf86iwkisZtRon3hFqiW+4wSt19M
        ZAWpEhYIlfg4H6JDREBT4vrf72BxZoEJTBL7t6mA2GwChhK9R/sYQWxeATuJE4tXMIHYLAKq
        EvNevAbrFRWIkFg49SlUjaDEj8n3wOKcAsESjUcnMEPM1JR48WUSC4QtLnHs/k1GCFteYvOa
        t8wgx0kIvGaT+Nk4lw3iBReJ1p9z2SFsYYlXx7cA2RxAtrTEpaO2EOFqic62LnaI3hZGiT/T
        LkH1WkscPn4R6hk+iXdfe1ghenklOtqEIEo8JGbv2wM13lGi+dgCaGg1M0kceNfOOoFRbhaS
        f2Yh+WEWkh9mIflhASPLKkax1ILi3PTUYsMCI73ixNzi0rx0veT83E2M4KSjZbaDcdE5n0OM
        AhyMSjy8DkfXRQmxJpYVV+YeYpTgYFYS4X16BSjEm5JYWZValB9fVJqTWnyIUZqDRUmcNyDA
        JUpIID2xJDU7NbUgtQgmy8TBKdXAGHEwsit84m+RYuGrzodMz+yVFLfqOdyW+/1jdrVbwJJ/
        nXOXMS/QcioJFNi7/2iP2i/1Bp6vfw40N31l+9Hzc2fd8mnX+e+ll1y9lyhV+cFfU1Hh0pFN
        yges9ZpfOQiJXRDpEPrWfCCK/8Dk87+XyPyYfDs8xfla/R39luq77+4Eaftsy5+wWImlOCPR
        UIu5qDgRAD8Fpm02AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsVy+t9jAd1Hl9dHGczdY21x5eIhJoupD5+w
        Wcw/co7V4vz5DewW3650MFlc3jWHzWLp9YtMFq17j7BbXFzxhcmB02PD5yY2jzXz1jB67Jx1
        l91j06pONo++LasYPT5vkgtgi+KySUnNySxLLdK3S+DK6N62hKXghUTFkh8n2RsYvwt3MXJy
        SAiYSJz/Ooupi5GLQ0hgJ6PE6fZjrBDOQ0aJNf9usYBUCQuESnyc/xHMFhHQlLj+9ztYEbPA
        BCaJA22NbBAdrUwSy5evZQWpYhMwlOg92scIYvMK2EmcWLyCCcRmEVCVmPfiNdgkUYEIic6V
        81kgagQlfky+B2ZzCgRLPJ3zjr2LkQNog7rElCm5IGFmAXGJY/dvMkLY8hKb17xlnsAoMAtJ
        9yyEjllIOmYh6VjAyLKKUTK1oDg3PbfYqMAwL7Vcrzgxt7g0L10vOT93EyMwSrYd1urbwXh/
        SfwhRgEORiUeXoej66KEWBPLiitzDzFKcDArifA+vQIU4k1JrKxKLcqPLyrNSS0+xCjNwaIk
        zns771ikkEB6YklqdmpqQWoRTJaJg1OqgVFim9N62c4jnRVehhPVHtVOsb/VM+f0ytmntMTy
        bjvNnHeDS7km9tGclxOW7O89NM/s2+zPqrx83xv+T7KRuNhTy2vycZ7j5sW3xbv15s2r/zv7
        3N/D5dbcX3Ltf74Rrai/Zbym2OfQij8n/Msrt5RNaHgfVrv3t3JM7n/+8F08fFrBwgqF3UuU
        WIozEg21mIuKEwHBIu4ujgIAAA==
X-CMS-MailID: 20180319151443epcas1p2af121edc3ad4867e10a884f3aa19369a
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180319102927epcas1p12d4a070d0a7125db9424990b997c01c8
X-RootMTR: 20180319102927epcas1p12d4a070d0a7125db9424990b997c01c8
References: <CGME20180319102927epcas1p12d4a070d0a7125db9424990b997c01c8@epcas1p1.samsung.com>
        <20180318153512.8343-1-krzk@kernel.org>
        <9bb639c3-f4e9-3a1e-61e8-a34fcfd0a344@samsung.com>
        <CAJKOXPcBesWpBoq07XbE1j3F1_N5dAWMTRkv8SN=tSMEm1q0iQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/19/2018 11:56 AM, Krzysztof Kozlowski wrote:
> On Mon, Mar 19, 2018 at 11:29 AM, Sylwester Nawrocki
> <s.nawrocki@samsung.com> wrote:
>> On 03/18/2018 04:35 PM, Krzysztof Kozlowski wrote:
>>> Compatible for XU4 audio is not being used.  Instead the board uses the
>>> same compatible as XU3.  The devices are now just compatible so they
>>> should use the same value.  Mark "hardkernel,odroid-xu4-audio" as being
>>> deprecated so in this future could be removed to limit useless
>>> properties.
>>
>> It doesn't feel right to obsolete the "hardkernel,odroid-xu4-audio"
>> compatible, there is significant difference between XU3 and XU4 - there
>> is no audio CODEC on XU4, this board only supports audio over HDMI interface.
>> XU4 could be compatible with XU3, but not the other way around.
>> It just happens we have other DT properties that help to handle such HW
>> design difference.
> 
> The compatible does not describe physical differences. It does not
> mean that devices are the same. In this case they are just coming from
> the same family and they operate the same, from the bindings
> perspective.

>From the ePAPR 'compatible' string definition you cited, the compatible 
string is supposed to indicate programming model of a device, for the purpose 
of matching a driver. I thought the programming model refers to the driver's
SW interfaces used to control the hardware, rather than only to a particular
DT binding design. And XU4 is not compatible with XU3 from device programming
perspective.

> The XU4 binding is not being used. Adding a compatible which is not
> used in the moment of adding is a proof that this compatible is not
> needed. It is just a duplicate. There is no point of adding
> duplicates.

I disagree it is just an unnecessary duplicate, I think dts for XU4 could
fixed instead of dropping that compatible from the binding.
>> Moreover, only XU4 is still in production and should be in few more years [1],
>> others are obsoleted now.
> 
> It is not a problem. Whether device is manufactured or not, does not
> reflect what bindings we are using. Deprecated XU4 compatible does not
> mean that XU4 itself is deprecated. Just this compatible should not be
> used for new DTS.

>> So I think we should keep at least these 2 compatible strings:
>>
>> - "hardkernel,odroid-xu3-audio" - for boards with audio CODEC,
>> - "hardkernel,odroid-xu4-audio" - for boards without audio CODEC,
>>    supporting only HDMI interface.
> 
> Yeah, and then we inflate this list into X, X2, U3, HC1 and all others
> which are the same. And then we should add XU3-lite (it is different
> device). This goes to some nonsense. Compatible is not for each device
> but for family even though there are differences between specific
> devices.

You are not listening, I refer only to major audio subsystem differences.
It would have been:

 - "hardkernel,odroid-xu3-audio" for: U2, U3, X, X2, XU, XU3, XU3-Lite
 - "hardkernel,odroid-xu4-audio" for: XU4

But if you insist on only one compatible I'm not going to argue further,
you will be responsible for this. :)  

-- 
Regards,
Sylwester
