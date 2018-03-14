Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752345AbeCNJ2f (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 05:28:35 -0400
Received: from ozlabs.org ([103.22.144.67]:46785 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750852AbeCNJ2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 05:28:32 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: c554ac91ce2213faa91c51c45423770218cccce3
In-Reply-To: <20180227112555.DEBCE6E8BA@po15720vm.idsi0.si.c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>,
        Vitaly Bordug <vitb@kernel.crashing.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/8xx: fix cpm_cascade() dual end of interrupt
Message-Id: <401RH26WRbz9sTw@ozlabs.org>
Date: Wed, 14 Mar 2018 20:28:19 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-02-27 at 11:25:55 UTC, Christophe Leroy wrote:
> cpm_cascade() doesn't have to call eoi() as it is already called
> by handle_fasteoi_irq()
> 
> And cpm_get_irq() will always return an unsigned int so the test
> is useless
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c554ac91ce2213faa91c51c4542377

cheers
