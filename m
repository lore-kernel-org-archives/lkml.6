Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BE8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE232086C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfBVJst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 04:48:49 -0500
Received: from ozlabs.org ([203.11.71.1]:35667 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727041AbfBVJrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 04:47:41 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 445RMv3S7Gz9sB8; Fri, 22 Feb 2019 20:47:39 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: beb4f4722cf60d9f0803054dec4eb5025f2cf594
X-Patchwork-Hint: ignore
In-Reply-To: <3c3638c1ece313ad3fa0a850f9a98a635ebe688a.1548165236.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: powerpc/selftest: fix type of mftb() in null_syscall
Message-Id: <445RMv3S7Gz9sB8@ozlabs.org>
Date:   Fri, 22 Feb 2019 20:47:39 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-22 at 13:54:57 UTC, Christophe Leroy wrote:
> All callers of mftb() expect 'unsigned long', and the function itself
> only returns lower part of the TB so it really is 'unsigned long'
> not 'unsigned long long'
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/beb4f4722cf60d9f0803054dec4eb502

cheers
