Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FDEC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09A7021920
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09A7021920
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388742AbeHGJJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 05:09:11 -0400
Received: from verein.lst.de ([213.95.11.211]:59557 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727224AbeHGJJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 05:09:11 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E62F168D62; Tue,  7 Aug 2018 09:01:36 +0200 (CEST)
Date:   Tue, 7 Aug 2018 09:01:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Richard Kuo <rkuo@codeaurora.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-hexagon@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] hexagon: remove the sync_single_for_cpu DMA
        operation
Message-ID: <20180807070136.GA32634@lst.de>
References: <20180719125635.824-1-hch@lst.de> <20180719125635.824-2-hch@lst.de> <20180725032948.GG12771@codeaurora.org> <20180725043927.GA10827@lst.de> <20180731152229.GA956@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731152229.GA956@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 05:22:29PM +0200, Christoph Hellwig wrote:
> On Wed, Jul 25, 2018 at 06:39:27AM +0200, Christoph Hellwig wrote:
> > On Tue, Jul 24, 2018 at 10:29:48PM -0500, Richard Kuo wrote:
> > > Patch series looks good.  Definitely appreciate the cleanup.
> > > 
> > > I can take it through my tree, or if not:
> > > 
> > > Acked-by: Richard Kuo <rkuo@codeaurora.org>
> > 
> > Please take it through your tree, thanks!
> 
> I haven't seen it in linux-next yet, do you still plan to take it?
> 
> Otherwise I'll merge it in the dma-mapping tree.

Given that I haven't seen this in linux-next nor haven't heard back
from you I assume you are on your well deserved summer vacation.

If I don't hear back until tomorrow night I'll merge it through the
dma-mapping tree, so that I have it in linux-next before heading out
to my summer vacation.
