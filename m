Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966436AbeEYLlZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 07:41:25 -0400
Received: from ozlabs.org ([203.11.71.1]:46195 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965906AbeEYLlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 07:41:22 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 9e0d86cd2d749998c3792059221cefa210b0177b
In-Reply-To: <20180322202007.23088-9-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
        kvm-ppc@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [08/19] powerpc/tau: Make some function static
Message-Id: <40skq50bx1z9s1d@ozlabs.org>
Date: Fri, 25 May 2018 21:41:21 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-22 at 20:19:54 UTC, Mathieu Malaterre wrote:
> These functions can all be static, make it so. Fix warnings treated as
> errors with W=1:
> 
>   arch/powerpc/kernel/tau_6xx.c:53:6: error: no previous prototype for ‘set_thresholds’ [-Werror=missing-prototypes]
>   arch/powerpc/kernel/tau_6xx.c:73:6: error: no previous prototype for ‘TAUupdate’ [-Werror=missing-prototypes]
>   arch/powerpc/kernel/tau_6xx.c:208:13: error: no previous prototype for ‘TAU_init_smp’ [-Werror=missing-prototypes]
>   arch/powerpc/kernel/tau_6xx.c:220:12: error: no previous prototype for ‘TAU_init’ [-Werror=missing-prototypes]
>   arch/powerpc/kernel/tau_6xx.c:126:6: error: no previous prototype for ‘TAUException’ [-Werror=missing-prototypes]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9e0d86cd2d749998c3792059221cef

cheers
