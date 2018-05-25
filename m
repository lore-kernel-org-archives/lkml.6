Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966616AbeEYLlj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 07:41:39 -0400
Received: from ozlabs.org ([203.11.71.1]:37551 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966591AbeEYLlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 07:41:36 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: bd13ac95f954570e01fba5a6caf771da754ac0e3
In-Reply-To: <20180404201028.27621-1-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [v3,19/19] powerpc/tau: Synchronize function prototypes and body
Message-Id: <40skqM1f95z9s3X@ozlabs.org>
Date: Fri, 25 May 2018 21:41:34 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-04-04 at 20:10:28 UTC, Mathieu Malaterre wrote:
> Some function prototypes and body for Thermal Assist Units were not in
> sync. Update the function definition to match the existing function
> declaration found in `setup-common.c`, changing an `int` return type to a
> `u32` return type. Move the prototypes to a header file. Fix the following
> warnings, treated as error with W=1:
> 
>   arch/powerpc/kernel/tau_6xx.c:257:5: error: no previous prototype for ‘cpu_temp_both’ [-Werror=missing-prototypes]
>   arch/powerpc/kernel/tau_6xx.c:262:5: error: no previous prototype for ‘cpu_temp’ [-Werror=missing-prototypes]
>   arch/powerpc/kernel/tau_6xx.c:267:5: error: no previous prototype for ‘tau_interrupts’ [-Werror=missing-prototypes]
> 
> Compile tested with CONFIG_TAU_INT.
> 
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/bd13ac95f954570e01fba5a6caf771

cheers
