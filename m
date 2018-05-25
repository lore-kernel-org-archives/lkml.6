Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966788AbeEYLmM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 07:42:12 -0400
Received: from ozlabs.org ([203.11.71.1]:34313 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966730AbeEYLl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 07:41:58 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: e4ccb1dae6bdef228d729c076c38161ef6e7ca34
In-Reply-To: <20180524110206.EFE226C991@localhost.localdomain>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/8xx: fix invalid register expression in head_8xx.S
Message-Id: <40skqm5m3yz9s1w@ozlabs.org>
Date: Fri, 25 May 2018 21:41:56 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-05-24 at 11:02:06 UTC, Christophe Leroy wrote:
> New binutils generate the following warning
> 
>   AS      arch/powerpc/kernel/head_8xx.o
> arch/powerpc/kernel/head_8xx.S: Assembler messages:
> arch/powerpc/kernel/head_8xx.S:916: Warning: invalid register expression
> 
> This patch fixes it.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e4ccb1dae6bdef228d729c076c3816

cheers
