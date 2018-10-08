Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882EFC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5412220645
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5412220645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbeJHOON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 10:14:13 -0400
Received: from verein.lst.de ([213.95.11.211]:46054 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbeJHOON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 10:14:13 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 9DC3C68C73; Mon,  8 Oct 2018 09:03:58 +0200 (CEST)
Date:   Mon, 8 Oct 2018 09:03:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: fix up nowarn confusion in the dma mapping layer
Message-ID: <20181008070358.GA3182@lst.de>
References: <20181001201257.366-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001201257.366-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any comments on these rather trivial patches?

On Mon, Oct 01, 2018 at 01:12:55PM -0700, Christoph Hellwig wrote:
> Hi all,
> 
> this series sorts out how we deal with the nowarn flags in the dma
> mapping code.  We still support __GFP_NOWARN for the legacy APIs that
> don't support passing the dma specific flags, but we generally want
> every implementation to actually check DMA_ATTR_NO_WARN instead.
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
---end quoted text---
