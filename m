Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752565AbeCNJaD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 05:30:03 -0400
Received: from ozlabs.org ([103.22.144.67]:38213 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752317AbeCNJ2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 05:28:34 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: d15a261d876da3267c8c706ef21e7fdf10c582be
In-Reply-To: <20180307203257.23542-1-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
        open list <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        "open list:LINUX FOR POWERPC 32-BIT AND 64-BIT"
        <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [v2,15/21] powerpc: Make function MMU_setup static
Message-Id: <401RH41mZNz9sVv@ozlabs.org>
Date: Wed, 14 Mar 2018 20:28:28 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-03-07 at 20:32:55 UTC, Mathieu Malaterre wrote:
> Since function `MMU_setup` is not meant to be exported, change the
> signature to `static`. Fix warning (treated as error with W=1):
> 
>   CC      kernel/sys.o
> arch/powerpc/mm/init_32.c:102:13: error: no previous prototype for ‘MMU_setup’ [-Werror=missing-prototypes]
>  void __init MMU_setup(void)
>              ^~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d15a261d876da3267c8c706ef21e7f

cheers
