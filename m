Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753508AbeDMBQn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 21:16:43 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:25055 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751771AbeDMBQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 21:16:41 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180413011639epoutp02504ec88266572c06dad35050aa41aeef~k2fAyja2U0791307913epoutp02q
X-AuditID: b6c32a35-151ff70000000fee-dd-5ad00453f25d
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Message-id: <5AD00452.5060400@samsung.com>
Date: Fri, 13 Apr 2018 10:13:54 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH] extcon: int3496: use proper GPIO include
In-reply-to: <5AD0032E.6020103@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUgTcRjH+e1u27lcXTPth0WuiyAnzt2cNstFpdhMA02iWJQdekxrb+w2
        S6GwiIxh5kxazsyE0pAoMQvTtLJZWDLHLCe1grLClxB6z16g266o/77Pl8/Dl+fLgyGSGX4s
        Vmqy0VYTZSAEIvTGvXhFYgHq0ymuNEjV9T/beOrRnrMC9fWpWZ762eFLAnWNd9N6vjY4dkug
        relqB9q3LVdR7cfOZXmojk4voali2iqlTUXm4lKTXkPkFBRmFKakKshEMk29mpCaKCOtITJz
        8xKzSg1sLCEtowx21sqjGIZIWpduNdtttLTEzNg0xE6SVMpJxWq5UqmUq5J3rVGmsMgeuuR8
        ux9Y3okOBIcnBJVgFnOACAziKvhyfApxABEmwbsBDPS9B9zwFUCfa5DvAFiYuvYym/N7AfQc
        beKFtsX4Qvjt1As0xCB4HPT494VsBI+Hk5/qUI5/DmD/kfsox8tgk786rFF8Jbw71AFCWsD6
        tyfHBSG9AF8On3ybCPvR+A54s/mLMKQX4QUw8PA+4AIqoHOuLsxH4RrYc6Er7EfgCbDxS68w
        FAzxDgE8M3QH5c7MhEc/PAacjoLTD7qE3GFLoH9Qw/FVAFb1nUO4oR5Ab+AFj1tIhm9bHDwu
        eT6c/Vz9pxUxPH5MwiFaON3v4nN6A3R9cAq563vY62cG+bVgmfu/wtz/CnP/V9h5gLSDGNrC
        GPU0Q1pIOUMZGbtJLy8yGztB+NFkKd2g3ps7AHAMEJFiafmITsKnyphy4wCAGEIsErsmWEtc
        TJVX0FZzodVuoJkBkML27URio4vM7NuabIWkKk2hSlWy75VGksRi8ZvcYZ0E11M2eh9NW2jr
        3z0eFhFbCSo2d9S88azUR45an/6qfRWx1uU7mZwYJ3Ju3781YeMYaJSezglMTLY5XTea52Te
        /KF5r9MjWxtuy/0tx7aXBWe27V6a9F524nJ+Q4z3u1t3MfA9e0XWmoy9T70j8QedPkaX7jnk
        x44MOfZXzQXvJHfmb/msOxQz+kjYWrAq50ebg0CZEoqUIVaG+g0dCeIzfgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsVy+t9jAd1glgtRBhNucVtM+bOcyeLyrjls
        FltfvmOyuN24gs2i75y7A6vHnWt72Dz6tqxi9Hi2cD2Lx+dNcgEsUVw2Kak5mWWpRfp2CVwZ
        C1ZdYix4w1Vx58xjtgbGdxxdjBwcEgImEpsfenYxcnEICexklFj8citTFyMnB6+AoMSPyfdY
        QGqYBeQljlzKhjDVJaZMyYUov88o0fO/jRGiXEti7qUeFhCbRUBV4uDJDWBxNqD4/hc32EBs
        fgFFias/HjOCzBEViJDoPlEJEhYRCJZ41tnECmIzC9RI7Dh7BMwWFrCV2LVkCyPErj2MEjO+
        vAWbwymgLTH72272CYwCs5BcOgvh0lkIly5gZF7FKJlaUJybnltsVGCYl1quV5yYW1yal66X
        nJ+7iREYxNsOa/XtYLy/JP4QowAHoxIPr0Ll+Sgh1sSy4srcQ4wSHMxKIrzTHwOFeFMSK6tS
        i/Lji0pzUosPMUpzsCiJ897OOxYpJJCeWJKanZpakFoEk2Xi4JRqYOQu53CYPcs7rG/h2f+m
        63n/liRwnlz0Imv1ygyfKe4Zpte72NMfWh7a9Oj01gfGRs5fvTZcrD624W9VhOBHUy+rx9Ep
        pyX79GXj+4LKt1v5ThXz//xAVK9jT8aE528XzrorWRtzlmWR7hSH70bv2DpuRtpMcZrAkK9X
        3aln9Idz0awt/QJ16UosxRmJhlrMRcWJAASiIKBeAgAA
X-CMS-MailID: 20180413011355epcas1p396d0fa9615fa1a53887ad2a70c1cb876
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180410124315epcas5p39971522b55337b5c1369883f128ff43c
X-RootMTR: 20180410124315epcas5p39971522b55337b5c1369883f128ff43c
References: <CGME20180410124315epcas5p39971522b55337b5c1369883f128ff43c@epcas5p3.samsung.com>
        <20180410124302.29932-1-wsa+renesas@sang-engineering.com>
        <5AD0032E.6020103@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018년 04월 13일 10:09, Chanwoo Choi wrote:
> Hi,
> 
> On 2018년 04월 10일 21:43, Wolfram Sang wrote:
>> Since commit eca0f13c836a ("extcon: int3496: Ignore incorrect
>> IoRestriction for ID pin"), the driver doesn't use GPIOF_* flags
>> anymore. We can thus now drop the deprecated include file for GPIO and
>> use the new one.
> 
> Looks good to me. But, you need to send stable mailing list
> and add 'Fixes' tag on v2.

You don't need to send stable mailing list. It is my mistake.
Just I'll pick this patch on extcon-fixes branch.

> 
>>
>> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> ---
>>
>> Compile tested only.
>>
>> @linusw: one more gone
>>
>>  drivers/extcon/extcon-intel-int3496.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/extcon/extcon-intel-int3496.c b/drivers/extcon/extcon-intel-int3496.c
>> index acaccb128fc4..fd24debe58a3 100644
>> --- a/drivers/extcon/extcon-intel-int3496.c
>> +++ b/drivers/extcon/extcon-intel-int3496.c
>> @@ -20,7 +20,7 @@
>>  
>>  #include <linux/acpi.h>
>>  #include <linux/extcon-provider.h>
>> -#include <linux/gpio.h>
>> +#include <linux/gpio/consumer.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/module.h>
>>  #include <linux/platform_device.h>
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
