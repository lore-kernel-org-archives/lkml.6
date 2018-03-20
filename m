Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751682AbeCTSI7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 14:08:59 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:26471 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbeCTSI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 14:08:56 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180320180854epoutp0382c295d9803c24ab15260011085148e9~dsz90crxs2442724427epoutp03d
X-AuditID: b6c32a36-c91ff70000001028-25-5ab14e359967
Subject: Re: [PATCH v2] ASoC: samsung: Mark unused Odroid compatibles as
 deprecated
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sangbeom Kim <sbkim73@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <248b81f5-adb2-a8cb-75a0-960bfaab89cc@samsung.com>
Date: Tue, 20 Mar 2018 19:08:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-version: 1.0
In-reply-to: <CAJKOXPe1_g3XoVSorXRAsLB532TCxoSi-GAgm5Ve9-PxkM3OKw@mail.gmail.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsWy7bCmrq6p38Yog+MrrSyuXDzEZDH14RM2
        i/lHzrFanD+/gd3i25UOJovLu+awWSy9fpHJonXvEXaLiyu+MDlwemz43MTmsWbeGkaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgFsUVw2Kak5mWWpRfp2CVwZG7YdYSlolKu40x3TwNgr0cXIySEh
        YCLx6eNRpi5GLg4hgR2MEktPXGWEcL4zSpxpnM4MU3Wh8SFUYgOjRNfzZkaQhJDAfUaJL5cL
        QWxhgVCJj/M/soDYIgKaEtf/fmcFsZkFJjBJ7N+mAmKzCRhK9B7tA+vlFbCT+PrzEDuIzSKg
        KvF1yluwuKhAhMTCqU+hagQlfky+BzaTUyBY4sK8V+wQMzUlXnyZxAJhi0scu3+TEcKWl9i8
        5i0zyKESAs/ZJM7u/wNUxAHkuEg8P60D8YywxKvjW9ghwtISl47aQoSrJTrbutghWlsYJf5M
        u8QGkbCWOHz8ItQvfBLvvvawQvTySnS0CUGUeEjM3reHHcJ2lGg+tgAaov+ZJN5962CbwCg3
        C8k7s5C8MAvJC7OQvLCAkWUVo1hqQXFuemqxYYGRXnFibnFpXrpecn7uJkZwutEy28G46JzP
        IUYBDkYlHt4JEhujhFgTy4orcw8xSnAwK4nwZioAhXhTEiurUovy44tKc1KLDzFKc7AoifMG
        BLhECQmkJ5akZqemFqQWwWSZODilGhj5rszsnbDr+8u8nN6goyc++YvM9pi85pF31+HFnLN7
        77v+cWN6d8xjR+b6HL0/U2ZOu+t2q+7BNgF3tlPJ5+RmbBN4NOtandqRlZcd3dQrr6jfYgrS
        XXNyyg0Th9QdLb/nCKZJvxBR6zoZte3wHD/jbRyBv44bPyiIYM+Z2qFU8P2Rav03sZg4JZbi
        jERDLeai4kQAKr0tmzMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsVy+t9jQV1Tv41RBrNPyFpcuXiIyWLqwyds
        FvOPnGO1OH9+A7vFtysdTBaXd81hs1h6/SKTReveI+wWF1d8YXLg9NjwuYnNY828NYweO2fd
        ZffYtKqTzaNvyypGj8+b5ALYorhsUlJzMstSi/TtErgyNmw7wlLQKFdxpzumgbFXoouRk0NC
        wETiQuNDxi5GLg4hgXWMEqcu/mWHcB4ySuw/e5kFpEpYIFTi4/yPYLaIgKbE9b/fWUGKmAUm
        MEkcaGtkg+hoZJZYv+QGG0gVm4ChRO/RPkYQm1fATuLrz0PsIDaLgKrE1ylvweKiAhESnSvn
        s0DUCEr8mHwPzOYUCJb496gHaAMH0AZ1iSlTckHCzALiEsfu32SEsOUlNq95yzyBUWAWku5Z
        CB2zkHTMQtKxgJFlFaNkakFxbnpusVGBYV5quV5xYm5xaV66XnJ+7iZGYIxsO6zVt4Px/pL4
        Q4wCHIxKPLwWYhujhFgTy4orcw8xSnAwK4nwZioAhXhTEiurUovy44tKc1KLDzFKc7AoifPe
        zjsWKSSQnliSmp2aWpBaBJNl4uCUamDcYi/cLCUh4PV67n7Rzy2LU3ri37+TPSj5OS/fQVMx
        78Ls18mLtiYfi8iR7P2ZOkF2YuOcuFDRmg/mX92uplsc61f8kJM54a33PP6V58VS4/5+Wtrl
        Y73eIf/r8r8vVTR4khbrvisqbv1/47/KmQ3tCzt/rvv+puaM/l8pqZM2Hsvi39zgn39DiaU4
        I9FQi7moOBEA9vXpEo0CAAA=
