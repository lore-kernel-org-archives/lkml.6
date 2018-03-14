Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752513AbeCNJbb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 05:31:31 -0400
Received: from ozlabs.org ([103.22.144.67]:38611 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752183AbeCNJ2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 05:28:17 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 0d60619e1c0ca20eb26103610349923451827688
In-Reply-To: <20180225172236.29650-18-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [17/21] powerpc: Add missing prototype for sys_debug_setcontext
Message-Id: <401RGl6DS7z9sTw@ozlabs.org>
Date: Wed, 14 Mar 2018 20:28:06 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-02-25 at 17:22:32 UTC, Mathieu Malaterre wrote:
> In commit 81e7009ea46c ("powerpc: merge ppc signal.c and ppc64 signal32.c")
> the function sys_debug_setcontext was added without a prototype.
> 
> Fix compilation warning (treated as error in W=1):
> 
>   CC      arch/powerpc/kernel/signal_32.o
> arch/powerpc/kernel/signal_32.c:1227:5: error: no previous prototype for ‘sys_debug_setcontext’ [-Werror=missing-prototypes]
>  int sys_debug_setcontext(struct ucontext __user *ctx,
>      ^~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/0d60619e1c0ca20eb2610361034992

cheers
