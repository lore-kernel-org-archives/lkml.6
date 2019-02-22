Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC6CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15AAC2081B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfBVJrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 04:47:47 -0500
Received: from ozlabs.org ([203.11.71.1]:50419 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727132AbfBVJro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 04:47:44 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 445RMz0rXqz9sLw; Fri, 22 Feb 2019 20:47:41 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 36da5ff0bea2dc67298150ead8d8471575c54c7d
X-Patchwork-Hint: ignore
In-Reply-To: <5a09a970ce5f7998719f0b4cd8af22cc7dd09ef0.1548371001.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Scott Wood <oss@buserror.net>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/83xx: Also save/restore SPRG4-7 during suspend
Message-Id: <445RMz0rXqz9sLw@ozlabs.org>
Date:   Fri, 22 Feb 2019 20:47:41 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-01-25 at 12:03:55 UTC, Christophe Leroy wrote:
> The 83xx has 8 SPRG registers and uses at least SPRG4
> for DTLB handling LRU.
> 
> Fixes: 2319f1239592 ("powerpc/mm: e300c2/c3/c4 TLB errata workaround")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/36da5ff0bea2dc67298150ead8d84715

cheers
