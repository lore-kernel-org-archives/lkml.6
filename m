Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED055C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F1F219E6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2F1F219E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbeHHQqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 12:46:46 -0400
Received: from ozlabs.org ([203.11.71.1]:47409 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727081AbeHHQqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 12:46:45 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 41ltxM6hTrz9ryt; Thu,  9 Aug 2018 00:26:39 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 81d7b08b3cec79a43411e7175401b369090dba29
In-Reply-To: <1533392700-24621-1-git-send-email-zhongjiang@huawei.com>
To:     zhong jiang <zhongjiang@huawei.com>, <benh@kernel.crashing.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: powpc:feature: of_node_put is not needed after iterator.
Message-Id: <41ltxM6hTrz9ryt@ozlabs.org>
Date:   Thu,  9 Aug 2018 00:26:39 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-08-04 at 14:25:00 UTC, zhong jiang wrote:
> for_each_node_by_name iterators only  exit normally when the loop
> cursor is NULL, So there is no point to call of_node_put.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> Reviewed-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/81d7b08b3cec79a43411e7175401b3

cheers
