Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C185C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5302086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F5302086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbeK0UTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:19:50 -0500
Received: from ozlabs.org ([203.11.71.1]:55111 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729950AbeK0UTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:19:49 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 433yx45hKJz9s55; Tue, 27 Nov 2018 20:22:32 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: af8511cf32189ba66c7e2a4146f11c86c9813ab7
In-Reply-To: <1542285196-156161-1-git-send-email-yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>, Scott Wood <oss@buserror.net>,
        Kumar Gala <galak@kernel.crashing.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
        Yue Haibing <yuehaibing@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [-next] powerpc/platforms/85xx: drop pointless static qualifier
Message-Id: <433yx45hKJz9s55@ozlabs.org>
Date:   Tue, 27 Nov 2018 20:22:32 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-11-15 at 12:33:16 UTC, YueHaibing wrote:
> From: Yue Haibing <yuehaibing@huawei.com>
> 
> There is no need to have the 'void __iomem *cpld_base' variable static
> since new value always be assigned before use it.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/af8511cf32189ba66c7e2a4146f11c

cheers
