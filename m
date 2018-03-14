Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752007AbeCNJ2A (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 05:28:00 -0400
Received: from ozlabs.org ([103.22.144.67]:42245 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751791AbeCNJ14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 05:27:56 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 8b604faff7d421904ebd1fa65d642f566f4a6648
In-Reply-To: <20180225172236.29650-12-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [11/21] powerpc: Add missing prototype for hdec_interrupt
Message-Id: <401RGL6N5Vz9sVK@ozlabs.org>
Date: Wed, 14 Mar 2018 20:27:54 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-02-25 at 17:22:26 UTC, Mathieu Malaterre wrote:
> In commit dabe859ec636 ("powerpc: Give hypervisor decrementer interrupts
> their own handler") an empty body function was added, but no prototype was
> declared. Fix warning (treated as error in W=1):
> 
>   CC      arch/powerpc/kernel/time.o
> arch/powerpc/kernel/time.c:629:6: error: no previous prototype for ‘hdec_interrupt’ [-Werror=missing-prototypes]
>  void hdec_interrupt(struct pt_regs *regs)
>       ^~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8b604faff7d421904ebd1fa65d642f

cheers
