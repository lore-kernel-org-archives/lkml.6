Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFB7C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB59921708
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:14:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB59921708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbeHHIcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 04:32:24 -0400
Received: from verein.lst.de ([213.95.11.211]:36236 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbeHHIcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 04:32:24 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 36BF668D60; Wed,  8 Aug 2018 08:19:42 +0200 (CEST)
Date:   Wed, 8 Aug 2018 08:19:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Richard Kuo <rkuo@codeaurora.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-hexagon@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] hexagon: remove the sync_single_for_cpu DMA
        operation
Message-ID: <20180808061941.GB15443@lst.de>
References: <20180719125635.824-1-hch@lst.de> <20180719125635.824-2-hch@lst.de> <20180725032948.GG12771@codeaurora.org> <20180725043927.GA10827@lst.de> <20180731152229.GA956@lst.de> <20180807070136.GA32634@lst.de> <20180808001927.GA20752@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180808001927.GA20752@codeaurora.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 07:19:27PM -0500, Richard Kuo wrote:
> I am here, and I have the patch queued up but it's waiting for approval
> before I get to push it out through my tree.
> 
> That said, I am perfectly fine with this going through a different tree
> if expedience is needed.

I just want to make sure it makes it for 4.19.  In general going through
the arch maintainer tree is preferred, I just don't want to lose it.
