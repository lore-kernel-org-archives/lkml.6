Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD8FC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847BE20844
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfBHNCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:02:43 -0500
Received: from ozlabs.org ([203.11.71.1]:58979 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727613AbfBHNCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:02:41 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43wwMM4s3bz9sNx; Sat,  9 Feb 2019 00:02:39 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 9bf3d3c4e4fd82c7174f4856df372ab2a71005b9
X-Patchwork-Hint: ignore
In-Reply-To: <5aa3c84a675405ac99382a5893406ef7e8dfd455.1548779831.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v2] powerpc/traps: fix the message printed when stack overflows
Message-Id: <43wwMM4s3bz9sNx@ozlabs.org>
Date:   Sat,  9 Feb 2019 00:02:39 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-29 at 16:37:55 UTC, Christophe Leroy wrote:
> Today's message is useless:
> 
> [   42.253267] Kernel stack overflow in process (ptrval), r1=c65500b0
> 
> This patch fixes it:
> 
> [   66.905235] Kernel stack overflow in process sh[356], r1=c65560b0
> 
> Fixes: ad67b74d2469 ("printk: hash addresses printed with %p")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9bf3d3c4e4fd82c7174f4856df372ab2

cheers
