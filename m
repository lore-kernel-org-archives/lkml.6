Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751943AbeCNJ15 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 05:27:57 -0400
Received: from ozlabs.org ([103.22.144.67]:53015 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751649AbeCNJ1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 05:27:52 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 67b464a89c21c9edd45ad15c457bb5f25dadecfd
In-Reply-To: <20180225172236.29650-5-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [04/21] powerpc: Mark both tmp variables as unused
Message-Id: <401RGG5XsHz9sVh@ozlabs.org>
Date: Wed, 14 Mar 2018 20:27:50 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-02-25 at 17:22:19 UTC, Mathieu Malaterre wrote:
> Since the value of `tmp` is never intended to be read, declare both `tmp`
> variables as unused. Fix warning (treated as error in W=1):
> 
>   CC      arch/powerpc/kernel/signal_32.o
> arch/powerpc/kernel/signal_32.c: In function ‘sys_swapcontext’:
> arch/powerpc/kernel/signal_32.c:1048:16: error: variable ‘tmp’ set but not used [-Werror=unused-but-set-variable]
>   unsigned char tmp;
>                 ^~~
> arch/powerpc/kernel/signal_32.c: In function ‘sys_debug_setcontext’:
> arch/powerpc/kernel/signal_32.c:1234:16: error: variable ‘tmp’ set but not used [-Werror=unused-but-set-variable]
>   unsigned char tmp;
>                 ^~~
> cc1: all warnings being treated as errors
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/67b464a89c21c9edd45ad15c457bb5

cheers
