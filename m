Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbeCNJbK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 05:31:10 -0400
Received: from ozlabs.org ([103.22.144.67]:46867 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752152AbeCNJ2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 05:28:22 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: bf7fb32dd5fc8a6bd25aaab05d3acddd1223ba03
In-Reply-To: <20180225172236.29650-21-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [20/21] powerpc: Add missing prototypes for ppc_select & ppc_fadvise64_64
Message-Id: <401RGr5TpCz9sVZ@ozlabs.org>
Date: Wed, 14 Mar 2018 20:28:13 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-02-25 at 17:22:35 UTC, Mathieu Malaterre wrote:
> Add missing prototypes for ppc_select & ppc_fadvise64_64 to header
> asm-prototypes.h. Fix the following warnings (treated as errors in W=1)
> 
>   CC      arch/powerpc/kernel/syscalls.o
> arch/powerpc/kernel/syscalls.c:87:1: error: no previous prototype for ‘ppc_select’ [-Werror=missing-prototypes]
>  ppc_select(int n, fd_set __user *inp, fd_set __user *outp, fd_set __user *exp, struct timeval __user *tvp)
>  ^~~~~~~~~~
> arch/powerpc/kernel/syscalls.c:119:6: error: no previous prototype for ‘ppc_fadvise64_64’ [-Werror=missing-prototypes]
>  long ppc_fadvise64_64(int fd, int advice, u32 offset_high, u32 offset_low,
>       ^~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/bf7fb32dd5fc8a6bd25aaab05d3acd

cheers
