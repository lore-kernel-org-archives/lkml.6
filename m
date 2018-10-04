Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E137AC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 06:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B031F21470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 06:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B031F21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbeJDNGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 09:06:20 -0400
Received: from ozlabs.org ([203.11.71.1]:47965 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbeJDNGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 09:06:20 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 42QjKC65JCz9sBj; Thu,  4 Oct 2018 16:14:39 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 51423a9c9b09352bea1c53b8324db78bf3b170d1
In-Reply-To: <86e85efc4b5a90523de6e964c5cef8858eb1177d.1537884465.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v2] powerpc/traps: merge unrecoverable_exception() and nonrecoverable_exception()
Message-Id: <42QjKC65JCz9sBj@ozlabs.org>
Date:   Thu,  4 Oct 2018 16:14:39 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-09-25 at 14:10:04 UTC, Christophe Leroy wrote:
> PPC32 uses nonrecoverable_exception() while PPC64 uses
> unrecoverable_exception().
> 
> Both functions are doing almost the same thing.
> 
> This patch removes nonrecoverable_exception()
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/51423a9c9b09352bea1c53b8324db7

cheers
