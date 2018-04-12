Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752904AbeDLB4M (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 21:56:12 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41550 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751858AbeDLB4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 21:56:10 -0400
Subject: Re: [PATCH v9 5/5] iommu/arm-smmu: Add support for qcom,smmu-v2
 variant
To: Vivek Gautam <vivek.gautam@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>
References: <20180313085534.11650-1-vivek.gautam@codeaurora.org>
 <20180313085534.11650-6-vivek.gautam@codeaurora.org>
 <61d30fff-1bf8-d2c1-bbe9-f93de836ae77@huawei.com>
 <7d5af071-ef98-8461-3ce9-e84fc0b3956a@codeaurora.org>
 <d97872fe-5e8e-cc27-e385-64cea8ea2458@huawei.com>
 <CAAFQd5Cj3qaqt8ACabZwN4ZKaNbF9N9suGVaOKD8-kNxgfeeVA@mail.gmail.com>
 <65a57964-805b-3a38-71a2-0c383af30539@huawei.com>
 <ff1c730f-0009-58e5-cf4a-45fe9ab93d1e@codeaurora.org>
CC: Mark Rutland <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>, <gaojianbo@hisilicon.com>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <76065271-c6e6-2ce7-8608-c18b621055ce@huawei.com>
Date: Thu, 12 Apr 2018 09:55:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <ff1c730f-0009-58e5-cf4a-45fe9ab93d1e@codeaurora.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.40]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vivek,

On 2018/4/11 13:15, Vivek Gautam wrote:
> Hi Yisheng,
> 
> 
> On 4/11/2018 6:52 AM, Yisheng Xie wrote:
>> Hi Tomasz,
>>
>> On 2018/4/10 21:14, Tomasz Figa wrote:
>>> Hi Yisheng,
>>>
>>> Sorry, I think we missed your question here.
>>>
>>> On Wed, Mar 28, 2018 at 3:12 PM Yisheng Xie <xieyisheng1@huawei.com> wrote:
>>>
>>>> Hi Vivek,
>>>> On 2018/3/28 12:37, Vivek Gautam wrote:
>>>>> Hi Yisheng
>>>>>
>>>>>
>>>>> On 3/28/2018 6:54 AM, Yisheng Xie wrote:
>>>>>> Hi Vivek,
>>>>>>
>>>>>> On 2018/3/13 16:55, Vivek Gautam wrote:
>>>>>>> +- power-domains:  Specifiers for power domains required to be
>>> powered on for
>>>>>>> +                  the SMMU to operate, as per generic power domain
>>> bindings.
>>>>>>> +
>>>>>> In this patchset, power-domains is not used right? And you just do the
>>> clock gating,
>>>>>> but not power gating, right?
>>>>> We are handling the power-domains too. Please see the example in this
>>> binding doc.
>>>
>>>> I see, but I do not find the point in code of these patchset, do you mean
>>> PMIC(e.g mmcc)
>>>> will gate the power domain of SMMU(e.g. MDSS_GDSC of mmcc) when PMIC
>>> suspend?
>>>
>>>
>>> If respective SoC power domains is registered as a standard genpd PM
>>> domain, then the runtime PM subsystem will take care of power domain
>>> control at runtime suspend and resume.
>>>
>> Get it, thanks for your explain, I should have learned about this.
> 
> Sorry, i missed your subsequent question, and Tomasz has explained it now.

Never mind about that.

> Let me know if you have further questions.

Presently, no other questions. Thanks for your kind help.

Thanks
Yisheng
> 
> regards
> Vivek
>>
>> Thanks
>> Yisheng
>>
>>> Best regards,
>>> Tomasz
>>>
>>> .
>>>
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> .
> 
