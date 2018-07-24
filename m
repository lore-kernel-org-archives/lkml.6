Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5E1C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 566DE20671
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:17:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 566DE20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388772AbeGXVZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 17:25:52 -0400
Received: from verein.lst.de ([213.95.11.211]:56456 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388640AbeGXVZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 17:25:52 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 5935868D64; Tue, 24 Jul 2018 22:21:15 +0200 (CEST)
Date:   Tue, 24 Jul 2018 22:21:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        iommu@lists.linux-foundation.org,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
Subject: Re: use the generic dma-noncoherent code for sh V2
Message-ID: <20180724202115.GA4685@lst.de>
References: <20180724120147.15096-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724120147.15096-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, there is one more issue with this version.   Wait for a new one
tomorrow.

On Tue, Jul 24, 2018 at 02:01:42PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> can you review these patches to switch sh to use the generic
> dma-noncoherent code?  All the requirements are in mainline already
> and we've switched various architectures over to it already.
> 
> Changes since V1:
>  - fixed two stupid compile errors and verified them using a local
>    cross toolchain instead of the 0day buildbot
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
---end quoted text---
