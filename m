Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754251AbeBNFny (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 00:43:54 -0500
Received: from ozlabs.org ([103.22.144.67]:42871 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751431AbeBNFnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 00:43:53 -0500
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 910961754572a2f4c83ad7e610d180e3e6c29bda
In-Reply-To: <1518474848-3158-1-git-send-email-linux@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [1/2] powerpc/kdump: Add missing optional dummy functions
Message-Id: <3zh7cg63zDz9t67@ozlabs.org>
Date: Wed, 14 Feb 2018 16:43:47 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-02-12 at 22:34:07 UTC, Guenter Roeck wrote:
> If KEXEC_CORE is not enabled, PowerNV builds fail as follows.
> 
> arch/powerpc/platforms/powernv/smp.c: In function 'pnv_smp_cpu_kill_self':
> arch/powerpc/platforms/powernv/smp.c:236:4: error:
> 	implicit declaration of function 'crash_ipi_callback'
> 
> Add dummy function calls, similar to kdump_in_progress(), to solve the
> problem.
> 
> Fixes: 4145f358644b ("powernv/kdump: Fix cases where the kdump kernel ...")
> Cc: Balbir Singh <bsingharora@gmail.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Acked-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/910961754572a2f4c83ad7e610d180

cheers
