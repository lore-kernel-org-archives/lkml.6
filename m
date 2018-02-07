Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754740AbeBGQxH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 11:53:07 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53436 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754412AbeBGQxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 11:53:06 -0500
Subject: Re: [PATCH v2 05/20] arm64: capabilities: Add flags to handle the
 conflicts on late CPU
To: Robin Murphy <robin.murphy@arm.com>, Dave Martin <Dave.Martin@arm.com>
Cc: mark.rutland@arm.com, ckadabi@codeaurora.org,
        ard.biesheuvel@linaro.org, marc.zyngier@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jnair@caviumnetworks.com,
        linux-arm-kernel@lists.infradead.org
References: <20180131182807.32134-1-suzuki.poulose@arm.com>
 <20180131182807.32134-6-suzuki.poulose@arm.com>
 <20180207103804.GV5862@e103592.cambridge.arm.com>
 <7221b67c-6581-93bd-ebb3-7e48736ecb02@arm.com>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <ab56a18c-a022-a6f5-05f7-b35b09ba74f6@arm.com>
Date: Wed, 7 Feb 2018 16:53:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <7221b67c-6581-93bd-ebb3-7e48736ecb02@arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/18 11:31, Robin Murphy wrote:
> On 07/02/18 10:38, Dave Martin wrote:
>> On Wed, Jan 31, 2018 at 06:27:52PM +0000, Suzuki K Poulose wrote:

...

>>> Case (b) is not permitted for errata work arounds which requires some work
>>> around, which cannot be delayed. And we ignore (b) for features. Here, yet
>>
>> Nit, maybe:
>>
>> "Case (b) is not permitted for any errata workaround that cannot be
>> activated if the kernel has finished booting and has not already enabled
>> it."
> 
> Nit^2: I think it would suffice to say "...that cannot be activated after the kernel has finished booting." - since we don't really have the concept of *de*activating workarounds, it is already implicit in that statement that the one in question wasn't activated *before* the kernel finished booting.

Robin, Dave,

I have updated the comments accordingly.

Thanks a lot for the review

Suzuki
