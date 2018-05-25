Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966819AbeEYLqH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 07:46:07 -0400
Received: from ozlabs.org ([203.11.71.1]:60253 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966505AbeEYLla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 07:41:30 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: f0e0b86638e9df6731b1d61c71ae180224664107
In-Reply-To: <20180404200911.27506-1-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [v3, 05/19] powerpc/chrp/setup: Remove idu_size variable and make some functions static
Message-Id: <40skqD3Yvlz9s2k@ozlabs.org>
Date: Fri, 25 May 2018 21:41:27 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-04-04 at 20:09:11 UTC, Mathieu Malaterre wrote:
> Remove variable declaration idu_size and associated code since not used.
> 
> These functions can all be static, make it so. Fix warnings treated as
> errors with W=1:
> 
>   arch/powerpc/platforms/chrp/setup.c:97:6: error: no previous prototype for ‘chrp_show_cpuinfo’ [-Werror=missing-prototypes]
>   arch/powerpc/platforms/chrp/setup.c:302:13: error: no previous prototype for ‘chrp_setup_arch’ [-Werror=missing-prototypes]
>   arch/powerpc/platforms/chrp/setup.c:385:16: error: variable ‘idu_size’ set but not used [-Werror=unused-but-set-variable]
>   arch/powerpc/platforms/chrp/setup.c:526:13: error: no previous prototype for ‘chrp_init_IRQ’ [-Werror=missing-prototypes]
>   arch/powerpc/platforms/chrp/setup.c:559:1: error: no previous prototype for ‘chrp_init2’ [-Werror=missing-prototypes]
> 
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f0e0b86638e9df6731b1d61c71ae18

cheers
