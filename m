Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752479AbeCNJ2z (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 05:28:55 -0400
Received: from ozlabs.org ([103.22.144.67]:58967 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752416AbeCNJ2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 05:28:52 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: e1368d0c9edbc366e45216e7295fd61ae55c2b12
In-Reply-To: <20180304173025.19520-1-vaibhav@linux.vnet.ibm.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
        Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Douglas Miller <dougmill@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [v2] xmon: Setup xmon debugger hooks when first break-point is set
Message-Id: <401RHQ2TS9z9s2R@ozlabs.org>
Date: Wed, 14 Mar 2018 20:28:31 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-03-04 at 17:30:25 UTC, Vaibhav Jain wrote:
> Presently sysrq key for xmon('x') is registered during kernel init
> irrespective of the value of kernel param 'xmon'. Thus xmon is enabled
> even if 'xmon=off' is passed on the kernel command line. However this
> doesn't enable the kernel debugger hooks needed for instruction or data
> breakpoints. Thus when a break-point is hit with xmon=off a kernel oops
> of the form below is reported:
> 
> Oops: Exception in kernel mode, sig: 5 [#1]
> < snip >
> Trace/breakpoint trap
> 
> To fix this the patch checks and enables debugger hooks when an
> instruction or data break-point is set via xmon console.
> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> Reviewed-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e1368d0c9edbc366e45216e7295fd6

cheers
