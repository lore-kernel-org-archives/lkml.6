Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755828AbeCHMOz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 07:14:55 -0500
Received: from foss.arm.com ([217.140.101.70]:36952 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755734AbeCHMOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 07:14:52 -0500
Subject: Re: [PATCH v3 10/22] arm64: capabilities: Allow features based on
 local CPU scope
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        ckadabi@codeaurora.org, ard.biesheuvel@linaro.org,
        marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jnair@caviumnetworks.com,
        robin.murphy@arm.com
References: <20180209175513.17100-1-suzuki.poulose@arm.com>
 <20180209175513.17100-20-suzuki.poulose@arm.com>
 <20180209182213.GH5862@e103592.cambridge.arm.com>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <076d272e-d056-6316-7dff-2c123578f89a@arm.com>
Date: Thu, 8 Mar 2018 12:14:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180209182213.GH5862@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/18 18:22, Dave Martin wrote:
> On Fri, Feb 09, 2018 at 05:54:49PM +0000, Suzuki K Poulose wrote:
>> So far we have treated the feature capabilities as system wide
>> and this doesn't help with features that could be detected on
> 
> doesn't -> wouldn't (since no such features exist yet)
> 
> detected to "detected locally" (maybe)
> 

Sure, fixed.

>> one or more CPUs (e.g, KPTI, Software prefetch). This patch
>> splits the feature detection to two phases :
>>
>>   1) Local CPU features are checked on all boot time active CPUs.
>>   2) System wide features are checked only once after all CPUs are
>>      active.
>>
>> Cc: Dave Martin <dave.martin@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> Otherwise,
> 
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>
> 

Thanks,

Suzuki
