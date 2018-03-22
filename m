Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751937AbeCVQo6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 12:44:58 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40158 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751586AbeCVQoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 12:44:55 -0400
Subject: Re: [PATCH v4 09/22] arm64: capabilities: Split the processing of
 errata work arounds
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will.deacon@arm.com, dave.martin@arm.com,
        catalin.marinas@arm.com, marc.zyngier@arm.com, mark.rutland@arm.com,
        ard.biesheuvel@linaro.org, jnair@caviumnetworks.com,
        ckadabi@codeaurora.org, robin.murphy@arm.com, shankerd@codeaurora.org
References: <20180313115120.17256-1-suzuki.poulose@arm.com>
 <20180313115120.17256-10-suzuki.poulose@arm.com>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <943b6c94-25a7-55dc-5eb4-29ab3eb893c9@arm.com>
Date: Thu, 22 Mar 2018 16:44:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180313115120.17256-10-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/18 11:51, Suzuki K Poulose wrote:
> Right now we run through the errata workarounds check on all boot
> active CPUs, with SCOPE_ALL. This wouldn't help for detecting erratum
> workarounds with a SYSTEM_SCOPE. There are none yet, but we plan to
> introduce some: let us clean this up so that such workarounds can be
> detected and enabled correctly.
> 
> So, we run the checks with SCOPE_LOCAL_CPU on all CPUs and SCOPE_SYSTEM
> checks are run only once after all the boot time CPUs are active.
> 
> Reviewed-by: Dave Martin <dave.martin@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>


Changes since v3
  - Reworded commit description
  - Added Reviewed-by tag from Dave
