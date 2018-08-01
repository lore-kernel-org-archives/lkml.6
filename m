Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF778C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B285320894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:24:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B285320894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387423AbeHAHIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 03:08:01 -0400
Received: from ozlabs.org ([203.11.71.1]:48989 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733304AbeHAHIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 03:08:00 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 41gMDX6qTQz9s3q; Wed,  1 Aug 2018 15:24:12 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 405cb4024e52b137685213b377ea3f0ce3f91735
In-Reply-To: <050c24f2b82d2dcf0007398ec69b7f0b073c3188.1530807556.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v3,16/16] powerpc: split asm/tlbflush.h
Message-Id: <41gMDX6qTQz9s3q@ozlabs.org>
Date:   Wed,  1 Aug 2018 15:24:12 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-07-05 at 16:25:21 UTC, Christophe Leroy wrote:
> Split asm/tlbflush.h into:
> asm/nohash/tlbflush.h
> asm/book3s/32/tlbflush.h
> asm/book3s/64/tlbflush.h (already existing)
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/405cb4024e52b137685213b377ea3f

cheers
