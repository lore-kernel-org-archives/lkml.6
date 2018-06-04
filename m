Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753745AbeFDOLJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:11:09 -0400
Received: from ozlabs.org ([203.11.71.1]:49121 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753718AbeFDOLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 10:11:06 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 373e098e1e788d7b89ec0f31765a6c08e2ea0f7c
In-Reply-To: <484bcfaccc1ec3d91b74aeaaa26a0ae66fe0955a.1527160868.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, segher@kernel.crashing.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/32: Optimise __csum_partial()
Message-Id: <40zxgC5wYpz9s0x@ozlabs.org>
Date: Tue,  5 Jun 2018 00:11:03 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-05-24 at 11:22:27 UTC, Christophe Leroy wrote:
> Improve __csum_partial by interleaving loads and adds.
> 
> On a 8xx, it brings neither improvement nor degradation.
> On a 83xx, it brings a 25% improvement.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reviewed-by: Segher Boessenkool <segher@kernel.crashing.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/373e098e1e788d7b89ec0f31765a6c

cheers
