Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE04C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A550520846
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A550520846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbeH0MYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:24:50 -0400
Received: from verein.lst.de ([213.95.11.211]:33155 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbeH0MYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:24:50 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E67BF68C35; Mon, 27 Aug 2018 10:41:31 +0200 (CEST)
Date:   Mon, 27 Aug 2018 10:41:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Richard Kuo <rkuo@codeaurora.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-hexagon@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] hexagon: remove the sync_single_for_cpu DMA
 operation
Message-ID: <20180827084131.GA21563@lst.de>
References: <20180719125635.824-1-hch@lst.de> <20180719125635.824-2-hch@lst.de> <20180725032948.GG12771@codeaurora.org> <20180725043927.GA10827@lst.de> <20180731152229.GA956@lst.de> <20180807070136.GA32634@lst.de> <20180808001927.GA20752@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180808001927.GA20752@codeaurora.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given that it didn't make 4.19-rc1, I'll pull this into the dma-mapping
tree first thing for 4.20 as I have some other changes that will go on
top of it.