X-CMS-MailID: 20180320180853epcas1p1e69ece35d6777d2abcff7bc4201b0041
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180319102927epcas1p12d4a070d0a7125db9424990b997c01c8
X-RootMTR: 20180319102927epcas1p12d4a070d0a7125db9424990b997c01c8
References: <CGME20180319102927epcas1p12d4a070d0a7125db9424990b997c01c8@epcas1p1.samsung.com>
        <20180318153512.8343-1-krzk@kernel.org>
        <9bb639c3-f4e9-3a1e-61e8-a34fcfd0a344@samsung.com>
        <CAJKOXPcBesWpBoq07XbE1j3F1_N5dAWMTRkv8SN=tSMEm1q0iQ@mail.gmail.com>
        <12dfaefb-fd79-7a1d-2676-307d4e28b7e1@samsung.com>
        <CAJKOXPe1_g3XoVSorXRAsLB532TCxoSi-GAgm5Ve9-PxkM3OKw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/20/2018 08:11 AM, Krzysztof Kozlowski wrote:
> On Mon, Mar 19, 2018 at 4:14 PM, Sylwester Nawrocki
> <s.nawrocki@samsung.com> wrote:
>> On 03/19/2018 11:56 AM, Krzysztof Kozlowski wrote:
>>> On Mon, Mar 19, 2018 at 11:29 AM, Sylwester Nawrocki
>>> <s.nawrocki@samsung.com> wrote:
>>>> On 03/18/2018 04:35 PM, Krzysztof Kozlowski wrote:

>>> The compatible does not describe physical differences. It does not
>>> mean that devices are the same. In this case they are just coming from
>>> the same family and they operate the same, from the bindings
>>> perspective.
>>
>> From the ePAPR 'compatible' string definition you cited, the compatible
>> string is supposed to indicate programming model of a device, for the purpose
>> of matching a driver.
> 
> Yes, you're correct, it refers to programming model. Although later
> you will find second explanation (chapter 4): "The compatible property
> of a device node describes the specific binding (or bindings) to which
> the node complies.".

Yes, I'm aware of that.
>> I thought the programming model refers to the driver's
>> SW interfaces used to control the hardware, rather than only to a particular
>> DT binding design. And XU4 is not compatible with XU3 from device programming
>> perspective.
> 
> The programming models of XU4 and XU3 audio components, to which we
> refer now and which are implemented/used, are the same. I mean not the
> same in general, but how we use them. The used subset of each is the
> same. Therefore the binding and the driver do not distinguish any
> differences (like codec).
 
Actually the driver has to determine the number of codecs, as one of them 
requires additional configuration steps. But this is currently being taken
care of by looking at number of entries in one of the properties.

>>> The XU4 binding is not being used. Adding a compatible which is not
>>> used in the moment of adding is a proof that this compatible is not
>>> needed. It is just a duplicate. There is no point of adding
>>> duplicates.
>>
>> I disagree it is just an unnecessary duplicate, I think dts for XU4 could
>> fixed instead of dropping that compatible from the binding.
> 
> You know, there is nothing to fix - changing the compatible to XU4
> will not change anything. The executed code will be exactly the
> same...

Right, there is really no need now for another compatible as the 
differences across boards are handled through additional properties. 

>>>> So I think we should keep at least these 2 compatible strings:
>>>>
>>>> - "hardkernel,odroid-xu3-audio" - for boards with audio CODEC,
>>>> - "hardkernel,odroid-xu4-audio" - for boards without audio CODEC,
>>>>    supporting only HDMI interface.
>>>
>>> Yeah, and then we inflate this list into X, X2, U3, HC1 and all others
>>> which are the same. And then we should add XU3-lite (it is different
>>> device). This goes to some nonsense. Compatible is not for each device
>>> but for family even though there are differences between specific
>>> devices.
>>
>> You are not listening, I refer only to major audio subsystem differences.
>> It would have been:
>>
>>  - "hardkernel,odroid-xu3-audio" for: U2, U3, X, X2, XU, XU3, XU3-Lite
>>  - "hardkernel,odroid-xu4-audio" for: XU4
>>
>> But if you insist on only one compatible I'm not going to argue further,
>> you will be responsible for this. :)
> 
> Ah, I read too fast and missed that point. Actually that is nice
> consensus in this case.

As Mark said, it is not essential what we decide here, my preference was 
to keep these 2 compatibles. I might got confused a bit and did not consider
a more feature complete "hardkernel,odroid-xu3-audio" binding being applied 
to a XU4 device supporting only a subset of functionality.

-- 
Regards,
Sylwester
