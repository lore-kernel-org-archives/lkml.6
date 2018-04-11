Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751553AbeDKFPd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 01:15:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36300 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750727AbeDKFPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 01:15:31 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B7D7E60264
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH v9 5/5] iommu/arm-smmu: Add support for qcom,smmu-v2
 variant
To: Yisheng Xie <xieyisheng1@huawei.com>, Tomasz Figa <tfiga@chromium.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>, gaojianbo@hisilicon.com
References: <20180313085534.11650-1-vivek.gautam@codeaurora.org>
 <20180313085534.11650-6-vivek.gautam@codeaurora.org>
 <61d30fff-1bf8-d2c1-bbe9-f93de836ae77@huawei.com>
 <7d5af071-ef98-8461-3ce9-e84fc0b3956a@codeaurora.org>
 <d97872fe-5e8e-cc27-e385-64cea8ea2458@huawei.com>
 <CAAFQd5Cj3qaqt8ACabZwN4ZKaNbF9N9suGVaOKD8-kNxgfeeVA@mail.gmail.com>
 <65a57964-805b-3a38-71a2-0c383af30539@huawei.com>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <ff1c730f-0009-58e5-cf4a-45fe9ab93d1e@codeaurora.org>
Date: Wed, 11 Apr 2018 10:45:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <65a57964-805b-3a38-71a2-0c383af30539@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yisheng,


On 4/11/2018 6:52 AM, Yisheng Xie wrote:
> Hi Tomasz,
>
> On 2018/4/10 21:14, Tomasz Figa wrote:
>> Hi Yisheng,
>>
>> Sorry, I think we missed your question here.
>>
>> On Wed, Mar 28, 2018 at 3:12 PM Yisheng Xie <xieyisheng1@huawei.com> wrote:
>>
>>> Hi Vivek,
>>> On 2018/3/28 12:37, Vivek Gautam wrote:
>>>> Hi Yisheng
>>>>
>>>>
>>>> On 3/28/2018 6:54 AM, Yisheng Xie wrote:
>>>>> Hi Vivek,
>>>>>
>>>>> On 2018/3/13 16:55, Vivek Gautam wrote:
>>>>>> +- power-domains:  Specifiers for power domains required to be
>> powered on for
>>>>>> +                  the SMMU to operate, as per generic power domain
>> bindings.
>>>>>> +
>>>>> In this patchset, power-domains is not used right? And you just do the
>> clock gating,
>>>>> but not power gating, right?
>>>> We are handling the power-domains too. Please see the example in this
>> binding doc.
>>
>>> I see, but I do not find the point in code of these patchset, do you mean
>> PMIC(e.g mmcc)
>>> will gate the power domain of SMMU(e.g. MDSS_GDSC of mmcc) when PMIC
>> suspend?
>>
>>
>> If respective SoC power domains is registered as a standard genpd PM
>> domain, then the runtime PM subsystem will take care of power domain
>> control at runtime suspend and resume.
>>
> Get it, thanks for your explain, I should have learned about this.

Sorry, i missed your subsequent question, and Tomasz has explained it now.
Let me know if you have further questions.

regards
Vivek
>
> Thanks
> Yisheng
>
>> Best regards,
>> Tomasz
>>
>> .
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
