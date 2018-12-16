Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4E2C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 10:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67BAE217FB
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 10:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbeLPKSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 05:18:18 -0500
Received: from verein.lst.de ([213.95.11.211]:56639 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729784AbeLPKSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 05:18:18 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id D59F868D93; Sun, 16 Dec 2018 11:18:16 +0100 (CET)
Date:   Sun, 16 Dec 2018 11:18:16 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: Signed-off-by missing for commit in the block tree
Message-ID: <20181216101816.GA31756@lst.de>
References: <20181216172649.5278d8e6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181216172649.5278d8e6@canb.auug.org.au>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2018 at 05:26:49PM +1100, Stephen Rothwell wrote:
> Hi Jens,
> 
> Commit
> 
>   6f7ceaa0559b ("block: remove the bioset_integrity_free export")
> 
> is missing a Signed-off-by from its author.

Ooops.  Jens, in case you still feel ok ammending the tree:

Signed-off-by: Christoph Hellwig <hch@lst.de>
