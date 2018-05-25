Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966749AbeEYLmA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 07:42:00 -0400
Received: from ozlabs.org ([203.11.71.1]:59127 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966731AbeEYLl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 07:41:57 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 7daf59300999693b85233762b847f1b2313cccbd
In-Reply-To: <20180523180054.9937-1-msuchanek@suse.de>
To: Michal Suchanek <msuchanek@suse.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>, Breno Leitao <leitao@debian.org>,
        Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
        "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
        Michal Suchanek <msuchanek@suse.de>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v2] powerpc/xmon: Also setup debugger hooks when single-stepping
Message-Id: <40skql47Ddz9s28@ozlabs.org>
Date: Fri, 25 May 2018 21:41:54 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-05-23 at 18:00:54 UTC, Michal Suchanek wrote:
> When single-stepping kernel code from xmon without a debug hook enabled
> the kernel crashes. This can happen when kernel starts with xmon on
> crash disabled but xmon is entered using sysrq.
> 
> Call force_enable_xmon when single-stepping in xmon to install the xmon
> debug hooks.
> 
> Fixes: e1368d0c9edb ("powerpc/xmon: Setup debugger hooks when first
> break-point is set")
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> Reviewed-by: Vaibhav Jain <vaibhav@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7daf59300999693b85233762b847f1

cheers
