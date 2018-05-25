Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966683AbeEYLrW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 07:47:22 -0400
Received: from ozlabs.org ([203.11.71.1]:60949 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966235AbeEYLlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 07:41:23 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: b87a358b4a1421abd544c0b554b1b7159b2b36c0
In-Reply-To: <20180322202007.23088-11-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
        kvm-ppc@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [10/19] powerpc/chrp/time: Make some functions static, add missing header include
Message-Id: <40skq60ynBz9s2R@ozlabs.org>
Date: Fri, 25 May 2018 21:41:21 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-22 at 20:19:56 UTC, Mathieu Malaterre wrote:
> Add a missing include <platforms/chrp/chrp.h>.
> 
> These functions can all be static, make it so. Fix warnings treated as
> errors with W=1:
> 
>   arch/powerpc/platforms/chrp/time.c:41:13: error: no previous prototype for ‘chrp_time_init’ [-Werror=missing-prototypes]
>   arch/powerpc/platforms/chrp/time.c:66:5: error: no previous prototype for ‘chrp_cmos_clock_read’ [-Werror=missing-prototypes]
>   arch/powerpc/platforms/chrp/time.c:74:6: error: no previous prototype for ‘chrp_cmos_clock_write’ [-Werror=missing-prototypes]
>   arch/powerpc/platforms/chrp/time.c:86:5: error: no previous prototype for ‘chrp_set_rtc_time’ [-Werror=missing-prototypes]
>   arch/powerpc/platforms/chrp/time.c:130:6: error: no previous prototype for ‘chrp_get_rtc_time’ [-Werror=missing-prototypes]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b87a358b4a1421abd544c0b554b1b7

cheers
