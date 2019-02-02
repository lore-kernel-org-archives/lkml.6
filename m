Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F507C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 17:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D7A2086C
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 17:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbfBBRGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 12:06:11 -0500
Received: from verein.lst.de ([213.95.11.211]:40494 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbfBBRGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 12:06:11 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id DE06668CEB; Sat,  2 Feb 2019 18:06:08 +0100 (CET)
Date:   Sat, 2 Feb 2019 18:06:08 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH] swiotlb: Return error from swiotlb_init_with_tbl()
Message-ID: <20190202170608.GA2801@lst.de>
References: <20190131162424.10477-1-joro@8bytes.org> <20190201081208.GB15512@lst.de> <20190201165029.GU32526@8bytes.org> <20190201165610.GA7484@lst.de> <20190201165901.GV32526@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201165901.GV32526@8bytes.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 05:59:01PM +0100, Joerg Roedel wrote:
> > > This sounds like a change to break quite a couple of places in the
> > > kernel. But okay, it just makes this hunk obsolete.
> > 
> > He also added either explicit panic calls or error handling (panic
> > in case of swiotlb):
> > 
> > https://patchwork.kernel.org/patch/10766115/
> 
> I see, are these patches queued somewhere? My patch needs to be based on
> his changes.

I think akpm queued them up in -mm.  At least I got some mails claiming
patches from the series have been applied.
