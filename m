Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8514BC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53C1420850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C1420850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbeLFOOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:14:36 -0500
Received: from verein.lst.de ([213.95.11.211]:57305 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727737AbeLFOOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:14:36 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 7F13C68AA6; Thu,  6 Dec 2018 15:14:34 +0100 (CET)
Date:   Thu, 6 Dec 2018 15:14:34 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     hch@lst.de, m.szyprowski@samsung.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        cai@gmx.us, salil.mehta@huawei.com, john.garry@huawei.com
Subject: Re: [PATCH v2 2/8] dma-debug: Expose nr_total_entries in debugfs
Message-ID: <20181206141434.GA24408@lst.de>
References: <cover.1544037783.git.robin.murphy@arm.com> <6740cfb143a084e8f5851b760bf99121a7ad6c67.1544037783.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6740cfb143a084e8f5851b760bf99121a7ad6c67.1544037783.git.robin.murphy@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 07:56:51PM +0000, Robin Murphy wrote:
> Expose nr_total_entries in debugfs, so that {num,min}_free_entries
> become even more meaningful to users interested in current/maximum
> utilisation. This becomes even more relevant once nr_total_entries
> may change at runtime beyond just the existing AMD GART debug code.
> 
> Suggested-by: John Garry <john.garry@huawei.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
