Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEBCC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 13:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D7B4223DD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 13:23:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D7B4223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbeKLXQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 18:16:49 -0500
Received: from 8bytes.org ([81.169.241.247]:39548 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729648AbeKLXQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 18:16:49 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id A2155533; Mon, 12 Nov 2018 14:23:31 +0100 (CET)
Date:   Mon, 12 Nov 2018 14:23:27 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        Christoph Hellwig <hch@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>
Subject: Re: [PATCH v2 1/1] iommu/vtd: Cleanup dma_remapping.h header
Message-ID: <20181112132327.mo5vpunwzsgv6vkm@8bytes.org>
References: <20181112064008.2102-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112064008.2102-1-baolu.lu@linux.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 02:40:08PM +0800, Lu Baolu wrote:
>  arch/x86/kernel/tboot.c                    |  2 +-
>  drivers/gpu/drm/i915/i915_gem_execbuffer.c |  2 +-
>  drivers/gpu/drm/i915/intel_display.c       |  2 +-
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.c        |  2 +-
>  drivers/misc/mic/scif/scif_rma.c           |  2 +-
>  drivers/misc/mic/scif/scif_rma.h           |  2 +-
>  include/linux/dma_remapping.h              | 58 ----------------------
>  include/linux/intel-iommu.h                | 49 +++++++++++++++++-
>  8 files changed, 53 insertions(+), 66 deletions(-)
>  delete mode 100644 include/linux/dma_remapping.h

Applied, thanks.

