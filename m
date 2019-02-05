Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6FEC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E1E520818
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbfBESCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 13:02:19 -0500
Received: from verein.lst.de ([213.95.11.211]:55482 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbfBESCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 13:02:19 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 3D51B68D93; Tue,  5 Feb 2019 19:02:18 +0100 (CET)
Date:   Tue, 5 Feb 2019 19:02:18 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-direct: Export dma_direct_alloc() and
 dma_direct_free()
Message-ID: <20190205180218.GB2882@lst.de>
References: <20190205110602.27717-1-thierry.reding@gmail.com> <20190205161036.GA782@lst.de> <20190205162057.GA29974@ulmo> <20190205163837.GA1222@lst.de> <20190205175611.GA7052@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205175611.GA7052@ulmo>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 06:56:11PM +0100, Thierry Reding wrote:
> Sure, here you go:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/gpu/host1x/cdma.c#n106

Yes, I think we I can come up with a nicer helper for that.
