Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E34AC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C332521533
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:50:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C332521533
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeI0UIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:08:48 -0400
Received: from verein.lst.de ([213.95.11.211]:45460 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727175AbeI0UIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:08:47 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 01F2E68B02; Thu, 27 Sep 2018 15:50:26 +0200 (CEST)
Date:   Thu, 27 Sep 2018 15:50:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] csky: fixups after bootmem removal
Message-ID: <20180927135025.GA8628@lst.de>
References: <20180926112744.GC4628@rapoport-lnx> <20180927134705.GA6376@guoren>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927134705.GA6376@guoren>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 09:47:05PM +0800, Guo Ren wrote:
> Hi Christoph,
> 
> Don't forget arch/csky for the patch:
> dma-mapping: merge direct and noncoherent ops.
> 
> arch/csky/Kconfig
> 
> -	select DMA_NONCOHERENT_OPS
> +	select DMA_DIRECT_OPS

Thanks for the reminder.  I'll just try to get my pull request in
irst so that you'll have to fix it up :)
