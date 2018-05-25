Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966604AbeEYLrG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 07:47:06 -0400
Received: from ozlabs.org ([203.11.71.1]:47105 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966319AbeEYLlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 07:41:24 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: c89ca593220931c150cffda24b4d4ccf82f13fc8
In-Reply-To: <20180322202007.23088-18-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
        kvm-ppc@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [17/19] powerpc/32: Add a missing include header
Message-Id: <40skq66hfpz9s28@ozlabs.org>
Date: Fri, 25 May 2018 21:41:22 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-22 at 20:20:03 UTC, Mathieu Malaterre wrote:
> The header file <linux/syscalls.h> was missing from the includes. Fix the
> following warning, treated as error with W=1:
> 
>   arch/powerpc/kernel/pci_32.c:286:6: error: no previous prototype for ‘sys_pciconfig_iobase’ [-Werror=missing-prototypes]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c89ca593220931c150cffda24b4d4c

cheers
