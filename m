Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27256C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C022089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfAGJHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 04:07:04 -0500
Received: from verein.lst.de ([213.95.11.211]:53525 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726516AbfAGJHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 04:07:04 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 004D668C8E; Mon,  7 Jan 2019 10:07:02 +0100 (CET)
Date:   Mon, 7 Jan 2019 10:07:02 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     He Zhe <zhe.he@windriver.com>
Cc:     konrad@darnok.org, konrad.wilk@oracle.com, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kernel/dma: Fix panic caused by passing swiotlb to
 command line
Message-ID: <20190107090702.GA14033@lst.de>
References: <1543832571-121638-1-git-send-email-zhe.he@windriver.com> <b35907a9-4d30-493b-3839-731b10d71c63@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b35907a9-4d30-493b-3839-731b10d71c63@windriver.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 04:46:51PM +0800, He Zhe wrote:
> Kindly ping.

Konrad, I'll pick this up through the DMA mapping tree unless you
protest in the next few days.
