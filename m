Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753811AbeFDONE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:13:04 -0400
Received: from ozlabs.org ([203.11.71.1]:49143 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753776AbeFDOLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 10:11:16 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: c95998811807d897ca112ea62d66716ed733d058
In-Reply-To: <f5f2de3e1a39613f7303bfdc0d2f2210d4c91910.1527573345.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v2] powerpc/64: Fix build failure with GCC 8.1
Message-Id: <40zxgP0370z9s08@ozlabs.org>
Date: Tue,  5 Jun 2018 00:11:11 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-05-29 at 06:03:53 UTC, Christophe Leroy wrote:
> CC      arch/powerpc/kernel/nvram_64.o
> arch/powerpc/kernel/nvram_64.c: In function 'nvram_create_partition':
> arch/powerpc/kernel/nvram_64.c:1042:2: error: 'strncpy' specified bound 12 equals destination size [-Werror=stringop-truncation]
>   strncpy(new_part->header.name, name, 12);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
>   CC      arch/powerpc/kernel/trace/ftrace.o
> In function 'make_field',
>     inlined from 'ps3_repository_read_boot_dat_address' at arch/powerpc/platforms/ps3/repository.c:900:9:
> arch/powerpc/platforms/ps3/repository.c:106:2: error: 'strncpy' output truncated before terminating nul copying 8 bytes from a string of the same length [-Werror=stringop-truncation]
>   strncpy((char *)&n, text, 8);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c95998811807d897ca112ea62d6671

cheers
