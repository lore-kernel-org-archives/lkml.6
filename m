Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754740AbeDCBRF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 21:17:05 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6722 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754665AbeDCBRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 21:17:04 -0400
Subject: Re: [PATCH 2/2] perf: add arm64 smmuv3 pmu driver
To: Neil Leeder <neil.m.leeder@gmail.com>,
        Yisheng Xie <xieyisheng1@huawei.com>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Mark Langsdorf <mlangsdo@redhat.com>, Mark Salter <msalter@redhat.com>,
        "Jon Masters" <jcm@redhat.com>, Timur Tabi <timur@codeaurora.org>,
        Mark Brown <broonie@kernel.org>,
        Agustin Vega-Frias <agustinv@codeaurora.org>,
        "Lorenzo Pieralisi" <Lorenzo.Pieralisi@arm.com>
References: <1501876754-1064-1-git-send-email-nleeder@codeaurora.org>
 <1501876754-1064-3-git-send-email-nleeder@codeaurora.org>
 <883d32ce-6581-ecf6-5088-ecb238322ebe@huawei.com>
 <e55ab4404143ea0b3cc4795a93e37480@codeaurora.org>
 <14f90cc6-f2c1-5a63-67c6-a5c8ddb4799e@gmail.com>
 <c1f9230b-8ff0-5b2e-def9-cbf6b2e2e99c@huawei.com>
 <66ef3bf4-9550-94c7-f8ad-ee53d6c75025@huawei.com>
 <0094c5ab-89db-409f-d5fb-c961f9d84740@gmail.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <23363f05-0fe0-0af3-5f3d-5f2e14181e95@huawei.com>
Date: Tue, 3 Apr 2018 09:15:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <0094c5ab-89db-409f-d5fb-c961f9d84740@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Cc Lorenzo]

Hi Neil,

On 2018/4/3 1:59, Neil Leeder wrote:
> Hi Hanjun,
> 
> On 4/2/2018 10:24 AM, Hanjun Guo wrote:
> <SNIP>
>>
>> I think we need to wait for the new version of IORT spec,
>> which includes the fix for the two base address for SMMUv3
>> PMCG (now just represent one).
>>
>> Thanks
>> Hanjun
>>
> It's in rev D which is available now:
> http://infocenter.arm.com/help/topic/com.arm.doc.den0049d/DEN0049D_IO_Remapping_Table.pdf

Thanks for let me know, I didn't notice the update :)

Lorenzo, do you have a plan for ACPICA changes?

Thanks
Hanjun
