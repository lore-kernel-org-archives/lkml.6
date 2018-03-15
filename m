Return-Path: <rogerq@ti.com>
X-Google-Smtp-Source: AG47ELuQOWdyJQhxz7iGTV6jVcvDGk7HRFvqo/YXKXWlveko/S9UxJh3TxBWJZw4HmeOAIfBm69o
ARC-Seal: i=1; a=rsa-sha256; t=1521133725; cv=none;
        d=google.com; s=arc-20160816;
        b=cU1LE/yetXmeeioHb6MbtjOtmKOQFZO4D1Kkl8hWQyv+B1dVt39Iiz5btRnh7sQ32Z
         ZEp+VfnMMVcH+Tqjh+StHzItTES5Speg7Nq21IqEJxJysbTpND3dP5KFDGd8HM6knRUL
         LsCBxDaCiHlcHtLVueAKgcrAws0dmZ6aZ8qQarfxX3MltXFILUZSrNQnqDP9e8HwB9k2
         PhOVsCAWdnwhouJb6tRC3Nck0G4oktNNWRSvo7FEfVXEf3JAeKH0NJIG0Tk1DPB7/43f
         ILR5hOrowoZmQUirBu1QYHLWRP7QVSOFLb/eknUMsL8+cnQUSSVycUavM4igTIi3eQVd
         RT/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=HKqPeMji2jAvcuDk+UO1drK+B6FDBDR7i04lDkoiqew=;
        b=X3tQrPp/w3u+DiNK8066gnbcT8IiblTJWQ5XkbfVCvhLQjEROarxViJDWXKkvaq2aE
         KXqguF5mz1snprFmLQyHoq+BolhgXYHjXGMLD+RWqRUytTSp+U8ZO0fMB75E0u4yO1WP
         FMv6s4FuY2K5lF7QwU1IElJRJjEpNoQd35WRcqcLtw+nKQbLJByKHi1BemBlq+TDeYB0
         LM4QTMkRlPXXXpQz7gkoE8e4hPBDZwb2L8YsRouAMC+iE6iHp4M3LFRddwl693xYEyDy
         /eFmOSof3oKAo65rlo8Wt18+G1pjEvJ00FKnTE3ydxt93nJH4RSZykFe8Oa54HuZGVzB
         YO4g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=hCMSHl/T;
       spf=pass (google.com: domain of rogerq@ti.com designates 198.47.19.17 as permitted sender) smtp.mailfrom=rogerq@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=hCMSHl/T;
       spf=pass (google.com: domain of rogerq@ti.com designates 198.47.19.17 as permitted sender) smtp.mailfrom=rogerq@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Subject: Re: [PATCH v5 1/6] dt-bindings: add bindings for USB physical
 connector
To: Robin Murphy <robin.murphy@arm.com>, Andrzej Hajda <a.hajda@samsung.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Felipe Balbi <balbi@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        <linux-samsung-soc@vger.kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Bartlomiej
 Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, Inki Dae
	<inki.dae@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Marek Szyprowski
	<m.szyprowski@samsung.com>
References: <20180227071134.28063-1-a.hajda@samsung.com>
 <CGME20180227071138eucas1p17e1e16f13f6d3e3b15a57dc93eb8cf3f@eucas1p1.samsung.com>
 <20180227071134.28063-2-a.hajda@samsung.com>
 <ed0ce43c-3c81-b027-2eb1-30e49156c3ac@ti.com>
 <b588527d-2ca2-9e88-9e27-e09e5b52f8d6@samsung.com>
 <12da0d00-9ab3-3752-793b-e487666f35a3@ti.com>
 <1c3f8cde-4f9a-306f-b4f9-c0bdc76caf1f@arm.com>
From: Roger Quadros <rogerq@ti.com>
Message-ID: <a470c2e0-09ea-fc3a-2eef-bba2af18b33f@ti.com>
Date: Thu, 15 Mar 2018 19:08:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1c3f8cde-4f9a-306f-b4f9-c0bdc76caf1f@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1594728151455116260?=
X-GMAIL-MSGID: =?utf-8?q?1595024316871487594?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 15/03/18 13:46, Robin Murphy wrote:
> On 12/03/18 10:41, Roger Quadros wrote:
> [...]
>>>>> @@ -0,0 +1,75 @@
>>>>> +USB Connector
>>>>> +=============
>>>>> +
>>>>> +USB connector node represents physical USB connector. It should be
>>>>> +a child of USB interface controller.
>>>>> +
>>>>> +Required properties:
>>>>> +- compatible: describes type of the connector, must be one of:
>>>>> +    "usb-a-connector",
>>>>> +    "usb-b-connector",
>>>>> +    "usb-c-connector".
>>>> compatible should be just "usb-connector"
>>>>
>>>> Type should be a property
>>>>
>>>> type: type of usb connector "A", "B", "AB", "C"
>>>> AB is for dual-role connectors.
>>>
>>> I have proposed such property (and size also) in my first RFC [1]. Rod
>>> did not like it :)
>>>
>>> [1]: https://marc.info/?l=devicetree&m=150660411515233&w=2
>>>
>>
>> This is what Rob says here https://patchwork.kernel.org/patch/9976043/
>> "We did "type" for hdmi-connector, but I think I'd really prefer
>> compatible be used to distinguish as least where it may matter to s/w.
>> In the HDMI case, they all are pretty much the same, just different
>> physical size."
>>
>> So the question is. Does it matter to this particular software implementation
>> if it is type A,B,C connector?
>> If yes, how?
>>
>> Type A will never have any alternate function. It is always dedicated to USB.
> 
> In USB spec terms, at least. In reality there are things like the cool trick Rockchip SoCs do whereby they can expose the debug UART Rx/Tx through the OTG port's D+/D- pins, and that is on a type A connector in many products. I'm guessing that's probably beyond the scope of this binding, though.
> 
>> Also does the size "full", "micro", "mini" matter to software?
> 
> If it means the user can look in sysfs to easily correlate logical ports with physical connectors that's certainly handy (e.g. on something like Odroid-XU where the two USB3 ports are brought out to an A and a micro-AB connector respectively).

But this logic fails if both connectors are the same type/size.
This is where the label comes in handy. The labels can be unique and end user can identify the port using that.

> 
> Robin.

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
