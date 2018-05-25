Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966376AbeEYLlX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 07:41:23 -0400
Received: from ozlabs.org ([203.11.71.1]:38765 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966097AbeEYLlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 07:41:22 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 86e11b6e9c56e605475462bf9ba7c12dbe1e3e29
In-Reply-To: <20180322202007.23088-7-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
        kvm-ppc@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [06/19] powerpc: Make function btext_initialize static
Message-Id: <40skq41zHfz9s15@ozlabs.org>
Date: Fri, 25 May 2018 21:41:20 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-22 at 20:19:52 UTC, Mathieu Malaterre wrote:
> This function can be static, make it so, this fix a warning treated as
> error with W=1:
> 
>   arch/powerpc/kernel/btext.c:173:5: error: no previous prototype for ‘btext_initialize’ [-Werror=missing-prototypes]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/86e11b6e9c56e605475462bf9ba7c1

cheers
