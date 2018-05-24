Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964910AbeEXHD0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 03:03:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49128 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbeEXHDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 03:03:23 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F2A2E60618
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
Subject: Re: [PATCH v9 3/4] arm64: Implement page table free interfaces
To: "Kani, Toshi" <toshi.kani@hpe.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
        "kristina.martsenko@arm.com" <kristina.martsenko@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "pelcan@codeaurora.org" <pelcan@codeaurora.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
References: <1525074094-25839-1-git-send-email-cpandya@codeaurora.org>
 <1525074094-25839-4-git-send-email-cpandya@codeaurora.org>
 <20180523140157.GG26965@arm.com> <1527085967.14039.10.camel@hpe.com>
From: Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <5a0481d4-4ac0-e65a-e00e-4ac63c4306c9@codeaurora.org>
Date: Thu, 24 May 2018 12:33:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1527085967.14039.10.camel@hpe.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/23/2018 8:04 PM, Kani, Toshi wrote:
> On Wed, 2018-05-23 at 15:01 +0100, Will Deacon wrote:
>> Hi Chintan,
>>
>> [as a side note: I'm confused on the status of this patch series, as part
>>   of it was reposted separately by Toshi. Please can you work together?]
> 
> I do not know the status of my patch series, either... That being said,
> I made my x86 patches based off from Chintan's 1/4 patch (which changes
> both x86 and arm) so that my series won't conflict with his.
> 
> Chintan,
Hi Toshi,

> If you need to update your series before mine's accepted, please make
> sure to use the updated 1/4 below. I've updated the descriptions per
> review comment.
> https://patchwork.kernel.org/patch/10407065/
For the sake of completeness, I will re-push my previous 1/4 but will
take your version of change log. I've seen this and your change log
describes the change better.

> 
> Thanks,
> -Toshi
> 

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
