Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E4BC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 06:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AECA827824
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 06:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AECA827824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752372AbeF2G73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 02:59:29 -0400
Received: from verein.lst.de ([213.95.11.211]:52600 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751924AbeF2G71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 02:59:27 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 87CC968B97; Fri, 29 Jun 2018 08:59:32 +0200 (CEST)
Date:   Fri, 29 Jun 2018 08:59:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Christoph Hellwig <hch@lst.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nubus: Set default dma mask for nubus_board devices
Message-ID: <20180629065932.GA12400@lst.de>
References: <142066981b41910f4e645590a8b1734a1ea72fb8.1529926655.git.fthain@telegraphics.com.au> <20180628142713.GA16044@lst.de> <alpine.LNX.2.21.1806291411150.8@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.21.1806291411150.8@nippy.intranet>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 02:15:21PM +1000, Finn Thain wrote:
> On Thu, 28 Jun 2018, Christoph Hellwig wrote:
> 
> > On Mon, Jun 25, 2018 at 09:46:11PM +1000, Finn Thain wrote:
> > > A 32-bit mask is used by default because a NuBus slot has 32 
> > > address/data lines and a NuBus board is free to use all of them.
> > 
> > Looks good:
> 
> Thanks for looking it over. But did you forget to include an 
> acked-by/reviewed-by tag?

Looks like it.

Reviewed-by: Christoph Hellwig <hch@lst.de>
