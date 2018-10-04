Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D45C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 06:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BD9B21473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 06:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BD9B21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbeJDNGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 09:06:21 -0400
Received: from ozlabs.org ([203.11.71.1]:37361 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbeJDNGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 09:06:21 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 42QjKF2wcZzB4MQ; Thu,  4 Oct 2018 16:14:40 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: cd5ff94577e004e0a4457e70d0ef3a030f4010b8
In-Reply-To: <1537963772-15309-1-git-send-email-zhongjiang@huawei.com>
To:     zhong jiang <zhongjiang@huawei.com>, <paulus@samba.org>,
        <akpm@linux-foundation.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        fbarrat@linux.vnet.ibm.com, npiggin@gmail.com,
        fthain@telegraphics.com.au
Subject: Re: powerpc: xive: Move a dereference below a NULL test
Message-Id: <42QjKF2wcZzB4MQ@ozlabs.org>
Date:   Thu,  4 Oct 2018 16:14:40 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-09-26 at 12:09:32 UTC, zhong jiang wrote:
> It is safe to move dereference below a NULL test.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/cd5ff94577e004e0a4457e70d0ef3a

cheers
