Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF61C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D0E214DB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8D0E214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730752AbeKUXhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 18:37:51 -0500
Received: from verein.lst.de ([213.95.11.211]:51218 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727486AbeKUXhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 18:37:51 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 0518368C19; Wed, 21 Nov 2018 14:03:32 +0100 (CET)
Date:   Wed, 21 Nov 2018 14:03:31 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>, m.szyprowski@samsung.com,
        john.stultz@linaro.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sstabellini@kernel.org
Subject: Re: [PATCH 0/2] SWIOTLB fixes for 4.20
Message-ID: <20181121130331.GA1373@lst.de>
References: <cover.1542722463.git.robin.murphy@arm.com> <20181120160818.GC2492@lst.de> <20181120163441.GD31199@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120163441.GD31199@char.us.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 11:34:41AM -0500, Konrad Rzeszutek Wilk wrote:
> > Konrad, are you ok with me picking up both through the dma-mapping
> > tree?
> 
> Yes, albeit I would want Stefano to take a peek at patch #2 just in case.

Stefano, can you take a look asap?  This is a pretty trivial fix for
a nasty bug that breaks boot on real life systems.  I'd like to merge
it by tomorrow so that I can send it off to Linus for the next rc
(I will be offline for about two days after Friday morning)
