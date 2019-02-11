Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAE9C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D3B421B18
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbfBKQIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:08:39 -0500
Received: from mga04.intel.com ([192.55.52.120]:58769 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728642AbfBKQIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:08:36 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 08:08:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,359,1544515200"; 
   d="scan'208";a="132712129"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Feb 2019 08:08:32 -0800
Received: from andy by smile with local (Exim 4.92-RC5)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gtE8E-0006NQ-UH; Mon, 11 Feb 2019 18:08:30 +0200
Date:   Mon, 11 Feb 2019 18:08:30 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: [PATCH v1] dma-mapping: Move debug configuration options to
 kernel/dma
Message-ID: <20190211160830.GF9224@smile.fi.intel.com>
References: <20190211155409.41465-1-andriy.shevchenko@linux.intel.com>
 <20190211155450.GA27697@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211155450.GA27697@lst.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 04:54:50PM +0100, Christoph Hellwig wrote:
> On Mon, Feb 11, 2019 at 05:54:09PM +0200, Andy Shevchenko wrote:
> > This is a follow up to the commit cf65a0f6f6ff
> > 
> >   ("dma-mapping: move all DMA mapping code to kernel/dma")
> > 
> > which moved source code of DMA API to kernel/dma folder. Since there is
> > no file left in the lib that require DMA API debugging options move the
> > latter to kernel/dma as well.
> 
> Can we do this without the separate Kconfig.debug file?

Sure.

> 
> Otherwise this looks good to me.

-- 
With Best Regards,
Andy Shevchenko


