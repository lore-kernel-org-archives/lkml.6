Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BCAC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB4B21B68
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfBKNMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:12:46 -0500
Received: from verein.lst.de ([213.95.11.211]:56614 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727106AbfBKNMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:12:46 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 98C9068DD6; Mon, 11 Feb 2019 14:12:43 +0100 (CET)
Date:   Mon, 11 Feb 2019 14:12:43 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, John Crispin <john@phrozen.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
        alsa-devel@alsa-project.org, iommu@lists.linux-foundation.org
Subject: Re: [PATCH 12/18] fotg210-udc: remove a bogus
 dma_sync_single_for_device call
Message-ID: <20190211131243.GA21917@lst.de>
References: <20190201084801.10983-1-hch@lst.de> <20190201084801.10983-13-hch@lst.de> <87d0obodci.fsf@linux.intel.com> <20190201161026.GE6532@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201161026.GE6532@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 05:10:26PM +0100, Christoph Hellwig wrote:
> On Fri, Feb 01, 2019 at 03:19:41PM +0200, Felipe Balbi wrote:
> > Christoph Hellwig <hch@lst.de> writes:
> > 
> > > dma_map_single already transfers ownership to the device.
> > >
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> > Do you want me to take the USB bits or will you take the entire series?
> > In case you're taking the entire series:
> 
> If you want to take the USB feel free.  I just want most of this in
> this merge window if possible.

I didn't see in the USB tree yet, so please let me know if you want to
take it.
