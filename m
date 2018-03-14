Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752261AbeCNJ2X (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 05:28:23 -0400
Received: from ozlabs.org ([103.22.144.67]:55705 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751401AbeCNJ2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 05:28:20 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: b0d876da1d1cd33a1c28049512a136e61d0ff371
In-Reply-To: <20180225172236.29650-20-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [19/21] powerpc: Add missing prototypes for hw_breakpoint_handler & arch_unregister_hw_breakpoint
Message-Id: <401RGn3kfmz9sVK@ozlabs.org>
Date: Wed, 14 Mar 2018 20:28:08 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-02-25 at 17:22:34 UTC, Mathieu Malaterre wrote:
> In commit 5aae8a537080 ("powerpc, hw_breakpoints: Implement hw_breakpoints
> for 64-bit server processors") function hw_breakpoint_handler and
> arch_unregister_hw_breakpoint were added without function prototypes in
> hw_breakpoint.h header.
> 
> Fix the following warning(s) (treated as error in W=1):
> 
>   AR      init/built-in.o
> arch/powerpc/kernel/hw_breakpoint.c:106:6: error: no previous prototype for ‘arch_unregister_hw_breakpoint’ [-Werror=missing-prototypes]
>  void arch_unregister_hw_breakpoint(struct perf_event *bp)
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/kernel/hw_breakpoint.c:209:5: error: no previous prototype for ‘hw_breakpoint_handler’ [-Werror=missing-prototypes]
>  int hw_breakpoint_handler(struct die_args *args)
>      ^~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b0d876da1d1cd33a1c28049512a136

cheers
