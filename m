Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470F7C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0372320863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lRTzMqf1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0372320863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730351AbeK3EMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:12:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38602 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728444AbeK3EMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:12:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uw5A57Pb5X7eAp2TUbGGT4xAyQUqD8J12f4M/qbch6E=; b=lRTzMqf1Q7dgHKHzlogUnehaI
        YzYnXsjxHHsE9PFCjVkcKm1rktL1llezxrDEXHlyItQd8i+mxIyo/Demu3UagtPz4qBCAHE5uW7wF
        7nThKI6E/wTXjnhFV3t48O/zAGJ1rHUi2Tf7OXFK7ZQN74eZ2DSd2pf9EZ6qx3xBfS/KXv78M8MTp
        EZbtiKDlBF+O0n5sj5c7YTDbFBIvyyPLt5VLk5Rex4/r1tQrB8r0iv2SK7dXwtAhjgBJRbkHth559
        mFpWu6zndYyGs2Y7Tv57bAj5jS8Byk1lrJgeBgIJQKvBUQbI+gzolGPjq6qAlzVKf/xHkndprEapu
        P66u8OT9Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSPlR-0000Ys-T7; Thu, 29 Nov 2018 17:06:09 +0000
Date:   Thu, 29 Nov 2018 09:06:09 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: scatterlist arch cleanups
Message-ID: <20181129170609.GA790@infradead.org>
References: <20181109090008.24150-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109090008.24150-1-hch@lst.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping, any comments?

On Fri, Nov 09, 2018 at 10:00:06AM +0100, Christoph Hellwig wrote:
> Remove leftovers, and switch the default on enabling SG chaining.
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
---end quoted text---
