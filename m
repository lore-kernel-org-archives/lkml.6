Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753144AbeFAPzI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 11:55:08 -0400
Received: from ozlabs.org ([203.11.71.1]:32857 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753038AbeFAPzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 11:55:02 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 8ce621e1d946b1d1d7717337ab8dc3cbc4fd996f
In-Reply-To: <2892e4f57d03caf1b3d6c14bc456b2f9a116b32a.1527220066.git.jpoimboe@redhat.com>
To: Josh Poimboeuf <jpoimboe@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/modules: remove unused mod_arch_specific.toc field
Message-Id: <40y86X6K4mz9s4Y@ozlabs.org>
Date: Sat,  2 Jun 2018 01:55:00 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-05-25 at 03:48:34 UTC, Josh Poimboeuf wrote:
> The toc field in the mod_arch_specific struct isn't actually used
> anywhere, so remove it.
> 
> Also the ftrace-specific fields are now common between 32-bit and
> 64-bit, so simplify the struct definition a bit by moving them out of
> the __powerpc64__ #ifdef.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8ce621e1d946b1d1d7717337ab8dc3

cheers
