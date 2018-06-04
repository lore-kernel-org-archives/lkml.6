Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753421AbeFDOKb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:10:31 -0400
Received: from ozlabs.org ([203.11.71.1]:43649 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753163AbeFDOKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 10:10:30 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 9887334b804892f10262fa7f805998d554e04367
In-Reply-To: <20180228182145.AD1C76F114@po15720vm.idsi0.si.c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/dma: remove unnecessary BUG()
Message-Id: <40zxfY1vv9z9s0w@ozlabs.org>
Date: Tue,  5 Jun 2018 00:10:29 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-02-28 at 18:21:45 UTC, Christophe Leroy wrote:
> Direction is already checked in all calling functions in
> include/linux/dma-mapping.h and also in called function __dma_sync()
> 
> So really no need to check it once more here.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9887334b804892f10262fa7f805998

cheers
