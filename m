Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751056AbeC0Ewp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 00:52:45 -0400
Received: from ozlabs.org ([103.22.144.67]:60677 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750937AbeC0Ewn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 00:52:43 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>
Subject: Re: linux-next: manual merge of the powerpc tree with the powerpc-fixes tree
In-Reply-To: <20180327101125.145e4dc5@canb.auug.org.au>
References: <20180327101125.145e4dc5@canb.auug.org.au>
Date: Tue, 27 Mar 2018 15:52:41 +1100
Message-ID: <87lgeejf1i.fsf@concordia.ellerman.id.au>
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
>   arch/powerpc/include/asm/cputable.h
>   arch/powerpc/kernel/dt_cpu_ftrs.c
>
> between commit:
>
>   a5d4b5891c2f ("powerpc/mm: Fixup tlbie vs store ordering issue on POWER9")
>
> from the powerpc-fixes tree and commits:
>
>   9bbf0b576d32 ("powerpc: Free up CPU feature bits on 64-bit machines")
>   b5af4f279323 ("powerpc: Add CPU feature bits for TM bug workarounds on POWER9 v2.2")
>
> from the powerpc tree.

Thanks, yeah that was a bit of disaster.

I'll merge fixes into next before sending to Linus.

cheers
