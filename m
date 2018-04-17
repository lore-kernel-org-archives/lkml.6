Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752048AbeDQHdA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 03:33:00 -0400
Received: from foss.arm.com ([217.140.101.70]:39058 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750821AbeDQHc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 03:32:59 -0400
Subject: Re: [PATCH] MAINTAINERS: Update e-mail address for Christoffer Dall
To: Christoffer Dall <christoffer.dall@arm.com>,
        linux-kernel@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
References: <20180416182831.4035-1-christoffer.dall@arm.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <6bb15fe7-cf20-c4e2-d596-fd9e243659e4@arm.com>
Date: Tue, 17 Apr 2018 08:32:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180416182831.4035-1-christoffer.dall@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/18 19:28, Christoffer Dall wrote:
> Update my e-mail address to a working address.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0a1410d5a621..3e9c99d2620b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7738,7 +7738,7 @@ F:	arch/x86/include/asm/svm.h
>  F:	arch/x86/kvm/svm.c
>  
>  KERNEL VIRTUAL MACHINE FOR ARM (KVM/arm)
> -M:	Christoffer Dall <christoffer.dall@linaro.org>
> +M:	Christoffer Dall <christoffer.dall@arm.com>
>  M:	Marc Zyngier <marc.zyngier@arm.com>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  L:	kvmarm@lists.cs.columbia.edu
> @@ -7752,7 +7752,7 @@ F:	virt/kvm/arm/
>  F:	include/kvm/arm_*
>  
>  KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)
> -M:	Christoffer Dall <christoffer.dall@linaro.org>
> +M:	Christoffer Dall <christoffer.dall@arm.com>
>  M:	Marc Zyngier <marc.zyngier@arm.com>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  L:	kvmarm@lists.cs.columbia.edu
> 

I'll queue this as a fix for the next -rc.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
