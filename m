Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1380BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE322081B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfBVJsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 04:48:08 -0500
Received: from ozlabs.org ([203.11.71.1]:53343 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727263AbfBVJsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 04:48:04 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 445RNL428fz9sDr; Fri, 22 Feb 2019 20:48:02 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: d065ee93aab6ef4c2a5af5c455b5044bd5136547
X-Patchwork-Hint: ignore
In-Reply-To: <3695e169b0367503f3a424d4862cba5a247fabf4.1550226577.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christoph Hellwig <hch@lst.de>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc: drop unused GENERIC_CSUM Kconfig item
Message-Id: <445RNL428fz9sDr@ozlabs.org>
Date:   Fri, 22 Feb 2019 20:48:02 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-02-15 at 10:32:02 UTC, Christophe Leroy wrote:
> Commit d4fde568a34a ("powerpc/64: Use optimized checksum routines on
> little-endian") converted last powerpc user of GENERIC_CSUM.
> 
> This patch does a final cleanup dropping the Kconfig GENERIC_CSUM
> option which is always 'n', and associated piece of code in
> asm/checksum.h
> 
> Fixes: d4fde568a34a ("powerpc/64: Use optimized checksum routines on little-endian")
> Reported-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d065ee93aab6ef4c2a5af5c455b5044b

cheers
