Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB729C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769A420894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:24:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 769A420894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733246AbeHAHHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 03:07:55 -0400
Received: from ozlabs.org ([203.11.71.1]:33385 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733214AbeHAHHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 03:07:54 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 41gMDR2nzjz9s9F; Wed,  1 Aug 2018 15:24:06 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: b5ac51d747122f8858bdcb3fc7a5c702ef06f6c5
In-Reply-To: <918a4533548b1f2b5ffc16c05cac1c6b0a808142.1530807556.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v3,08/16] powerpc: declare set_breakpoint() static
Message-Id: <41gMDR2nzjz9s9F@ozlabs.org>
Date:   Wed,  1 Aug 2018 15:24:06 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-07-05 at 16:25:05 UTC, Christophe Leroy wrote:
> set_breakpoint() is only used in process.c so make it static
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b5ac51d747122f8858bdcb3fc7a5c7

cheers
