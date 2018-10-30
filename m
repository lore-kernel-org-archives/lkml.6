Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7214C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A005220838
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A005220838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbeJ3WRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:17:30 -0400
Received: from verein.lst.de ([213.95.11.211]:60245 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbeJ3WR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:17:29 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 3A3CF68B02; Tue, 30 Oct 2018 14:24:02 +0100 (CET)
Date:   Tue, 30 Oct 2018 14:24:02 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Alistair Popple <alistair@popple.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        mpe@ellerman.id.au
Subject: Re: [PATCH] powerpc/npu-dma: Remove NPU DMA ops
Message-ID: <20181030132401.GC30783@lst.de>
References: <20181030110203.27257-1-alistair@popple.id.au> <20181030125841.GB30158@lst.de> <30359cc433e97739d93e13717b2897e462895097.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30359cc433e97739d93e13717b2897e462895097.camel@kernel.crashing.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 12:09:29AM +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2018-10-30 at 13:58 +0100, Christoph Hellwig wrote:
> > Please take my patch instead.  We have a kernel polcity to not keep
> > dead code around, and everyone including Linus and the attending IBMers
> > confirmed this.
> 
> Let's call a cat a cat ... ;-)
> 
> It's not *dead* code. It's code that is used by an out of tree driver
> (which also happen not to be open source).

Which clearly makes it a derived work of the kernel if it uses an
interface just create for it, and thus even more important to remove
it to not get anyone into legal trouble.
