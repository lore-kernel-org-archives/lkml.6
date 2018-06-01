Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751551AbeFAIXl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 04:23:41 -0400
Received: from foss.arm.com ([217.140.101.70]:48416 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751431AbeFAIX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 04:23:29 -0400
Subject: Re: linux-next: manual merge of the kvm-arm tree with the arm64 tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Christoffer Dall <cdall@cs.columbia.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Martin <Dave.Martin@arm.com>
References: <20180601162320.1ef18d8e@canb.auug.org.au>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <bc517d41-dac3-13a1-23b7-9d3f4cab3154@arm.com>
Date: Fri, 1 Jun 2018 09:23:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180601162320.1ef18d8e@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 01/06/18 07:23, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the kvm-arm tree got conflicts in:
> 
> arch/arm64/include/asm/kvm_host.h arch/arm64/kvm/hyp/switch.c
> 
> between commit:
> 
> 55e3748e8902 ("arm64: KVM: Add ARCH_WORKAROUND_2 support for
> guests")
> 
> from the arm64 tree and commits:
> 
> fa89d31c5306 ("KVM: arm64: Repurpose vcpu_arch.debug_flags for
> general-purpose flags") e6b673b741ea ("KVM: arm64: Optimise FPSIMD
> handling to reduce guest/host thrashing")
> 
> from the kvm-arm tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This 
> is now fixed as far as linux-next is concerned, but any non
> trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to
> consider cooperating with the maintainer of the conflicting tree to
> minimise any particularly complex conflicts.
> 

All three resolutions look correct to me.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
