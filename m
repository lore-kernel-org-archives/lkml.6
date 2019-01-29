Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B42C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C7620857
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbfA2SMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:12:17 -0500
Received: from verein.lst.de ([213.95.11.211]:47688 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbfA2SMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:12:16 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 06BE368CEC; Tue, 29 Jan 2019 19:12:15 +0100 (CET)
Date:   Tue, 29 Jan 2019 19:12:15 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Helge Deller <deller@gmx.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: DMA-related cleanups for parisc
Message-ID: <20190129181214.GA16066@lst.de>
References: <20190114112353.30616-1-hch@lst.de> <20190126171124.GA8151@ls3530.dellerweb.de> <20190128073437.GA3287@lst.de> <fece406f-c6b4-a8bc-43b6-4f44fc5d548b@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fece406f-c6b4-a8bc-43b6-4f44fc5d548b@gmx.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 07:06:17PM +0100, Helge Deller wrote:
> On 28.01.19 08:34, Christoph Hellwig wrote:
> > On Sat, Jan 26, 2019 at 06:11:24PM +0100, Helge Deller wrote:
> >> Thanks for doing that!
> >> I tested it. Your patches work, but you need the fixup below (0-day
> >> testing complained as well).
> > 
> > I actually sent a v2 series since then which makes sure the new iommu.h
> > includes <linux/pci.h>, so that we don't rely on header ordering.
> 
> I don't see a v2 series. At least it wasn't sent to the parisc mailing list.
> Can you point me to this series?

Hmm, looks like I prepared it but didn't actually end up sending it,
as I can't find it either.  I'll send it now.
