Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751824AbeCNJ1z (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 05:27:55 -0400
Received: from ozlabs.org ([103.22.144.67]:38517 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751556AbeCNJ1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 05:27:53 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 8b51e679a54e808bdf1f2cc6552cf25577f0a3ea
In-Reply-To: <20180225172236.29650-8-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [07/21] powerpc: Make functions flipper_pic_init & ug_udbg_putc static
Message-Id: <401RGH3PSMz9sTw@ozlabs.org>
Date: Wed, 14 Mar 2018 20:27:51 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-02-25 at 17:22:22 UTC, Mathieu Malaterre wrote:
> Change signature of two functions, adding static keyword to prevent the
> following two warnings (treated as errors on W=1):
> 
>   CC      kernel/sys.o
> arch/powerpc/platforms/embedded6xx/flipper-pic.c:135:28: error: no previous prototype for ‘flipper_pic_init’ [-Werror=missing-prototypes]
>  struct irq_domain * __init flipper_pic_init(struct device_node *np)
>                             ^~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> and
> 
>   CC      arch/powerpc/platforms/embedded6xx/usbgecko_udbg.o
> arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c:172:6: error: no previous prototype for ‘ug_udbg_putc’ [-Werror=missing-prototypes]
>  void ug_udbg_putc(char ch)
>       ^~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8b51e679a54e808bdf1f2cc6552cf2

cheers
