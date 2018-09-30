Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABE1C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 23:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F60206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 23:08:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F60206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbeJAFnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 01:43:11 -0400
Received: from verein.lst.de ([213.95.11.211]:34138 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbeJAFnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 01:43:11 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id A2C4D68B02; Mon,  1 Oct 2018 01:08:18 +0200 (CEST)
Date:   Mon, 1 Oct 2018 01:08:18 +0200
From:   christoph hellwig <hch@lst.de>
To:     Guan Xuetao <gxt@pku.edu.cn>
Cc:     christoph hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH, RFC] unicore32: remove swiotlb support
Message-ID: <20180930230818.GA20776@lst.de>
References: <20180927135434.6866-1-hch@lst.de> <467b89ea.5028.166258f1945.Coremail.gxt@pku.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <467b89ea.5028.166258f1945.Coremail.gxt@pku.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 29, 2018 at 09:40:27PM +0800, Guan Xuetao wrote:
> That's right and really good to use direct.c, not swiotlb.c
> No special limitation for dma zone in unicore32.

Thanks.  Added to the dma-mapping tree for 4.20.
