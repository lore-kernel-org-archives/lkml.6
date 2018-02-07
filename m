Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754231AbeBGOrR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 09:47:17 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51768 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753983AbeBGOrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 09:47:16 -0500
Subject: Re: [PATCH v2 02/20] arm64: capabilities: Move errata work around
 check on boot CPU
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        ckadabi@codeaurora.org, ard.biesheuvel@linaro.org,
        marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jnair@caviumnetworks.com
References: <20180131182807.32134-1-suzuki.poulose@arm.com>
 <20180131182807.32134-3-suzuki.poulose@arm.com>
 <20180207103737.GS5862@e103592.cambridge.arm.com>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <9e21e22a-b41c-ced0-48aa-6738f3b062d9@arm.com>
Date: Wed, 7 Feb 2018 14:47:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180207103737.GS5862@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/18 10:37, Dave Martin wrote:
> On Wed, Jan 31, 2018 at 06:27:49PM +0000, Suzuki K Poulose wrote:
>> We trigger CPU errata work around check on the boot CPU from
>> smp_prepare_boot_cpu() to make sure that we run the checks only
>> after the CPU feature infrastructure is initialised. While this
>> is correct, we can also do this from init_cpu_features() which
>> initilisation of the infrastructure, and is called only on the
> 
> Typo or missing words here?
> 
> Should this be "which initialises the infrastructure" or "which is
> called to initialise the infrastructure"?
> 
> With that (or any suitable rewording):

Correct. Will fix it.

> 
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>

Thanks
Suzuki
