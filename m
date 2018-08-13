Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0404CC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B47FC21746
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:23:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B47FC21746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbeHMOFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 10:05:09 -0400
Received: from ozlabs.org ([203.11.71.1]:47701 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728493AbeHMOFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 10:05:08 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 41ptdK3GPNz9sCq; Mon, 13 Aug 2018 21:23:16 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: fa54a981ea7a852c145b05c95abba11e81fc1157
In-Reply-To: <da0c182b76c27988b88ebd35ee284f5be5882dd1.1533802042.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/lib: Use patch_site to patch copy_32 functions once cache is enabled
Message-Id: <41ptdK3GPNz9sCq@ozlabs.org>
Date:   Mon, 13 Aug 2018 21:23:16 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-09 at 08:14:41 UTC, Christophe Leroy wrote:
> The symbol memcpy_nocache_branch defined in order to allow patching
> of memset function once cache is enabled leads to confusing reports
> by perf tool.
> 
> Using the new patch_site functionality solves this issue.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/fa54a981ea7a852c145b05c95abba1

cheers
