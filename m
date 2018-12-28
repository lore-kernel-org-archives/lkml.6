Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55901C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 08:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB132146F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 08:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbeL1Isg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 03:48:36 -0500
Received: from verein.lst.de ([213.95.11.211]:60672 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbeL1Isg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 03:48:36 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id C001468AFE; Fri, 28 Dec 2018 09:48:34 +0100 (CET)
Date:   Fri, 28 Dec 2018 09:48:34 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Huang Shijie <sjhuang@iluvatar.ai>
Cc:     akpm@linux-foundation.org, linux@armlinux.org.uk, arnd@arndb.de,
        gregkh@linuxfoundation.org, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, sfr@canb.auug.org.au,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, shijie8@gmail.com
Subject: Re: [PATCH] lib/genalloc.c: rename addr_in_gen_pool to
 gen_pool_has_addr
Message-ID: <20181228084834.GA8658@lst.de>
References: <20181228083950.20398-1-sjhuang@iluvatar.ai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181228083950.20398-1-sjhuang@iluvatar.ai>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 04:39:50PM +0800, Huang Shijie wrote:
> Follow the kernel conventions, rename addr_in_gen_pool to
> gen_pool_has_addr.

Which convention?  The old name certainly looks more sensible to me.

If we really want to change anything about this function I'd suggest
to drop the size argument, as the address itself should describe the
region good enough.
