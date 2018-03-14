Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752302AbeCNJ2Z (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 05:28:25 -0400
Received: from ozlabs.org ([103.22.144.67]:58801 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752220AbeCNJ2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 05:28:23 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 1cdf039bf82a39d816ca4b8161b01c0acfca3e62
In-Reply-To: <20180225172236.29650-9-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [08/21] powerpc: Make function __giveup_fpu static
Message-Id: <401RGt0zpqz9sVn@ozlabs.org>
Date: Wed, 14 Mar 2018 20:28:15 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-02-25 at 17:22:23 UTC, Mathieu Malaterre wrote:
> When CONFIG_PPC_FPU is defined the prototype exposed in asm/switch_to.h is:
> 
>   extern void giveup_fpu(struct task_struct *);
> 
> Change the function prototype of __giveup_fpu to static. Fix warning
> (treated as error in W=1):
> 
>   CC      arch/powerpc/kernel/process.o
> arch/powerpc/kernel/process.c:176:6: error: no previous prototype for ‘__giveup_fpu’ [-Werror=missing-prototypes]
>  void __giveup_fpu(struct task_struct *tsk)
>       ^~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1cdf039bf82a39d816ca4b8161b01c

cheers
