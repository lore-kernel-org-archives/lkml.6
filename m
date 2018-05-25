Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966708AbeEYLly (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 07:41:54 -0400
Received: from ozlabs.org ([203.11.71.1]:39483 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966591AbeEYLlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 07:41:50 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 8a0b1120cb25ccd4480ba4fe3650bc22b0dfadf4
In-Reply-To: <484449fcfad0f718ce6d63a056d2aafc073991e7.1527058932.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, npiggin@gmail.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/mm: Use instruction symbolic names in store_updates_sp()
Message-Id: <40skqd1PTdz9s3c@ozlabs.org>
Date: Fri, 25 May 2018 21:41:49 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-05-23 at 07:04:04 UTC, Christophe Leroy wrote:
> Use symbolic names defined in asm/ppc-opcode.h
> instead of hardcoded values.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8a0b1120cb25ccd4480ba4fe3650bc

cheers
