Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752117AbeCNJ2O (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 05:28:14 -0400
Received: from ozlabs.org ([103.22.144.67]:55565 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751791AbeCNJ2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 05:28:08 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: f5246862f82f1e16bbf84cda4cddf287672b30fe
In-Reply-To: <20180225172236.29650-15-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [14/21] powerpc: Add missing prototype for arch_irq_work_raise
Message-Id: <401RGZ11pbz9sVn@ozlabs.org>
Date: Wed, 14 Mar 2018 20:27:58 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-02-25 at 17:22:29 UTC, Mathieu Malaterre wrote:
> In commit 4f8b50bbbe63 ("irq_work, ppc: Fix up arch hooks") a new function
> arch_irq_work_raise was added without a prototype in header irq_work.h.
> 
> Fix the following warning (treated as error in W=1):
> 
>   CC      arch/powerpc/kernel/time.o
> arch/powerpc/kernel/time.c:523:6: error: no previous prototype for ‘arch_irq_work_raise’ [-Werror=missing-prototypes]
>  void arch_irq_work_raise(void)
>       ^~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f5246862f82f1e16bbf84cda4cddf2

cheers
