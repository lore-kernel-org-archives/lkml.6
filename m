Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966950AbeEYLqJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 07:46:09 -0400
Received: from ozlabs.org ([203.11.71.1]:35891 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966459AbeEYLl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 07:41:29 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 5a4b475cf8511da721f20ba432c244061db7139f
In-Reply-To: <20180404200746.27379-1-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [v3,01/19] powerpc/powermac: Mark variable x as unused
Message-Id: <40skqC3Cs8z9s15@ozlabs.org>
Date: Fri, 25 May 2018 21:41:26 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-04-04 at 20:07:46 UTC, Mathieu Malaterre wrote:
> Since the value of x is never intended to be read, declare it with gcc
> attribute as unused. Fix warning treated as error with W=1:
> 
>   arch/powerpc/platforms/powermac/bootx_init.c:471:21: error: variable ‘x’ set but not used [-Werror=unused-but-set-variable]
> 
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/5a4b475cf8511da721f20ba432c244

cheers
