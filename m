Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753833AbeFDOLZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:11:25 -0400
Received: from ozlabs.org ([203.11.71.1]:49029 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753810AbeFDOLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 10:11:23 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 60f1d2893ee6de65cdea609c84950b133e76a769
In-Reply-To: <2e937890abac10677aae3c1e345dd934a6794c37.1527610536.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v3,1/3] powerpc/time: inline arch_vtime_task_switch()
Message-Id: <40zxgZ0Gtrz9s7S@ozlabs.org>
Date: Tue,  5 Jun 2018 00:11:19 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-05-29 at 16:19:14 UTC, Christophe Leroy wrote:
> arch_vtime_task_switch() is a small function which is called
> only from vtime_common_task_switch(), so it is worth inlining
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/60f1d2893ee6de65cdea609c84950b

cheers
