Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753488AbeFDOKe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:10:34 -0400
Received: from ozlabs.org ([203.11.71.1]:53751 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753373AbeFDOKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 10:10:31 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 8820a44738308a8a1644c6c3d04b477624db2d6b
In-Reply-To: <03c175e506e88e57f48f01de9120768e1b942c6e.1521641042.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [1/4] powerpc/mm: constify FIRST_CONTEXT in mmu_context_nohash
Message-Id: <40zxfZ27JTz9s0x@ozlabs.org>
Date: Tue,  5 Jun 2018 00:10:29 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-03-21 at 14:07:47 UTC, Christophe Leroy wrote:
> First context is now 1 for all supported platforms, so it
> can be made a constant.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8820a44738308a8a1644c6c3d04b47

cheers
