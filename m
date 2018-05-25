Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934549AbeEYB7R (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 21:59:17 -0400
Received: from ozlabs.org ([203.11.71.1]:60691 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934393AbeEYB7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 21:59:13 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 9f9eae5ce717f497812dfc1bda5219bc589b455d
In-Reply-To: <20180328195811.27758-1-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [v2,04/19] powerpc/kvm: Prefer fault_in_pages_readable function
Message-Id: <40sTvM71Vbz9s1b@ozlabs.org>
Date: Fri, 25 May 2018 11:59:11 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-03-28 at 19:58:11 UTC, Mathieu Malaterre wrote:
> Directly use fault_in_pages_readable instead of manual __get_user code. Fix
> warning treated as error with W=1:
> 
>   arch/powerpc/kernel/kvm.c:675:6: error: variable ‘tmp’ set but not used [-Werror=unused-but-set-variable]
> 
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc topic/ppc-kvm, thanks.

https://git.kernel.org/powerpc/c/9f9eae5ce717f497812dfc1bda5219

cheers
