Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33399C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 03:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C46E2184B
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 03:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfAXDkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 22:40:19 -0500
Received: from ozlabs.org ([203.11.71.1]:51705 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbfAXDkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 22:40:17 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43lSbM51Wnz9sMr; Thu, 24 Jan 2019 14:40:15 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 607ea5090b3fb61fea1d0bc5278e6c1d40ab5bd6
X-Patchwork-Hint: ignore
In-Reply-To: <dc0760e25a38ce64dd6cfde78b717c8e4a601a1e.1546947335.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/irq: drop arch_early_irq_init()
Message-Id: <43lSbM51Wnz9sMr@ozlabs.org>
Date:   Thu, 24 Jan 2019 14:40:15 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-08 at 11:37:19 UTC, Christophe Leroy wrote:
> arch_early_irq_init() does nothing different than
> the weak arch_early_irq_init() in kernel/softirq.c
> 
> Fixes: 089fb442f301 ("powerpc: Use ARCH_IRQ_INIT_FLAGS")
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/607ea5090b3fb61fea1d0bc5278e6c1d

cheers
