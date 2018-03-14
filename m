Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751696AbeCNJ1w (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 05:27:52 -0400
Received: from ozlabs.org ([103.22.144.67]:48875 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751596AbeCNJ1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 05:27:50 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 174b701d3dcd14514f869e2bc08ac404b16fdb9d
In-Reply-To: <20180225172236.29650-3-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [02/21] powerpc: Move the inline keyword at the beginning of function declaration
Message-Id: <401RGF3db0z9sVP@ozlabs.org>
Date: Wed, 14 Mar 2018 20:27:48 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-02-25 at 17:22:17 UTC, Mathieu Malaterre wrote:
> The inline keyword was not at the beginning of the function declaration.
> Fix the following warning (treated as error in W=1)
> 
>   CC      kernel/sys.o
> arch/powerpc/lib/sstep.c:283:1: error: ‘inline’ is not at beginning of declaration [-Werror=old-style-declaration]
>  static int nokprobe_inline copy_mem_in(u8 *dest, unsigned long ea, int nb,
>  ^~~~~~
> arch/powerpc/lib/sstep.c:388:1: error: ‘inline’ is not at beginning of declaration [-Werror=old-style-declaration]
>  static int nokprobe_inline copy_mem_out(u8 *dest, unsigned long ea, int nb,
>  ^~~~~~
>   CC      arch/powerpc/kernel/setup_32.o
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/174b701d3dcd14514f869e2bc08ac4

cheers
