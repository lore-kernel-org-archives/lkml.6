Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966063AbeEJApG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 20:45:06 -0400
Received: from ozlabs.org ([203.11.71.1]:54193 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964863AbeEJApF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 20:45:05 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: linux-next: manual merge of the powerpc tree with the powerpc-fixes tree
In-Reply-To: <20180510101703.57ffb774@canb.auug.org.au>
References: <20180510101703.57ffb774@canb.auug.org.au>
Date: Thu, 10 May 2018 10:45:02 +1000
Message-ID: <87d0y4z6cx.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> Today's linux-next merge of the powerpc tree got a conflict in:
>
>   arch/powerpc/include/asm/ftrace.h
>
> between commit:
>
>   edf6a2dfe388 ("powerpc/trace/syscalls: Update syscall name matching logic to account for ppc_ prefix")
>
> from the powerpc-fixes tree and commit:
>
>   c3e59d778403 ("powerpc64/ftrace: Rearrange #ifdef sections in ftrace.h")
>
> from the powerpc tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> Michael, I think the version in your merge branch is not quite right ...

Yep.

Don't do merges after midnight kids.

I've pushed a fixed version, which I think matches yours.

I'll resolve it in my next when I merge my fixes & next later in the
cycle.

cheers
