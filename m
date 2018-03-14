Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752172AbeCNJ2P (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 05:28:15 -0400
Received: from ozlabs.org ([103.22.144.67]:60449 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751401AbeCNJ2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 05:28:14 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 23a6d8b9634897add6ebff32372f34348387b1ee
In-Reply-To: <20180225172236.29650-17-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [16/21] powerpc: Add missing prototype for init_IRQ
Message-Id: <401RGc5Lx5z9sVl@ozlabs.org>
Date: Wed, 14 Mar 2018 20:28:00 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-02-25 at 17:22:31 UTC, Mathieu Malaterre wrote:
> A function init_IRQ was added without a prototype declared in header irq.h.
> Fix the following warning (treated as error in W=1):
> 
>   CC      arch/powerpc/kernel/irq.o
> arch/powerpc/kernel/irq.c:662:13: error: no previous prototype for ‘init_IRQ’ [-Werror=missing-prototypes]
>  void __init init_IRQ(void)
>              ^~~~~~~~
> cc1: all warnings being treated as errors
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/23a6d8b9634897add6ebff32372f34

cheers
