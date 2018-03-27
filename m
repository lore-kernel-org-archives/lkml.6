Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752040AbeC0HNA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 03:13:00 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46908 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750907AbeC0HM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 03:12:56 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180327071253euoutp01321761afb9a28b4bb3417c031cf852cc~ftYMNI1_I1985919859euoutp01C
X-AuditID: cbfec7f2-1dbff70000011644-a5-5ab9eef2f8ea
Subject: Re: [PATCH v6 1/3] dt-bindings: display: bridge: Document
 THC63LVD1024 LVDS decoder
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Rob Herring <robh@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        architt@codeaurora.org, airlied@linux.ie, horms@verge.net.au,
        magnus.damm@gmail.com, geert@linux-m68k.org,
        niklas.soderlund@ragnatech.se, sergei.shtylyov@cogentembedded.com,
        mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <1dd27170-153c-90f6-e13f-949ba7d0d4a9@samsung.com>
Date: Tue, 27 Mar 2018 09:12:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <a1b0e678-38b8-dd29-b441-e2a09b565105@mentor.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTYRTHed671uR1XTyZFC2iDCoFPzxYjQo/vCBS0gdDwVz5esFpsand
        qGRmTUvL7k5rrhqG2c3cmt2d1RDLNKPUModZdpvVbEUNXc7XwG+/c/7/c87zh4cj5fuZUC4z
        J1fU5KjUCiaQsj7+82yJe6gxMaL/HcalbS0E1uldNDY+bKPxC883Bn/ouUvgQosHYYf3MouL
        yy+wuPNWFYMtn4YI7LzkYrD5VQeBHSfLaOy7Y2Pxk9oeFn94YGVW8ULd2TokdJaVEoLzhI8Q
        Gg29rFCpr6AFX1c/KdTXFjOCvVmPhJu/nLTQd9BBCLc9OiQMdv5mhKo/vyhhuH7OuqDEwBWp
        ojozX9QsU6YEZtxu7qG23puzvfX1MFuARqAEBXDAR4HpyhO2BAVycv4igrdH3KRU/ETQVvhm
        ohhGUGH8S/wfqW3tR5JQg+Byr26icCE45NXTftc0Phma7cWkn6fzm2Cwo298FcmbSdCNvqT8
        AsOHw8iNbsbPMl4Jvhdfx17CcRS/ALynU/ztGfwGMJ14jyRLMLRUDIyPBozZrYPV40zyEfDw
        XBUt8VwotFSSEodAz4CR8N8F3sZB/eEyyr8f+Bh48GqhlGYafHY0sBKHga/ROJFyF3R/1FHS
        rB5Bn/cAIwnLodnRQUu8Epz33RM7g6DLFSzdDYKj1lOk1JaBfr9ccs+DvqcWUuIQMLd7mCNo
        vmFSMsOkNIZJaQyT0lQjqhaFiHna7HRRG5kjbluqVWVr83LSl27ekl2Pxn5n66jDbUOe55vs
        iOeQYqpsFdOYKKdV+dod2XYEHKmYLssyj7VkqaodO0XNlo2aPLWotaPZHKUIkSUv2pMo59NV
        uWKWKG4VNf9VggsILUDqlkum3vPJ1u4l8adia67PvNlUZIp4VHr8e9f673abMi2hoTwpZvfc
        qLzQjPbFFnaN5Zhrb0JHAVJcS0sNfj6rJFM3pWg0Pnqf0aW0vY/9sa/JFPdlbeyx9WeaZrij
        awYERV1WW2RFZnhuKT8Ul/I4NP7GyXBzwlWlMzosd/XauCQFpc1QRS4mNVrVP/mPZPmZAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsVy+t/xe7of3+2MMvj5nNei99xJJoumjres
        FvOPnGO1uPL1PZvFs1t7mSyat35ltDj+ey27RefEJewWl3fNYbPY+vIdk8WD1W/ZLJZev8hk
        cXxaH6vF/z072C3OrLrFbvHswDY2BwGPNfPWMHpc7utl8ngw9T+Tx85Zd9k9ZnfMZPX4f+MR
        s8emVZ1sHocOdzB6bP/2gNXjfvdxJo/dX5sYPZ5f/s7mMefnNxaPz5vkAvii9GyK8ktLUhUy
        8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DJ2H77FUrBPruL07c/s
        DYx/JboYOTkkBEwkVp1+xNjFyMUhJLCUUaLz2SY2iIS4xO75b5khbGGJP9e62CCKXjNKXJn8
        ghUkISwQJ3H4UCdQEQeHiECSxITdziA1zAJLmSW+TToHNfU+k8TqL/1gDWwCmhJ/N98E28Ar
        YCfx/8obdpBmFgFVid8zEkDCogIREp0r57NAlAhKnJz5BMzmBCrf9nwBmM0soCex4/ovVghb
        XqJ562xmCFtc4taT+UwTGIVmIWmfhaRlFpKWWUhaFjCyrGIUSS0tzk3PLTbSK07MLS7NS9dL
        zs/dxAhMFNuO/dyyg7HrXfAhRgEORiUe3hkcO6OEWBPLiitzDzFKcDArifBmLwUK8aYkVlal
        FuXHF5XmpBYfYjQF+m0is5Rocj4wieWVxBuaGppbWBqaG5sbm1koifOeN6iMEhJITyxJzU5N
        LUgtgulj4uCUamA8OX3y1TL21w863T0e365u0eyeYM987adLlVj50wTGtWaCDepPjGxNwifO
        mnvS4VyqZaXF6nuzJ/b8djsl6LdmmnKEuJXyB8nSMI0N567lnL/ZUc26N2ymvL9YaK2/YfCh
        2YKTzos/65Xc5vf38ObCC/80DodnTU89X/NbctmT7ldc36/7BxUqsRRnJBpqMRcVJwIAvB5N
        2CoDAAA=
