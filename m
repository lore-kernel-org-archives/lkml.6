Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F87C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB18321872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730745AbfBAQLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 11:11:19 -0500
Received: from verein.lst.de ([213.95.11.211]:35660 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbfBAQLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 11:11:19 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id CBC2E68D93; Fri,  1 Feb 2019 17:11:16 +0100 (CET)
Date:   Fri, 1 Feb 2019 17:11:16 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, John Crispin <john@phrozen.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Felipe Balbi <balbi@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH 10/18] smc911x: pass struct device to DMA API functions
Message-ID: <20190201161116.GG6532@lst.de>
References: <20190201084801.10983-1-hch@lst.de> <20190201084801.10983-11-hch@lst.de> <a8653acc-e0db-69a1-a8d3-2190f3767ce3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8653acc-e0db-69a1-a8d3-2190f3767ce3@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 02:14:34PM +0000, Robin Murphy wrote:
> And equivalently for rxdma here. However, given that this all seems only 
> relevant to antique ARCH_PXA platforms which are presumably managing to 
> work as-is, it's probably not worth tinkering too much. I'd just stick a 
> note in the commit message that we're still only making these 
> self-consistent with the existing dma_map_single() calls rather than 
> necessarily correct.

Sounds good.
