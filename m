Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F29C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3DC22148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfA1Hek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 02:34:40 -0500
Received: from verein.lst.de ([213.95.11.211]:38239 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbfA1Hej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 02:34:39 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 3156C7F07E; Mon, 28 Jan 2019 08:34:38 +0100 (CET)
Date:   Mon, 28 Jan 2019 08:34:38 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Helge Deller <deller@gmx.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: DMA-related cleanups for parisc
Message-ID: <20190128073437.GA3287@lst.de>
References: <20190114112353.30616-1-hch@lst.de> <20190126171124.GA8151@ls3530.dellerweb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190126171124.GA8151@ls3530.dellerweb.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 26, 2019 at 06:11:24PM +0100, Helge Deller wrote:
> Thanks for doing that!
> I tested it. Your patches work, but you need the fixup below (0-day
> testing complained as well).

I actually sent a v2 series since then which makes sure the new iommu.h
includes <linux/pci.h>, so that we don't rely on header ordering.

> 
> With the one below, you may add
> Tested-by: Helge Deller <deller@gmx.de>

While this series prepares for DMA layerer work it isn't urgent, so
if you want to pick it up through the parisc tree that is perfectly
fine with me.