X-CMS-MailID: 20180327071249eucas1p250947918fb3ab02ea9618903ad5ded21
X-Msg-Generator: CA
X-MTR: 20180327071249eucas1p250947918fb3ab02ea9618903ad5ded21
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180327061536epcas5p40faf6caf0d9825e6c33cd3e6ba9d8378
X-RootMTR: 20180327061536epcas5p40faf6caf0d9825e6c33cd3e6ba9d8378
References: <1521213399-31947-1-git-send-email-jacopo+renesas@jmondi.org>
        <1521213399-31947-2-git-send-email-jacopo+renesas@jmondi.org>
        <4060923.7DxT9ae38L@avalon> <20180326222249.tvjiutyd4amlibpa@rob-hp-laptop>
        <CGME20180327061536epcas5p40faf6caf0d9825e6c33cd3e6ba9d8378@epcas5p4.samsung.com>
        <a1b0e678-38b8-dd29-b441-e2a09b565105@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.03.2018 08:15, Vladimir Zapolskiy wrote:
> Hi Jacopo,
>
> On 03/27/2018 01:22 AM, Rob Herring wrote:
>> On Tue, Mar 20, 2018 at 02:43:33PM +0200, Laurent Pinchart wrote:
>>> Hi Jacopo,
>>>
>>> (CC'ing Rob)
>>>
>>> Thank you for the patch.
>>>
>>> On Friday, 16 March 2018 17:16:37 EET Jacopo Mondi wrote:
>>>> Document Thine THC63LVD1024 LVDS decoder device tree bindings.
>>>>
>>>> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
>>>> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
>>>> Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
>>>> ---
>>>>  .../bindings/display/bridge/thine,thc63lvd1024.txt | 66 +++++++++++++++++++
>>>>  1 file changed, 66 insertions(+)
>>>>  create mode 100644
>>>> Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
>>>>
>>>> diff --git
>>>> a/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
>>>> b/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
>>>> new file mode 100644
>>>> index 0000000..8225c6a
>>>> --- /dev/null
>>>> +++
>>>> b/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
>>>> @@ -0,0 +1,66 @@
>>>> +Thine Electronics THC63LVD1024 LVDS decoder
>>>> +-------------------------------------------
>>>> +
>>>> +The THC63LVD1024 is a dual link LVDS receiver designed to convert LVDS
>>>> streams
>>>> +to parallel data outputs. The chip supports single/dual input/output modes,
>>>> +handling up to two two input LVDS stream and up to two digital CMOS/TTL
>>>> outputs.
>>>> +
>>>> +Single or dual operation modes, output data mapping and DDR output modes
>>>> are
>>>> +configured through input signals and the chip does not expose any control
>>>> bus.
>>>> +
>>>> +Required properties:
>>>> +- compatible: Shall be "thine,thc63lvd1024"
>>>> +
>>>> +Optional properties:
>>>> +- vcc-supply: Power supply for TTL output and digital circuitry
>>>> +- cvcc-supply: Power supply for TTL CLOCKOUT signal
>>>> +- lvcc-supply: Power supply for LVDS inputs
>>>> +- pvcc-supply: Power supply for PLL circuitry
>>> As explained in a comment to one of the previous versions of this series, I'm 
>>> tempted to make vcc-supply mandatory and drop the three other power supplies 
>>> for now, as I believe there's very little chance they will be connected to 
>>> separately controllable regulators (all supplies use the same voltage). In the 
>>> very unlikely event that this occurs in design we need to support in the 
>>> future, the cvcc, lvcc and pvcc supplies can be added later as optional 
>>> without breaking backward compatibility.
>> I'm okay with that.
>>
>>> Apart from that,
>>>
>>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>>
>>>> +- pdwn-gpios: Power down GPIO signal. Active low
>> powerdown-gpios is the semi-standard name.
>>
> right, I've also noticed it. If possible please avoid shortenings in
> property names.

It is not shortening, it just follow pin name from decoder's datasheet.

>
>>>> +- oe-gpios: Output enable GPIO signal. Active high
>>>> +
> And this one is also a not ever met property name, please consider to
> rename it to 'enable-gpios', for instance display panels define it.


Again, it follows datasheet naming scheme. Has something changed in DT
conventions?

Regards
Andrzej

>
>>>> +The THC63LVD1024 video port connections are modeled according
>>>> +to OF graph bindings specified by
>>>> Documentation/devicetree/bindings/graph.txt
> [snip]
>
>>>> +
>>>> +			port@2{
>>>> +				reg = <2>;
>>>> +
>>>> +				lvds_dec_out_2: endpoint {
>>>> +					remote-endpoint = <&adv7511_in>;
>>>> +				};
>>>> +
> Drop a surplus empty line above.
>
>>>> +			};
>>>> +
> Drop a surplus empty line above.
>
>>>> +		};
>>>> +	};
> --
> With best wishes,
> Vladimir
>
>
>
