Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9B8ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A40A9206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A40A9206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731556AbeGTOLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:11:33 -0400
Received: from verein.lst.de ([213.95.11.211]:38348 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731205AbeGTOLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:11:33 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id D390E6FC87; Fri, 20 Jul 2018 15:26:12 +0200 (CEST)
Date:   Fri, 20 Jul 2018 15:26:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Michal Simek <monstr@monstr.eu>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: use the generic dma-noncoherent code for microblaze
Message-ID: <20180720132612.GA15416@lst.de>
References: <20180719125440.424-1-hch@lst.de> <434e2ef1-3e3f-46d5-a7d1-62ed0e217da0@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <434e2ef1-3e3f-46d5-a7d1-62ed0e217da0@xilinx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 02:33:44PM +0200, Michal Simek wrote:
> Hi,
> 
> On 19.7.2018 14:54, Christoph Hellwig wrote:
> > Hi Michal,
> > 
> > can you review these patches to switch microblaze to use the generic
> > dma-noncoherent code?  All the requirements are in mainline already
> > and we've switched various architectures over to it already.
> > 
> 
> I can't see any issue with them.
> Both applied to next.

!
