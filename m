Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3151C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD70C21B24
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731754AbfBKPyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:54:54 -0500
Received: from verein.lst.de ([213.95.11.211]:58062 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730842AbfBKPyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:54:51 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 163E368DD6; Mon, 11 Feb 2019 16:54:50 +0100 (CET)
Date:   Mon, 11 Feb 2019 16:54:50 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v1] dma-mapping: Move debug configuration options to
 kernel/dma
Message-ID: <20190211155450.GA27697@lst.de>
References: <20190211155409.41465-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211155409.41465-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 05:54:09PM +0200, Andy Shevchenko wrote:
> This is a follow up to the commit cf65a0f6f6ff
> 
>   ("dma-mapping: move all DMA mapping code to kernel/dma")
> 
> which moved source code of DMA API to kernel/dma folder. Since there is
> no file left in the lib that require DMA API debugging options move the
> latter to kernel/dma as well.

Can we do this without the separate Kconfig.debug file?

Otherwise this looks good to me.
