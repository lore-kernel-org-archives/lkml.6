Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752370AbeCNJ2g (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 05:28:36 -0400
Received: from ozlabs.org ([103.22.144.67]:53655 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752254AbeCNJ2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 05:28:32 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 4f1f40f7b2b4487f582ecafec64076e430c72b22
In-Reply-To: <20180302194918.4358-1-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [v2,01/21] powerpc: Remove warning on array size when empty
Message-Id: <401RH218Zgz9sVp@ozlabs.org>
Date: Wed, 14 Mar 2018 20:28:24 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-03-02 at 19:49:18 UTC, Mathieu Malaterre wrote:
> When neither CONFIG_ALTIVEC, nor CONFIG_VSX or CONFIG_PPC64 is defined, the
> array feature_properties is defined as an empty array, which in turn
> triggers the following warning (treated as error on W=1):
> 
>   CC      arch/powerpc/kernel/prom.o
> arch/powerpc/kernel/prom.c: In function ‘check_cpu_feature_properties’:
> arch/powerpc/kernel/prom.c:298:16: error: comparison of unsigned expression < 0 is always false [-Werror=type-limits]
>   for (i = 0; i < ARRAY_SIZE(feature_properties); ++i, ++fp) {
>                 ^
> cc1: all warnings being treated as errors
> 
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/4f1f40f7b2b4487f582ecafec64076

cheers
