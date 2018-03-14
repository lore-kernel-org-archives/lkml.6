Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751969AbeCNJ17 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 05:27:59 -0400
Received: from ozlabs.org ([103.22.144.67]:42475 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751788AbeCNJ14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 05:27:56 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 45b4d27a3897d6094bcf84bc87743954e038620a
In-Reply-To: <20180225172236.29650-11-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [10/21] powerpc: Add missing prototype for slb_miss_bad_addr
Message-Id: <401RGK6Fs4z9sVj@ozlabs.org>
Date: Wed, 14 Mar 2018 20:27:53 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-02-25 at 17:22:25 UTC, Mathieu Malaterre wrote:
> In commit f0f558b131db ("powerpc/mm: Preserve CFAR value on SLB miss caused
> by access to bogus address"), the function slb_miss_bad_addr was added
> without a prototype. This commit adds it.
> 
> Fix a warning (treated as error in W=1):
> 
>   CC      arch/powerpc/kernel/traps.o
> arch/powerpc/kernel/traps.c:1498:6: error: no previous prototype for ‘slb_miss_bad_addr’ [-Werror=missing-prototypes]
>  void slb_miss_bad_addr(struct pt_regs *regs)
>       ^~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/45b4d27a3897d6094bcf84bc877439

cheers
