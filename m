Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966936AbeEYLpb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 07:45:31 -0400
Received: from ozlabs.org ([203.11.71.1]:38071 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966523AbeEYLlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 07:41:31 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: f91d5998996819eaf194ff48e00d4956a9270abd
In-Reply-To: <20180404201355.27925-1-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [v3, 11/19] powerpc/powermac: Move pmac_pfunc_base_install prototype to header file
Message-Id: <40skqG33pXz9s2R@ozlabs.org>
Date: Fri, 25 May 2018 21:41:30 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-04-04 at 20:13:55 UTC, Mathieu Malaterre wrote:
> The pmac_pfunc_base_install prototype was declared in powermac/smp.c since
> function was used there, move it to pmac_pfunc.h header to be visible in
> pfunc_base.c. Fix a warning treated as error with W=1:
> 
>   arch/powerpc/platforms/powermac/pfunc_base.c:330:12: error: no previous prototype for ‘pmac_pfunc_base_install’ [-Werror=missing-prototypes]
> 
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f91d5998996819eaf194ff48e00d49

cheers
