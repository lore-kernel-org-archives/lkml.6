Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C838C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C090218AF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730641AbfBAQK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 11:10:29 -0500
Received: from verein.lst.de ([213.95.11.211]:35638 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbfBAQK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 11:10:28 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 77CA868D93; Fri,  1 Feb 2019 17:10:26 +0100 (CET)
Date:   Fri, 1 Feb 2019 17:10:26 +0100
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
Message-ID: <20190201161026.GE6532@lst.de>
References: <20190201084801.10983-1-hch@lst.de> <20190201084801.10983-13-hch@lst.de> <87d0obodci.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d0obodci.fsf@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 03:19:41PM +0200, Felipe Balbi wrote:
> Christoph Hellwig <hch@lst.de> writes:
> 
> > dma_map_single already transfers ownership to the device.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Do you want me to take the USB bits or will you take the entire series?
> In case you're taking the entire series:

If you want to take the USB feel free.  I just want most of this in
this merge window if possible.
