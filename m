Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752704AbeCUPSn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 11:18:43 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54766 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752385AbeCUPSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 11:18:42 -0400
Date: Wed, 21 Mar 2018 15:18:37 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        ckadabi@codeaurora.org, ard.biesheuvel@linaro.org,
        marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jnair@caviumnetworks.com,
        robin.murphy@arm.com, shankerd@codeaurora.org
Subject: Re: [PATCH v4 15/22] arm64: capabilities: Change scope of VHE to
 Boot CPU feature
Message-ID: <20180321151837.GC16308@e103592.cambridge.arm.com>
References: <20180313115120.17256-1-suzuki.poulose@arm.com>
 <20180313115120.17256-16-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313115120.17256-16-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 11:51:13AM +0000, Suzuki K Poulose wrote:
> We expect all CPUs to be running at the same EL inside the kernel
> with or without VHE enabled and we have strict checks to ensure
> that any mismatch triggers a kernel panic. If VHE is enabled,
> we use the feature based on the boot CPU and all other CPUs
> should follow. This makes it a perfect candidate for a cpability

Nit: capability (not worth fixing unless you respin for some other
reason though.)

> based on the boot CPU,  which should be matched by all the CPUs
> (both when is ON and OFF). This saves us some not-so-pretty
> hooks and special code, just for verifying the conflict.
> 
> The patch also makes the VHE capability entry depend on
> CONFIG_ARM64_VHE.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Dave Martin <dave.martin@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

[...]

Cheers
---Dave
