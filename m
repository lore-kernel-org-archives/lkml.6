Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966498AbeEYLl3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 07:41:29 -0400
Received: from ozlabs.org ([203.11.71.1]:53223 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966379AbeEYLlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 07:41:25 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: d647b210ac738b401c7f824bbebdcbcedbe7cb6b
In-Reply-To: <20180322202007.23088-19-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
        kvm-ppc@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [18/19] powerpc: Add a missing include header
Message-Id: <40skq76R3wz9s33@ozlabs.org>
Date: Fri, 25 May 2018 21:41:23 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-22 at 20:20:04 UTC, Mathieu Malaterre wrote:
> The header file <asm/switch_to.h> was missing from the includes. Fix the
> following warning, treated as error with W=1:
> 
>   arch/powerpc/kernel/vecemu.c:260:5: error: no previous prototype for ‘emulate_altivec’ [-Werror=missing-prototypes]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d647b210ac738b401c7f824bbebdcb

cheers
