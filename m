Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752013AbeBZCHo (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 21:07:44 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:20073 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751931AbeBZCHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 21:07:41 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180226020739epoutp0385e278b231ce95737beea451f50f0f9d~WvgZ89eXL3080030800epoutp03J
X-AuditID: b6c32a37-433ff70000001029-95-5a936beb9ae6
Subject: Re: [PATCH 1/6] mmc: dw_mmc: remove the deprecated
 "clock-freq-min-max" property
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joachim Eastwood <manabian@gmail.com>, dinguyen@kernel.org,
        Will Deacon <will.deacon@arm.com>, "xuwei (O)" <xuwei5@hisilicon.com>
From: Jaehoon Chung <jh80.chung@samsung.com>
Message-id: <9938e4eb-45aa-bf68-dd64-bb0a23f99e3d@samsung.com>
Date: Mon, 26 Feb 2018 11:07:38 +0900
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
        Thunderbird/52.5.0
MIME-version: 1.0
In-reply-to: <CAHp75VcthggOwOPjQFNX-xMmK44F99oXYOdeBxfO=euT_JvkoQ@mail.gmail.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-US
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm2znbzsrF17T8MjI7UKi1tTOnO4azIqtB/RgUSYtaB/1wotts
        Z9qFoMJLaaJlhbnuRZFiZXbT0opdWlFZWiaVGZHF7Er36H7mMfDf8z7f83zv+7y8FKGql8VQ
        uQ43djm4fFo2gjzvS9CqX+ftsGjfvyDZgW0+wB7wd0jZwJ1LEvbexb0y1v+3GrCXejoAe7Sn
        U8KWtvvlbG//KSkbPJHJDny4TrL9gZ3ErAhT4/5GYGr1PJGbnu87LTc1N5TLTL0P2mSm354r
        pOlTc6xZbsFpNsxlY1ccdmQ5s3MdOUZ6wSLrHGtyipZRM6msgY5zcHZspDMWmtXzcvOFQem4
        Ii6/UKDMHM/T09PTXM5CN46zOXm3kV7GMDoNozVodDqdRp+0fIYuWZCsxLbDTe1EwaORa+pD
        /dKN4JSiAigoBPXIG3ojrQAjKBVsAaiv3CcXi29CcSMg+a/q7jtGig9NAIW6/krEog+g/qoj
        RFgVCZch364/gp2iomAmunZ/bFhDwB8SdKK1C4Q1MjgNXfgaHPxVCdNR8ZESeRiTcDI62O2V
        hvEYuAQF6j4CUTMafd/RR4b/VMBFaJM/PkwTMAGFPteQIo5GxaUPh/BEdKbxLRHui2CxHHWf
        8ZNiggzU2VBNiDgSvQqeHZwTwfGoK2AU6c0A3d4TKXp3AnR899ah9Eno5aEKidhgFHr3pVIq
        epVoS5lKlJjQ57KjpEjPRo3BoSV2S9DPujbpNhDrGZbGMyyCZ1gEz7AIBwHZAMbiAt6eg3mm
        IEnDc3a+0JGjyXLam8HgmSYaWkBTx0IvgBSgI5Tff9ZYVFKuiF9r9wJEEXSU8tE6gVJmc2vX
        YZfT6irMx7wXJAvb3k7EjMlyCkfvcFsZfapWn6ITTi2VYehopdmcYVHBHM6N8zAuwK7/Pgml
        iNkI9GWB+Lm39jakz5zyNDCr/YcR1t2M1c74VV0/v33906nPJrWOa7mL79WO5q6+2ByhVttC
        yjZf8O3pxeXTLifMNawo6ZqwoUS3aunD1S+XPLbsPjfeakkt7bxwJRuG8lyrFL/dva+nRMGT
        5xhtYuiB3vC1Cp+t+ZXmCb6pzDTHp9TW0iRv45hEwsVz/wAX27OfvAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42I5/e+xoO6r7MlRBrPPGFu8nHCY0WL+kXOs
        FkfP72ayuLxrDpvFkf/9jBa7r59jtFh6/SKTReveI+wWd56sZ7U4vjbc4uXHEywWT45OYXbg
        8Vgzbw2jx85Zd9k9Hs/dyO6xaVUnm8eda3vYPP7O2s/i8XmTXAB7FJdNSmpOZllqkb5dAlfG
        og17mQtucVesfPGEtYFxPWcXIyeHhICJxNV7y1i6GLk4hATWMUqsnHaeEcJ5wCjxbdJ+NpAq
        YYFoicNT/7GD2CIC4RKn9h9iBrGZBX4xSVxfwQvRcJ1J4tSlGYwgCTYBHYnt344zgdi8AnYS
        zYtbwJpZBFQlFlw9xApiiwqESfRsuswIUSMo8WPyPaAzODg4BYIl9pwxBjGZBdQlpkzJhVgl
        LtHcepMFwpaX2LzmLfMERoFZSJpnIXTMQtIxC0nHAkaWVYySqQXFuem5xUYFhnmp5XrFibnF
        pXnpesn5uZsYgXG07bBW3w7G+0viDzEKcDAq8fD++D0pSog1say4MvcQowQHs5II760qoBBv
        SmJlVWpRfnxRaU5q8SFGaQ4WJXHe23nHIoUE0hNLUrNTUwtSi2CyTBycUg2Mq7TWbnBRiti7
        /8rhT1ufye3etnJZc+dP3S0ihm8uXzNi6vwklbcl8SWfS+WplVZr5/b7/q9JOm3jlpZ77dg9
        nznGutIH47pPZ7SePv4j8ta1uVfXT9V58H25x34bsUSfRUyHcyfnRazPesz3MedADXdrj05H
        7rtbd5L+lZg1nVbcrvwtNMf1qhJLcUaioRZzUXEiAJa1JPqfAgAA
X-CMS-MailID: 20180226020738epcas1p4dc28391e2289a04eb654378893ef827e
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180223064140epcas2p104fe6cca431ec24f2b09a6f5a45ed342
X-RootMTR: 20180223064140epcas2p104fe6cca431ec24f2b09a6f5a45ed342
References: <CGME20180223064140epcas2p104fe6cca431ec24f2b09a6f5a45ed342@epcas2p1.samsung.com>
        <20180223064138.18401-1-jh80.chung@samsung.com>
        <CAHp75Vd27mFnSJTOta0ZWhfOGz1WA8ETNgU_GpuxEJ9nnhsR-g@mail.gmail.com>
        <7ba335af-3fc5-2afd-8c52-03dca5eba9a4@rock-chips.com>
        <CAHp75VcthggOwOPjQFNX-xMmK44F99oXYOdeBxfO=euT_JvkoQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/24/2018 01:16 AM, Andy Shevchenko wrote:
> On Fri, Feb 23, 2018 at 4:19 PM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>> On 2018/2/23 21:27, Andy Shevchenko wrote:
>>> On Fri, Feb 23, 2018 at 8:41 AM, Jaehoon Chung <jh80.chung@samsung.com>
>>> wrote:
>>>>
>>>> 'clock-freq-min-max' property had already deprecated.
>>>> Remove the 'clock-freq-min-max' property that is kept to maintain
>>>> the compatibility.
>>>
>>>
>>> Removing a property without telling the user what to expect is a bad
>>> idea and ABI breakage.
>>>
>>
>> What's the general process to remove a property?
>>
>> I guess we should do:
>> 1) deprecate it in the first place and remove it from all upstream DT
>> 2) wait some long enough days for expecting the stale of all old DTB
>> containing that property
>> 3) remove the functionality of the deprecated property from the driver
>> but still leave some warning there
>> 4) remove the left warning finally
> 
> I don't know. Perhaps Rob can shed a light here.
> But I would really OK with removal of some of such properties from
> some drivers where it's more burden to keep them.

This property had deprecated about 8months ago.
I think that it was enough to keep this property for maintaining the compatibility.

I didn't remove this property without any alternative.

Best Regards,
Jaehoon Chung

> 
>> And for the ABI breakage, we should add something in Documentation/ABI
>> /obsolete  or Documentation/ABI/removed ?
> 
