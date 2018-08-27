Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975A9C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D63E208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D63E208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbeH0WS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:18:26 -0400
Received: from verein.lst.de ([213.95.11.211]:35428 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726895AbeH0WS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:18:26 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 2DE1768C76; Mon, 27 Aug 2018 20:33:08 +0200 (CEST)
Date:   Mon, 27 Aug 2018 20:33:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Konrad Rzeszutek Wilk <konrad@darnok.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: swiotlb cleanup (resend)
Message-ID: <20180827183308.GA496@lst.de>
References: <20180725113802.18943-1-hch@lst.de> <20180827181309.GA3834@0021ccb48c25>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827181309.GA3834@0021ccb48c25>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 02:13:11PM -0400, Konrad Rzeszutek Wilk wrote:
> On Wed, Jul 25, 2018 at 01:37:56PM +0200, Christoph Hellwig wrote:
> > Hi Konrad,
> > 
> > below are a few swiotlb patches.  Mostly just cleanups, but the removal
> > of the panic option is an actual change in (rarely used) functionality.
> > 
> > I'd be happy to pick them up through the dma-mapping tree if you are
> > fine with that.
> 
> Hey,
> 
> I put them in my 'devel/for-linus-4.19' as I would like to make
> sure that they work just fine with Xen-SWIOTLB and some baremetal
> machines.

I actually have a new version of these combined with merging
arm64 support into the main swiotlb ops.  Please hold off a bit for
now.
