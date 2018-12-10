Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649A9C67838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3234820855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3234820855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbeLJJFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 04:05:31 -0500
Received: from 8bytes.org ([81.169.241.247]:52872 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726888AbeLJJF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 04:05:28 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 1D5543AA; Mon, 10 Dec 2018 10:05:27 +0100 (CET)
Date:   Mon, 10 Dec 2018 10:05:26 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     John Garry <john.garry@huawei.com>
Cc:     robin.murphy@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        ganapatrao.kulkarni@cavium.com, hch@lst.de,
        m.szyprowski@samsung.com, linuxarm@huawei.com
Subject: Re: [PATCH v4] iommu/dma: Use NUMA aware memory allocations in
 __iommu_dma_alloc_pages()
Message-ID: <20181210090526.GP16835@8bytes.org>
References: <1543576440-222098-1-git-send-email-john.garry@huawei.com>
 <df449701-5ecb-26c7-cb17-b3fe03cc29e7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df449701-5ecb-26c7-cb17-b3fe03cc29e7@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 05:57:42PM +0000, John Garry wrote:
> A friendly reminder. Can you please let me know your position on this patch?

I am waiting for a Reviewed-by or at least Acked-by from Robin on it
before I put it in my tree.


Regards,

	Joerg
