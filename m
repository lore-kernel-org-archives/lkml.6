Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755305AbeCHMYo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 07:24:44 -0500
Received: from foss.arm.com ([217.140.101.70]:37130 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754822AbeCHMYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 07:24:43 -0500
Subject: Re: [PATCH v3 09/22] arm64: capabilities: Split the processing of
 errata work arounds
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        ckadabi@codeaurora.org, ard.biesheuvel@linaro.org,
        marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jnair@caviumnetworks.com,
        robin.murphy@arm.com
References: <20180209175513.17100-1-suzuki.poulose@arm.com>
 <20180209175513.17100-19-suzuki.poulose@arm.com>
 <20180209181834.GG5862@e103592.cambridge.arm.com>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <b5b90236-7734-2c05-65fd-57fcbe732b6c@arm.com>
Date: Thu, 8 Mar 2018 12:24:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180209181834.GG5862@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/18 18:18, Dave Martin wrote:
> On Fri, Feb 09, 2018 at 05:54:48PM +0000, Suzuki K Poulose wrote:
>> Right now we run through the errata workarounds check on all boot
>> active CPUs, with SCOPE_ALL. This doesn't help with detecting the
>> errata's with a SYSTEM_SCOPE. While nobody uses it, let us clean
>> this up in preparation for merging capability handling.
> 
> errata; and SCOPE_SYSTEM (if I'm being pedantic)
> 
> To make it clearer this this is adding support for new behaviour rather
> than changing old behaviour, perhaps change "This doesn't help ...
> While nobody uses it ..." to something like:
> 
> "This wouldn't help for detecting erratum workarounds with SCOPE_SYSTEM.
> There are none yet, but we plan to introduce some: let us clean this up
> so that such workarounds can be detected and enabled correctly."

Fixed

>>
>> So, we run the checks with SCOPE_LOCAL_CPU on all CPUs and SCOPE_SYSTEM
>> checks are run only once after all the boot time CPUs are active.
>>
>> Cc: Dave Martin <dave.martin@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> Otherwise,
> 
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>

Thanks
Suzuki
